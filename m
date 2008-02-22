From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 19:02:18 +0200
Message-ID: <43e8c7320802220902j3a4ff3a1wdae77ec25f2d3785@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BED4C2.4020501@ladisch.de>
	<43e8c7320802220619x4dfc049cv1f38a6fb8b1cb7a8@mail.gmail.com>
	<47BEDF9E.3000907@ladisch.de>
	<43e8c7320802220651r25ac78d7pecca63f3e1d48249@mail.gmail.com>
	<47BEEF4D.4050507@ladisch.de>
	<43e8c7320802220815y332a82f4kac19999cc15fd276@mail.gmail.com>
	<47BEF8FE.4030408@ladisch.de>
	<43e8c7320802220846g7d7c8b61jb29e8ca3028d2c24@mail.gmail.com>
	<47BEFFFC.8030301@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EDB5243DB
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 18:02:22 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so351683tia.8
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 09:02:20 -0800 (PST)
In-Reply-To: <47BEFFFC.8030301@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

OK!

I *think* the 0202 USB is also in the same situation.
Thank you again!

Best regards,
Adi

On Fri, Feb 22, 2008 at 7:01 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > Yes!!! the feedback works correctly this way => perfect playback!
>  >
>  > what I had to do was:
>  >                 [...]
>  >                 f = combine_quad((u8*)urb->transfer_buffer) & 0x0fffffff;
>  >                 f /= 8;
>  >                 if (f >= subs->freqn - subs->freqn / 8 && f <= subs->freqmax) {
>  >                         spin_lock_irqsave(&subs->lock, flags);
>  >                         subs->freqm = f;
>  >                 [...]
>  >
>  > otherwise, the 'if' condition would still not be satisfied.
>
>  Oops.  Of course.
>
>
>  > Now, is there a way to incorporate this change into the driver without
>  > affecting functionality for other usb audio devices?
>
>  I'll write a quirk.
>
>
>  Regards,
>  Clemens
>
