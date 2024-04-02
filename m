Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA30C6FD1F
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:21:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E2892C19;
	Tue,  2 Apr 2024 17:21:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E2892C19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712071279;
	bh=UwtYxBJyt3wQGzqEI4KWrGa53H0S9tKuqrOmRnTF6Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cwQ8/AJZNmRVm70vAb14DSZxegWT1POViAILz+6gg9LO36SIVMl1QJxDh2VAKm7Ds
	 KTygcwDUW6AUUA7skaqYO4B3c0dgQQ357Wnv549DDtV14RhxOXnDwBtWZ+vTQIdnp0
	 jrhBCZar3QNkjIDcqTjGRvTnwX9YcnkZBrHwsIXk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E37F2F806BB; Tue,  2 Apr 2024 17:19:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EC6DDF806BD;
	Tue,  2 Apr 2024 17:19:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EF1DF805EC; Tue,  2 Apr 2024 17:18:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DD545F8055C
	for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2024 17:18:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD545F8055C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FcmVhkZk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712071129; x=1743607129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwtYxBJyt3wQGzqEI4KWrGa53H0S9tKuqrOmRnTF6Sc=;
  b=FcmVhkZkqT0a0mUOm0XRYMMKLDPRo/U26WSzOuixQlU7UDXHhAjSTbKr
   iYhKF2YMoLjIiyEaJNz2P8l92ARl6IBzxHWXH3qNu1th/ywNr6WFCbQ4o
   YV05YGFVYMtYGM5x4Ddpba4FHnjtYP0+K1u32sO+lMobb7jRGPlwmqIqG
   2ap0tsMpJwA6b+k+Fhy4dQc9MzE4mo5aoznGt4/vwlXEkJOhNEC/KM4Zr
   Q2I6xvBrtSNoOYu19OsBlkEDpa927Z6SB+s3ROqc7yTg4DfFF39XaJphC
   jC3wisx8zzN/7o2Gfk6qQvjA/Vyi/JPOFFynLggx4w6fULeebKNtpmu9p
   A==;
X-CSE-ConnectionGUID: m6hwvYugRsCgUJwF828PSA==
X-CSE-MsgGUID: gd/CBDKoTKyzoPcbXY16Qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="29730019"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000";
   d="scan'208";a="29730019"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 08:18:42 -0700
X-CSE-ConnectionGUID: zPRIZFbSSLWQAvUAgJ8+mQ==
X-CSE-MsgGUID: BHW7BdmLR7aSh/HeLSBHFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000";
   d="scan'208";a="22796510"
Received: from skhare-mobl5.amr.corp.intel.com (HELO pbossart-mobl6.intel.com)
 ([10.212.8.83])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 08:18:41 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 08/17] ASoC: SOF: Intel: set the DMA TLV device as dai_index
Date: Tue,  2 Apr 2024 10:18:19 -0500
Message-Id: <20240402151828.175002-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402151828.175002-1-pierre-louis.bossart@linux.intel.com>
References: <20240402151828.175002-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4Z24JAI6ZYFVJAZK6ULQPURH3PHSL7Q2
X-Message-ID-Hash: 4Z24JAI6ZYFVJAZK6ULQPURH3PHSL7Q2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4Z24JAI6ZYFVJAZK6ULQPURH3PHSL7Q2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

We've already defined the value for dai_index, let's use it instead of
open-coding the same thing. No functionality change.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index c48ac931753c..86efcbe8f0d8 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -533,7 +533,7 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 	ipc4_copier = widget_to_copier(w);
 	dma_config_tlv = &ipc4_copier->dma_config_tlv[cpu_dai_id];
 	dma_config = &dma_config_tlv->dma_config;
-	dma_config->dma_stream_channel_map.mapping[0].device = link_id << 8 | cpu_dai->id;
+	dma_config->dma_stream_channel_map.mapping[0].device = data.dai_index;
 	dma_config->dma_stream_channel_map.mapping[0].channel_mask = ch_mask;
 
 	/*
-- 
2.40.1

