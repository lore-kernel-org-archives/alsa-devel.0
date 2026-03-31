Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE381061B26
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:43:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12605601F8;
	Tue, 31 Mar 2026 12:43:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12605601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774953820;
	bh=4j+xpLGVS8SWxR8qK58YPeKfoNjHd4nUWFjd8/QcM90=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qbAv/+L+d4ROfARcZP9CEwC74eK3g3ZwCkZaY3IQHKS1krr27SAExFlZST8QwAXIV
	 g4/MPeIn9ite7zkp28bjkAmGE88BDR9ApK764/IBAEW8VczhhQqSXx8HoA2eM19Lnf
	 +bqAxvIN7okluTy/+DuZ7AWbMstwuUO6fJLXZza4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E53BF805F2; Tue, 31 Mar 2026 12:43:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A05C4F805F3;
	Tue, 31 Mar 2026 12:43:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 184FAF80549; Tue, 31 Mar 2026 12:42:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8CA4EF80087
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 12:42:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CA4EF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HR1crYNH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774953774; x=1806489774;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4j+xpLGVS8SWxR8qK58YPeKfoNjHd4nUWFjd8/QcM90=;
  b=HR1crYNHp1+Ug9qOAf2pnraYhNR3cdSegf/Ejvn5pMB0RHrwH589q5NG
   9lPcsZ2fCBorkubik45ya9crwRnm1RJfz2CwdmYZvPgQzQyrNcD2GgPxb
   ET43XFpIsCLP/qjZ9BhVstbbc6XAdsemM5Mtlae8iTRIC1nc3pPMN3zfY
   RuIpmZ4uuLF9IDFzNQvKM83URx3qONB2OFWoxC94qBFKg6IhIQnFaFUZT
   vF/1aqrHMjNtR3T6whbKIf1Wxnp75lb5B1sqgFdPBFKepOofntYH0qowG
   6Mi82FYeV2ONPnlu6OVVBCGwAhjzhWua7PCM4fT1A6x2riiGcLkefXJ+I
   A==;
X-CSE-ConnectionGUID: K6yc1wwuRGK8zvdj6kNYag==
X-CSE-MsgGUID: B4rj3mnyQwyddtnI89MxHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86657058"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000";
   d="scan'208";a="86657058"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 03:42:48 -0700
X-CSE-ConnectionGUID: qWKtq/uHRs2xP1J0RGZLrw==
X-CSE-MsgGUID: 8YD4GSSTQvOV0blXn973UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000";
   d="scan'208";a="226580018"
Received: from slindbla-desk.ger.corp.intel.com ([10.245.246.72])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 03:42:44 -0700
Date: Tue, 31 Mar 2026 13:42:28 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: Jaroslav Kysela <perex@perex.cz>
cc: Takashi Iwai <tiwai@suse.de>,
    =?ISO-8859-15?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
    Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
    Liam Girdwood <liam.r.girdwood@linux.intel.com>,
    Linux-ALSA <alsa-devel@alsa-project.org>,
    "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
    Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
    wim.taymans@gmail.com
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
In-Reply-To: <88979231-caef-4eaa-b89d-22e6973c92f9@perex.cz>
Message-ID: <1f08dea9-f117-ea7a-c9e2-cc163dedb770@linux.intel.com>
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
 <87se9htms4.wl-tiwai@suse.de>
 <67b9f48b-1cc7-4dac-8f6a-c0cba6a84b36@linux.intel.com>
 <87ikadtgpe.wl-tiwai@suse.de>
 <dadef18b-1c2e-4c0d-8ae8-2e4b8ad75d04@linux.intel.com>
 <878qb8tsib.wl-tiwai@suse.de>
 <88979231-caef-4eaa-b89d-22e6973c92f9@perex.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: RB7PKJWNYBJUEVJJW3XMH2ESMNRX7NUW
X-Message-ID-Hash: RB7PKJWNYBJUEVJJW3XMH2ESMNRX7NUW
X-MailFrom: kai.vehmanen@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RB7PKJWNYBJUEVJJW3XMH2ESMNRX7NUW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hey,

On Tue, 31 Mar 2026, Jaroslav Kysela wrote:

> So, perhaps, the only flag may be added notifying that the (first) minimal
> period is processed immediately after start. It's also common situation for
> other drivers with double buffering in the driver like USB, maybe FireWire,
> right ? Note that this flag won't be the BATCH flag. Or we can just add a
> field notifying how many minimal periods are queued at start to be more
> universal (apparently SOF requires this, because the initial chunk of queued
> samples is bigger then the later chunks - so the first transfer will go over
> more periods).
> 
> We may discuss if small periods are efficient. We have already mechanism to
> disable period events (SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP) and drivers don't
> do usually deep buffering, so they program DMA transfers with smaller (or
> equal) chunks than period size.
> 
> It seems to me that we are trying to design another layer on top of the
> current just to satisfy the improper current PCM API use.

btw, I think this is a bit of a chicken and egg problem. Hardware may have 
deep buffering capability, but it's difficult to enable via ALSA without 
breaking applications with current interfaces (and how they are used).
There could be more drivers that enable deep buffering if the semantics
were clear.

E.g. with SOF firmware, the buffering behaviour is completely 
programmable. E.g. we could have a 100ms buffer between main CPU and the 
DSP and still report accurate delay with snd_pcm_delay(). In most cases 
the FW support is there anyways and one could enable this just by 
modifying the DSP topology file (which is basicly an alsaconf file). The 
hw_ptr will move in bursts, and will move faster-than-realtime at start. 
And it's important to note, to maximize power benefits, the exact size and 
timing of the bursts may be driven by what else is going on in the system. 
The audio DSP of course knows what is the maximum size of a burst (as the 
DSP needs to have local memory to receive the transfer), but we can't 
guarantee the acual burst (as seen as hw_ptr movement) is always of the 
same size.

We do already honor period size configuration set by applications and SOF 
never allows DMA bursts to exceed period size.

But once we increase the buffer size beyond a few milliseconds, 
applications start to break and we see the interpretation of the ALSA 
period semantics becomes less and less clear.

PS The DSP code that decides on DMA reloads in SOF (this is called every 
1ms, hd->dma_buffer_size is buffer towards host, this can be tens of 
msecs):
   https://github.com/thesofproject/sof/blob/main/src/audio/host-zephyr.c#L570
   .. this is common code in SOF, not specific to any one vendor.

Br, Kai
