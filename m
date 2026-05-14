Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ECCCD4F39
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2026 13:39:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65731601F8;
	Thu, 14 May 2026 15:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65731601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778765981;
	bh=ZNdw6NdIJeJXeR+RT9p/Yd5j8Rhaonea5rOWBYpXPZQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=h09P3rtd6+Bc+7cHUJ8szPcWXAN/C8SjeZ008NHLVhwbaGFCJ/kJgUR2vxjAY66/G
	 VWLGFXYYzINTptWpSqd3OxHFtE2EvVbogEYWrTtgi+1q2TTIMIut5I9Y2+MH7J907J
	 LK/+704mi/iXLCkyrwzf2YgtW9y3I1JP109OUBC8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34564F805F3; Thu, 14 May 2026 15:39:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D99C5F805F1;
	Thu, 14 May 2026 15:39:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 307FAF8021D; Thu, 14 May 2026 15:38:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F3E41F800D2
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2026 15:38:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3E41F800D2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18af7231e6aacf00-webhooks-bot@alsa-project.org>
In-Reply-To: <18af7231e680fa00-webhooks-bot@alsa-project.org>
References: <18af7231e680fa00-webhooks-bot@alsa-project.org>
Subject: ALSA PCM playing stops randomly, write buffer fills up
Date: Thu, 14 May 2026 15:38:59 +0200 (CEST)
Message-ID-Hash: ERBNGORMNCBU4ABTVCZH46AWQ6UBNRJR
X-Message-ID-Hash: ERBNGORMNCBU4ABTVCZH46AWQ6UBNRJR
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ERBNGORMNCBU4ABTVCZH46AWQ6UBNRJR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #506 was edited from brucemack:

Hi:

I have simple ASLA application that exhibits a strange behavior. I would welcome any advice for improved debug techniques.

My program is non-blocking with a single playback handle.
My program is a loop that plays a tone that lasts for 2 seconds, with a 1 second gap.
While the tone is active my program writes a 20ms block of audio (960 PCM samples x 2 channels at 48k) every 20ms. 
My buffer time is set to 320ms (plenty of space).
My start threshold is set to 1200 frames.
The audio hardware is a USB-connected device using a CM108B chip.

My program runs very nicely with good audio quality for several minutes.  The delay/available pointers move around exactly the way I'd expect and the delay never goes above 2000 frames when the tone is playing. Production and consumption of audio are perfectly matched in a smooth stream.

The state also looks good - it moves from XRUN to prepared to running and back to XRUN as the tone starts and stops.

After several minutes, the delay suddenly starts to rise (and the available space falls) to the point where snd_pcm_writei() won't accept any more data. It gets stuck like this forever.

Strangely, when I kill the program and restart it everything is fine until this repeats several minutes later.

>From my diagnostic prints (see below) it seems like the play buffer just suddenly stops getting consumed, even though the state is still running (3).

I would be grateful if someone could suggest an idea for diagnosing this problem.

arduino@Q1:~/amp-server/build$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version k6.16.7-g0dd6551ae96b.

