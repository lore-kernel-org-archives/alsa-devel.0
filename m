Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F4CC4BA09
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:39:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE492082F
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yf7Bmp81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE492082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 940C816A0;
	Wed, 26 Feb 2020 02:38:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 940C816A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582681172;
	bh=yBsxXSfWZHPVhhpSWe/T9tCfRGqHuIUL3XgAQoVcWrE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yf7Bmp81QdA48Wv/QOxtaHjgl2AUKmRIAuJ8Vc59+Y6o7w/HK1OOBTWQnEQ0j1N42
	 uDtPCcAZPxTfK5lv7aFM6cFoJsWodrATeCfWKdgGEtoJ5sEmJLMr+9L8xEqcTo2E7Q
	 Rwp1j7iaz5wO3wlAUBFXgkdHs/RxEWbFGpkmVzl4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E491F802A8;
	Wed, 26 Feb 2020 02:35:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35290F80096; Wed, 26 Feb 2020 02:35:25 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDDE4F80277
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 02:35:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDDE4F80277
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2020 17:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; d="scan'208";a="436461005"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2020 17:35:18 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH v5 5/6] ASoC: Return error if the function does not support
 multi-cpu
Date: Tue, 25 Feb 2020 21:39:16 +0800
Message-Id: <20200225133917.21314-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225133917.21314-1-yung-chuan.liao@linux.intel.com>
References: <20200225133917.21314-1-yung-chuan.liao@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 bard.liao@intel.com, pierre-louis.bossart@linux.intel.com,
 kuninori.morimoto.gx@renesas.com
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

Multi cpu is not supported by all functions yet. Add an error message
and return.

Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-compress.c              |  5 +++--
 sound/soc/soc-generic-dmaengine-pcm.c | 18 ++++++++++++++++++
 sound/soc/soc-pcm.c                   | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 392a1c5b15d3..50062eb79adb 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -810,9 +810,10 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	int playback = 0, capture = 0;
 	int i;
 
-	if (rtd->num_codecs > 1) {
+	if (rtd->num_cpus > 1 ||
+	    rtd->num_codecs > 1) {
 		dev_err(rtd->card->dev,
-			"Compress ASoC: Multicodec not supported\n");
+			"Compress ASoC: Multi CPU/Codec not supported\n");
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index d6b4831e8aec..facf1922a714 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -62,6 +62,12 @@ int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	int ret;
 
+	if (rtd->num_cpus > 1) {
+		dev_err(rtd->dev,
+			"%s doesn't support Multi CPU yet\n", __func__);
+		return -EINVAL;
+	}
+
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	ret = snd_hwparams_to_dma_slave_config(substream, params, slave_config);
@@ -118,6 +124,12 @@ dmaengine_pcm_set_runtime_hwparams(struct snd_soc_component *component,
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct snd_pcm_hardware hw;
 
+	if (rtd->num_cpus > 1) {
+		dev_err(rtd->dev,
+			"%s doesn't support Multi CPU yet\n", __func__);
+		return -EINVAL;
+	}
+
 	if (pcm->config && pcm->config->pcm_hardware)
 		return snd_soc_set_runtime_hwparams(substream,
 				pcm->config->pcm_hardware);
@@ -185,6 +197,12 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	dma_filter_fn fn = NULL;
 
+	if (rtd->num_cpus > 1) {
+		dev_err(rtd->dev,
+			"%s doesn't support Multi CPU yet\n", __func__);
+		return NULL;
+	}
+
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 44694e65fc4a..adbceaff07b8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -125,6 +125,12 @@ static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
 	int stream;
 	char *buf;
 
+	if (fe->num_cpus > 1) {
+		dev_err(fe->dev,
+			"%s doesn't support Multi CPU yet\n", __func__);
+		return -EINVAL;
+	}
+
 	buf = kmalloc(out_count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -1550,6 +1556,12 @@ int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	int paths;
 
+	if (fe->num_cpus > 1) {
+		dev_err(fe->dev,
+			"%s doesn't support Multi CPU yet\n", __func__);
+		return -EINVAL;
+	}
+
 	/* get number of valid DAI paths and their widgets */
 	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, list,
 			dpcm_end_walk_at_be);
@@ -2834,6 +2846,12 @@ static int soc_dpcm_fe_runtime_update(struct snd_soc_pcm_runtime *fe, int new)
 	int count, paths;
 	int ret;
 
+	if (fe->num_cpus > 1) {
+		dev_err(fe->dev,
+			"%s doesn't support Multi CPU yet\n", __func__);
+		return -EINVAL;
+	}
+
 	if (!fe->dai_link->dynamic)
 		return 0;
 
-- 
2.17.1

