Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555EEC2BB85
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:13:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D852C20757
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q/IrEbsq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PJ+FCQbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D852C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 296ED1658;
	Thu,  9 Apr 2020 20:12:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 296ED1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586455991;
	bh=Wo5cIS2V5G8HCGM13QtN9+aQaDrP9gGK3/yiDKU7W8g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q/IrEbsqzp/soFhWv5KwhZGjvUAuVcSRM8UkuuLDbBx65PqqNdknQbWT+BnlaVHaT
	 AGK3vEF14BN+Vs2ibBeG207wpbe0+CXgbN2UwuCjCzmKO3LCabEuhfhEAEAjRw9+Rw
	 QGZEdCOpJaBcofFVJPLVQBC0xhiBKMbdfSHMXO20=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B31CAF80107;
	Thu,  9 Apr 2020 20:12:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B1ACF80216; Thu,  9 Apr 2020 20:12:18 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59637F800FD
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 20:12:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59637F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="PJ+FCQbV"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 039IC10E030906; Thu, 9 Apr 2020 13:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=Im4hEQkRMc+g5JP5gOMOSBTo29iO7B3/J7dcjNFYotU=;
 b=PJ+FCQbVnQtWHhYiiZi2lGPZ2t4lXOiP/U9XcGZhC5u7s3/EEa/IoOHxvPeuNBZ9aiYo
 7wtF2HkdV8O6bOzlPUOj1Q2YxJ3JAmGBUkuwv7I4W0/qgFXtFJJEf9qyqLMWlVOjIxpR
 f3452mqEaJc9KVJT4kwdDxEk+SYqXtEQsK808Hp8FCM+q8UYCIO9fzrzlxEUgsZn9J+5
 tfxlC/tUKT7lcuczZXEQqY4PHyzoZHaqCt5G1dIMBxY8cI3SxWj4oXGFhP03TQXgeD0O
 geHRDZxsvwR2Cro4E4DJNCSUjl+QtUfMX/PEeRe56q376XXFu/PpPWAXKB4s3eCWnWKA 2Q== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3091p0m0sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 09 Apr 2020 13:12:11 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 9 Apr
 2020 19:12:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Thu, 9 Apr 2020 19:12:09 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 92ED32AB;
 Thu,  9 Apr 2020 18:12:09 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: dapm: Fix regression introducing multiple copies of
 DAI widgets
Date: Thu, 9 Apr 2020 19:12:07 +0100
Message-ID: <20200409181209.30130-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0
 phishscore=0 mlxlogscore=996 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=1 mlxscore=0 clxscore=1011 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090132
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 patches@opensource.cirrus.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, shreyas.nc@intel.com,
 yung-chuan.liao@linux.intel.com
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

Refactoring was done to factor out the linking of DAI widgets into
a helper function, dapm_add_valid_dai_widget. However when this was
done, a regression was introduced for CODEC to CODEC links. It was
over looked that the playback and capture variables persisted across
all CODEC DAIs being processed, which ensured that the special DAI
widget that is added for CODEC to CODEC links was only created once.
This bug causes kernel panics during DAPM shutdown.

To stick with the spirit of the original refactoring whilst fixing the
issue, variables to hold the DAI widgets are added to snd_soc_dai_link.
Furthermore the dapm_add_valid_dai_widget function is renamed to
dapm_connect_dai_pair, the function only adds DAI widgets in the CODEC
to CODEC case and its primary job is to add routes connecting two DAI
widgets, making the original name quite misleading.

Fixes: 6c4b13b51aa3 ("ASoC: Add dapm_add_valid_dai_widget helper")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc.h  |  3 ++
 sound/soc/soc-dapm.c | 91 +++++++++++++++++++++++++++-------------------------
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 13458e4fbb132..946f88a6c63d1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -790,6 +790,9 @@ struct snd_soc_dai_link {
 	const struct snd_soc_pcm_stream *params;
 	unsigned int num_params;
 
+	struct snd_soc_dapm_widget *playback_widget;
+	struct snd_soc_dapm_widget *capture_widget;
+
 	unsigned int dai_fmt;           /* format to set on init */
 
 	enum snd_soc_dpcm_trigger trigger[2]; /* trigger type for DPCM */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 679ed60d850ec..fe907f0cc709b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4283,52 +4283,63 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 	return 0;
 }
 
