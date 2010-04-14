From: Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 14 Apr 2010 18:21:05 +0100
Message-ID: <n2k74fd948d1004141021r8815647cx2b74085fc37a27b2@mail.gmail.com>
References: <t2w74fd948d1004140347k3447bffapb73856eacddfde55@mail.gmail.com>
	 <Pine.LNX.4.44L0.1004141003170.1716-100000@iolanthe.rowland.org>
	 <20100414163637.GV30807@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100414163637.GV30807-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 14 April 2010 17:36, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
> On Wed, Apr 14, 2010 at 10:08:47AM -0400, Alan Stern wrote:
>> On Wed, 14 Apr 2010, Pedro Ribeiro wrote:
>> > On 14 April 2010 11:09, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
>> > > Thanks! So the only thing I can do for now is submit exactly thi=
s patch.
>> > > At least, it helps you and it shouldn't break anything. The ques=
tion
>> > > remains whether this type of memory should be used for all
>> > > transfer_buffers.
>> > >
>> >
>> > Is there any chance you could push this to -stable? I don't care
>> > because I always use the latest kernel, but the next Debian stable=
 and
>> > Ubuntu LTS are going to use 2.6.32.
>>
>> No! =A0Please don't do it: Don't submit the patch and _certainly_ do=
n't
>> submit it to -stable. =A0It doesn't fix anything; it only works arou=
nd a
>> bug, and at the moment we don't even know if the bug is in the kerne=
l
>> or in Pedro's hardware (and even though it affects two different
>> systems of his, nobody else has reported a similar problem). =A0Pape=
ring
>> over it will only remove the incentive to fix it properly.
>
> No worries - I agree. But unfortunately, I'm out of ideas now, and my
> initial thoughts about what might cause the trouble were abviously no=
t
> able to explain the issue. Does anyone see further steps of tracking
> this issue down?
>
> Thanks,
> Daniel
>

Well if this is a dirty / dangerous hack, what about your first patch?
I've been testing it for days and has given me no problems.

The best way to trigger the issue is to connect a dib0700 based DVB
adapter. All you need is to connect it. Since it polls for the remote
control every 50 msec, it causes a constant interference. Beware that
on 2.6.34 this behaviour has been corrected. Other DVB adapters may
trigger the same issue if they also poll constatly for the rc.

Regards,
Pedro
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
