Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645ADC54E64
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Mar 2024 01:43:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5ACE622A8;
	Sat, 23 Mar 2024 02:43:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5ACE622A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711158196;
	bh=PkbywcFQ22gRuuNKCjqZGZXkxAfXTrgx32KNdC4qoyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kP5d2hjQt9UXW0yqC46/YfGveCgLDEdfzS9+pctMAcU0DzB09LaJZoHrd+vcokcZv
	 oaQ946Hy5YMdo+/lPMOSgmd8Y2XPYMGWPRX1CcYo6NB9ZqbEsyZFavLZmRm304AtUN
	 +nuXqvmGz4Imdk4QNPH87eSh8HuiCPdZNV/mg5jA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59639F805A0; Sat, 23 Mar 2024 02:42:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DDD6CF805A9;
	Sat, 23 Mar 2024 02:42:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24766F804E7; Sat, 23 Mar 2024 02:42:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7F460F8025F
	for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2024 02:42:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F460F8025F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IwWBSyqv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711158153; x=1742694153;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PkbywcFQ22gRuuNKCjqZGZXkxAfXTrgx32KNdC4qoyk=;
  b=IwWBSyqvnNKM/HtM5E3J0S15VHQJxPxw2xUDAZFAdruNd3WeoguCHG3J
   +VT9ssER4eJdvQEcaXdhCT7lBckMUyN9uWuUgBM+lWv0+k8FzJCBA1Scy
   /NAXx684lQjWJzd98gOa3uDDswfjQvMEEQMA0cx0VD/V4aEMJLBc4Gx6n
   UTVswHYsVVjq2qhS4epT03NCcJyJaa9NhDTt1k6Eg9qQuIozyOl/7YBry
   7+7hxk5rVxGS+zjHJvrvHfHC2hQvvmiS1q1NloMc4MSuuQdVBNKTCN/O3
   zzmczVGjwgRxBWzxPMjMEm1a8m1d/dSA2V8PeA42cwJ6UZC/zWCfyFbDH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6434636"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000";
   d="scan'208";a="6434636"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2024 18:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000";
   d="scan'208";a="19636616"
Received: from ajbawden-mobl1.amr.corp.intel.com (HELO [10.212.109.118])
 ([10.212.109.118])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2024 18:42:27 -0700
Message-ID: <473a0261-737e-4e80-ba63-47bce99894bf@linux.intel.com>
Date: Fri, 22 Mar 2024 20:42:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] ASoC: Intel: Disable route checks for Skylake
 boards
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, tiwai@suse.com,
 perex@perex.cz, amadeuszx.slawinski@linux.intel.com, hdegoede@redhat.com
References: <20240308090502.2136760-1-cezary.rojewski@intel.com>
 <20240308090502.2136760-2-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240308090502.2136760-2-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: LELM5I37LBHDKAKZZYYL4PK36GCKE3ST
X-Message-ID-Hash: LELM5I37LBHDKAKZZYYL4PK36GCKE3ST
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LELM5I37LBHDKAKZZYYL4PK36GCKE3ST/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 3/8/24 03:04, Cezary Rojewski wrote:
> Topology files that are propagated to the world and utilized by the
> skylake-driver carry shortcomings in their SectionGraphs.
> 
> Since commit daa480bde6b3 ("ASoC: soc-core: tidyup for
> snd_soc_dapm_add_routes()") route checks are no longer permissive. Probe
> failures for Intel boards have been partially addressed by commit
> a22ae72b86a4 ("ASoC: soc-core: disable route checks for legacy devices")
> and its follow up but only skl_nau88l25_ssm4567.c is patched. Fix the
> problem for the rest of the boards.
> 
> Link: https://lore.kernel.org/all/20200309192744.18380-1-pierre-louis.bossart@linux.intel.com/
> Fixes: daa480bde6b3 ("ASoC: soc-core: tidyup for snd_soc_dapm_add_routes()")
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
