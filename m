Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1609109B46F
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:10:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 762EE601F4;
	Tue, 31 Mar 2026 16:10:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 762EE601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774966215;
	bh=2w0ngJrbmXF6tUy0LlRP0HjJJny1NVtHmHBUcUFcOZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dqLGAFZ+7yCocWKUFT7/oKM3B0YnxYFJ9X3YwiCuolBuNh8EAtN17fKVvwZW2Zwkd
	 d+gs+X7bxsaspe8Rz/FvvvHVh8vgQ2o2/KdRFUlbh4VM9HyUH3qBMIHa9aw/Ic5wr/
	 rR0WF+pctfmfxmguS/VTbYvzSBuJnZqTVEZL8BQw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2066BF805F6; Tue, 31 Mar 2026 16:09:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 80F86F805F2;
	Tue, 31 Mar 2026 16:09:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73E05F80549; Tue, 31 Mar 2026 16:09:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 682FEF804CC
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 16:09:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 682FEF804CC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kyh2mWmo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774966168; x=1806502168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2w0ngJrbmXF6tUy0LlRP0HjJJny1NVtHmHBUcUFcOZA=;
  b=kyh2mWmonFQ9rZNdNbKj/pE5h5y6Fb1WajlksEh5Bq3ybXphWLbe1/j8
   HRt6XyAecPwGUykOv30TtqjWu8L5p7cFpmPN7BOZVy3Viat0c6VUhTggR
   ePHmIJSi5+e0oyJoZfe0b/gdqFcqS55f+mDCL7G/pZ17QwvVJIaBKbK2K
   Cpy4Cocawrmj/XNuqRdpDf1WOq6XfSTZ9XzBXCPdEjorN9p0SeiMD2553
   do+IZZ/QkbF+pOoff4QNdQKnj/0VU8FivEcv6zxJBhEKmZax8sSaNMajY
   jeFQELV6+9VnRB0+jydQ8Owh3nCyNcx5/8WYTwP82UliTVvU8od4Chrud
   w==;
X-CSE-ConnectionGUID: TqW9OkWtSlCQ4QZd5OF5gA==
X-CSE-MsgGUID: jZV5TOwlT6epzXbg9JgD3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76092913"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000";
   d="scan'208";a="76092913"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 07:09:10 -0700
X-CSE-ConnectionGUID: xomyWnABScGrwXl+ZBG1Aw==
X-CSE-MsgGUID: XE3EYAwDQ+2uCIEQhuHOxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000";
   d="scan'208";a="219725950"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.218])
 ([10.245.245.218])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 07:09:08 -0700
Message-ID: <4c73e4cb-298a-411a-97ed-f0eff1b06ac9@linux.intel.com>
Date: Tue, 31 Mar 2026 17:09:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
 wim.taymans@gmail.com
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
 <87se9htms4.wl-tiwai@suse.de>
 <67b9f48b-1cc7-4dac-8f6a-c0cba6a84b36@linux.intel.com>
 <87ikadtgpe.wl-tiwai@suse.de>
 <dadef18b-1c2e-4c0d-8ae8-2e4b8ad75d04@linux.intel.com>
 <878qb8tsib.wl-tiwai@suse.de> <88979231-caef-4eaa-b89d-22e6973c92f9@perex.cz>
 <cfb84df3-c2bf-4173-bc45-7df29b6a94a3@linux.intel.com>
 <a1b6b2ed-2e26-48ff-afab-60f90ecc4360@perex.cz>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <a1b6b2ed-2e26-48ff-afab-60f90ecc4360@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: G6XSJXLULXO73TZNWLYYFIIJQJLT2VSZ
