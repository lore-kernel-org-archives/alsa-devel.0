Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969A9FF60FF
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:57:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A13EF601F5;
	Tue, 31 Mar 2026 12:56:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A13EF601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774954620;
	bh=lSBUzqMO/uGc0GfI5KdUEO2OB3v/FAZmUcEDUbaxJUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aHOL8Mf2iJLHbf6Xz4sqfX5Vlh5DKF08t1Zm5y2OYxe6pxG6BXNJh7mlsoOPj7mBB
	 hgpKBzWUA28sAZ9g3xY5Y/wnxUp15CHh/MQ11aYqM6OxJhp4rJ3vBEzAMguT4jq/+i
	 RWql/XveBdeNcS8zaV3oH+U593kvlkAahyT1TgPI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27F64F805EE; Tue, 31 Mar 2026 12:56:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3EBCF805F2;
	Tue, 31 Mar 2026 12:56:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D31FF80549; Tue, 31 Mar 2026 12:56:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F39FBF80087
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 12:56:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F39FBF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e28o8tZ2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774954572; x=1806490572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lSBUzqMO/uGc0GfI5KdUEO2OB3v/FAZmUcEDUbaxJUY=;
  b=e28o8tZ228ZwP64ayM/4rpH9FkHI+kJouMmwWZCvdp9E8XwQvN+yo5L2
   ZeECIKkf9Uj8nAXCDquOHJ4cG1GWbaon7QwpvlJKrMPUEMDqMc6ECuX4o
   QdzHhSMhFgD6oBGAwIRC8KgZUCU49FYw7fIeyXzoM7dV6xRNTmbUJQJek
   4u/T/ipTTzRchYLxZvOF5K4XUK+rKfIHJhlw6dHUgEINre1kYp8q/z1RC
   gtuuO3B8SDHrjodjw04U6IorR3eogO4TsoOikgb773WjD7HkI+qbYDgKe
   dUTXUzL9SNH++I1AHTcXQIE3QRnn7+nWYJ91gG/PtY/8I+DRrS4sM8hCO
   w==;
X-CSE-ConnectionGUID: Vp30MRkhTb2XLe3Jc8VZ2A==
X-CSE-MsgGUID: uo8oq/ncQl2tIjbL4kVLIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="78556626"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000";
   d="scan'208";a="78556626"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 03:56:08 -0700
X-CSE-ConnectionGUID: 0h4NUDYZSCKtGCHlzL0ETg==
X-CSE-MsgGUID: yLeo97fdTrisKeRN2y5Glg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000";
   d="scan'208";a="256831214"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.218])
 ([10.245.245.218])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 03:56:06 -0700
Message-ID: <cfb84df3-c2bf-4173-bc45-7df29b6a94a3@linux.intel.com>
Date: Tue, 31 Mar 2026 13:56:22 +0300
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
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <88979231-caef-4eaa-b89d-22e6973c92f9@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XFYO7ZYMIFIIUXJAWAAI3ZM3RO3UE5ZE
X-Message-ID-Hash: XFYO7ZYMIFIIUXJAWAAI3ZM3RO3UE5ZE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XFYO7ZYMIFIIUXJAWAAI3ZM3RO3UE5ZE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 31/03/2026 12:29, Jaroslav Kysela wrote:
> On 3/31/26 08:36, Takashi Iwai wrote:
> 
>>>> if a device allows a different queue size, it should be configurable
>>>> via hw_params.
>>>
>>> I'm not sure if I follow this statement. the fifo_size is a driver to
>>> user space information, driver fills it and user space ignores it ;) - I
>>> cannot find any evidence of it's use.
>>
>> If a chip has a similar constraint but the init and step sizes are
>> adjustable, they should be configurable via hw_params procedure --
>> that's my point.
>>
>>> The init_chunk, step_chunk would be similar, the driver sets it and user
>>> space would use it.
>>>
>>> In SOF this will be dynamic and it will depend on the period size:
>>> https://github.com/thesofproject/linux/pull/5673/
>>> commits/18f3ba5e42212d77019d79ec09b7057a7703d361
>>
>> Well, so even in your case, the driver can implement the hw_constraint
>> for coupling those numbers, too.  Then application may choose the
>> init_chunk or step_chunk, which restricts the period size
>> automatically.  If application doesn't choose those, the hw_params
>> engine will choose depending on the period size, and application can
>> see the values after hw_params call.
> 
> I was more thinking about this problem and it seems that the root of
> this cause is that application (pipewire) is trying to bypass the period
> based mechanism for which we already have the handshake. It's no issue
> to ask for smaller periods from the app side to maintain the expected
> latency. It is also understandable that we need to fill at least two
> periods at start and keep this buffer timing (also with counting the
> system scheduling latencies).
> 
> So, perhaps, the only flag may be added notifying that the (first)
> minimal period is processed immediately after start. It's also common
> situation for other drivers with double buffering in the driver like
> USB, maybe FireWire, right ? Note that this flag won't be the BATCH
> flag. Or we can just add a field notifying how many minimal periods are
> queued at start to be more universal (apparently SOF requires this,
> because the initial chunk of queued samples is bigger then the later
> chunks - so the first transfer will go over more periods).
> 
> We may discuss if small periods are efficient. We have already mechanism
> to disable period events (SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP) and
> drivers don't do usually deep buffering, so they program DMA transfers
> with smaller (or equal) chunks than period size.
> 
> It seems to me that we are trying to design another layer on top of the
> current just to satisfy the improper current PCM API use.
> 
> And saying this, it appears that the kernel drivers (yes SOF) are trying
> the bypass the period constraints make it freely customized [1] instead
> to apply constraints based on the hardware limits including the internal
> maintenance (CPU <-> DSP buffering). So the issue is on both sides and
> the things are failing because the standard period handshake is not
> honored.

