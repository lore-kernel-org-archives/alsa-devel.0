Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4051EC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 20:52:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB97D20758
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 20:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y8A2PumT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB97D20758
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 153C91803;
	Wed, 20 May 2020 22:51:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 153C91803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590007943;
	bh=PBqNAvn92ZuuULflNJ3JxbAcFUY8XucjOTqJJ3HhztM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y8A2PumTz5FuKNs8QjHv3VLNygCklSS7gbECyDtvk1eUhKj1NQYdpe3t5D4cNkcEJ
	 5NvhOu01FwwMoXJk7M6lxXH7kEvuB/2O+Ua7M4nzPswMpehJoHPtjK0GR2Ze+mCoCV
	 QqM2w8rjYadCGdOVNdF+kCLvTfQGth7zB9rSXnio=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87E9EF801DA;
	Wed, 20 May 2020 22:51:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9899CF801F9; Wed, 20 May 2020 22:51:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7147DF80090
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 22:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7147DF80090
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1590007879404277086-webhooks-bot@alsa-project.org>
References: <1590007879404277086-webhooks-bot@alsa-project.org>
Subject: latency.c randomly gives persistent scratchy audio
Message-Id: <20200520205130.9899CF801F9@alsa1.perex.cz>
Date: Wed, 20 May 2020 22:51:30 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #53 was opened from archenemies:

I had been intending to modify the example program test/latency.c in the alsa-lib distribution to build a filter.

However, I found the original program itself was unable to produce a good transfer of audio.

I am using it like

    ./latency -C plughw:3 -P hw:0,7 -r 44100 -m 256 -M 512 -c 2 -s 3000

but I also tried higher numbers (2048 and 4096) for -m and -M and this didn't help.

This command should theoretically work to transfer audio samples between the capture device, hw:3 which is a USB audio card with 3.5mm input, and the playback device hw:0,7 which is an HDMI monitor with builtin speakers. The second device has no volume control in alsamixer.

Most of the times when I run the above command, there is a scratchy sound which can be heard here

    mpv http://ix.io/2mPY

In the recording, whenever the music stops and starts again, it's because I killed the 'latency' program and restarted it. You can hear that there are different levels of distortion from one invocation to the next. The signal is coming from a digital audio player which is plugged into the USB sound card via analog 3.5mm. Nothing else changes about the setup, I am just stopping and starting "./latency".

The same level of scratchiness usually persists throughout the running of the program, however, each time the program is restarted a new level of scratchiness is chosen seemingly at random. It's almost like every time the program is started, a threshold is chosen uniformly at random, such that whenever the audio signal exceeds this threshold then it gets clipped. The other circumstances would seem to rule out buffer underflow or crystal drift, and there is no warning of dropped samples. I made some experiments, and even the effect of dropping every 10th sample sounds less distorted than this. But if it is from crystal drift, it should be more like every 1/1000th sample getting dropped. The sound that I am hearing is more like the result of zeroing or thresholding all the samples which exceed a certain amplitude, and a significant number of samples must be affected to make it sound this bad.

I do not notice this problem with "ecasound -i .. -o .." or with Pulseaudio's "module-loopback", which are both able to produce clear audio. As I uderstand it, ecasound does not do resampling to account for crystal drift. Pulseaudio's module-loopback does do adaptive resampling.

I'm including the command that I use, and the output. I don't know what some of those words mean - tstamp_mode, start_threshold, silence_threshold, period_event. Anyway, please let me know if it is possible to make this program behave more like Pulseaudio or Ecasound. I'll be happy to assist with reproduction issues and so on.

    $ ./latency -P hw:0,7 -C plughw:3 -r 44100 -m 4096 -M 16384 -c 2 -s 3000
    !!!Scheduler set to Round Robin with priority 99 FAILED!!!
    Playback device is hw:0,7
    Capture device is plughw:3
    Parameters are 44100Hz, S16_LE, 2 channels, non-blocking mode
    Poll mode: no
    Loop limit is 132300000 frames, minimum latency = 4096, maximum latency = 16384
    Hardware PCM card 0 'HD-Audio Generic' device 7 subdevice 0
    Its setup is:
      stream       : PLAYBACK
      access       : RW_INTERLEAVED
      format       : S16_LE
      subformat    : STD
      channels     : 2
      rate         : 44100
      exact rate   : 44100 (44100/1)
      msbits       : 16
      buffer_size  : 4096
      period_size  : 2048
      period_time  : 46439
      tstamp_mode  : NONE
      tstamp_type  : MONOTONIC
      period_step  : 1
      avail_min    : 2048
      period_event : 0
      start_threshold  : 2147483647
      stop_threshold   : 4096
      silence_threshold: 0
      silence_size : 0
      boundary     : 4611686018427387904
      appl_ptr     : 0
      hw_ptr       : 0
    Plug PCM: Route conversion PCM (sformat=S16_LE)
      Transformation table:
        0 <- 0
        1 <- 0
    Its setup is:
      stream       : CAPTURE
      access       : RW_INTERLEAVED
      format       : S16_LE
      subformat    : STD
      channels     : 2
      rate         : 44100
      exact rate   : 44100 (44100/1)
      msbits       : 16
      buffer_size  : 4096
      period_size  : 2048
      period_time  : 46439
      tstamp_mode  : NONE
      tstamp_type  : MONOTONIC
      period_step  : 1
      avail_min    : 2048
      period_event : 0
      start_threshold  : 2147483647
      stop_threshold   : 4096
      silence_threshold: 0
      silence_size : 0
      boundary     : 4611686018427387904
    Slave: Hardware PCM card 3 'USB Audio Device' device 0 subdevice 0
    Its setup is:
      stream       : CAPTURE
      access       : MMAP_INTERLEAVED
      format       : S16_LE
      subformat    : STD
      channels     : 1
      rate         : 44100
      exact rate   : 44100 (44100/1)
      msbits       : 16
      buffer_size  : 4096
      period_size  : 2048
      period_time  : 46439
      tstamp_mode  : NONE
      tstamp_type  : MONOTONIC
      period_step  : 1
      avail_min    : 2048
      period_event : 0
      start_threshold  : 2147483647
      stop_threshold   : 4096
      silence_threshold: 0
      silence_size : 0
      boundary     : 4611686018427387904
      appl_ptr     : 0
      hw_ptr       : 0
    Trying latency 4096 frames, 92879.819us, 92.879819ms (10.7666Hz)

The Linux distribution is Arch, the kernel is 5.6.10-arch1-1, x86_64 GNU/Linux. Thank you.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/53
Repository URL: https://github.com/alsa-project/alsa-lib
