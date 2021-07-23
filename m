Return-Path: <SRS0=VrYT=MP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F8C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 18:44:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6093E60F12
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 18:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6093E60F12
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1096D174F;
	Fri, 23 Jul 2021 20:43:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1096D174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627065843;
	bh=uNxXdectPxMFScvNdh74b4fCYHexoD5ySRoyQEKOSr4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vUW4Luglm2wRrxwHf0AP0vPoVkHSmcauRu3x+22huE1fEHOGzEFtzeZ9Sv9OX4X5t
	 mXTBFNsvag3mTn7gPuPxYWyocLuhB8HqQSwiCM3tkbPWYX6dQDazZO+FPV8aG0ZMBY
	 VOHeN8wNhhnRblFwUzPTZG3LmNepIojTJpmK/7Qw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D160F804AB;
	Fri, 23 Jul 2021 20:43:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DA5FF804AC; Fri, 23 Jul 2021 20:43:11 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A166DF8016C
 for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2021 20:43:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A166DF8016C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1627065781931773901-webhooks-bot@alsa-project.org>
References: <1627065781931773901-webhooks-bot@alsa-project.org>
Subject: kbl-r5514-5663-max Headphone does not work
Message-Id: <20210723184311.5DA5FF804AC@alsa1.perex.cz>
Date: Fri, 23 Jul 2021 20:43:11 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #108 was opened from jmontleon:

On a Pixelbook I have copied these firmware files in place:
- /opt/google/dsm/dsmparam.bin
- /lib/firmware/9d71-GOOGLE-EVEMAX-0-tplg.bin
- /lib/firmware/dsp_lib_dsm_core_spt_release.bin
- /lib/firmware/intel/dsp_fw_C75061F3-F2B2-4DCC-8F9F-82ABB4131E66.bin

With that alone the speakers started working after a reboot.

I have been trying to modify the ucm HiFi.conf to ucm2 on Fedora. If I comment out all of `SectionDevice."Headphones"` the speakers and internal microphone work. If I leave it I see a bunch of error messages in dmesg. Pulseaudio also produces some error messages and then just loads a dummy device.

dmesg:
```
[ 7866.107942]  Kbl Audio Headset Playback: ASoC: no backend DAIs enabled for Kbl Audio Headset Playback
[ 7866.107950]  Kbl Audio Headset Playback: ASoC: dpcm_fe_dai_prepare() failed (-22)
```

pulseaudio:
```
D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 21845 ms
I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_PREPARE failed (-22)
I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_PREPARE failed (-22)
I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_PREPARE failed (-22)
I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_PREPARE failed (-22)
D: [pulseaudio] alsa-util.c: Set neither period nor buffer size.
I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_PREPARE failed (-22)
I: [pulseaudio] alsa-util.c: snd_pcm_hw_params failed: Invalid argument
D: [pulseaudio] alsa-util.c: Trying plug:_ucm0006.hw:kblr55145663max,2 with SND_PCM_NO_AUTO_FORMAT ...
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameter 1
I: [pulseaudio] (alsa-lib)conf.c: Parse arguments error: No such file or directory
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM plug:_ucm0006.hw:kblr55145663max,2
I: [pulseaudio] alsa-util.c: Error opening PCM device plug:_ucm0006.hw:kblr55145663max,2: No such file or directory
D: [pulseaudio] alsa-mixer.c: Profile set 0x555cededf730, auto_profiles=no, probed=yes, n_mappings=0, n_profiles=0, n_decibel_fixes=0
E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id="0" name="platform-kbl_r5514_5663_max" card_name="alsa_card.platform-kbl_r5514_5663_max" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""): initialization failed.
I: [pulseaudio] module-udev-detect.c: Card /devices/platform/kbl_r5514_5663_max/sound/card0 (alsa_card.platform-kbl_r5514_5663_max) failed to load module.
```

>From reading I gather there's probably some routing incorrectly or incompletely set up that is the cause, but I'm at a bit of a loss on where to go from here.

I saw a suggestion somewhere to set this module option, but as far as I can tell it makes no difference:
```
cat /etc/modprobe.d/dsp.conf 
options snd_intel_dspcfg dsp_driver=2
```


Not really an alsa / ucm problem as far as I am aware but in the interest of giving as much info as possible I originally switched to pulseaudio because I had an easier time finding meaningful logs. I switched back to pipewire later to realize the mic is just producing awful noise so I went back to pulseaudio for the time being. Might need to file a pipewire bug later.

The HiFi.conf and alsa-info are attached.

[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/6870590/alsa-info.txt)
[Hifi.conf.txt](https://github.com/alsa-project/alsa-ucm-conf/files/6870593/Hifi.conf.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/108
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
