Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA71CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:30:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0283A2184C
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PJCTCqgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0283A2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D633166C;
	Tue, 22 Oct 2019 21:29:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D633166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571772647;
	bh=wXq3zTWFwdKCXPKrqDOk/wvHJMJ02+6ZIrl6AlkGDCQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PJCTCqgG75IsiehrOpsVzgK50MVE4/XTJCWmWSU5bJ+iwvhhJ//lls66uks3+0gDp
	 Y3tgGcoIfyIibDaeq9g4H0YYDUesxE4bTIbQtwaWCgYF9LkNRd6zARK6iqEs03T3+L
	 mfmaFE816RPgFCVLpZxe5t78qmoP8r5WygEHC7ZU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AC3FF80390;
	Tue, 22 Oct 2019 21:29:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C25E3F80322; Tue, 22 Oct 2019 21:28:58 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 279E8F8031A
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 21:28:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 279E8F8031A
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 12:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,217,1569308400"; d="scan'208";a="281393567"
Received: from mssikder-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.68.44])
 by orsmga001.jf.intel.com with ESMTP; 22 Oct 2019 12:28:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 22 Oct 2019 14:28:44 -0500
Message-Id: <20191022192844.21022-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022192844.21022-1-pierre-louis.bossart@linux.intel.com>
References: <20191022192844.21022-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 2/2] ASoC: SOF: Intel: hda: add dev_err()
	traces for snd_sof_dsp_read_poll_timeout()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Such traces should be extremely rare but extremely useful for debug.

Report errors for all calls to sdn_sof_dsp_read_poll_timeout(), but
only on negative values for consistency.

Add traces that enable each timeout to be uniquely identified.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c    | 30 +++++++++++++++++++++++++++---
 sound/soc/sof/intel/hda-loader.c | 13 ++++++++++++-
 sound/soc/sof/intel/hda-stream.c | 24 ++++++++++++++++++++----
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index f456ba962c8f..fa2f1f66c72c 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -42,6 +42,12 @@ int hda_dsp_core_reset_enter(struct snd_sof_dev *sdev, unsigned int core_mask)
 					((adspcs & reset) == reset),
 					HDA_DSP_REG_POLL_INTERVAL_US,
 					HDA_DSP_RESET_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: %s: timeout on HDA_DSP_REG_ADSPCS read\n",
+			__func__);
+		return ret;
+	}
 
 	/* has core entered reset ? */
 	adspcs = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
@@ -77,6 +83,13 @@ int hda_dsp_core_reset_leave(struct snd_sof_dev *sdev, unsigned int core_mask)
 					    HDA_DSP_REG_POLL_INTERVAL_US,
 					    HDA_DSP_RESET_TIMEOUT_US);
 
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: %s: timeout on HDA_DSP_REG_ADSPCS read\n",
+			__func__);
+		return ret;
+	}
+
 	/* has core left reset ? */
 	adspcs = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
 				  HDA_DSP_REG_ADSPCS);
@@ -151,8 +164,12 @@ int hda_dsp_core_power_up(struct snd_sof_dev *sdev, unsigned int core_mask)
 					    (adspcs & cpa) == cpa,
 					    HDA_DSP_REG_POLL_INTERVAL_US,
 					    HDA_DSP_RESET_TIMEOUT_US);
-	if (ret < 0)
-		dev_err(sdev->dev, "error: timeout on core powerup\n");
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: %s: timeout on HDA_DSP_REG_ADSPCS read\n",
+			__func__);
+		return ret;
+	}
 
 	/* did core power up ? */
 	adspcs = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
@@ -171,17 +188,24 @@ int hda_dsp_core_power_up(struct snd_sof_dev *sdev, unsigned int core_mask)
 int hda_dsp_core_power_down(struct snd_sof_dev *sdev, unsigned int core_mask)
 {
 	u32 adspcs;
+	int ret;
 
 	/* update bits */
 	snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
 					 HDA_DSP_REG_ADSPCS,
 					 HDA_DSP_ADSPCS_SPA_MASK(core_mask), 0);
 
-	return snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR,
 				HDA_DSP_REG_ADSPCS, adspcs,
 				!(adspcs & HDA_DSP_ADSPCS_SPA_MASK(core_mask)),
 				HDA_DSP_REG_POLL_INTERVAL_US,
 				HDA_DSP_PD_TIMEOUT * USEC_PER_MSEC);
