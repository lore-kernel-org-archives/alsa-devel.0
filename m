Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0F2C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 12:27:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2BD60F9C
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 12:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A2BD60F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E46916A5;
	Mon, 15 Nov 2021 13:26:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E46916A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636979242;
	bh=yb9AxKn69H9AcnxRt95CuqOPMBxupDhIhzXIU5/J64I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YHOe1taGE/5/GRI2sU9GjU/31sftih1z5OmqJvM5rTKqNdMp+MDd1AzVgSd4u2FDU
	 uVkPalXazAwLTJqLPRdcSzPV5wZlwSDQhfEk+DV+pUjweyd0uvZ8awLAGB7tlRzqhP
	 QSinIlohHG3x9BxzexNnNPfPr6mIhJbaQ088fPHU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1C67F80533;
	Mon, 15 Nov 2021 13:23:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16458F8051D; Mon, 15 Nov 2021 13:23:23 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8187F804FB
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 13:23:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8187F804FB
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220639146"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; d="scan'208";a="220639146"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 04:23:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; d="scan'208";a="505899132"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 04:23:07 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [RESEND PATCH 09/10] ASoC: intel: sof_sdw: remove get_next_be_id
Date: Mon, 15 Nov 2021 20:22:40 +0800
Message-Id: <20211115122241.13242-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115122241.13242-1-yung-chuan.liao@linux.intel.com>
References: <20211115122241.13242-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
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

DAI link id will not be set from sdw codec init feedback function,
and be_id is changed by create_sdw_dailink() now. So we don't need
get_next_be_id() anymore.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index aac493aea002..df29f7b478a4 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1044,17 +1044,6 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 	return 0;
 }
 
-/*
- * DAI link ID of SSP & DMIC & HDMI are based on last
- * link ID used by sdw link. Since be_id may be changed
- * in init func of sdw codec, it is not equal to be_id
- */
-static inline int get_next_be_id(struct snd_soc_dai_link *links,
-				 int be_id)
-{
-	return links[be_id - 1].id + 1;
-}
-
 #define IDISP_CODEC_MASK	0x4
 
 static int sof_card_codec_conf_alloc(struct device *dev,
@@ -1223,9 +1212,6 @@ static int sof_card_dai_links_create(struct device *dev,
 		}
 	}
 
-	/* get BE ID for non-sdw DAI */
-	be_id = get_next_be_id(links, link_index);
-
 SSP:
 	/* SSP */
 	if (!ssp_num)
-- 
2.17.1

