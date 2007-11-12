From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: Re: No sound from usb on Motorola C350 cellphone
Date: Mon, 12 Nov 2007 14:44:38 +0100
Message-ID: <7c5010d60711120544p4d884b3etcdd5c3597a043d79@mail.gmail.com>
References: <7c5010d60711120528u16bef715ua48f440c49d962d1@mail.gmail.com>
	<7c5010d60711120534l13376fc9gc71228ca84322ddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C1F02442D
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 14:44:39 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id b15so192747ana
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 05:44:38 -0800 (PST)
In-Reply-To: <7c5010d60711120534l13376fc9gc71228ca84322ddc@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Seems that there is a problem in sending compressed attachments (and
non compressed is over the max limit size for list).

So, you can get the attachment with all the files at:
http://www.celliax.org/c350_usb_sound.tgz

Sorry for the mess,

Giovanni

On Nov 12, 2007 2:34 PM, Giovanni Maruzzelli <gmaruzz.lists@gmail.com> wrote:
>
> Hi list participants,
>
> I am using cellphones connected to soundcards as cheap gsm gateways
> (more complex than that, actually. You can see the whole GPL project
> at www.celliax.org).
>
> Maybe there is a way to not using soundcards, that would be *so* much
> better: I found that Motorola c350 phones after receiving an AT+MODE=8
> command via USB, make available an usb sound device.
>
> That would be wonderful (less cables, more robustness, etc). Problem
> is: the usb sound device do not plays or captures samples.
>
> I suspect that the usb audio has to be activated, maybe by an AT or a
> P2K command.
>
> Or that a quirk has to be added to the alsa driver (snd_usb_audio).
>
> Do you know anything about (maybe the quirk to be added to ALSA driver...)?
>
> Do you have any hint?
>
> I'm available to do all the research-testing-debugging that may be useful.
>
> What happens is as follow:
> 1) attach the c350 to usb
> 2) is recognized as acm0
> 3) send at+mode=8 to c350 (via minicom, for eg)
> 4) it changes its usbid, disconnect from usb, reconnect, is recognized
> as acm1, makes available a sound device
> 5) at commands work on the new acm1
> 6) trying to use the audio device directly (eg aplay -Dhw:1) do not
> give errors on play (but no sound is head on the phone), gives error
> pcm_read 1349 on record (eg arecord -Dhw:1)
> 7) trying to use the audiodevice through alsalib does not gives errors
> at all (eg -Dplughw:1) but does not caputeres samples, and no sound is
> heard on the phone
>
>
> In the tgz archive attached you can find the following files:
>
>
> lusb_without -> result of lusb -vv with no device attached
>
> lsusb_with_ACM0 -> result of lusb -vv with c350 just attached,
> recognized as acm modem
>
> lsusb_with_ACM1 -> result of lusb -vv with c350 after sending
> at+mode=8 to him, he has disconnected and was recognized again, this
> time as ACM1, with a lot of additional usb interfaces
>
> dmesg-acm0 -> result of dmesg after first c350 attachment
>
> dmesg-acm1 -> result of dmesg after at+mode=8 was sent to the c350
>
> aplay-l -> result of aplay -l showing the c350 as an alsa device
>
> stream0_pstop_cstop -> result of cat /proc/asound/C350/stream0 while not active
>
> stream0_pstop_crun -> result of cat /proc/asound/C350/stream0 while
> arecord -vv -Dplughw:1 -fS16_LE ciapa.raw (if using -Dhw:1 it fails
> with error: "pcm_read:1349: read error: Input/output error"). arecord
> does not gives errors, but do not write samples
>
> stream0_prun_crun -> result of cat /proc/asound/C350/stream0 while
> aplay and arecord -vv -Dplughw:1 -fS16_LE ciapa.raw (if using -Dhw:1
> arecord fails with error: "pcm_read:1349: read error: Input/output
> error", aplay works but no audio) arecord does not gives errors, but
> do not write samples
>
> aplay_play -> results of aplay
>
> arecord_rec -> results of arecord
>
> Thank you all in advance,
>
> Giovanni Maruzzelli
>
