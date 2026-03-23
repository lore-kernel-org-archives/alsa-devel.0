Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D37F483C6
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:17:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F3CB601FC;
	Mon, 23 Mar 2026 17:17:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F3CB601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774282647;
	bh=3hwIS+zPCLF5vniCygeT0FvF1Fbn5HwfJaoUULVHv8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Qk247pOC/hs9/pRK8XCyldYHnnm5eOmMYRCmdZG9YaXWxaNfXAoOEXSW+XgF6N9TP
	 q9XpNEhdRVZYmjZ1GAA6Ngll4zYkiF+vbqnqW074d8EdFwCC0fbDSKWjf/v6H1pbpc
	 R0T1akDY8PlZZmfdLJh2AGJQHs1cFxOspzPT4jC4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 688D6F805BE; Mon, 23 Mar 2026 17:16:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1355F805BE;
	Mon, 23 Mar 2026 17:16:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1ECD4F80496; Mon, 23 Mar 2026 17:16:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 53812F800C1
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2026 17:16:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53812F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HJXfc3sM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774282602; x=1805818602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3hwIS+zPCLF5vniCygeT0FvF1Fbn5HwfJaoUULVHv8w=;
  b=HJXfc3sMm3hZU2h19NzxKh0n4x4gyq55kzF9p0V8Apx5qwpv+QnctjOk
   C/bFboCDEh8x8dbbiUqUEH+vqab/o3rny8LbUZzFT1heTE/ymXz0rEJ95
   lxjB6hlgxOxbX3SEDk3QsUqUFnnMstP2U6wRi+DZNuuo8XZIh5gF7UyYS
   4ZIh/1Y2jiTfzP26phJIVagwjXpYVq6itTtkf7lKYiJIdBZemk9P7SSgz
   nISjGmriJCys1bR8aVFF3Gkx/Shr0UdWDuGYcBWrReR7elwz8ntsKHsG2
   fKY3gcIrc7Squyg/E8fM7X865TNmRnisEd85GOTAzCk1nYN3IcUZLjXnt
   g==;
X-CSE-ConnectionGUID: GiEux511RmW7I8XVHsvcxA==
X-CSE-MsgGUID: AwwBfJi1TdukNyausQl0Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="78881710"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000";
   d="scan'208";a="78881710"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 09:16:37 -0700
X-CSE-ConnectionGUID: g/nGMyQVSX6hNJiwE2B0zQ==
X-CSE-MsgGUID: PiHb+PFGQyu+4CeuaRI2JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000";
   d="scan'208";a="219228521"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.12])
 ([10.245.244.12])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 09:16:35 -0700
Message-ID: <8fe7f61b-dae4-4ae6-aa96-7e604a37e624@linux.intel.com>
Date: Mon, 23 Mar 2026 18:16:52 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <c521e0d9-4d69-4fd4-9c29-bb9b62c93310@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GCFP5SZNCHXKSTZUU7IYC6MYNYHDLM75
X-Message-ID-Hash: GCFP5SZNCHXKSTZUU7IYC6MYNYHDLM75
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GCFP5SZNCHXKSTZUU7IYC6MYNYHDLM75/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 23/03/2026 16:54, Jaroslav Kysela wrote:
>> Or should we add a new member (carved out from the reserved section of
>> hw_params struct) specifically for this purpose, like dma_burst_size,
>> which likely going to be equal to fifo_size if both is filled by the
>> driver.
> 
> I would not change the fifo_size definition at this moment. It's not
> directly related to the sample transfers. This value just describes the
> additional latency for streaming.

Aren't we have the delay reported for this reason, which is actually in
use by user space?

> The new member seems like a good way to go with more universal name like
> 'chunk_size' (in frames) defining the transfer granularity information
> for the PCM buffer I/O.

right, but (I think these are the main issues that blocked any progress
on this) this is not really about the chunk_size, it is telling user
space what is the safe distance from hw_ptr to modify samples without
the DMA jumping over the area.

I know how SOF and tlv320dac33 does this, they have one overlapping and
one-one different modes

A. nSample mode (SOF with bigger than 8ms host buffer or dac33 MODE1)
initially fill the FIFO, then when only threshold amount of data remain
in FIFO, read N number of samples then wait for the threshold to be reached.

B. keep full (SOF with less than 8ms host buffer)
initially fill the FIFO, then whenever 1ms is free, read 1ms

C. two threshold mode (dac33 MODE7)
initially fill the FIFO up to upper threshold, then if the low threshold
is reached start reading data until the high threshold is hit, then wait
again for the low threshold to burst again.

The initial burst for A and B is equal, it is the size of the FIFO, in
case of C it is somewhere above the upper threshold as while filling the
FIFO there are samples played out, so it is a moving target, sort of.

But consequent DMA activity is different:
A: it is nSample, which is smaller than the fifo size
B: it is 1ms
C: something about the diff between the two thresholds

There could be different FIFO and burst setups out there, but in all
cases the fifo_size is something which is a hard safety limit that
applications must be aware of.

Fwiw, ASoC collects the delay from CPU driver, codec driver and also
from platform (DMA) driver, while the fifo_size never been configured,
afaik.

And the fun comes when we give numbers to these! Let's say the FIFO is
100ms long and we have the low threshold at 4ms (start DMA when only 4ms
left in FIFO).
A
start: read 100ms, wait
after 96ms read 96ms, wait
after 96ms, read 96ms, wait
The hw_ptr after 20ms after the start will be at 100ms
The hw_ptr after 70ms after the start will be at 100ms
The hw_ptr after 100ms after the start will be at 196ms

B (theoretical as SOF only uses this in 'small' FIFO case)
start: read 100ms, wait
after 1m, read 1ms, wait
after 1m, read 1ms, wait
The hw_ptr after 20ms after the start will be at 120ms
The hw_ptr after 70ms after the start will be at 170ms
The hw_ptr after 100ms after the start will be at 200ms

C
More like A, with reduced fifo_size, but that is a variable size.

Application must keep 2x fifo_size distance initially, if you plan to
check back in fifo_size time, B will be at one fifo_size ahead already
for examplem, but with A if you check at fifo_size time again, you risk
to race with the coming bursts, so you should not poke too close either..

My idea is to tell user space to keep fifo_size of data as minimum, but
initially this should be 2x fifo_size. How to document and do this is
still not clear, but the only thing the driver can tell: this is my
fifo_size, I burst based on this number.

And I'm really bad at naming things ;)

-- 
Péter

