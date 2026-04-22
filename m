Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE27F9EDD7
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:20:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91BA060204;
	Wed, 22 Apr 2026 16:19:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91BA060204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776867607;
	bh=bt4pGrNfouyqD0XrmIu6b6yVtP4EOp2Zsw799fKULhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XnAYtAzGYkXm//CoFBYPnU9D43YTAMpgmXTJeaE26+bk4fo+2KU0VSLaTkMXuvqTQ
	 meWIrZeeu01zkf3/Ruzl6E2Rrvs6LQzBFabKI0MLoiFXg2XVA4LWUgYbxB5k2WBy1H
	 3iuoWVrLY4Vv1I/jIZEVQW+Fx1HbE0kTxGhjBmAM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD6BFF805EB; Wed, 22 Apr 2026 16:19:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 20D8DF805E1;
	Wed, 22 Apr 2026 16:19:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 374FFF80526; Wed, 22 Apr 2026 16:19:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 69AC1F800D2
	for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2026 16:19:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69AC1F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MsM7P+Of
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776867562; x=1808403562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bt4pGrNfouyqD0XrmIu6b6yVtP4EOp2Zsw799fKULhQ=;
  b=MsM7P+Of3ugPJ4pAqQmkwxJgIe8Rt7KHKbNqXSk6cvtuDkywTw3LQeiS
   CzVZrgNklfvhetOgmZlMoymfaE/cS8opD9WlibH4BxuBKQ+sqfM4oYgky
   7FgqciMdRBIOs5g0clYNvsODf83EEd7E+I9KZH4EMNvbJpQDtfR0ikm3h
   UyQgfsXvny8ShHJ611bBBEqPuwk5qp7BksJ0qXIX04PvUdUL+MEfoLexl
   hofa8S18ees4wqg/+0QF1Y4euhLC/dx5Xz3DUEm7tMzv/noX2dRaO0zdZ
   dAvcSQBndArLHtKxTDQ3SXcidlWQB8HmKyyzQwV9+tbWQQUzjAblUbNCK
   Q==;
X-CSE-ConnectionGUID: K/uj+7ttSBmahdW4mdMcBQ==
X-CSE-MsgGUID: Gd7V3f0uTJ+iAynuM5ZZyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="95234686"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000";
   d="scan'208";a="95234686"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 07:19:17 -0700
X-CSE-ConnectionGUID: Ro997VoTS7eb6GwVHkxqCg==
X-CSE-MsgGUID: 3pg/+YE1R26BJiIjYb0o0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000";
   d="scan'208";a="229700159"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.245.178])
 ([10.245.245.178])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 07:19:15 -0700
Message-ID: <8af520bc-cb27-416a-b823-7a21f0784f89@linux.intel.com>
Date: Wed, 22 Apr 2026 17:19:10 +0300
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
 <4c73e4cb-298a-411a-97ed-f0eff1b06ac9@linux.intel.com>
 <978bdc67-b91e-437a-bb8a-b609a4fef6d1@perex.cz>
 <b97ae6b9-ef72-4dbf-bf29-9092ec3919d8@linux.intel.com>
 <82d870b3-4ec1-440a-ae8b-87edbf665b99@perex.cz>
 <542a9743-2a47-477a-b457-ae32c3f8dc49@linux.intel.com>
 <39fcca55-77f4-4cd9-8a94-d80e5b94c8ba@perex.cz>
 <401a7777-e83c-4120-9d82-71388bf38397@linux.intel.com>
 <b9308972-1795-44c5-9263-ab9f88013215@perex.cz>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <b9308972-1795-44c5-9263-ab9f88013215@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DGHQVL4SB6HJZJYHB6ASZDEYQN24Q5SB
X-Message-ID-Hash: DGHQVL4SB6HJZJYHB6ASZDEYQN24Q5SB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DGHQVL4SB6HJZJYHB6ASZDEYQN24Q5SB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 14/04/2026 20:23, Jaroslav Kysela wrote:
> [appologize Péter - I forgot to include others, so duplicating for you]

Sorry for the delay, I was pulled into something unrelated...

