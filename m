Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C95F46101
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:34:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65F67601F5;
	Mon, 23 Mar 2026 14:34:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65F67601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774272893;
	bh=fJSe2c+5DKesNbsvyu7SGa5484mJci3yxmc25EHQhGA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XKFySIQw+rnUifhHlDyNZQ+HfgH7yo/wUDPUZ4X/LhHsp1T7gJHDpg3u7V3vdbedj
	 4GB/6yQ/2eWiO8ORtxDwFjiApxdxG0JkbxVW8ZNVlOhtP6lEOnK1NS3jXEPeLmmEeF
	 tqkpPn+MaZJFaQvfGrz7cKx5uIp1pqdcnLOFBLRI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA8C7F805EF; Mon, 23 Mar 2026 14:34:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E50FF805F4;
	Mon, 23 Mar 2026 14:34:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E93FF80496; Mon, 23 Mar 2026 14:34:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AA676F800FE
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2026 14:34:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA676F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZetfnwVP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774272845; x=1805808845;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=fJSe2c+5DKesNbsvyu7SGa5484mJci3yxmc25EHQhGA=;
  b=ZetfnwVPqLP33w1aVH3A+09yGAAmMzOC7oJhUxb9TT3hJZMpVmMr0F/E
   EMyV2VpQ/5mgcfI9TnPG3dGrNmhQ1HwamcAaOxTFMl5JzhzhfWA7w6kAi
   YFRqKRoIm5o2lOwM2SkBx7UzMZi0txLxeS2uKBis4hKA7t9/ec4G+CwCI
   +MKX9A/TY9UzZdGVBMWBIkruTWIHRyj3kIGg5NxT/WQA5+agefqY0FGn0
   uhTQrPwZ11if04T8lCxkUKk48e02q/BlHojncbNw7YP+W7KkJER9ZRHBY
   nSLaSjirS1fYNUdSZSgL5IBGgEkSKqbyVqAviPz+qi+DL3Z2SSddfwlnN
   A==;
X-CSE-ConnectionGUID: 0hHkPEgORTeU/fcPqdr4og==
X-CSE-MsgGUID: d1ETdEiVT86KPtXrlgaKjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75292651"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000";
   d="scan'208";a="75292651"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 06:34:01 -0700
X-CSE-ConnectionGUID: QSg06LASS/WsCOWcasgIRQ==
X-CSE-MsgGUID: 3mlNk/pURpCFQtHz27MqOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000";
   d="scan'208";a="228502793"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.12])
 ([10.245.244.12])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 06:33:59 -0700
Message-ID: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
Date: Mon, 23 Mar 2026 15:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
 wim.taymans@gmail.com
Subject: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for 'jumpy
 DMA'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3RKW6D2MGHQKQEJTWT4YO7OXE645WUMQ
X-Message-ID-Hash: 3RKW6D2MGHQKQEJTWT4YO7OXE645WUMQ
X-MailFrom: peter.ujfalusi@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3RKW6D2MGHQKQEJTWT4YO7OXE645WUMQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

for years the discussion around jumpy, bursty DMA have been popping up
and we always concluded that we are missing a good definition and agreed
way between kernel and user space to handle this.

In ALSA it is expected that the DMA (hw_ptr) moves in steady small
steps. There is a BATCH mode which tells that the DMA cannot report sub
period size position, progression.
The DMA bursting fits neither of this, it moves in bigger jumps (bursts)
and it can as well can report position in byte level.

Typically these systems have DSP which can consumes data in various
chunks, making the hw_ptr to jump. Over time the hw_ptr do move at the
sampling rate, but when zooming in we can see:
initial jump of X frames, hw_ptr stays static for about ~X frame worth
of time then the hw_ptr jumps again ahead of X frames, and again, hw_ptr
stops, ...

This can be a problem for user space which wants to write samples as
close to hw_ptr as possible since if it is not aware of the bursty-DMA
than it is possible that a burst will jump over the sw_ptr, causing xrun.

I was looking at what, how and where we should add this information in
kernel and to take it in use by user space when I stumbled across the
'fifo_size' of hw_params struct.

It is only set by a few drivers:
sound/arm/aaci.c
sound/arm/pxa2xx-pcm-lib.c
sound/soc/renesas/dma-sh7760.c
sound/soc/starfive/jh7110_tdm.c
sound/soc/tegra/tegra_pcm.c
sound/soc/xtensa/xtfpga-i2s.c
sound/usb/misc/ua101.c
sound/x86/intel_hdmi_audio.c

It's definition is awkwardly a bit different in kernel and alsa-lib:
in kernel it can be in bytes or frames, but in user space it is always
in frames (snd_pcm_hw_params_get_fifo_size).

So far I could not find evidence that this is in active use by user
space. Not used in alsa-utils, pipewire, pulseaudio at least and web
search came back empty handed as well.

My proposal thus is to re-use, re-define extend the fifo_size as and
indication that the hw_ptr _can_ jump at least fifo_size number of
frames so applications must take this into account when doing direct
update in ALSA buffer for low latency.

Or should we add a new member (carved out from the reserved section of
hw_params struct) specifically for this purpose, like dma_burst_size,
which likely going to be equal to fifo_size if both is filled by the driver.

Or a new flag (SNDRV_PCM_INFO_) that PCM devices can use to indicate
that the DMA is bursting and in that case the fifo_size holds the number
of frames that it is expected to jump.
But we are slowly running out of bits and I'm not sure if it is a good
idea to dual use in kernel internal bits for user ABI
(SNDRV_PCM_INFO_DRAIN_TRIGGER, SNDRV_PCM_INFO_FIFO_IN_FRAMES)

https://github.com/thesofproject/linux/issues/5313
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4489

-- 
Péter

