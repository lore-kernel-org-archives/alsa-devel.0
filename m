Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DFBC32771
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:28:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB2D22527
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AJAXm8LM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB2D22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA841167B;
	Tue, 21 Jan 2020 02:27:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA841167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579570102;
	bh=IELZCa0jfVR1RA/DpZ0ZToBzX39+028kXNY3pEPABC4=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AJAXm8LMjEgshpg8P6W5B5p+Kouu0ZKCXTE38qghyEhHkQI/JnWXkUqicVaVca5RR
	 5l/FULIrL2oH3RYECyHzXZWRd32+JEKk1JswrMfoZdrjjS+/DWBMIAndk6X91sJcr7
	 Dj57AjJG20Dmpn1PUH5sLPmUNqUEwy+kHFrcQzCw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F43BF800C6;
	Tue, 21 Jan 2020 02:25:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2632F80272; Tue, 21 Jan 2020 02:25:53 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6FF9F801D8
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 02:25:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6FF9F801D8
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jan 2020 17:25:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; d="scan'208";a="258880016"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2020 17:25:42 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Date: Mon, 20 Jan 2020 21:29:25 +0800
Message-Id: <20200120132928.25257-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120132928.25257-1-yung-chuan.liao@linux.intel.com>
References: <20200120132928.25257-1-yung-chuan.liao@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 bard.liao@intel.com, pierre-louis.bossart@linux.intel.com,
 kuninori.morimoto.gx@renesas.com
Subject: [alsa-devel] [PATCH RFC v4 3/6] ASoC: Add dapm_add_valid_dai_widget
	helper
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Shreyas NC <shreyas.nc@intel.com>

Adding a helper to connect widget for a specific cpu and codec dai
The helper will help dapm_connect_dai_link_widgets() to reduce indents.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/soc-dapm.c | 119 +++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 56 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 442846f12cd4..1a414054ee23 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4274,16 +4274,15 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 	return 0;
 }
 
-static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
-					  struct snd_soc_pcm_runtime *rtd)
+static void dapm_add_valid_dai_widget(struct snd_soc_card *card,
+				      struct snd_soc_pcm_runtime *rtd,
+				      struct snd_soc_dai *codec_dai,
+				      struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dapm_widget *playback = NULL, *capture = NULL;
 	struct snd_soc_dapm_widget *codec, *playback_cpu, *capture_cpu;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_str *streams = rtd->pcm->streams;
-	int i;
 
 	if (rtd->dai_link->params) {
 		playback_cpu = cpu_dai->capture_widget;
@@ -4295,67 +4294,75 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 		capture_cpu = capture;
 	}
 
-	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		/* connect BE DAI playback if widgets are valid */
-		codec = codec_dai->playback_widget;
-
-		if (playback_cpu && codec) {
-			if (!playback) {
-				substream = streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
-				playback = snd_soc_dapm_new_dai(card, substream,
-								"playback");
-				if (IS_ERR(playback)) {
-					dev_err(rtd->dev,
-						"ASoC: Failed to create DAI %s: %ld\n",
-						codec_dai->name,
-						PTR_ERR(playback));
-					continue;
-				}
-
-				snd_soc_dapm_add_path(&card->dapm, playback_cpu,
-						      playback, NULL, NULL);
+	/* connect BE DAI playback if widgets are valid */
+	codec = codec_dai->playback_widget;
+
+	if (playback_cpu && codec) {
+		if (!playback) {
+			substream = streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+			playback = snd_soc_dapm_new_dai(card, substream,
+							"playback");
+			if (IS_ERR(playback)) {
+				dev_err(rtd->dev,
+					"ASoC: Failed to create DAI %s: %ld\n",
+					codec_dai->name,
+					PTR_ERR(playback));
+				goto capture;
 			}
 
-			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				cpu_dai->component->name, playback_cpu->name,
-				codec_dai->component->name, codec->name);
-
-			snd_soc_dapm_add_path(&card->dapm, playback, codec,
-					      NULL, NULL);
+			snd_soc_dapm_add_path(&card->dapm, playback_cpu,
+					      playback, NULL, NULL);
 		}
-	}
 
-	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		/* connect BE DAI capture if widgets are valid */
-		codec = codec_dai->capture_widget;
-
-		if (codec && capture_cpu) {
-			if (!capture) {
-				substream = streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-				capture = snd_soc_dapm_new_dai(card, substream,
-							       "capture");
-				if (IS_ERR(capture)) {
-					dev_err(rtd->dev,
-						"ASoC: Failed to create DAI %s: %ld\n",
-						codec_dai->name,
-						PTR_ERR(capture));
-					continue;
-				}
-
-				snd_soc_dapm_add_path(&card->dapm, capture,
-						      capture_cpu, NULL, NULL);
+		dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
+			cpu_dai->component->name, playback_cpu->name,
+			codec_dai->component->name, codec->name);
+
+		snd_soc_dapm_add_path(&card->dapm, playback, codec,
+				      NULL, NULL);
+	}
+
+capture:
+	/* connect BE DAI capture if widgets are valid */
+	codec = codec_dai->capture_widget;
+
+	if (codec && capture_cpu) {
+		if (!capture) {
+			substream = streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+			capture = snd_soc_dapm_new_dai(card, substream,
+						       "capture");
+			if (IS_ERR(capture)) {
+				dev_err(rtd->dev,
+					"ASoC: Failed to create DAI %s: %ld\n",
+					codec_dai->name,
+					PTR_ERR(capture));
+				return;
 			}
 
-			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-				codec_dai->component->name, codec->name,
-				cpu_dai->component->name, capture_cpu->name);
-
-			snd_soc_dapm_add_path(&card->dapm, codec, capture,
-					      NULL, NULL);
+			snd_soc_dapm_add_path(&card->dapm, capture,
+					      capture_cpu, NULL, NULL);
 		}
+
+		dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
+			codec_dai->component->name, codec->name,
+			cpu_dai->component->name, capture_cpu->name);
+
+		snd_soc_dapm_add_path(&card->dapm, codec, capture,
+				      NULL, NULL);
 	}
 }
 
+static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
+					  struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *codec_dai;
+	int i;
+
+	for_each_rtd_codec_dai(rtd, i, codec_dai)
+		dapm_add_valid_dai_widget(card, rtd,
+					  codec_dai, rtd->cpu_dais[0]);
+}
+
 static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
 	int event)
 {
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
