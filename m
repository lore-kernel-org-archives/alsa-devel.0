Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D99BC4167B
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Dec 2023 15:27:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0045ED7;
	Tue,  5 Dec 2023 16:27:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0045ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701790054;
	bh=xukjuGan3FvwHjC1u8CeuWNpwvGB/cEkfZb7z28+Ess=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nbbActgByVfpc24cw8W/U4gRxRvSiUdfvC7+2IsHThFqWNlzLW5e3RNrpcYtCQiN5
	 cfelv/n1E74xiCcitw8P6TKUVilLa12XpbgO7zuUOJH4QmDyr4CxuNkZKC2EFIbE7S
	 FA94ViAxe7kTN7zKvfdgGSehyt+n6nRSR6nIhJEQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0A9BF80604; Tue,  5 Dec 2023 16:26:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 276A7F805E0;
	Tue,  5 Dec 2023 16:26:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E85BCF802BE; Tue,  5 Dec 2023 16:25:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BFE1FF800F5
	for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2023 16:25:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFE1FF800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i2tG7uZa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701789943; x=1733325943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xukjuGan3FvwHjC1u8CeuWNpwvGB/cEkfZb7z28+Ess=;
  b=i2tG7uZakp91q5y1GqNmQkK+E4pj6gZsGFOJfpNIQEfxf/84iVMxQ6ES
   sm76KmSPOJxdyCI06jhbwy+vT7K4DkOiqVK1hDsx2WXrcb5OpqK+45chC
   HKJ4cxlVGzDYzfIxQV4/Ha72KRVv3hiOqCt6/L6bpEn5R6cu0imbDtWgA
   MRp4cmULDrrwsLdOKT2AuoVOMDFE2bijiI8kMnuCGBCA/GQmStTnlOFsz
   nzWEOzDgP/RV6tUbSj36QlLK2DtnAcgLFc/AoBclfSPAjH4C4e7YbiE0R
   SckSdGJapnradFigxgvBv1AzrD7yNpKd1rb+a5F5bvpzlAH2nh3EE/iMl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12626116"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600";
   d="scan'208";a="12626116"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 07:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="888975313"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600";
   d="scan'208";a="888975313"
Received: from mbapna-mobl1.amr.corp.intel.com (HELO [10.212.151.198])
 ([10.212.151.198])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 07:25:37 -0800
Message-ID: <72bb44a8-dbe6-4fdd-921a-b9fcf798fe3c@linux.intel.com>
Date: Tue, 5 Dec 2023 09:22:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: sof_sdw_cs_amp: Connect outputs to a speaker
 widget
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
 ranjani.sridharan@linux.intel.com
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20231205135001.2506070-1-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231205135001.2506070-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 4GQVYSKUK6FVVQORVVTDDA5DMDS3PHPR
X-Message-ID-Hash: 4GQVYSKUK6FVVQORVVTDDA5DMDS3PHPR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4GQVYSKUK6FVVQORVVTDDA5DMDS3PHPR/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 12/5/23 07:50, Richard Fitzgerald wrote:
> Hookup the CS35L56 DAPM_OUTPUT widgets to a DAPM_SPK widget so
> that there is a complete logical path to a speaker.
> 
> There is no particular reason to use multiple speaker widgets.
> The CS35L56 are designed to work together as a set so they have
> all been connected to a single speaker widget.
> 
> Instead of a hardcoded list of codec widget names, the code walks
> through all the codecs on the dailink and for every cs35l56 it uses
> its name prefix to construct the source end of the route. This adds
> a small amount of overhead during probe but has the benefit that it
> isn't dependent on every system using the same prefixes.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We should probably do the same thing for sof_sdw_rt_map.c, there's no
good reason to encode rt1316-2 SPOL and rt1318-2 SPOR
