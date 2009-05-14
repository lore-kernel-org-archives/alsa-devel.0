From: Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget
	driver
Date: Thu, 14 May 2009 14:12:41 -0700
Message-ID: <4a5ff6bc0905141412t5ab4f0f5x6c50b4e38af0790f@mail.gmail.com>
References: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net>
	 <200905142258.42935.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905142258.42935.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Cc: Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 1:58 PM, Laurent Pinchart
<laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org> wrote:
> Hi Hal,
>
> first of all, thanks for your answer.
>
> On Thursday 14 May 2009 20:18:07 Hal Murray wrote:
>> > I need an API to transfer audio data from userspace to kernelspace=
=2E I
>> > initially thought about ALSA, but it turns out some assumptions ma=
de
>> > by ALSA =C2=A0are not fulfilled by my system. One of the most seri=
ous
>> > problems is that the =C2=A0UAC gadget driver doesn't have any audi=
o clock.
>> > The only hardware clock =C2=A0available is the USB device controll=
er
>> > interrupts generated at the USB =C2=A0transfer rate, and those are=
 much
>> > faster than the audio sample rate. This will =C2=A0cause buffer un=
derruns
>> > that I need to handle.
>>
>> You don't need a clock. =C2=A0The data will come to you at the right=
 rate. =C2=A0All
>> you need to do is pass it on when you have enough to fill up a buffe=
r. =C2=A0The
>> buffer size is fixed. =C2=A0It's part of the spec for the device you=
 are
>> emulating.
>
> I'm not emulating any device. The buffer size is up to me, and I actu=
ally have
> a fixed number of small buffers, but that shouldn't make a difference=
=2E
>
Hi Laurent,

The problems might be clearer to you if you do the output side first.
You have to define one or more alt/interfaces with isoc OUT sizes to
match the sample rate. Some rates are straight forward and don't care
much about the buffer/packet sizes like 45,000 HZ. However the 44100
hz rate (and 22050 and 11025) made popular by CDs is interesting
because it doesn't divide by 1000, the FS frame rate. So a driver must
output 9 packets of 44 samples (times the number of bytes in sample
width times stereo/mono) and 1 of 45 samples. Typically USB chips
determine the sample rate by the interface and the number of bytes
coming per frame.

This is a challenging project, compounded by the audio usb class spec.
In my opinion audio is the worst, hardest to understand spec. Second
is the HID-PID spec.

Regards, Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
