From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 11 Aug 2011 11:05:07 -0700
Message-ID: <20110811180507.GC5884@xanatos>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
 <4E42A4AE.4020008@gmail.com>
 <20110810231552.GA7194@xanatos>
 <CACTFLAP9eRG6TVtFsNGO+oDu0U0gOUth-_TzLeW2yGb6Jxn2tA@mail.gmail.com>
 <20110811164539.GB5884@xanatos>
 <CACTFLAOi5u-YL+FKGotPSBv5BgEhKO5FLwZeJKdgyis3nZLbcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACTFLAOi5u-YL+FKGotPSBv5BgEhKO5FLwZeJKdgyis3nZLbcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Florian Mickler <florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 07:27:15PM +0200, Daniel Mack wrote:
> On Thu, Aug 11, 2011 at 6:45 PM, Sarah Sharp
> <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > On Thu, Aug 11, 2011 at 02:57:41AM +0200, Daniel Mack wrote:
> >> On Thu, Aug 11, 2011 at 1:15 AM, Sarah Sharp
> >> <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> >> > On Wed, Aug 10, 2011 at 05:33:02PM +0200, Daniel Mack wrote:
> >> >> On 08/10/2011 04:32 PM, Alan Stern wrote:
> >> >> >Looking at the driver's current code, it appears that your pat=
ch
> >> >> >does not fix the bug properly. =A0Using discontiguous regions =
in the
> >> >> >transfer buffer is perfectly okay. =A0The real problem is late=
r on,
> >> >> >where you do:
> >> >> >
> >> >> >if (send_it) { out->number_of_packets =3D FRAMES_PER_URB;
> >> >> >
> >> >> >This should be
> >> >> >
> >> >> >out->number_of_packets =3D outframe;
> >> >> >
> >> >> >The way it is now, the USB stack will try to use data from all=
 the
> >> >> >frame descriptors, and the last few will be stale because the =
loop
> >> >> >doesn't set them.
> >> >>
> >> >> That's actually true, even though it doesn't seem to cause any =
trouble.
> >> >> I tested everything here of course, and the output URBs return =
back from
> >> >> the USB stack with their length fields zeroed out, which then
> >> >> causes the stack to send packets with zero-length fields at the=
 end.
> >> >
> >> > Actually, it causes system hangs when the driver is loaded on a =
device
> >> > attached to a USB 3.0 port, as Alan Stern pointed out:
> >> >
> >> > https://bugzilla.kernel.org/show_bug.cgi?id=3D40702
> >>
> >> Yes, I've noticed this.
> >>
> >> > Please don't submit zero-length transfers. =A0The xHCI driver ju=
st isn't
> >> > able to handle it. =A0Arguably, it probably should have just rej=
ected your
> >> > URB when it found a zero length buffer, so I'll probably be subm=
itting a
> >> > patch to fix that.
> >>
> >> According to the spec, sending zero-length frames should be fine, =
no?
> >> Is there any particular reason why XCHI can't handle this while EH=
CI
> >> can? And does my patch fix the driver for XHCI?
> >
> > Ok, yes, you're correct that the xHCI spec allows the transfer leng=
th to
> > be set to zero. =A0In the case where the frame buffer is zero-lengt=
h, is
> > the buffer pointer still valid? =A0It's not clear from the spec whe=
ther it
> > needs to be.
>=20
> Well, the buffer pointer is set in the URB, not in its individual iso
> subframes which just denotes them via the offset field. So yes, it is
> valid in my case. But it doesn't matter anymore, as the code which
> does that is now gone :)

Do you mean it was removed with this patch:

http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dcom=
mitdiff;h=3D15439b

Because according to Matej, he applied that patch, plus my patch to
reject zero-length buffers[1], and he saw debugging that indicated he
*did* see zero-length buffers.  Is there any chance your driver might
submit a zero-length buffer in the middle of the isochronous URB
transfer array?

Sarah Sharp

[1]
http://git.kernel.org/?p=3Dlinux/kernel/git/sarah/xhci.git;a=3Dcommitdi=
ff;h=3De70d79bda63050729fcef654167d22eb59380aa6
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