> On 4/14/26 15:47, Péter Ujfalusi wrote:
> 
>>> This extension allows us to do
>>> the full "refine" (handshake) between application and kernel to settle
>>> the transfer details with the slightly updated framework. Also, this
>>> flag will activate init_periods and step_periods fields. Basically, the
>>> app will set the maximal acceptable period size (expected latency = 2 *
>>> period size) and the driver will return first biggest period size
>>> depending on driver constraints (initial periods will be included - in
>>> this case the period size must be lowered to maintain the requested
>>> latency). It's the complete handshake.
>>
>> My main problem with this is that I cannot reply to application which
>> say that I can accept up to XYms latency.
> 
> You can reply the maximal period size (thus maximal accepted latency).
> Basically, I think that the minimal and maximal period size boundaries
> will be
> a hint for apps to determine the lowest and highest available latencies.

Right, but how this differs from driver setting SNDRV_PCM_INFO_JUMPY_DMA
to say that it can have jumpyDMA and application telling that I know how
to handle this with a SNDRV_PCM_HW_PARAMS_JUMPY_DMA flag and returning
the chunk_init and step to application which is based on the period size?

>> I don't know the latency in here, it depends on the DSP topology that
>> has been loaded, what I can know is how the host side hw_ptr will behave.
> 
> I don't understand. Who else than the driver can know the latency
> constraints?
> Driver loads the topologies, doesn't ?

Sure, but the driver can just guess this. What if we have a module in
DSP in path which adds delay and is configurable (a delay modue or
reverb or something else)? The delay / latency jumpiness of the DMA is
while related, they are different things. The Jumpy part is just one
part of things.
Also to note that during open, hw_params we don't necessarily know the
full path and thus cannot calculate the non jumpyDMA related latency.
Not to mention that the codec might add latency, so the host (hw_ptr)
side cannot reliably decide what it should do with it's part of the
'latency'.

>> Sure, that translates to a 'latency' It will add maximum of FIFO size
>> latency , but this FIFO size is not equal to the initial burst size in
>> some cases, if the FIFO size is small then we will overshoot with hw_ptr.
> 
> Yes, I proposed that app will ask for latency using period size, but driver
> may reduce period size according the initial burst, like:
> 
> Application expects 50ms latency, so it sets period size for 25ms. But
> driver supports only 30ms initial burst and 5ms transfer granularity, so it will
> reply with 10ms period size, 3 initial periods (3 * 10 = 30) and 1 step
> period (2 * 1 * 10 = 20). The initial burst must be handled separately, because
> apps should know which "block" is being transferred, thus we need 2 periods at
> minimum to ensure that (one active, second for the buffering) for the
> standard streaming.

Hrm, so this is a driver scoped refine, right? Based on the requested
period size and a flag (SNDRV_PCM_HW_PARAMS_LATENCY_AWARE?) the driver
refines the period size based on it's jumpyDMA capabilities?

But in this example the application will have no knowledge still how the
DMA will move, the DMA will initially move 30ms and after that, every
5ms it moves 5ms, so the driver should be refining to 5ms period size, 6
initial periods and 1 period step, no.

Or with my favorite examples:
4ms initial burst w/ 1ms steps will refine to 1ms periods, 4 init and 1
step.
100ms initial burst w/ 96ms steps will refine to... I'm not sure, and
same for
40ms initial burst w/ 36ms steps.

And in you example of application prepared for 50ms 'latency' and asking
fro 25ms period size, how that would refine in case the driver/hardware
is flexible?
The step and initial burst might be just few ms different based on how
the arch is working, the diff usually is the wake-up latency to do the
burst from an idle system and this might depend on the depth of sleep as
well and the depth is not a fixed one, other peripherals can affect it
like blanked display so eGPU is not fetching from DDR for example.

> If the driver does not allow to set the exact specified latency, it should
> return the first lower latency setup.
> 
> For "full" buffering, the app may ask for the maximal (or very large)
> period
> size. In this case, the driver can optimize the period setup in the
> right way.
> And it can end with the deep buffer.

I think this deeper buffering should be only allowed or to be more
precise, can work if application is using the NO_PERIOD_WAKE (+
additional flag that it knows about the jumpyDMA?), it is hard or even
impossible in some cases to align both init and step chunks to period size.

> 
>                     Jaroslav
> 

-- 
Péter