+	if (ret < 0)
+		dev_err(sdev->dev,
+			"error: %s: timeout on HDA_DSP_REG_ADSPCS read\n",
+			__func__);
+
+	return ret;
 }
 
 bool hda_dsp_core_is_enabled(struct snd_sof_dev *sdev,
diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 7956dbf5be88..b1783360fe10 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -126,7 +126,8 @@ static int cl_dsp_init(struct snd_sof_dev *sdev, const void *fwdata,
 					    HDA_DSP_INIT_TIMEOUT_US);
 
 	if (ret < 0) {
-		dev_err(sdev->dev, "error: waiting for HIPCIE done\n");
+		dev_err(sdev->dev, "error: %s: timeout for HIPCIE done\n",
+			__func__);
 		goto err;
 	}
 
@@ -152,6 +153,10 @@ static int cl_dsp_init(struct snd_sof_dev *sdev, const void *fwdata,
 	if (!ret)
 		return 0;
 
+	dev_err(sdev->dev,
+		"error: %s: timeout HDA_DSP_SRAM_REG_ROM_STATUS read\n",
+		__func__);
+
 err:
 	hda_dsp_dump(sdev, SOF_DBG_REGS | SOF_DBG_PCI | SOF_DBG_MBOX);
 	hda_dsp_core_reset_power_down(sdev, chip->cores_mask);
@@ -258,6 +263,12 @@ static int cl_copy_fw(struct snd_sof_dev *sdev, struct hdac_ext_stream *stream)
 	 * but we return the initial error should the DMA stop also fail
 	 */
 
+	if (status < 0) {
+		dev_err(sdev->dev,
+			"error: %s: timeout HDA_DSP_SRAM_REG_ROM_STATUS read\n",
+			__func__);
+	}
+
 	ret = cl_trigger(sdev, stream, SNDRV_PCM_TRIGGER_STOP);
 	if (ret < 0) {
 		dev_err(sdev->dev, "error: DMA trigger stop failed\n");
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 2c7447188402..450f9c55785f 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -275,8 +275,12 @@ int hda_dsp_stream_trigger(struct snd_sof_dev *sdev,
 					HDA_DSP_REG_POLL_INTERVAL_US,
 					HDA_DSP_STREAM_RUN_TIMEOUT);
 
-		if (ret)
+		if (ret < 0) {
+			dev_err(sdev->dev,
+				"error: %s: cmd %d: timeout on STREAM_SD_OFFSET read\n",
+				__func__, cmd);
 			return ret;
+		}
 
 		hstream->running = true;
 		break;
@@ -294,8 +298,12 @@ int hda_dsp_stream_trigger(struct snd_sof_dev *sdev,
 						HDA_DSP_REG_POLL_INTERVAL_US,
 						HDA_DSP_STREAM_RUN_TIMEOUT);
 
-		if (ret)
+		if (ret < 0) {
+			dev_err(sdev->dev,
+				"error: %s: cmd %d: timeout on STREAM_SD_OFFSET read\n",
+				__func__, cmd);
 			return ret;
+		}
 
 		snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, sd_offset +
 				  SOF_HDA_ADSP_REG_CL_SD_STS,
@@ -356,8 +364,12 @@ int hda_dsp_stream_hw_params(struct snd_sof_dev *sdev,
 					    HDA_DSP_REG_POLL_INTERVAL_US,
 					    HDA_DSP_STREAM_RUN_TIMEOUT);
 
-	if (ret)
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: %s: timeout on STREAM_SD_OFFSET read1\n",
+			__func__);
 		return ret;
+	}
 
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 				sd_offset + SOF_HDA_ADSP_REG_CL_SD_STS,
@@ -418,8 +430,12 @@ int hda_dsp_stream_hw_params(struct snd_sof_dev *sdev,
 					    HDA_DSP_REG_POLL_INTERVAL_US,
 					    HDA_DSP_STREAM_RUN_TIMEOUT);
 
-	if (ret)
+	if (ret < 0) {
+		dev_err(sdev->dev,
+			"error: %s: timeout on STREAM_SD_OFFSET read2\n",
+			__func__);
 		return ret;
+	}
 
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
 				sd_offset + SOF_HDA_ADSP_REG_CL_SD_STS,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