-static void dapm_add_valid_dai_widget(struct snd_soc_card *card,
-				      struct snd_soc_pcm_runtime *rtd,
-				      struct snd_soc_dai *codec_dai,
-				      struct snd_soc_dai *cpu_dai)
+static void dapm_connect_dai_routes(struct snd_soc_dapm_context *dapm,
+				    struct snd_soc_dai *src_dai,
+				    struct snd_soc_dapm_widget *src,
+				    struct snd_soc_dapm_widget *dai,
+				    struct snd_soc_dai *sink_dai,
+				    struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_dapm_widget *playback = NULL, *capture = NULL;
-	struct snd_soc_dapm_widget *codec, *playback_cpu, *capture_cpu;
+	dev_dbg(dapm->dev, "connected DAI link %s:%s -> %s:%s\n",
+		src_dai->component->name, src->name,
+		sink_dai->component->name, sink->name);
+
+	if (dai) {
+		snd_soc_dapm_add_path(dapm, src, dai, NULL, NULL);
+		src = dai;
+	}
+
+	snd_soc_dapm_add_path(dapm, src, sink, NULL, NULL);
+}
+
+static void dapm_connect_dai_pair(struct snd_soc_card *card,
+				  struct snd_soc_pcm_runtime *rtd,
+				  struct snd_soc_dai *codec_dai,
+				  struct snd_soc_dai *cpu_dai)
+{
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+	struct snd_soc_dapm_widget *dai, *codec, *playback_cpu, *capture_cpu;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_str *streams = rtd->pcm->streams;
 
-	if (rtd->dai_link->params) {
+	if (dai_link->params) {
 		playback_cpu = cpu_dai->capture_widget;
 		capture_cpu = cpu_dai->playback_widget;
 	} else {
-		playback = cpu_dai->playback_widget;
-		capture = cpu_dai->capture_widget;
-		playback_cpu = playback;
-		capture_cpu = capture;
+		playback_cpu = cpu_dai->playback_widget;
+		capture_cpu = cpu_dai->capture_widget;
 	}
 
 	/* connect BE DAI playback if widgets are valid */
 	codec = codec_dai->playback_widget;
 
 	if (playback_cpu && codec) {
-		if (!playback) {
+		if (dai_link->params && !dai_link->playback_widget) {
 			substream = streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
-			playback = snd_soc_dapm_new_dai(card, substream,
-							"playback");
-			if (IS_ERR(playback)) {
+			dai = snd_soc_dapm_new_dai(card, substream, "playback");
+			if (IS_ERR(dai)) {
 				dev_err(rtd->dev,
 					"ASoC: Failed to create DAI %s: %ld\n",
 					codec_dai->name,
-					PTR_ERR(playback));
+					PTR_ERR(dai));
 				goto capture;
 			}
-
-			snd_soc_dapm_add_path(&card->dapm, playback_cpu,
-					      playback, NULL, NULL);
+			dai_link->playback_widget = dai;
 		}
 
-		dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-			cpu_dai->component->name, playback_cpu->name,
-			codec_dai->component->name, codec->name);
-
-		snd_soc_dapm_add_path(&card->dapm, playback, codec,
-				      NULL, NULL);
+		dapm_connect_dai_routes(&card->dapm, cpu_dai, playback_cpu,
+					dai_link->playback_widget,
+					codec_dai, codec);
 	}
 
 capture:
@@ -4336,28 +4347,22 @@ static void dapm_add_valid_dai_widget(struct snd_soc_card *card,
 	codec = codec_dai->capture_widget;
 
 	if (codec && capture_cpu) {
-		if (!capture) {
+		if (dai_link->params && !dai_link->capture_widget) {
 			substream = streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-			capture = snd_soc_dapm_new_dai(card, substream,
-						       "capture");
-			if (IS_ERR(capture)) {
+			dai = snd_soc_dapm_new_dai(card, substream, "capture");
+			if (IS_ERR(dai)) {
 				dev_err(rtd->dev,
 					"ASoC: Failed to create DAI %s: %ld\n",
 					codec_dai->name,
-					PTR_ERR(capture));
+					PTR_ERR(dai));
 				return;
 			}
-
-			snd_soc_dapm_add_path(&card->dapm, capture,
-					      capture_cpu, NULL, NULL);
+			dai_link->capture_widget = dai;
 		}
 
-		dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
-			codec_dai->component->name, codec->name,
-			cpu_dai->component->name, capture_cpu->name);
-
-		snd_soc_dapm_add_path(&card->dapm, codec, capture,
-				      NULL, NULL);
+		dapm_connect_dai_routes(&card->dapm, codec_dai, codec,
+					dai_link->capture_widget,
+					cpu_dai, capture_cpu);
 	}
 }
 
@@ -4369,12 +4374,12 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 
 	if (rtd->num_cpus == 1) {
 		for_each_rtd_codec_dais(rtd, i, codec_dai)
-			dapm_add_valid_dai_widget(card, rtd, codec_dai,
-						  rtd->cpu_dais[0]);
+			dapm_connect_dai_pair(card, rtd, codec_dai,
+					      rtd->cpu_dais[0]);
 	} else if (rtd->num_codecs == rtd->num_cpus) {
 		for_each_rtd_codec_dais(rtd, i, codec_dai)
-			dapm_add_valid_dai_widget(card, rtd, codec_dai,
-						  rtd->cpu_dais[i]);
+			dapm_connect_dai_pair(card, rtd, codec_dai,
+					      rtd->cpu_dais[i]);
 	} else {
 		dev_err(card->dev,
 			"N cpus to M codecs link is not supported yet\n");
-- 
2.11.0

