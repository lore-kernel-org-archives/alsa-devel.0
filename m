Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDD4C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:25:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178D464E7A
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178D464E7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F1CB16A2;
	Tue,  9 Feb 2021 00:24:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F1CB16A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612826723;
	bh=tmoeTG1GcnuxfOLn9QSPloyite1LOyrwuYRtLxk4lvc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uzpFbHYouznRYkVVYzqe1z/qobG8JoJTMLdC4Jh8GdVbeFXn12jGvAuUkYSOggNjn
	 ppPZuDaS1Yt73qxoUqH6Eo0m4zoVaTQbzCGpKHkePktESNHd4MUPn4aqdqRpgODpgK
	 0mqUKvAaboOgTKCsjiNWNLF7G3mBy3pSSS4MOS14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0707AF8026C;
	Tue,  9 Feb 2021 00:23:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1951F80278; Tue,  9 Feb 2021 00:23:45 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2E1DF80165
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:23:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2E1DF80165
IronPort-SDR: yEqeO0yzP2LJrHT+PU++KIbPVSe5hwW5PldUGbJMBP1it6td+3SZJWp0pSp0n/PGSFcVEKamSi
 elfnwEiHCX4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="243295592"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="243295592"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:22:16 -0800
IronPort-SDR: hpMqE0sEW5ZDMVZt6E8waDl313yo9K+O+0GdHSueIwch2flexldVJgx8agcboL/HRXVM+unSmT
 9mEzRMucguoQ==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="585854675"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:22:16 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/5] ASoC: SOF: fix string format for errors
Date: Mon,  8 Feb 2021 17:21:46 -0600
Message-Id: <20210208232149.58899-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208232149.58899-1-pierre-louis.bossart@linux.intel.com>
References: <20210208232149.58899-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Curtis Malainey <cujomalainey@chromium.org>
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

From: Curtis Malainey <cujomalainey@chromium.org>

These are negative error return values, printing them as hex is annoying
and not beneficial. Switch back to signed type to make error lookup
simpler.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-compress.c | 2 +-
 sound/soc/sof/intel/hda-dsp.c      | 2 +-
 sound/soc/sof/intel/hda-loader.c   | 6 +++---
 sound/soc/sof/intel/hda-pcm.c      | 2 +-
 sound/soc/sof/intel/hda-trace.c    | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda-compress.c b/sound/soc/sof/intel/hda-compress.c
index c6cf7b313934..fe2f3f7d236b 100644
--- a/sound/soc/sof/intel/hda-compress.c
+++ b/sound/soc/sof/intel/hda-compress.c
@@ -82,7 +82,7 @@ int hda_probe_compr_set_params(struct snd_sof_dev *sdev,
 
 	ret = hda_dsp_stream_hw_params(sdev, stream, dmab, NULL);
 	if (ret < 0) {
-		dev_err(sdev->dev, "error: hdac prepare failed: %x\n", ret);
+		dev_err(sdev->dev, "error: hdac prepare failed: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index e92e9750b720..72c0b8e9a196 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -732,7 +732,7 @@ int hda_dsp_resume(struct snd_sof_dev *sdev)
 				ret = snd_hdac_ext_bus_link_power_up(hlink);
 				if (ret < 0) {
 					dev_dbg(sdev->dev,
-						"error %x in %s: failed to power up links",
+						"error %d in %s: failed to power up links",
 						ret, __func__);
 					return ret;
 				}
diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index d744952f6954..fc25ee8f68dc 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -47,7 +47,7 @@ static struct hdac_ext_stream *cl_stream_prepare(struct snd_sof_dev *sdev, unsig
 	/* allocate DMA buffer */
 	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG, &pci->dev, size, dmab);
 	if (ret < 0) {
-		dev_err(sdev->dev, "error: memory alloc failed: %x\n", ret);
+		dev_err(sdev->dev, "error: memory alloc failed: %d\n", ret);
 		goto error;
 	}
 
@@ -58,13 +58,13 @@ static struct hdac_ext_stream *cl_stream_prepare(struct snd_sof_dev *sdev, unsig
 	if (direction == SNDRV_PCM_STREAM_CAPTURE) {
 		ret = hda_dsp_iccmax_stream_hw_params(sdev, dsp_stream, dmab, NULL);
 		if (ret < 0) {
-			dev_err(sdev->dev, "error: iccmax stream prepare failed: %x\n", ret);
+			dev_err(sdev->dev, "error: iccmax stream prepare failed: %d\n", ret);
 			goto error;
 		}
 	} else {
 		ret = hda_dsp_stream_hw_params(sdev, dsp_stream, dmab, NULL);
 		if (ret < 0) {
-			dev_err(sdev->dev, "error: hdac prepare failed: %x\n", ret);
+			dev_err(sdev->dev, "error: hdac prepare failed: %d\n", ret);
 			goto error;
 		}
 		hda_dsp_stream_spib_config(sdev, dsp_stream, HDA_DSP_SPIB_ENABLE, size);
diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index 689934131a68..df00db8369c7 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -111,7 +111,7 @@ int hda_dsp_pcm_hw_params(struct snd_sof_dev *sdev,
 
 	ret = hda_dsp_stream_hw_params(sdev, stream, dmab, params);
 	if (ret < 0) {
-		dev_err(sdev->dev, "error: hdac prepare failed: %x\n", ret);
+		dev_err(sdev->dev, "error: hdac prepare failed: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/sof/intel/hda-trace.c b/sound/soc/sof/intel/hda-trace.c
index 81d76d3debc6..29e3da3c63db 100644
--- a/sound/soc/sof/intel/hda-trace.c
+++ b/sound/soc/sof/intel/hda-trace.c
@@ -32,7 +32,7 @@ static int hda_dsp_trace_prepare(struct snd_sof_dev *sdev)
 
 	ret = hda_dsp_stream_hw_params(sdev, stream, dmab, NULL);
 	if (ret < 0)
-		dev_err(sdev->dev, "error: hdac prepare failed: %x\n", ret);
+		dev_err(sdev->dev, "error: hdac prepare failed: %d\n", ret);
 
 	return ret;
 }
@@ -59,7 +59,7 @@ int hda_dsp_trace_init(struct snd_sof_dev *sdev, u32 *stream_tag)
 	 */
 	ret = hda_dsp_trace_prepare(sdev);
 	if (ret < 0) {
-		dev_err(sdev->dev, "error: hdac trace init failed: %x\n", ret);
+		dev_err(sdev->dev, "error: hdac trace init failed: %d\n", ret);
 		hda_dsp_stream_put(sdev, SNDRV_PCM_STREAM_CAPTURE, *stream_tag);
 		hda->dtrace_stream = NULL;
 		*stream_tag = 0;
-- 
2.25.1

