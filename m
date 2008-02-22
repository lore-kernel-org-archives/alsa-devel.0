From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 18:49:23 +0200
Message-ID: <43e8c7320802220849r1b9f3570we4ce31081ce51d47@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
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
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BEF124412
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 17:49:27 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so347114tia.8
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 08:49:25 -0800 (PST)
In-Reply-To: <43e8c7320802220846g7d7c8b61jb29e8ca3028d2c24@mail.gmail.com>
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

forgot to mention:

vader:~# while sleep 0.05; do grep "Momentary freq"
/proc/asound/card1/stream0 >> out; done

vader:~# cat out | sort | uniq -c
   1272     Momentary freq = 48000 Hz (0x6.0000)
      7     Momentary freq = 48063 Hz (0x6.0200)
vader:~#

On Fri, Feb 22, 2008 at 6:46 PM, Adrian Stancu
<adrian.stancu.82@gmail.com> wrote:
> Yes!!! the feedback works correctly this way => perfect playback!
>
>  what I had to do was:
>                 [...]
>                 f = combine_quad((u8*)urb->transfer_buffer) & 0x0fffffff;
>                 f /= 8;
>                 if (f >= subs->freqn - subs->freqn / 8 && f <= subs->freqmax) {
>                         spin_lock_irqsave(&subs->lock, flags);
>                         subs->freqm = f;
>                 [...]
>
>  otherwise, the 'if' condition would still not be satisfied.
>  Words can not describe how thankful I am about this one!
>
>  Now, is there a way to incorporate this change into the driver without
>  affecting functionality for other usb audio devices?
>
>
>  On Fri, Feb 22, 2008 at 6:31 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>
>
> > Adrian Stancu wrote:
>  >  > According to dmesg, the device is running at high speed:
>  >  > usb 1-6: new high speed USB device using ehci_hcd and address 20
>  >  >
>  >
>  > > So, if I convert the freq using the high speed formula, I get a value
>  >  > within the acceptable range,
>  >
>  >  No; the device is high speed, but it sends a full speed feedback value.
>  >
>  >  Please try "subs->freqm = f / 8;"
>  >
>  >
>  >  The value quoted in your previous message was exactly 48000 Hz; please
>  >  check if it ever changes.
>  >
>  >
>  >  Regards,
>  >  Clemens
>  >
>
