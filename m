Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FACB10A3D80
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:05:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F61D601F6;
	Thu, 26 Mar 2026 13:04:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F61D601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774526709;
	bh=zdihGUYNRTvbma15RRqLshkNpQmW75lqN32ZKFC3I54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JPC2bKUhnxHdQML189x4pKi8YxXtxpgOg8GUI6JOyKHMk8GcBfTGJ6C+LCGNBZjYk
	 1dM54jqpTck9eHUPaYP3nmqMBFux16RfozqAaGogQ+xhqrCDPEdlHHEp2q5Hk8UNXY
	 FIfzIV6ZagsDTCRr3SGNdf0/t6dav6U4kil5fcBY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8EEFEF805EF; Thu, 26 Mar 2026 13:04:33 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BCFE4F805F3;
	Thu, 26 Mar 2026 13:04:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C925CF80525; Thu, 26 Mar 2026 13:04:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EA4A3F80246
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2026 13:04:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA4A3F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=A3fBmzHH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774526659; x=1806062659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zdihGUYNRTvbma15RRqLshkNpQmW75lqN32ZKFC3I54=;
  b=A3fBmzHHArY/isgp39jOM5mnLC3wVixyhiOF1Ny2XomHz6EWzHgfaf1M
   ANP69Nmn3SHXkE9gXImXA32yThH0WaRAEyeBKVVv9PcF+J3PUa6RPpEc7
   cCbxau9s+oFPtCSXw3y4nhXAoVwvKOjfydU9tMd+MaoTg8XBz1han6GR1
   9ctO7jze4TwoPMx7o/I4cp1YbVTF+krIwLYDFjYbk5v/4am3HyPUAM5fU
   1fv3tEpIrGAoquP+MrZSHSCawlWJt1MK2cMFZGqcUYe8eDKBT/myk1eb3
   UPOWH90XyKXKxWHNHyuuYwtue75yhceaktzcBFNTqYofRuDbcR9bZkeLT
   w==;
X-CSE-ConnectionGUID: adyi/236SgmPmLkN54tKag==
X-CSE-MsgGUID: +RAGmYFoRrK8m7aYVy0qCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86960551"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000";
   d="scan'208";a="86960551"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 05:04:14 -0700
X-CSE-ConnectionGUID: 1B2gqNaeTuigq8FKx3lrTg==
X-CSE-MsgGUID: sGMvx/1NQAywJTFu9ydE+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000";
   d="scan'208";a="224915430"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.219])
 ([10.245.245.219])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 05:04:11 -0700
Message-ID: <41aa963d-876c-4ee1-b91c-7026e72a16ec@linux.intel.com>
Date: Thu, 26 Mar 2026 14:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
 wim.taymans@gmail.com
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
 <c521e0d9-4d69-4fd4-9c29-bb9b62c93310@perex.cz>
 <8fe7f61b-dae4-4ae6-aa96-7e604a37e624@linux.intel.com>
 <813612ea-f942-432f-9bf1-7b1ccfe59046@perex.cz>
 <6b129498-f130-44a0-a679-6fa1c639046e@linux.intel.com>
 <a3eaedae-f23b-46ac-9e8f-a6167df7ef41@perex.cz>
 <420a8205-6a95-4e8a-852e-f3094200e5b1@linux.intel.com>
 <1ca0acb2-18fb-449e-9a52-e73d9eebfb62@perex.cz>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <1ca0acb2-18fb-449e-9a52-e73d9eebfb62@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2VO7IQ7CLEBIWL6HLZQH3VXEMQCN36QN
X-Message-ID-Hash: 2VO7IQ7CLEBIWL6HLZQH3VXEMQCN36QN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2VO7IQ7CLEBIWL6HLZQH3VXEMQCN36QN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 25/03/2026 16:08, Jaroslav Kysela wrote:
> On 3/25/26 14:28, Péter Ujfalusi wrote:
> 
>> Looking at the PW code (spa/plugins/alsa/alsa-pcm.c) and I sort of
>> started to appreciate the 'headroom' term.
>>
>> I disagree that this is not about DMA or about burst since it is
>> precisely about that. It can be viewed as 'latency' but the latency is
>> reported via the delay and the delay fluctuates over time based on how
>> the DSP FIFO drains and fills.
> 
> My point was that we should not use those terms for the structure
> members, because it's standard prefill / data fetch (put) granularity
> issue. DMA is just the concrete use. Describing both parameters seem
> like the best idea.

OK.

>> PW then probably can use these:
>> state->start_delay = hw_buffer_size;
>> state->headroom = hw_buffer_refill_step_size
> 
> We don't use head/tail in the buffer variables for ALSA API. The
> headroom can be named just 'update_granularity' or 'update_step' or so.
> Also, start delay is not correct, too. Maybe 'prefill' or 'init_fill'
> says all. Or we can eventually try to be more consistent and use
> 'init_chunk' and 'step_chunk' to notify applications about the data
> transfer characteristics from the other (hw) side of the audio buffer.
> The chunk word is not used actually in the ALSA API, so developers
> should not mix that with other things like fifo or period.

The headroom and start_delay are pipewire internal variables.

Right, let's go with init_chunk and step_chunk it is.
I needed to move these around in mouth to get the taste of it, but I
think it will do it.

It is better to have them in frames, right?

>> and on start/xrun it might need to provide
>> state->start_delay + max(state->start_delay, state->headroom)
>> or to the distance that it is planning to wake up.
> 
> It will end with 2 * prefill for your examples, because start_delay >
> headroom.

true

> It should be just prefill + step.

Not quite right, this works when the DSP buffer is 'large enough' - yes,
the definition for now is 'large enough', see:
We have only experience with this with SOF so far... The default PCMs
are using 4ms buffer in DSP and what we see is that if the PW headroom
is less than 8ms then it can xrun right away at start.
In this case the firmware steps the DMA in 1ms steps, so after just 1ms
into the playback (and this is counted when the kernel flipped the start
bit!) the DMA already pointing at the 6th ms data, if there is any
scheduling latency spike around this then it is pretty much guarantied
that and xrun will happen.
With larger DSP buffers this is less likely as the DMA is more stationary.

But, this is up to the application to interpret the values the kernel
gives, I would personally do the headroom 2x init_chunk at minimum for
the start/xrun case then use the step_chunk runtime.

> Also, it seems that in SOF case, the queued "prefill" sample block is
> mandatory for internal processing, otherwise xrun will happen, or no ?

Yes, the firmware fills the host buffer initially, but with
https://github.com/thesofproject/linux/pull/5673 this buffer is not
static, it changes based on period size. Can be limited by topology.

The prefill block is sort of not mandatory, we need ~4ms minimum
internally on host side to be able to compensate DSP internal scheduling
(clock scaling, power transitions, rate changes, etc), this is the default.
With 'DeepBuffer' on PCM we can put the system to lower PC state while
playing audio as we only need the DSP and the IP to run and it has audio
data to chew through.

-- 
Péter

