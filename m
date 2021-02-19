Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55379C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:21:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C423964EAF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C423964EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 454BC166F;
	Sat, 20 Feb 2021 00:20:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 454BC166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613776862;
	bh=R13ooe3Bbj6tsQxvx3dWjVbs/Esr9VID2g3m/OBqHRQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dqtTZ9/9Q3KsUq3MSrIOzBGO3VMweVA5SBT9DmpsX/K8V124PIuBCoFQKN/kzzgCW
	 w9IBguoZA9Mq7caUmz3ZBZ0WPC2rVmlo8eZmlzamq6Ees1MXYaKqA65mzJJNS18D1M
	 EKgVd3DzqSc2jAzJhSFQJks83Pc3ks6VbCReOI0M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2491F8049C;
	Sat, 20 Feb 2021 00:17:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3200F802DB; Sat, 20 Feb 2021 00:17:05 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44E8EF800C7
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:16:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44E8EF800C7
IronPort-SDR: H7MGEbaXJX//aw6oU/WqWx7RnMJkk4oNpuF4lLsNA87mx2vZh4hNiI5sU2sXYMY9pdh7rPEbVY
 iUxdGqMsM0zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="181436681"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="181436681"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:16:50 -0800
IronPort-SDR: 0Pq2TbEvYOtVH5RDtU64/b2G0VQv870Cetp2TFS4JuH9gGDEcohDiiXVDM2k13wx2GCJAuojKn
 +F0+VtjWrQ7Q==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="420329802"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:16:49 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 8/8] ASoC: sh: siu_pcm: remove unused variable
Date: Fri, 19 Feb 2021 17:16:35 -0600
Message-Id: <20210219231635.5749-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219231635.5749-1-pierre-louis.bossart@linux.intel.com>
References: <20210219231635.5749-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

cppcheck warning:

sound/soc/sh/siu_pcm.c:225:8: style: Variable 'virt' is assigned a
value that is never used. [unreadVariable]

  virt = PERIOD_OFFSET(rt->dma_area,
       ^

It's not clear what this variable was needed for, remove it.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sh/siu_pcm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 6496300f73a9..0a8a3c314a73 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -217,14 +217,10 @@ static void siu_io_work(struct work_struct *work)
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		dma_addr_t buff;
 		size_t count;
-		u8 *virt;
 
 		buff = (dma_addr_t)PERIOD_OFFSET(rt->dma_addr,
 						siu_stream->cur_period,
 						siu_stream->period_bytes);
-		virt = PERIOD_OFFSET(rt->dma_area,
-				     siu_stream->cur_period,
-				     siu_stream->period_bytes);
 		count = siu_stream->period_bytes;
 
 		/* DMA transfer start */
-- 
2.25.1

