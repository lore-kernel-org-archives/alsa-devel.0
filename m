From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 18:01:48 +0100
Message-ID: <47BEFFFC.8030301@ladisch.de>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>	
	<47BEC97A.3030507@ladisch.de>	
	<43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>	
	<47BED4C2.4020501@ladisch.de>	
	<43e8c7320802220619x4dfc049cv1f38a6fb8b1cb7a8@mail.gmail.com>	
	<47BEDF9E.3000907@ladisch.de>	
	<43e8c7320802220651r25ac78d7pecca63f3e1d48249@mail.gmail.com>	
	<47BEEF4D.4050507@ladisch.de>	
	<43e8c7320802220815y332a82f4kac19999cc15fd276@mail.gmail.com>	
	<47BEF8FE.4030408@ladisch.de>
	<43e8c7320802220846g7d7c8b61jb29e8ca3028d2c24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 199A924412
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 18:00:04 +0100 (CET)
In-Reply-To: <43e8c7320802220846g7d7c8b61jb29e8ca3028d2c24@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Stancu <adrian.stancu.82@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian Stancu wrote:
> Yes!!! the feedback works correctly this way => perfect playback!
>
> what I had to do was:
>                 [...]
>                 f = combine_quad((u8*)urb->transfer_buffer) & 0x0fffffff;
>                 f /= 8;
>                 if (f >= subs->freqn - subs->freqn / 8 && f <= subs->freqmax) {
>                         spin_lock_irqsave(&subs->lock, flags);
>                         subs->freqm = f;
>                 [...]
>
> otherwise, the 'if' condition would still not be satisfied.

Oops.  Of course.

> Now, is there a way to incorporate this change into the driver without
> affecting functionality for other usb audio devices?

I'll write a quirk.


Regards,
Clemens