X-Message-ID-Hash: G6XSJXLULXO73TZNWLYYFIIJQJLT2VSZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G6XSJXLULXO73TZNWLYYFIIJQJLT2VSZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 31/03/2026 15:00, Jaroslav Kysela wrote:
> On 3/31/26 12:56, Péter Ujfalusi wrote:
> 
>> Pipewire uses the minimum period size internally for headroom
>> calculation:
>> https://gitlab.freedesktop.org/pipewire/pipewire/-/
>> commit/9c42c06af00818038be494fd41632cb2d50a0df5
>>
>> This works more or less, but things started to get out of control soon.
> 
> It's conditional, so it's not a general rule. Pipewire just tries to
> push the drivers to limits with hard-coded assumptions.
> 
>> To get the most power saving benefit, you would want quite big
>> DeepBuffer, let's say 100ms but for video/voice calls you don't want
>> this big buffer, around 40ms should be OK, some other use case might
>> need something in between.
>> If you run tinyplay on the DeepBuffer PCM w/o  specifying period size,
>> it will fail to find the minimum and outright fails unless we lower the
>> DB to around 20ms.
>> With 20ms you don't have much power savings in case of audio playback.
>> So, you spam out several PCM devices with different DeepBuffer to
>> accommodate use cases, this is really not something that makes sense.
>>
>> This is the reason why I have reversed the rules and adjusted the
>> DeepBuffer size based on the period size.
>> In this case we still need to limit how large the DB can be, so it is
>> not true that the DeepBuffer equals to the period size, it is caped.
> 
> It seems that the discussion somewhere else:
> 
> 1) applications don't know what they are want, thus driver will enforce
> a configuration (e.g. a forced deep buffer)
> 
> 2) ALSA PCM period mapping to the hardware which allows "deep buffering"

With SOF we don't advertise the use of the DeepBuffer enabled PCM, it is only used on consumer devices where the audio HAL knows how to use it.
The static-DB and the dynamic-DB both works fine with applications, like mplayer, mpv, vlc, the only issue is with pipewire (which is not aware of it).
What I want is to achieve at the end is to advertise this via UCM's low-power-hifi, but due to the bursts, Pipewire can get xrun.

> At the moment, nothing prevents ALSA applications to use the bigger
> period sizes when there are known beforehand like "play background
> music". In other words - power efficiency can be controlled from the
> app.

But with a static-DB and locking t he period size to the DB size would prevent bigger period size use and even with bigger period size, if the DB size is 'small' then the power efficiency is out of the window.
But, if we increase the static-DB size then we limit the minimum period size to scale down.

> The applications can also update PCM buffer at any time, so new
> data (we are speaking about playback) can be feed at any time to make
> the time window for the underrun occurrence shorter when the driver
> transfers data to the hardware.

Yes, pipewire does this, it does not care about the period size while media players do. I guess most application which uses NO_PERIOD_WAKEUP does this, they don't care about period boundaries.
They look at avail (hw_ptr, sw_ptr, delay) and work on manage the data in buffer as close to hw_ptr as possible.

> 
> We may have those configurations (* = future when driver tells the
> initial count of queued periods):
> 

>  period | period count | init_periods  | minimal data latency |
> --------+--------------+---------------+----------------------+---------
>  4ms    | 4            | unsettled (1) | 4ms                  | realtime
> *4ms    | 200          | 25            | 100ms                | semi-realtime
>  1000ms | 2            | 1             | 1000ms               | pwr efficient

SOF specific, but we limit the period size to be min 8ms to unbrake pipewire to avoid xzrun on start and xrun handling and to hint application what is safe.
Also: we cannot scale the DeepBuffer infinitely, it is carved out from the DSP's SRAM, so it is limited.
period size=1000ms with DeepBuffer=100ms is perfectly valid configuration, as well period size=50ms with DeepBuffer=50ms, as well period size=1000ms with 4ms non-deepbuffer.
 
>> Strictly locking the DeepBuffer with period size creates another
>> obstacle for audio applications, audio servers like PW don't care about
>> periods, they work on the buffer with timer based updates and rewriting
>> samples in buffer ahead of the hw_ptr.
> 
> IMHO, the period size describes the expected minimal latency and
> applications can put more samples to the PCM buffer. So the whole
> question is to give suggestions which data threshold is safe for the
> standard operation.

Yes, it is and not. PW allocates big period sizes and manages really low latencies when it comes to audio.
And yes, the question is the 'headroom' that is safe to use by applications when dealing with something which is jumpy

> The timer based queuing should just help to feed data more frequently,
> but it does not mean that applications should not set the period size
> based on the requirements. Ideally, everything should be coordinated -
> period sizes with proper sample feed timing from the application side.

Right, but, but, in normal PCM of SOF, the ShallowBuffer is 4ms, we cannot set constraint for the period size to be min and max 4ms, that would xrun right away.
And this would just bring in the issue of the static DB that we have, if it is big, then applications would break if they want smaller periods.

BTW, should we still keep the dynamic DeepBuffer as a way from the kernel to do things automatically? It will allow unaware ALSA applications to gain this for free, but it needs information to be given to clever ones (like PW) on how to deal with the jumps.

Again: the deep buffer is not in use by user space, we just think that it is a great feature to have and would benefit laptop users if they listen to music with the screen blanked.

-- 
Péter

