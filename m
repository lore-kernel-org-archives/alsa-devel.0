From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Fri, 12 Aug 2011 03:28:42 +0200
Message-ID: <CACTFLANyL95Gy6c2YznV-h0tYdZ7nvRhObsq8dvp9n4_9=D_Mw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
	<3166003.Y8gKYdUrh9@edgy>
	<4E446873.9020508@gmail.com>
	<1451239.ZLFiT5MIDr@edgy>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451239.ZLFiT5MIDr@edgy>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TWF0xJtqIExhaXRs?= <matej-kxE3iQeWS/M@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Florian Mickler <florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2011 at 1:50 AM, Mat=C4=9Bj Laitl <matej-kxE3iQeWS/M@public.gmane.org> wrot=
e:
> On 12.=E2=80=AF8.=E2=80=AF2011 Daniel Mack wrote:
>> > This patch actually makes the sound playback _worse_. Now I get st=
range
>> > squawks where previously at least first seconds of a song sounded
>> > normally.
>> >
>> > However, I no longer get "zero length buffer submitted" or that ".=
=2E.
>> > Weird." debug messages, only several megabytes of: (should I post =
these
>> > somewhere?)
>> >
>> > xhci_hcd 0000:05:00.0: Giveback URB ffff880114cec000, len =3D 880,
>> > expected =3D 1000, status =3D -115
>> > xhci_hcd 0000:05:00.0: Giveback URB ffff880114740000, len =3D 352,
>> > expected =3D 1000, status =3D -115
>> > xhci_hcd 0000:05:00.0: underrun event on endpoint
>>
>> Might be the hardware doesn't like this. As I said, the patch is bli=
ndly
>> written and I couldn't test it. Did you test this on a EHCI port as =
well?
>
> Good point, this patch distorts the playback also on the EHCI port. (=
the
> playback seems to be 10 times slower than it should be)

And it is only this *last* patch that causes it, yes?

If that is the case, we need empty subframes in the middle of urbs,
and we need to figure a way how to teach the XHCI driver to cope with
that, too.


Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
