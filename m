Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFFFC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 10:27:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C03091884;
	Thu, 25 Nov 2021 11:26:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C03091884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637836024;
	bh=evF2avG3od/CtDOeABxDdpKY0wug4HA2fXTsVY1GLMg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NghSiy5XxZ6MhNnnT9r1+nyz9NZL/gnnlunHdg000PO+vjgDmNuWblU0EK8fZFwwk
	 /jIsifntVnSIq8UNno1B3ggdzwWrDjeoV+MiH8iZg0ivebkMBeZ9/G+JZOmDsDdNQT
	 nxv3S4oqIT6G5NqMKLbG0vMR+wsIhlBZaVU6Pc7Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D54F4F80511;
	Thu, 25 Nov 2021 11:23:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB316F80525; Thu, 25 Nov 2021 11:23:57 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 693CAF80519
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 11:23:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 693CAF80519
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="215515377"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="215515377"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 02:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="741672158"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2021 02:23:50 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 10/10] ASoC: SOF: Intel: hda: send DAI_CONFIG IPC during pause
Date: Thu, 25 Nov 2021 12:15:20 +0200
Message-Id: <20211125101520.291581-11-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125101520.291581-1-kai.vehmanen@linux.intel.com>
References: <20211125101520.291581-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

For HDA DAI's the DMA must be paused after the RUN bit is cleared by the
host. So, send the DAI_CONFIG IPC with just the SOF_DAI_CONFIG_FLAGS_PAUSE
flag set to indicate this to the firmware.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 42 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index bce5366cf913..8c1d7ddb00e2 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -287,6 +287,36 @@ static int hda_link_pcm_prepare(struct snd_pcm_substream *substream,
 				  dai);
 }
 
+static int hda_link_dai_config_pause_push_ipc(struct snd_soc_dapm_widget *w)
+{
+	struct snd_sof_widget *swidget = w->dobj.private;
+	struct snd_soc_component *component = swidget->scomp;
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct sof_ipc_dai_config *config;
+	struct snd_sof_dai *sof_dai;
+	struct sof_ipc_reply reply;
+	int ret;
+
+	sof_dai = swidget->private;
+
+	if (!sof_dai || !sof_dai->dai_config) {
+		dev_err(sdev->dev, "No config for DAI %s\n", w->name);
+		return -EINVAL;
+	}
+
+	config = &sof_dai->dai_config[sof_dai->current_config];
+
+	/* set PAUSE command flag */
+	config->flags = FIELD_PREP(SOF_DAI_CONFIG_FLAGS_CMD_MASK, SOF_DAI_CONFIG_FLAGS_PAUSE);
+
+	ret = sof_ipc_tx_message(sdev->ipc, config->hdr.cmd, config, config->hdr.size,
+				 &reply, sizeof(reply));
+	if (ret < 0)
+		dev_err(sdev->dev, "DAI config for %s failed during pause push\n", w->name);
+
+	return ret;
+}
+
 static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
@@ -312,6 +342,9 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 	hda_stream = hstream_to_sof_hda_stream(link_dev);
 
 	dev_dbg(dai->dev, "In %s cmd=%d\n", __func__, cmd);
+
+	w = snd_soc_dai_get_widget(dai, substream->stream);
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 		/* set up hw_params */
@@ -331,11 +364,6 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_STOP:
 		snd_hdac_ext_link_stream_clear(link_dev);
 
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			w = dai->playback_widget;
-		else
-			w = dai->capture_widget;
-
 		/*
 		 * free DAI widget during stop/suspend to keep widget use_count's balanced.
 		 */
@@ -352,6 +380,10 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_hdac_ext_link_stream_clear(link_dev);
+
+		ret = hda_link_dai_config_pause_push_ipc(w);
+		if (ret < 0)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
-- 
2.33.0

