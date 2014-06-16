From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [alsa-devel] [PATCH 1/3] sound: Add a quirk to enforce period_bytes
Date: Mon, 16 Jun 2014 12:05:44 -0300
Message-ID: <20140616120544.10ef75f4.m.chehab@samsung.com>
References: <1402762571-6316-1-git-send-email-m.chehab@samsung.com>
 <1402762571-6316-2-git-send-email-m.chehab@samsung.com>
 <539E9F25.7030504@ladisch.de>
 <CAGoCfiw3du9rXFvDfsUYLu4Ru6mbdWa+LtAyYupXosM0n-71NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-reply-to: <CAGoCfiw3du9rXFvDfsUYLu4Ru6mbdWa+LtAyYupXosM0n-71NA@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Devin Heitmueller <dheitmueller@kernellabs.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

Em Mon, 16 Jun 2014 09:22:08 -0400
Devin Heitmueller <dheitmueller@kernellabs.com> escreveu:

> > This looks like a workaround for a userspace bug that would affect all
> > USB audio devices.  What period/buffer sizes are xawtv/tvtime trying to
> > use?
> 
> I have similar concerns, although I don't know what the right solution
> is.  For example, the last time Mauro tweaked the latency in tvtime,
> it broke support for all cx231xx devices (note that tvtime and xawtv
> share essentially the same ALSA code):
> 
> http://git.linuxtv.org/cgit.cgi/tvtime.git/commit/?id=3d58ba563bfcc350c180b59a94cec746ccad6ebe
> 
> It seems like there is definitely something wrong with the
> latency/period selection in both applications, but we need some
> insight from people who are better familiar with the ALSA subsystem
> for advice on the "right" way to do low latency audio capture (i.e.
> properly negotiating minimal latency in a way that works with all
> devices).

Well, I suspect that the issue is at Kernel level.

Let's see the au0828 case:
	48 kHz, 2 bytes/sample, 2 channels, 256 maxpacksize, 1 ms URB
interval (bInterval = 1).

In this case, there is 192 bytes per 1ms period.	

Let's assume that the period was set to 3456, with corresponds to
a latency of 18 ms.

In this case, as NUM_URBS = 12, it means that the transfer buffer
will be set to its maximum value of 3072 bytes per URB pack (12 * 256),
and the URB transfer_callback will be called on every 16 ms.

So, what happens is:

	- after 16 ms, the first 3072 bytes arrive. The next
	  packet will take another 16ms to arrive;
	- after 2 ms, underrun, as the period_size was not
	  filled yet.

The thing is that any latency that between 16 ms and 32 ms
are invalid, as the URB settings won't support it.

Regards,
Mauro
