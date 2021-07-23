Return-Path: <SRS0=VrYT=MP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8DDC4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 11:58:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E5260E8C
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 11:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12E5260E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5B931724;
	Fri, 23 Jul 2021 13:57:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5B931724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627041483;
	bh=xIXdWqE+yZ7R1LvP0c0gbpZYw1I4tGp2hJpGaLMpp0w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=muztAgIULBBwQiGhnu0psTuGCsMzoDiR9cNmxhvQofwvPcG381j1tMxt2FMHpmE1q
	 89vzb6OumHBDFf5CdOWoTr2XKnWuWRCtEjcCn1gaoJ7wVbc2MMMbqp3R7ZA6+1fI1Q
	 Jzp0cTLK3uos1BIK3OlHNmt12rwHVWj977Azb3f8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17BB2F804F1;
	Fri, 23 Jul 2021 13:55:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61CCBF804F2; Fri, 23 Jul 2021 13:55:22 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87103F804BD
 for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2021 13:55:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87103F804BD
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="209972207"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; d="scan'208";a="209972207"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 04:55:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; d="scan'208";a="455069777"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 04:55:08 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 3/6] ASoC: SOF: intel: hda: remove
 HDA_DSP_REG_SNDW_WAKE_STS definition
Date: Fri, 23 Jul 2021 19:54:48 +0800
Message-Id: <20210723115451.7245-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

HDA_DSP_REG_SNDW_WAKE_STS is actually (SDW_SHIM_BASE + SDW_SHIM_WAKESTS)
and SDW_SHIM_BASE is platform-dependent. Removing HDA_DSP_REG_SNDW_WAKE_STS
and use (hdev->desc->sdw_shim_base + SDW_SHIM_WAKESTS) instead.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 2 +-
 sound/soc/sof/intel/hda.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e1e368ff2b12..e48e030f6005 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -249,7 +249,7 @@ static bool hda_sdw_check_wakeen_irq(struct snd_sof_dev *sdev)
 	hdev = sdev->pdata->hw_pdata;
 	if (hdev->sdw &&
 	    snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-			     HDA_DSP_REG_SNDW_WAKE_STS))
+			     hdev->desc->sdw_shim_base + SDW_SHIM_WAKESTS))
 		return true;
 
 	return false;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 4d44f8910393..06ea0006999a 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -233,7 +233,6 @@
 #define HDA_DSP_REG_ADSPIS2		(HDA_DSP_GEN_BASE + 0x14)
 
 #define HDA_DSP_REG_ADSPIS2_SNDW	BIT(5)
-#define HDA_DSP_REG_SNDW_WAKE_STS      0x2C192
 
 /* Intel HD Audio Inter-Processor Communication Registers */
 #define HDA_DSP_IPC_BASE		0x40
-- 
2.17.1

