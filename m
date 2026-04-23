Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7352FAD40B
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:06:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 719C660204;
	Thu, 23 Apr 2026 07:06:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 719C660204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776920785;
	bh=XbNo9ez4QCom4Wza0xYVSYZJHZPha+NYGVoo0OJkRvU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sGluEWSBBAVirLFzi2UonuUTBlWGODBFKZY6Nv3HadZuw3xGd1dpDtP6PjuX+sWdd
	 ygy+hSqxCkJHN7+xZ6yVwwkHkfJjKHVtW99RKMXUWoirXcAYTTgex8RO/WIQQGuJ0C
	 EQeomWIad48O0XaC2zPSsym8XkgaU2cQmkHzsAT4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC465F805C3; Thu, 23 Apr 2026 07:05:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74F86F805C3;
	Thu, 23 Apr 2026 07:05:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B93EF80526; Thu, 23 Apr 2026 07:05:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F267F80162
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2026 07:05:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F267F80162
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZbifwyVD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776920743; x=1808456743;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XbNo9ez4QCom4Wza0xYVSYZJHZPha+NYGVoo0OJkRvU=;
  b=ZbifwyVDcC9Zgy0J1UhShLg4VJHy7Dmr6962PfUBQyOiotkIhCkppYi2
   DCYwVTIGDZYwuuOD25ZVygw65rkZG/13V67b3ZGJpifLyvxLJY5onrJKM
   z9i1fU1WDvQ8Lwfy5uf4XrJXd6iBQ5B3+PmNiciCFsFYsmQsj75KQJv0G
   /Okano/lTolCzwtEx0rS0l5hxMHk4x3s+98QakL/FDCtf4rR8X4AgHjnB
   dKSeAQOY3FCtFN1PV+iDfHZ7NZ+5twWUzCuxDCxDr9lKGWr7HOwr09P54
   cxr0wwMt6tuzt6idJoHh+NbTcsb/ARZ6/lMJAQlyxzfzFM4+T9HvUxR7B
   A==;
X-CSE-ConnectionGUID: Pj8k4ugTRyGkixYz1PYUow==
X-CSE-MsgGUID: 8T2ZiNssSdi2Y3m3cb5cAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81745406"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000";
   d="scan'208";a="81745406"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:05:36 -0700
X-CSE-ConnectionGUID: FXcxBodXRfa426+jizs9gA==
X-CSE-MsgGUID: bLmGRteXRJW8p6tFqPjhVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000";
   d="scan'208";a="256035501"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.105])
 ([10.245.244.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:05:34 -0700
Message-ID: <463d844b-ef44-471a-8749-6bb068833c4a@linux.intel.com>
Date: Thu, 23 Apr 2026 08:05:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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
 <8af520bc-cb27-416a-b823-7a21f0784f89@linux.intel.com>
Content-Language: en-US
In-Reply-To: <8af520bc-cb27-416a-b823-7a21f0784f89@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5H6EO62G5QDMZF75OGB7XBAZESGVYORT
X-Message-ID-Hash: 5H6EO62G5QDMZF75OGB7XBAZESGVYORT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5H6EO62G5QDMZF75OGB7XBAZESGVYORT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 22/04/2026 17:19, Péter Ujfalusi wrote:

> Hrm, so this is a driver scoped refine, right? Based on the requested
> period size and a flag (SNDRV_PCM_HW_PARAMS_LATENCY_AWARE?) the driver
> refines the period size based on it's jumpyDMA capabilities?
> 
> But in this example the application will have no knowledge still how the
> DMA will move, the DMA will initially move 30ms and after that, every
> 5ms it moves 5ms, so the driver should be refining to 5ms period size, 6
> initial periods and 1 period step, no.
> 
> Or with my favorite examples:
> 4ms initial burst w/ 1ms steps will refine to 1ms periods, 4 init and 1
> step.
> 100ms initial burst w/ 96ms steps will refine to... I'm not sure

4ms period size, 25 init periods, 24 step periods?

and same for
> 40ms initial burst w/ 36ms steps.

4ms period size, 10 init periods, 9 step periods?

-- 
Péter

