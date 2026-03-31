Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FC3FF60C8
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:01:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00E7F601FA;
	Tue, 31 Mar 2026 08:01:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00E7F601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774936894;
	bh=fkXxvhiVBFqKqKw3s3He36S3sohTgtdnqNJ9mwd5fL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vu1g8LKQ1SluNLHC7ViSdbgt3/TJhOE/FSxNC52DwXVh8sibrc87XENeI2TWFdaKu
	 eI9npMxDXrrovw9chTm9nqEtwCLfq5Jy63XENPiFguqYBFOu++cQZdFCcMt4diSZ9o
	 IyWGKkGQhD5oUJW3GF4jfKGyvbK8mQGIOkvrSqKQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC270F805F3; Tue, 31 Mar 2026 08:00:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F22BDF805EC;
	Tue, 31 Mar 2026 08:00:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E3D4F80549; Tue, 31 Mar 2026 08:00:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D8BEF80087
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 08:00:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D8BEF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=F9Uo7p7j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774936847; x=1806472847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fkXxvhiVBFqKqKw3s3He36S3sohTgtdnqNJ9mwd5fL0=;
  b=F9Uo7p7jIK/PpHJJ6zGS3lPp65MEmcxW/0rv2srwtSisK9kaSJCvTQoH
   tCrtkSoH1h3NhoswVwXum+nzU0a2D+XvawZsLTBorJvXDPQGIcmHrnao+
   ucH4wMm6bxFkQr8HW9Tu2bLcIlKygPpcR9sY6iEVb5gKhNSsPEFh35R6E
   +dG1Gn4GZmzqWGgHHZPaUSqLWLfjS1GhS4wIcddmcA1DiqQhF+VNJDe6t
   JKl2eQHU9qeW+CZ7/JouJn8nu0NL/9jEuI3+nnKgYsTL9k3TcYDE+xbvH
   8NDtqBaHD9cMPihd6Eqpd7Not/xLIu+NdLOMKmyY2oQ73/6ZddESGw9XW
   A==;
X-CSE-ConnectionGUID: ICYoXoseTf69I3CJTWRQ/Q==
X-CSE-MsgGUID: zHo2xYX8Ryi69m/UAvam/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79837286"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000";
   d="scan'208";a="79837286"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 23:00:42 -0700
X-CSE-ConnectionGUID: JRRtkffGTEyet5gCMMNYhg==
X-CSE-MsgGUID: eGN7wwo9Q1GCp+icGXYCSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000";
   d="scan'208";a="231198697"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.218])
 ([10.245.245.218])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 23:00:40 -0700
Message-ID: <dadef18b-1c2e-4c0d-8ae8-2e4b8ad75d04@linux.intel.com>
Date: Tue, 31 Mar 2026 09:00:56 +0300
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
 <67b9f48b-1cc7-4dac-8f6a-c0cba6a84b36@linux.intel.com>
 <87ikadtgpe.wl-tiwai@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <87ikadtgpe.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YWNDV3X3TEOOGU3OX7JZXKG5OLBP25RW
X-Message-ID-Hash: YWNDV3X3TEOOGU3OX7JZXKG5OLBP25RW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YWNDV3X3TEOOGU3OX7JZXKG5OLBP25RW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 30/03/2026 19:39, Takashi Iwai wrote:
> OK, then I'd say that the existing fifo_size doesn't fit fully for
> this kind of stuff.  e.g.

We came to the same conclusion with Jaroslav, and the plan is to
introduce two new parameter in hw_params:
init_chunk and step_chunk, both in frames.
init_chunk - is the size of the hw_ptr jump right when the start happens
step_chunk - is the runtime jump size which happens every step_chunk time.

for example:
init_chunk = 100ms
step_chunk = 1ms
hw_ptr moves 100ms on start (pointing to 101ms), after 1ms of time the
hw_ptr will move 1ms ahead to 102ms, in another 1ms it again moves 1ms
to 103ms...

init_chunk = 100ms
step_chunk = 96ms
hw_ptr moves 100ms on start (pointing to 101ms), after 96ms of time the
hw_ptr will move 96ms ahead to 197ms, in another 96ms it again moves 1ms
to 293ms...

Note, the first is theoretical, with SOF 1ms step is used only with
'small' DSP side buffer:

init_chunk = 4ms
step_chunk = 1ms
hw_ptr moves 4ms on start (pointing to 5ms), after 1ms of time the
hw_ptr will move 1ms ahead to 6ms, in another 1ms it again moves 1ms to
7ms...

I'm not sure if we want these to be snd_pcm_uframes_t types in
snd_pcm_hw_params or should be u32 simplify the shrinking of reserved..

-       unsigned char reserved[48];
+       snd_pcm_uframes_t init_chunk;	/* in frames */
+       snd_pcm_uframes_t step_chunk;	/* in frames */
+       unsigned char reserved[48 - 2 * sizeof(snd_pcm_uframes_t)];

with u32 we can simply change the reserved size to 40, which is anyways
going to be the case for the snd_pcm_hw_params32{}

> if a device allows a different queue size, it should be configurable
> via hw_params.

I'm not sure if I follow this statement. the fifo_size is a driver to
user space information, driver fills it and user space ignores it ;) - I
cannot find any evidence of it's use.

The init_chunk, step_chunk would be similar, the driver sets it and user
space would use it.

In SOF this will be dynamic and it will depend on the period size:
https://github.com/thesofproject/linux/pull/5673/commits/18f3ba5e42212d77019d79ec09b7057a7703d361

-- 
Péter

