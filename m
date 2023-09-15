Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584C4EE6457
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 11:45:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F0F5AE8;
	Fri, 15 Sep 2023 13:44:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F0F5AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694778299;
	bh=SYmstbt0LQw+wocgMfpIIE8Oaex7gGlxRsW9kAeUI6s=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z8lZ/Yz8CL8ELdFhu+W6SFE7R2DzggwauVK82Uu6aXBCJYQ1vQHT5GxZ81o4GRRhx
	 7SJ6KPmAd+pFyQ7aVi3jD+2CkKBpDs+qpOnBN9Z03tuLctO5e3VQRlJ/e25gazZU/U
	 xViupn7RJdeCRqhloN9rtFSLQopiq0bszvbnafvU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 610BAF80431; Fri, 15 Sep 2023 13:43:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E8E0F80551;
	Fri, 15 Sep 2023 13:43:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 845AAF80425; Fri, 15 Sep 2023 13:43:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EDA99F80537
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 13:43:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDA99F80537
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kTdpuBTe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694778204; x=1726314204;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=SYmstbt0LQw+wocgMfpIIE8Oaex7gGlxRsW9kAeUI6s=;
  b=kTdpuBTefJo8wdhPok3KTYFPUYtEiWZaAK0CPjf7tcfOABCbRHMkI7ni
   fizmH91By+0I35LvSeR2YUFPHcbnGY1H55ik+Tl4XGOgQuaj3bTQ6DMsk
   US7ZQgU/kYoGsNOT+Q4t+2xtxKuD0CZjFkmjgRUaWH5AMVvBVw8OJ4qLf
   FbjaLHMqRDd5t/FAADnbrydyw7vP+YdwTBn7nt+A0Jx02h2qqeGGEiMAh
   iPQQ0DUoysXGr+RBFls6tDHAmngplyk1NBtJgib0/iWKrbwwaYUBiHvsV
   5yBFEul7sGbL3jYBXQGPDY2DgqoEe+j+eNiYgGUgZyLiI0ebNTyTVva7I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359485246"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000";
   d="scan'208";a="359485246"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 04:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744954114"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000";
   d="scan'208";a="744954114"
Received: from brhacker-mobl26.amr.corp.intel.com (HELO [10.252.48.34])
 ([10.252.48.34])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 04:43:18 -0700
Message-ID: <81010324-1f1b-4706-bbcd-09c3babaeaa7@linux.intel.com>
Date: Fri, 15 Sep 2023 14:43:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: SOF: ipc4/Intel: Implement split fw library
 loading
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 guennadi.liakhovetski@linux.intel.com, chao.song@linux.intel.com
References: <20230915113912.1405-1-peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230915113912.1405-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: L463CGJVABULK7WBG4GCL3CL2S7SFF53
X-Message-ID-Hash: L463CGJVABULK7WBG4GCL3CL2S7SFF53
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L463CGJVABULK7WBG4GCL3CL2S7SFF53/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 15/09/2023 14:39, Peter Ujfalusi wrote:
> Hi,
> 
> This series implements support for split library loading to comply with the HDA
> DMA programming sequence recommendation, which is:
> 1. DSP side DMA programming and GEN bit set to 1
> 2. host side DMA programming and RUN bit set to 1
> 
> The SOF support for library loading is based on this sequence, backwards
> compatibility with older reference firmware is supported (where only the
> LOAD_LIBRARY message is supported).
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ASoC: SOF: Intel: hda: Add definition for SDxFIFOS.FIFOS mask
>   ASoC: SOF: ipc4: Add new message type:
>     SOF_IPC4_GLB_LOAD_LIBRARY_PREPARE
>   ASoC: SOF: Intel: hda-loader: Add support for split library loading

There is something off with my scripts, one patch is missing, send the
series again with the four patch, please ignore this set.

> 
>  include/sound/sof/ipc4/header.h  | 15 +++++++++---
>  sound/soc/sof/intel/hda-loader.c | 42 ++++++++++++++++++++++++++++++--
>  sound/soc/sof/intel/hda-stream.c |  2 +-
>  sound/soc/sof/intel/hda.h        |  3 +++
>  sound/soc/sof/ipc4.c             |  1 +
>  5 files changed, 56 insertions(+), 7 deletions(-)
> 

-- 
Péter
