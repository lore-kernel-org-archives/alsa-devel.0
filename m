From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Tue, 26 Feb 2008 11:20:48 +0200
Message-ID: <43e8c7320802260120u241d2c83r97d7e00d4896992c@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BEFFFC.8030301@ladisch.de>
	<43e8c7320802220902j3a4ff3a1wdae77ec25f2d3785@mail.gmail.com>
	<47C2B822.7000507@ladisch.de>
	<43e8c7320802251032j7541ac02t1459ef83d95dfd4e@mail.gmail.com>
	<47C3C07B.2040104@ladisch.de>
	<43e8c7320802252353p2798488at87163c75a4511c4f@mail.gmail.com>
	<47C3CA77.5070104@ladisch.de>
	<43e8c7320802260038x17c2c350wade07dcd4f32cb3e@mail.gmail.com>
	<47C3D29B.9070708@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 71F3224422
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 10:20:50 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id c6so1251826gvd.24
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 01:20:49 -0800 (PST)
In-Reply-To: <47C3D29B.9070708@ladisch.de>
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

This time, the driver does not consider the feedback frequencies
invalid. What I did was:
                f = combine_quad((u8*)urb->transfer_buffer) & 0x0fffffff;
                printk("freqn=%u, freqmax=%u, f=%u, dataint=%u\n",
subs->freqn, subs->freqmax, f, subs->datainterval);
                f >>= subs->datainterval;
                if (f >= subs->freqn - subs->freqn / 8 && f <= subs->freqmax) {
                        spin_lock_irqsave(&subs->lock, flags);
                        subs->freqm = f;
                        printk("f=%u assigned!", f);
                        spin_unlock_irqrestore(&subs->lock, flags);

And what I got:
f=1572864 assigned!freqn=1572864, freqmax=1589248, f=6291456, dataint=2
f=1572864 assigned!freqn=1572864, freqmax=1589248, f=6291456, dataint=2
f=1572864 assigned!freqn=1572864, freqmax=1589248, f=6291456, dataint=2

However, the feedback value does not seem to ever change.

I wanted to mention that (from what I noticed until now), it is not
possible to get correct playback on this device unless the sampling
frequency it is set to (it defaults to 48k when powered on) matches
the sampling frequency of the audio stream you send to it. So how is
this supposed to work, if the device is set to 48k and my stream has
192k (and I cannot set the device to 192k)?


On Tue, Feb 26, 2008 at 10:49 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > OK, I tried playing the stereo file but still getting the same error:
>  > deathu@vader:~/Desktop$ aplay -D hw:1 testtone192.wav
>  > Playing WAVE 'testtone192.wav' : Signed 16 bit Little Endian, Rate 192000 Hz, Stereo
>  > aplay: set_params:918: Sample format non available
>
>  Oops, the device supports only 24-bit samples, and this isn't supported
>  by .wav files, so using hw:1 won't ever work with aply.
>
>
>  > Well, my test file contained a single constant frequency tone; it is
>  > still there while I play the 192k file through plughw:1,0, but burried
>  > under:
>  > - periodic series of clicks
>  > - other high frequency tones
>  >
>  > Here is  /proc/asound/card1/stream0 while playing through plughw:1,0:
>  > ...
>
> >     Momentary freq = 192000 Hz (0x18.0000)
>
>  Does this value ever change?
>  Could you again try inserting a printk to see whether the driver thinks
>  it gets invalid frequency values?
>
>
>  Regards,
>  Clemens
>
