Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE57F532E8
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:13:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88C41601F6;
	Tue, 24 Mar 2026 08:13:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88C41601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774336391;
	bh=XRacGBV8OYXae8LlOvhWtDtbl1mY0BWLksV3lr+az5s=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=otT8LOTZ8LVGe06NCsaeQ9BVPgC221i3swGPgmpRWvQ9s6pNmNXNRjUx+J8B2V/Zy
	 D7B3Jo1/wXgGzbeAn31DLrSo1lfUaZy8TYJRM2G4eYuFF1+7VWlDEryeENH/7t4lkj
	 6eppqUaa99I8cWkf1eDWRgW7JiRs2C7YeT8z3Y5Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87ADEF805E6; Tue, 24 Mar 2026 08:12:33 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4197F805F2;
	Tue, 24 Mar 2026 08:12:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D009FF805BA; Tue, 24 Mar 2026 08:12:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D06E7F8011B
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 08:12:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D06E7F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BZ4G703i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774336339; x=1805872339;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XRacGBV8OYXae8LlOvhWtDtbl1mY0BWLksV3lr+az5s=;
  b=BZ4G703i3BeiuYb6jTOKNnbU/D7nn77vRtg6Y/lMdu/9t2uGYOwdFMOR
   f+KQ2Exc6t7dJj1bA2J1NELepVkhxe5o1gQc9oEva7W+5nrrIuuspo3WL
   T+QNGG6k7iSp4jjICPlFgRBtOBODkFbxFQA3XqUjd+o/VWwRBVhPvLGWL
   +AkxMM5sws54XVK7SzgKFhiu1hf8KNZ9qzW/LZd5wC+ivEO44upwicvNS
   GaH3+g/GOrsdHVdsvHfpaxTomj/p9oV3CEznDRWs7aVtj/OsvMP+n4asb
   BffoPpJC9n4TSFyUaS0fmIo5TFO18RGEutIp0YUKsegCBpQfD5ZPQ1PaH
   w==;
X-CSE-ConnectionGUID: vh6yHHaKQceEkFm3CZxVvQ==
X-CSE-MsgGUID: wk8DRAXKQYO0XqkJRk+jPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="97964247"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="97964247"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 00:12:12 -0700
X-CSE-ConnectionGUID: dlnejzdxQj6eDFbAvv9fGQ==
X-CSE-MsgGUID: 5TsicKkjSVWtiKBj6cZpnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000";
   d="scan'208";a="254753048"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.138])
 ([10.245.244.138])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 00:12:11 -0700
Message-ID: <c3867377-28bd-41c9-9a03-f646bea60704@linux.intel.com>
Date: Tue, 24 Mar 2026 09:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
 wim.taymans@gmail.com
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
Content-Language: en-US
In-Reply-To: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6VRUI7UMK6QHTVYGYQZXUENGYLRDAT5B
X-Message-ID-Hash: 6VRUI7UMK6QHTVYGYQZXUENGYLRDAT5B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6VRUI7UMK6QHTVYGYQZXUENGYLRDAT5B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 23/03/2026 15:34, Péter Ujfalusi wrote:
> Hi,
> 
> for years the discussion around jumpy, bursty DMA have been popping up
> and we always concluded that we are missing a good definition and agreed
> way between kernel and user space to handle this.
> 
> In ALSA it is expected that the DMA (hw_ptr) moves in steady small
> steps. There is a BATCH mode which tells that the DMA cannot report sub
> period size position, progression.
> The DMA bursting fits neither of this, it moves in bigger jumps (bursts)
> and it can as well can report position in byte level.

I think it worth explaining why this came up again...
In SOF we have a concept of DeepBuffer PCM devices for which in topology
one can specify the size of the host DMA buffer size (this is in the
DSP), this is where the host DMA transfers data from ALSA buffer.

side note: The DeepBuffer PCMs are not used in Linux (pipewire for
example), so no immediate need

I'm changing how it is working in a fundamental way with
https://github.com/thesofproject/linux/pull/5673
from static to dynamic allocation.

The current, static mode is really simple: in topology the DB is set to
let's say 100ms and the this is how it will be configured.
For applications I place a constraint on the minimum period size to be
100ms.
Since Pipewire does not care about period size, but it needs to provide
at least DB size of data ahead of hw_ptr we have a temporary way to use
the minimum period size as headroom:
https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2548
This avoids xruns in PW and most ALSA applications also work fine.

But the change to dynamic mode will render the PW 'guessing' broken:
In dynamic mode the DB size will be configured based on the ALSA period
size, but caped at the DB value from topology. If DB was set to 100ms in
topology then this will be the maximum size of the DB, no matter how big
the ALSA period size is (see PR5673 for some numbers on how this looks),
but something like this:
ALSA period:    8 -> dma buffer:   4 ms
ALSA period:   10 -> dma buffer:   6 ms
ALSA period:   16 -> dma buffer:  12 ms
ALSA period:   19 -> dma buffer:  15 ms
ALSA period:   20 -> dma buffer:  20 ms
ALSA period:   50 -> dma buffer:  50 ms
ALSA period:  100 -> dma buffer: 100 ms
ALSA period:  150 -> dma buffer: 100 ms
ALSA period: 2000 -> dma buffer: 100 ms

Legacy applications should be fine with this, but PW still needs to
figure out the headroom andthe min period size will no longer aid that.

If we want to enable at some point the DeepBuffer PCMs for Linux via
pipewire, we need to have a way to communicate the DMA behavior.

I'm not keen on staying on the static DB as I see it as a limiting
factor. If we want a PCM with 200ms buffer (for audio playback) and we
want shallower one with 40ms for calls then you would need to have
separate PCMs and the period size would be constrained, so it is sort of
a headache for user space, while with dynamic DB you would have freedom
to use these as you wish and also benefit the power saving of the bigger
period sizes.

-- 
Péter

