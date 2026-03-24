Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6C3E9A764
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:52:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CE43601F9;
	Tue, 24 Mar 2026 11:52:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CE43601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774349533;
	bh=s4Ip/9OTPODrxWag+XEmbwUwFOQZouTajrRzZEiPINg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BBPEnxHxO65OPU+lhTqUmhESSc7uOeEgVtd5QnT/2dBpPx2edY4c5NoWtxaW6uy2I
	 8VN4Qux8WMfVBRblySmzQ3zOkvwntw5Wv8IF0s6GpBM41u3kNJmgxyffT9A0AsEr8n
	 pzqRbTu5OflhKrt47eyG7/289J53wFevkNrBXUA4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B35FAF805F5; Tue, 24 Mar 2026 11:51:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CBF61F805E4;
	Tue, 24 Mar 2026 11:51:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3ECB9F805BA; Tue, 24 Mar 2026 11:51:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A37EAF800E2
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 11:51:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A37EAF800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=g5RVuBc+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774349488; x=1805885488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s4Ip/9OTPODrxWag+XEmbwUwFOQZouTajrRzZEiPINg=;
  b=g5RVuBc+Ck6dR+DgYj9p/gzgRn43hrTDUOJaPLiBXcjpt3X/06YWswD2
   ImRQbMGEb4+ZGethXBgHMp4QjZVwiqq4op2pDWcedpr2ZCTCDz2Ayw8eu
   aFsjmAkd4Y326fwfTuKTRqHs63sDQxaYCL9IJu5i5V/0hnvRf7jHhEaPD
   LYoE8HmoHg1uqacEduQ9jtMaOK+TZtug538RVorbE6w1/l2al2fxjqSj7
   GRs1m5JNtompnxMsVlLz5+VoB5U9yviQmbps3VWaMke0eKZdyc4/B3UhG
   vczbNiq1c/U7UAVUPRadtrKMger0hqX8sDt3DOClGglzUZ4y/5VT+myBx
   g==;
X-CSE-ConnectionGUID: 4Mh0Lp6WRyyzNG0g94GWVA==
X-CSE-MsgGUID: ycu1dB45QguFlKFAsuZ4lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="78957046"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="78957046"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 03:51:24 -0700
X-CSE-ConnectionGUID: v81aUKcXTPezeU6Nj2tqIw==
X-CSE-MsgGUID: SKskgW8CRWqCJyqAoRrbjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="219428179"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.138])
 ([10.245.244.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 03:51:21 -0700
Message-ID: <6b129498-f130-44a0-a679-6fa1c639046e@linux.intel.com>
Date: Tue, 24 Mar 2026 12:51:38 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <813612ea-f942-432f-9bf1-7b1ccfe59046@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FKS5OANSVEDZC52CTVDL2EH2IRCQ2NSY
X-Message-ID-Hash: FKS5OANSVEDZC52CTVDL2EH2IRCQ2NSY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FKS5OANSVEDZC52CTVDL2EH2IRCQ2NSY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 24/03/2026 10:58, Jaroslav Kysela wrote:
> On 3/23/26 17:16, Péter Ujfalusi wrote:
>>> I would not change the fifo_size definition at this moment. It's not
>>> directly related to the sample transfers. This value just describes the
>>> additional latency for streaming.
>>
>> Aren't we have the delay reported for this reason, which is actually in
>> use by user space?
> 
> Yes, this field was defined before the final delay reporting. It
> describes the static FIFOs in hardware. But it was not defined to be
> related to the hw_ptr granularity (transfers). SOF may set this value to
> indicate fixed latencies caused by double buffering, too.

In SOF we use delay to report the delay that the DSP processing might add.
I have noticed the fifo_size only when started to look around again to
give another try to the DMA burst issue.
I did also looked at user space and saw no evidence of anything using
it, that's why I thought that it can be re-purposed - no users, no
regression ;)
But you are right, the original definition of fifo_size is detached from
hw_ptr.

> 
>>> The new member seems like a good way to go with more universal name like
>>> 'chunk_size' (in frames) defining the transfer granularity information
>>> for the PCM buffer I/O.
>>
>> right, but (I think these are the main issues that blocked any progress
>> on this) this is not really about the chunk_size, it is telling user
>> space what is the safe distance from hw_ptr to modify samples without
>> the DMA jumping over the area.
> 
> It depends on the view and definition. From the hardware view, the
> 'chunk_size' may be defined as the maximal block transfer from (or to)
> the audio buffer (describing the hw_ptr granularity). So applications
> will be notified, that filling buffer lower than 'chunk_size' may
> introduce underruns. It covers also the initial transfer (when hw_ptr
> moves immediately to 'chunk_size').

I'm trying to wrap my head around this, I think this is the generalized
view of this:
We have a FIFO in hardware which will be filled on start: dma_fifo_size
After the initial burst, the DMA keeps the FIFO full with sample, 1ms,
2ms, etc steps: dma_runtime_size
A DMA burst happens every dma_runtime_size time after the initial FIFO
fill burst.
Something like this:
dma_fifo_size = 100ms
dma_runtime_size = 1ms
Initial burst is 100ms, then after every 1ms DMA moves 1ms ahead

dma_fifo_size = 100ms
dma_runtime_size = 96ms
Initial burst is 100ms, then after every 96ms DMA moves 96ms ahead

On start thus it is going to cause immediate xrun if application only
provides dma_fifo_size data if the dma_runtime_size is 1ms. Well, it
will cause xrun right at 1ms playback time, if dma_runtime_size is 10ms,
then after 10ms, given if application is not quick to fill data right
away it started, which might not be the case.

During runtime however it is safe for application to have sort of
untouchable data of dma_runtime_size ahead of hw_ptr, but dma_fifo_size
is definitely a safe distance with some headroom.

The question is: is it enough to only have single value exposed or do we
need/want add all small variations of this to be exposed?
I would think that a single dma_fifo_size should be OK and apps should
prepare for the crawling DMA case.

> But if we agree on other name like 'burst_size' or 'batch_size', I'll be
> fine with it, too.

I think neither of these are right, unless we substitute them with a
variable which tells the size of the FIFO in hardware that is going to
be filled.
max_hw_ptr_burst_size or max_dma_burst_size or max_burst_size - in frames?

> 
>                     Jaroslav
> 

-- 
Péter

