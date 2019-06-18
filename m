From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: Intel: skl: extract common function
Date: Tue, 18 Jun 2019 15:05:03 +0800
Message-ID: <20190618070503.36310-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com
 [IPv6:2607:f8b0:4864:20::949])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 286C7F80CC4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 09:05:15 +0200 (CEST)
Received: by mail-ua1-x949.google.com with SMTP id m2so1233340uap.12
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 00:05:15 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Extract common logic to a function to avoid duplicate code.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Refactor HDMI init to as most Intel machine drivers did, e.g.
kbl_da7219_max98357a.c.

 .../soc/intel/boards/skl_nau88l25_max98357a.c | 39 +++++-------------
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 40 +++++--------------
 2 files changed, 18 insertions(+), 61 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 3ce8efbeed12..485614c4fa47 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -179,7 +179,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
+static int skylake_hdmi_init(struct snd_soc_pcm_runtime *rtd, int device)
 {
 	struct skl_nau8825_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
@@ -189,7 +189,7 @@ static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 	if (!pcm)
 		return -ENOMEM;
 
-	pcm->device = SKL_DPCM_AUDIO_HDMI1_PB;
+	pcm->device = device;
 	pcm->codec_dai = dai;
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
@@ -197,40 +197,19 @@ static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct skl_nau8825_private *ctx = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *dai = rtd->codec_dai;
-	struct skl_hdmi_pcm *pcm;
-
-	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
-	if (!pcm)
-		return -ENOMEM;
-
-	pcm->device = SKL_DPCM_AUDIO_HDMI2_PB;
-	pcm->codec_dai = dai;
-
-	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+	return skylake_hdmi_init(rtd, SKL_DPCM_AUDIO_HDMI1_PB);
+}
 
-	return 0;
+static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+{
+	return skylake_hdmi_init(rtd, SKL_DPCM_AUDIO_HDMI2_PB);
 }
 
 static int skylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct skl_nau8825_private *ctx = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *dai = rtd->codec_dai;
-	struct skl_hdmi_pcm *pcm;
-
-	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
-	if (!pcm)
-		return -ENOMEM;
-
-	pcm->device = SKL_DPCM_AUDIO_HDMI3_PB;
-	pcm->codec_dai = dai;
-
-	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
-
-	return 0;
+	return skylake_hdmi_init(rtd, SKL_DPCM_AUDIO_HDMI3_PB);
 }
 
 static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 1a7ac8bdf543..772cbd6940db 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -198,7 +198,7 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
+static int skylake_hdmi_init(struct snd_soc_pcm_runtime *rtd, int device)
 {
 	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
@@ -208,7 +208,7 @@ static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 	if (!pcm)
 		return -ENOMEM;
 
-	pcm->device = SKL_DPCM_AUDIO_HDMI1_PB;
+	pcm->device = device;
 	pcm->codec_dai = dai;
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
@@ -216,41 +216,19 @@ static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+static int skylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *dai = rtd->codec_dai;
-	struct skl_hdmi_pcm *pcm;
-
-	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
-	if (!pcm)
-		return -ENOMEM;
-
-	pcm->device = SKL_DPCM_AUDIO_HDMI2_PB;
-	pcm->codec_dai = dai;
-
-	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
-
-	return 0;
+	return skylake_hdmi_init(rtd, SKL_DPCM_AUDIO_HDMI1_PB);
 }
 
+static int skylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+{
+	return skylake_hdmi_init(rtd, SKL_DPCM_AUDIO_HDMI2_PB);
+}
 
 static int skylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *dai = rtd->codec_dai;
-	struct skl_hdmi_pcm *pcm;
-
-	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
-	if (!pcm)
-		return -ENOMEM;
-
-	pcm->device = SKL_DPCM_AUDIO_HDMI3_PB;
-	pcm->codec_dai = dai;
-
-	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
-
-	return 0;
+	return skylake_hdmi_init(rtd, SKL_DPCM_AUDIO_HDMI3_PB);
 }
 
 static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
-- 
2.22.0.410.gd8fdbe21b5-goog
