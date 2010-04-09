From: Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 19:19:22 +0100
Message-ID: <w2r74fd948d1004091119j9f33d8a6kc1824d9243abf38b@mail.gmail.com>
References: <m2n74fd948d1004081613n90408827s7c51ef572848fb1d@mail.gmail.com>
	 <Pine.LNX.4.44L0.1004091155570.1852-100000@iolanthe.rowland.org>
	 <20100409180942.GK30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100409180942.GK30801-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 9 April 2010 19:09, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
> On Fri, Apr 09, 2010 at 12:01:27PM -0400, Alan Stern wrote:
>> On Fri, 9 Apr 2010, Pedro Ribeiro wrote:
>> > here is the output of the patch you sent me when the interference =
is triggered.
>> >
>> > The log is long, 1.3mb in size.
>>
>> I don't see anything suspicious. =A0The transfer_buffer addresses re=
peat
>> every 32 URBs, and the DMA addresses cycle almost entirely uniformly
>> from 0x20000000 to 0x23ffffff in units of 0x2000 (there are a few ga=
ps
>> where the interval is a little bigger).
>
> The DMA pointers do indeed look sane. I wanted to take a deeper look =
at
> this and set up a 64bit system today. However, I fail to see the prob=
lem
> here. Pedro, how much RAM does your machine have installed?
>
> Daniel
>
>

It has 4 GB.

Pedro
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