The dynamic DeepBuffer support is not upstream for SOF, yet. Currently
we have static DeepBuffer where the topology defines the size of the hos
facing buffer to be used in the DSP.
This is entirely SW concept.
For this static DeepBuffer the kernel will place a constraint on the
minimum period size to not allow it smaller (plus some headroom) than
the DeepBuffer set by the topology file.
Pipewire uses the minimum period size internally for headroom calculation:
https://gitlab.freedesktop.org/pipewire/pipewire/-/commit/9c42c06af00818038be494fd41632cb2d50a0df5

This works more or less, but things started to get out of control soon.
To get the most power saving benefit, you would want quite big
DeepBuffer, let's say 100ms but for video/voice calls you don't want
this big buffer, around 40ms should be OK, some other use case might
need something in between.
If you run tinyplay on the DeepBuffer PCM w/o  specifying period size,
it will fail to find the minimum and outright fails unless we lower the
DB to around 20ms.
With 20ms you don't have much power savings in case of audio playback.
So, you spam out several PCM devices with different DeepBuffer to
accommodate use cases, this is really not something that makes sense.

This is the reason why I have reversed the rules and adjusted the
DeepBuffer size based on the period size.
In this case we still need to limit how large the DB can be, so it is
not true that the DeepBuffer equals to the period size, it is caped.

With the reversed rule we cannot constrain the period size obviously.

Still, with the constrained period size in current static DeepBuffer, PW
is free to do whatever it wants and thus we needed to enforce that the
it is not safe to be closer to the hw_ptr than the minimum period size.

We don't want to allow DeepBuffer on the normal PCM, we still want this
to be available on a special PCM device, use case:
audio plays on DeepBuffer which allows power saving and notifications
are played through normal PCMs - they are mixed in DSP and as soon as
normal PCM is closed we can immediately benefit from the power savings.

Probably a user configurable DeepBuffer can work, but then the kernel
should limit the maximum period size?

Strictly locking the DeepBuffer with period size creates another
obstacle for audio applications, audio servers like PW don't care about
periods, they work on the buffer with timer based updates and rewriting
samples in buffer ahead of the hw_ptr.

> 
>                     Jaroslav
> 
> [1] https://github.com/thesofproject/linux/pull/5673/changes#diff-
> d8bbc05d879b6eee2041d6fc0ee06f050be097ac05b12cfec9b35d89f66d3a84R79-R89
> 
> /*
>  * When the host DMA buffer size is larger than 8ms, the firmware
> switches from       
>  * a constant fill mode to burst mode, keeping a 4ms threshold to
> trigger        
>  * transfer of approximately host DMA buffer size - 4ms after the
> initial burst       
>  * to fill the entire buffer.       
>  * To simplify the logic, above 20ms ALSA period size use the same size
> for host       
>  * DMA buffer, while if the ALSA period size is smaller than 20ms, then
> use a       
>  * headroom between host DMA buffer and ALSA period size.       
>  */
> 

-- 
Péter

