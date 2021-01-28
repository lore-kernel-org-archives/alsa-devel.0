Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FECDC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 09:44:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798E664DD1
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 09:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798E664DD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BC4C16E1;
	Thu, 28 Jan 2021 10:43:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BC4C16E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611827086;
	bh=slPr7+JWKmT1EeWqcQWcNVhE7Rx49C9zFDSQv2h4L7o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQBKJTdDRIdDmH8jCMW+utGXGtbnO9Ef5zOQ9xZYhxsB2JImvNIGTj1hHW0U0/U+x
	 HWvaCRJGfPH3zqNWbFNN4OmaMOM2l6Dkt6CzUwS1xT17HjWBXZsr8fNTPBRADcuyBP
	 SxYcFB478b91+lGlBPuxjYNi/gBsv1r0S6ZYh/eA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0274F804CA;
	Thu, 28 Jan 2021 10:42:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA91FF804D2; Thu, 28 Jan 2021 10:42:36 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4ED80F800D1
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 10:42:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4ED80F800D1
IronPort-SDR: El2Uwy+wFxYWgTJS8JAgz5StJVBy/1JVSsyTXohFYKGAYkYy8oz45Ak8HnyEoOXLWirugpbCWZ
 oQux76m7/hkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159380109"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; d="scan'208";a="159380109"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2021 01:42:19 -0800
IronPort-SDR: sXZlwUuRspbFDlquc24/TlQVDyGkxWFGLlSuy8mSsy0i6So/t6V7Hk+Pi1nBT6o7Jh31uAk/sK
 aBZRg6tziHTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; d="scan'208";a="369789136"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 28 Jan 2021 01:42:17 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 3/5] ASoC: SOF: update dsp core power status in common APIs
Date: Thu, 28 Jan 2021 11:38:48 +0200
Message-Id: <20210128093850.1041387-4-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128093850.1041387-1-kai.vehmanen@linux.intel.com>
References: <20210128093850.1041387-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Only manage enabled_cores_mask in common snd_sof_dsp_core_power_up/down
APIs to ensure it stays in sync with actual DSP core state.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/loader.c   |  6 ------
 sound/soc/sof/ops.h      | 22 ++++++++++++++++------
 sound/soc/sof/pm.c       |  1 -
 sound/soc/sof/topology.c |  8 --------
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 08a17abb63ff..4ade55bf6d75 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -811,7 +811,6 @@ EXPORT_SYMBOL(snd_sof_load_firmware);
 int snd_sof_run_firmware(struct snd_sof_dev *sdev)
 {
 	int ret;
-	int init_core_mask;
 
 	init_waitqueue_head(&sdev->boot_wait);
 
@@ -843,8 +842,6 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
-	init_core_mask = ret;
-
 	/*
 	 * now wait for the DSP to boot. There are 3 possible outcomes:
 	 * 1. Boot wait times out indicating FW boot failure.
@@ -874,9 +871,6 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
-	/* fw boot is complete. Update the active cores mask */
-	sdev->enabled_cores_mask = init_core_mask;
-
 	return 0;
 }
 EXPORT_SYMBOL(snd_sof_run_firmware);
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index f0c9ca8820d2..2e9a8da53d57 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -76,19 +76,29 @@ static inline int snd_sof_dsp_reset(struct snd_sof_dev *sdev)
 static inline int snd_sof_dsp_core_power_up(struct snd_sof_dev *sdev,
 					    unsigned int core_mask)
 {
-	if (sof_ops(sdev)->core_power_up)
-		return sof_ops(sdev)->core_power_up(sdev, core_mask);
+	int ret = 0;
 
-	return 0;
+	if (sof_ops(sdev)->core_power_up) {
+		ret = sof_ops(sdev)->core_power_up(sdev, core_mask);
+		if (!ret)
+			sdev->enabled_cores_mask |= core_mask;
+	}
+
+	return ret;
 }
 
 static inline int snd_sof_dsp_core_power_down(struct snd_sof_dev *sdev,
 					      unsigned int core_mask)
 {
-	if (sof_ops(sdev)->core_power_down)
-		return sof_ops(sdev)->core_power_down(sdev, core_mask);
+	int ret = 0;
 
-	return 0;
+	if (sof_ops(sdev)->core_power_down) {
+		ret = sof_ops(sdev)->core_power_down(sdev, core_mask);
+		if (!ret)
+			sdev->enabled_cores_mask &= ~core_mask;
+	}
+
+	return ret;
 }
 
 /* pre/post fw load */
diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index c83fb6255961..fd265803f7bc 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -256,7 +256,6 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 
 	/* reset FW state */
 	sdev->fw_state = SOF_FW_BOOT_NOT_STARTED;
-	sdev->enabled_cores_mask = 0;
 
 	return ret;
 }
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index b6b32a7a91f8..b69f493b5faa 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1352,10 +1352,6 @@ static int sof_core_enable(struct snd_sof_dev *sdev, int core)
 			core, ret);
 		goto err;
 	}
-
-	/* update enabled cores mask */
-	sdev->enabled_cores_mask |= BIT(core);
-
 	return ret;
 err:
 	/* power down core if it is host managed and return the original error if this fails too */
@@ -2603,10 +2599,6 @@ static int sof_widget_unload(struct snd_soc_component *scomp,
 		if (ret < 0)
 			dev_err(scomp->dev, "error: powering down pipeline schedule core %d\n",
 				pipeline->core);
-
-		/* update enabled cores mask */
-		sdev->enabled_cores_mask &= ~(1 << pipeline->core);
-
 		break;
 	default:
 		break;
-- 
2.29.2

