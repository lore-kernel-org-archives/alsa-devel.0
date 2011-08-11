From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 11 Aug 2011 09:45:39 -0700
Message-ID: <20110811164539.GB5884@xanatos>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
 <4E42A4AE.4020008@gmail.com>
 <20110810231552.GA7194@xanatos>
 <CACTFLAP9eRG6TVtFsNGO+oDu0U0gOUth-_TzLeW2yGb6Jxn2tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACTFLAP9eRG6TVtFsNGO+oDu0U0gOUth-_TzLeW2yGb6Jxn2tA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Florian Mickler <florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 02:57:41AM +0200, Daniel Mack wrote:
> On Thu, Aug 11, 2011 at 1:15 AM, Sarah Sharp
> <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > On Wed, Aug 10, 2011 at 05:33:02PM +0200, Daniel Mack wrote:
> >> On 08/10/2011 04:32 PM, Alan Stern wrote:
> >> >Looking at the driver's current code, it appears that your patch
> >> >does not fix the bug properly. =A0Using discontiguous regions in =
the
> >> >transfer buffer is perfectly okay. =A0The real problem is later o=
n,
> >> >where you do:
> >> >
> >> >if (send_it) { out->number_of_packets =3D FRAMES_PER_URB;
> >> >
> >> >This should be
> >> >
> >> >out->number_of_packets =3D outframe;
> >> >
> >> >The way it is now, the USB stack will try to use data from all th=
e
> >> >frame descriptors, and the last few will be stale because the loo=
p
> >> >doesn't set them.
> >>
> >> That's actually true, even though it doesn't seem to cause any tro=
uble.
> >> I tested everything here of course, and the output URBs return bac=
k from
> >> the USB stack with their length fields zeroed out, which then
> >> causes the stack to send packets with zero-length fields at the en=
d.
> >
> > Actually, it causes system hangs when the driver is loaded on a dev=
ice
> > attached to a USB 3.0 port, as Alan Stern pointed out:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D40702
>=20
> Yes, I've noticed this.
>=20
> > Please don't submit zero-length transfers. =A0The xHCI driver just =
isn't
> > able to handle it. =A0Arguably, it probably should have just reject=
ed your
> > URB when it found a zero length buffer, so I'll probably be submitt=
ing a
> > patch to fix that.
>=20
> According to the spec, sending zero-length frames should be fine, no?
> Is there any particular reason why XCHI can't handle this while EHCI
> can? And does my patch fix the driver for XHCI?

Ok, yes, you're correct that the xHCI spec allows the transfer length t=
o
be set to zero.  In the case where the frame buffer is zero-length, is
the buffer pointer still valid?  It's not clear from the spec whether i=
t
needs to be.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
