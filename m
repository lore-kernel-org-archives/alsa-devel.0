Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF62C4345F
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:58:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91F0182B;
	Fri, 26 Apr 2024 11:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91F0182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714125528;
	bh=S0Y14cS9v8T8Hz+iw6/hHSZd+jbr1t3NSc0nj1YWyuY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sKCK1TMQPbo/zjAvBFbPs5DURjw7fULlZ2seca2dtn+onxCh4kLPQGmwwBQmL6j49
	 EFuZOjCcCIT6WPfTgMNhTr3aC6N5O8Jbn9zhFcYBxsz7//o7lVds9dHCUgzzNQ8nE9
	 DVrjOSvP2d1w7gNf+utealIIl5iGdF3IXLTrY+mo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 496EEF8059F; Fri, 26 Apr 2024 11:58:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 83B6FF805A8;
	Fri, 26 Apr 2024 11:58:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12CD1F80571; Fri, 26 Apr 2024 11:57:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A05B9F800B5
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2024 11:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A05B9F800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XnSX/fJ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714125415; x=1745661415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S0Y14cS9v8T8Hz+iw6/hHSZd+jbr1t3NSc0nj1YWyuY=;
  b=XnSX/fJ1BB3eVF3omlt8/DowQVXfAQaAO8RT7ml9vLoHvjXzxBkZnmv3
   eKJ0nXloX7EOA4KVBB/eYd3AsXhrOBzgSHuUwxMBtfhY5Vv2UaF7kkJTy
   7W41WqbDrTHLsdWPIGStpW3anrnC3FwXKOuVS8eGYGT4aIvH05bPRqSx/
   BWGBQF3UyJOKXIjCdbV6yNK2+TFo8ZLBt4VILe1jSCB7krA9gNeAsqIar
   kAfMl6GTwNPkRcfTvypdJM+9Opz1uXtCLF+W17FVinYyGAeKSSBiyXhNo
   WJRXK/5jGkVCIeb2KaeyDk30Lh6YQhzsd0pZ8Zg55Xv3puTJrT4nMorME
   w==;
X-CSE-ConnectionGUID: rPE2w3q7T+yGpOnH21x6TA==
X-CSE-MsgGUID: EHV+ES8DQSyIE+S13i7Rtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20409179"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000";
   d="scan'208";a="20409179"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 02:56:50 -0700
X-CSE-ConnectionGUID: oKRUPPqGQMO4N8oKYUN0JA==
X-CSE-MsgGUID: aJLiadZ6SDK4FcscLUKDYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000";
   d="scan'208";a="25460535"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa010.fm.intel.com with ESMTP; 26 Apr 2024 02:56:48 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	amadeuszx.slawinski@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 0/8] ASoC: Intel: avs: PCM code cleanup
Date: Fri, 26 Apr 2024 11:57:25 +0200
Message-Id: <20240426095733.3946951-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: V2HYMY5A6VKYWRSXEJCQABHJ3O6ZHBP6
X-Message-ID-Hash: V2HYMY5A6VKYWRSXEJCQABHJ3O6ZHBP6
X-MailFrom: cezary.rojewski@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V2HYMY5A6VKYWRSXEJCQABHJ3O6ZHBP6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

A set of changes that aims to improve readability of cohesiveness of the
pcm code for the avs-driver.

Start off with a change that synchronizes DAI open/close - DAIs are
started up in ascending order yet their shutdown does not follow the
scheme - it is done in the ascending order too, rather than desceding
one. This patch is a dependency for the next one in line.

To align the HDAudio DAI startup/shutdown with the non-HDAudio
equivalents, relocate the code from component to DAI. The reason above
is a dependency stems from codec driver requirements - HDAudio code
found in sound/pci/hda/ expects substream->runtime->private_data to
point to a valid stream (HOST) pointer.

With the hard part done, the follow up changes update the existing code
to reduce it is complexity - removal of duplicates, renaming of
ambiguous functions and adding new fields to DAI-data object so that the
number of local variables and casts is reduced.

Cezary Rojewski (8):
  ASoC: pcm: Reverse iterate DAIs when shutting them down
  ASoC: Intel: avs: Relocate HDA BE DAI specific operations
  ASoC: Intel: avs: Remove redundancy around DAI shutdown
  ASoC: Intel: avs: Store pointer to adev in DAI dma_data
  ASoC: Intel: avs: Remove redundancy around DAI startup
  ASoC: Intel: avs: Remove redundancy around DAI prepare
  ASoC: Intel: avs: Store pointer to link_stream in dma_data
  ASoC: Intel: avs: Clean up hw constraints initialization

 include/sound/soc.h       |   4 +
 sound/soc/intel/avs/pcm.c | 250 +++++++++++++++++---------------------
 sound/soc/soc-pcm.c       |   2 +-
 3 files changed, 117 insertions(+), 139 deletions(-)

-- 
2.25.1

