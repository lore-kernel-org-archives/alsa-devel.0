Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5055AFC97F3
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:16:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA3C9601F7;
	Mon, 30 Mar 2026 17:16:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA3C9601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774883776;
	bh=PKNUCePXCjzDc9dM2FdtEZ/Ozzr24NKKzl0tB2sVhlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=COSfIO8ugv3MBeEF/D9eTYEJHdLvU+pPGZiNqN0RbBGAgjq0i9pNf6GgjiAMUgtFz
	 I4RjyWZm3+qOYXJOUeH5naSZUpFrgK+3tkIuMGchmx/kvaTdJheLXqCmqoprniWRap
	 j0h7Q5PvjJUWAH0nt2Zl7ExGgt9viTUbFLWGjS8U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DB25F805E5; Mon, 30 Mar 2026 17:15:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 01A19F805F4;
	Mon, 30 Mar 2026 17:15:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81D61F8052D; Mon, 30 Mar 2026 17:15:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B81C3F8021D
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 17:15:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B81C3F8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ANw6e9nW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774883729; x=1806419729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PKNUCePXCjzDc9dM2FdtEZ/Ozzr24NKKzl0tB2sVhlk=;
  b=ANw6e9nWwZgheZKZoK9ya6/OBhWdNohYdbU4Os7B835RK878f2PYDBzc
   njnHKuP1HzdvVMqPeHjLJP3thy5mJzvALANzqxNqsbrOMCdNhG0BQT80y
   0V7uRmYGtiT2gLT4QpaUARniNLVBRi27/Heftj0Zh8/ZO4z0j8HBVz48U
   wyBAcAcZx9kGc6bW5MWhu5RxQWhhow11kj2IDxcq1TzeDSILXim6Q7mOk
   GpvVZGSTk9RRYXlD67Lh0XloXNmC2Bh7wFru7/AvHEgCb1F2S9its2Q2y
   ci24TFtoQ1UcoPqcUWNpXGOxUUe8173QZpxoBySrIxGttZRmJeh/DahS2
   g==;
X-CSE-ConnectionGUID: to2+nCbiRFafGEfxZfKK+w==
X-CSE-MsgGUID: U6i+NDPuQ5y7+0sdwpvzSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79743164"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000";
   d="scan'208";a="79743164"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 08:15:25 -0700
X-CSE-ConnectionGUID: BVTVLSKQRBeOldDlGRWNkw==
X-CSE-MsgGUID: YFQby36KQB6V8g65YV0r2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000";
   d="scan'208";a="230903400"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.70])
 ([10.245.245.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 08:15:23 -0700
Message-ID: <67b9f48b-1cc7-4dac-8f6a-c0cba6a84b36@linux.intel.com>
Date: Mon, 30 Mar 2026 18:15:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
 wim.taymans@gmail.com
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
 <87se9htms4.wl-tiwai@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <87se9htms4.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LCVMMPPOXAV6BR5RZNX6ANR2SD2AZ3Z7
X-Message-ID-Hash: LCVMMPPOXAV6BR5RZNX6ANR2SD2AZ3Z7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LCVMMPPOXAV6BR5RZNX6ANR2SD2AZ3Z7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 30/03/2026 17:27, Takashi Iwai wrote:
>> https://github.com/thesofproject/linux/issues/5313
>> https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4489
> 
> Sorry to be late in the game as I was off in the last weeks, and
> slowly catching up.  So, I'm reading this thread from the beginning,
> and wondering what is needed from user-space API POV.

This discussion is stretches back a decade or so, few weeks do not matter ;)

> First off, we do already have a way to report a fine-grained playback
> pointer as "delay" even in jumpy hw_ptr updates as long as the driver
> supports it;

The delay reporting with the jumpy hw_ptr works great, most application
on Linux uses it (mplayer, mpv, vlc, pipewire, pulseaudio, etc).
Chromium's alsa_conformance ironically did not, but it is for some times
now:
https://chromium.googlesource.com/chromiumos/platform/audiotest/+/eccd8be776d45a2e3b3006d74f174ff216cb01d8%5E%21/#F0

> e.g. a few drivers for hardware with packet-based
> transfers like USB-audio support that mode.  Doesn't it suffice for
> your need?

There is no real way to express the jumpy hw_ptr, it is not really
packet mode (while in some sense it is, but rather not) and the BATCH
mode certainly not a fit.

> And, if a more different parameter is required and defined, how an
> application can use it?  An application can read/write PCM parameters,
> write PCM data (either via mmap or write/ioctl), and sleep/wakeup via
> poll() -- basically that's all.  Would the new parameter influence on
> the poll wakeup behavior?  Or who controls in which way?

The main target at the moment is pipewire in Linux, it uses mmap and
timer (no period wakeup) to process audio in the most efficient way. It
can fall back to non mmap and poll, but that comes with lots of drawback
in power consumption and CPU use.

We have the default configuration of SOF working now fine with it's
jumpy-DMA, which is:
4ms host facing buffer inside of DSP and 1ms DMA bursts every 1ms.
This translates:
when audio starts, before 1ms elapsed the hw_ptr will be pointing to the
sample at 5ms, 4ms has been sent to the DSP, when 1ms elapsed from the
playback, the hw_ptr is at 6ms, you can say that it is 4ms ahead of the
playback progress viewed in the host facing buffer of the DSP.
But, this 4ms is not the delay, the delay is a different thing, which
includes the 4ms plus processing path within the DSP.

The issues at hand is that we need to tell the applications about this
so they can work out how to manage the mmaped area.
They must provide enough data on start - 1ms is not enough as the DMA
jumps 4ms, 4ms is likely not enough, unless the application can be sure
it can provide more data with 1ms - when the DMA will move 1ms ahead.

I have other examples in later mails for different configurations.

This is not really about delay, it is not really fits into BATCH mode
either.

-- 
Péter