I: 05-14 00:52:00.780 Turning off tone
I: 05-14 00:52:00.800 Playback state change (2801) 3 -> 4 [1536, 14400]
I: 05-14 00:52:00.820 Playback state change (2802) 4 -> 2 [0, 15360]
I: 05-14 00:52:00.820 Delay/avail 0 / 15360 frames
I: 05-14 00:52:01.780 Turning on tone
I: 05-14 00:52:01.800 Delay/avail 960 / 14400 frames
I: 05-14 00:52:01.820 Playback state change (2852) 2 -> 3 [1536, 14400]
I: 05-14 00:52:01.820 Delay/avail 1536 / 14400 frames
I: 05-14 00:52:03.780 Turning off tone
I: 05-14 00:52:03.800 Playback state change (2951) 3 -> 4 [1536, 14400]
I: 05-14 00:52:03.820 Playback state change (2952) 4 -> 2 [0, 15360]
I: 05-14 00:52:03.820 Delay/avail 0 / 15360 frames
I: 05-14 00:52:04.780 Turning on tone
I: 05-14 00:52:04.800 Delay/avail 960 / 14400 frames
I: 05-14 00:52:04.820 Playback state change (3002) 2 -> 3 [1536, 14400]
I: 05-14 00:52:04.820 Delay/avail 1536 / 14400 frames
I: 05-14 00:52:06.780 Turning off tone
I: 05-14 00:52:06.800 Playback state change (3101) 3 -> 4 [1536, 14400]
I: 05-14 00:52:06.820 Playback state change (3102) 4 -> 2 [0, 15360]
I: 05-14 00:52:06.820 Delay/avail 0 / 15360 frames
I: 05-14 00:52:07.780 Turning on tone
I: 05-14 00:52:07.800 Delay/avail 960 / 14400 frames
I: 05-14 00:52:07.820 Playback state change (3152) 2 -> 3 [1536, 14400]
I: 05-14 00:52:07.820 Delay/avail 1536 / 14400 frames
I: 05-14 00:52:09.780 Turning off tone
I: 05-14 00:52:09.800 Playback state change (3251) 3 -> 4 [1536, 14400]
I: 05-14 00:52:09.820 Playback state change (3252) 4 -> 2 [0, 15360]
I: 05-14 00:52:09.820 Delay/avail 0 / 15360 frames
I: 05-14 00:52:10.780 Turning on tone
I: 05-14 00:52:10.800 Delay/avail 960 / 14400 frames
I: 05-14 00:52:10.820 Playback state change (3302) 2 -> 3 [1920, 13440]

**PROBLEM STARTS HERE**

I: 05-14 00:52:10.820 Delay/avail 1920 / 13440 frames
I: 05-14 00:52:10.840 Delay/avail 2880 / 12480 frames
I: 05-14 00:52:10.860 Delay/avail 3840 / 11520 frames
I: 05-14 00:52:10.880 Delay/avail 4800 / 10560 frames
I: 05-14 00:52:10.900 Delay/avail 5760 / 9600 frames
I: 05-14 00:52:10.920 Delay/avail 6720 / 8640 frames
I: 05-14 00:52:10.940 Delay/avail 7680 / 7680 frames
I: 05-14 00:52:10.960 Delay/avail 8640 / 6720 frames
I: 05-14 00:52:10.980 Delay/avail 9600 / 5760 frames
I: 05-14 00:52:10.000 Delay/avail 10560 / 4800 frames
E: 05-14 00:52:10.000 Delay is growing
I: 05-14 00:52:11.220 Delay/avail 11520 / 3840 frames
E: 05-14 00:52:11.220 Delay is growing
I: 05-14 00:52:11.440 Delay/avail 12480 / 2880 frames
E: 05-14 00:52:11.440 Delay is growing
I: 05-14 00:52:11.660 Delay/avail 13440 / 1920 frames
E: 05-14 00:52:11.660 Delay is growing
I: 05-14 00:52:11.880 Delay/avail 14400 / 960 frames
E: 05-14 00:52:11.880 Delay is growing
I: 05-14 00:52:12.100 Delay/avail 15360 / 0 frames
E: 05-14 00:52:12.100 Delay is growing
E: 05-14 00:52:12.300 USB BUFFER FULL, state 3 15360 0
I: 05-14 00:52:12.780 Turning off tone
I: 05-14 00:52:13.781 Turning on tone
E: 05-14 00:52:14.300 USB BUFFER FULL, state 3 15360 0
I: 05-14 00:52:15.780 Turning off tone
I: 05-14 00:52:16.780 Turning on tone
E: 05-14 00:52:16.781 USB BUFFER FULL, state 3 15360 0

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/506
Repository URL: https://github.com/alsa-project/alsa-lib
