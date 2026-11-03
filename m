Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84D60736E9
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=p//EzIzN;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nz38ywuM
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 666B06022A;
	Tue,  3 Nov 2026 11:34:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 666B06022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793702102;
	bh=0V0fh2przo7r7md+e8U0YmIXDyPWRO/jFzU6LlNmtxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p//EzIzNEZxeT/vPes8W2TVC7SP0w+jPcctjxJ2JMq51jQ0w9mnbDtHhQUQwCzZN6
	 V9Uiy7zSnr4HeB4pV0MmIp36/yPibRXVC+EuQ6ECK5aVxP8A7dWOfeMidoK9zlmRYl
	 pZw+iCa5fgWBKdUcvbbFTt6cyIlcUIHj6v2Bpqrk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95D4BF80601; Tue,  3 Nov 2026 11:34:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7ADE7F805FC;
	Tue,  3 Nov 2026 11:34:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3A4FF804CF; Tue,  3 Nov 2026 11:34:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793702056;
	b=HCVzf4/4+eh9ZBrLjCNLIpBaMUW3ZI3WkPsFD+52cLvu+piH8tZZkM1wOorkCPTfLCEw
	 3cCKgfOJ0kNfPvSqphYP3/J3gsnkRodB0TwhDIctlMIMKaHLQjG0lhCR+oeP7eRRozRAd
	 U1cfPz0Q7ZBit5ATay4vLbd7KgHpF4Yrdo0BfR1Sw9PpfC9kVrNdoxAUhQXGLE+Z5pJhb
	 SWOxw+5ceM+NCEmWeOC/KmmiGVDFIqIcTYXwIbtLlwQElH/qMx2d3kY5s0dLUtqBmqJE8
	 kETmv8gzrGtHMu2XMap5dp7bMkrdzqQ4TBcWjfZn6YXkyTnx/GZddkZ4SWUjf9zaKlA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793702056;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=0V0fh2przo7r7md+e8U0YmIXDyPWRO/jFzU6LlNmtxE=;
	b=Fr6TCgdvU49YZ4eDTfsaFwQqxjD/CJ1/TXwSrxh1tb3uwu0rdZUbwy5qARzW7m4Eak5I
	 ajps8ZBcnLonbHCkWg0d7HKFPjUG4/DQjbp0zhsBvH6Akj4oOdUnAkThVOUbm450KPADm
	 P9pUSI19g8quMumfn7kraIqZong1EuhN9pKlRhuToW7Gcg28+nK0CdTTDGLnNugVkcD8u
	 f3XZ1ozPDH6MJ6rZnVeDwav2vahOPEEV+0EP15+H4X0dZfuiNTAFOxu2etN2qXIEtY8a4
	 hPhS7zr+/7X96QkPfsCEA6gxwmaAo8kGNAeBkuvHNtDoVETB9fiCicQzj/p4/s1wteg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nz38ywuM;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EBC67F80100
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 11:34:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBC67F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nz38ywuM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793702056; x=1825238056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0V0fh2przo7r7md+e8U0YmIXDyPWRO/jFzU6LlNmtxE=;
  b=nz38ywuMsUKDPodp4iDAMFOEoCR0Llz2p3QSgHvqEXDIu+xp5CkRl/jc
   jgZAyKzp30rJcmnj8EQ/makUPc+ZJl11gSVcZkAU/SxcRBT82VHarlm+z
   3ttnY0FJoEp+oiH3VqnLzFkdnoNqYGFdjbEUV+9QdEwuoiQBNbfIuAj+R
   Ue41QcvKkwUb7QaxXOw26ziSoQdWUqWu+xDX424vvfs9j+tiOyTI0WegS
   VQW7wFz+V1k2yBf9lyW9onwFgoUVMb5cb3GvAcUUXJ61SmJ/c+pUYFatp
   WEe6Q309m7qUfk9yZQ8YGmRTy2SkAEiOWHtiVBGSICWeX5r7QUO/FIB2q
   w==;
X-CSE-ConnectionGUID: GAyXPLd4QC6uj/gDasRePQ==
X-CSE-MsgGUID: 4PRHKT9hQJaAqEg4izYRxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2427482"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400";
   d="scan'208";a="2427482"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 02:34:10 -0800
X-CSE-ConnectionGUID: LvWPIjPoStuKtB5XlBlNaQ==
X-CSE-MsgGUID: VJ8EYBCoQAe/AaGko+DNrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400";
   d="scan'208";a="6234062"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 02:34:07 -0800
Date: Tue, 3 Nov 2026 12:34:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com,
	pin-hao.huang@hp.com, Syed.SabaKareem@amd.com
Subject: Re: [PATCH v1] ASoC: amd: acp: Add support for more projects on
 ACP7.0
Message-ID: <aum4nJ6RQUyXjfDM@ashevche-desk.local>
References: <20261103034415.1495-1-baojun.xu@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103034415.1495-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
Message-ID-Hash: UJCQBK5IU224HDAQCTJGKKTAWPCRRKH6
X-Message-ID-Hash: UJCQBK5IU224HDAQCTJGKKTAWPCRRKH6
X-MailFrom: andriy.shevchenko@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UJCQBK5IU224HDAQCTJGKKTAWPCRRKH6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, Nov 03, 2026 at 11:44:15AM +0800, Baojun Xu wrote:
> Add driver data and ACPI match table entries to support additional projects
> using the TAS2783 codec on the ACP7.0 platform.

...

> +++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c

>  	},
>  	{}
>  };
> -

Stray blank line removal.

> +/* HP: Sundae, Cashmere-A. */
>  static const struct snd_soc_acpi_adr_device tas2783_2_adr[] = {
>  	{

>  	},
>  };

-- 
With Best Regards,
Andy Shevchenko


