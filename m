From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: Use params_width() at appropriate places
Date: Fri, 24 Jul 2015 16:11:25 +0800
Message-ID: <1437725485.4914.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id DD335260558
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 10:11:56 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so10224411pdj.3
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 01:11:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Ralph Birt <rdbirt@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Anish Kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max98925.c | 2 +-
 sound/soc/codecs/pcm512x.c  | 4 ++--
 sound/soc/codecs/wm2200.c   | 2 +-
 sound/soc/codecs/wm5100.c   | 2 +-
 sound/soc/codecs/wm8776.c   | 4 ++--
 sound/soc/codecs/wm8996.c   | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index ebb648a..5990de3 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -430,7 +430,7 @@ static int max98925_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
 
-	switch (snd_pcm_format_width(params_format(params))) {
+	switch (params_width(params)) {
 	case 16:
 		regmap_update_bits(max98925->regmap,
 				MAX98925_FORMAT,
diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index de16429..047c489 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1117,7 +1117,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		params_rate(params),
 		params_channels(params));
 
-	switch (snd_pcm_format_width(params_format(params))) {
+	switch (params_width(params)) {
 	case 16:
 		alen = PCM512x_ALEN_16;
 		break;
@@ -1132,7 +1132,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		dev_err(codec->dev, "Bad frame size: %d\n",
-			snd_pcm_format_width(params_format(params)));
+			params_width(params));
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 35199fc..fd1439e 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1702,7 +1702,7 @@ static int wm2200_hw_params(struct snd_pcm_substream *substream,
 	int *bclk_rates;
 
 	/* Data sizes if not using TDM */
-	wl = snd_pcm_format_width(params_format(params));
+	wl = params_width(params);
 	if (wl < 0)
 		return wl;
 	fl = snd_soc_params_to_frame_size(params);
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 8120b0c..c2cdcae 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -1408,7 +1408,7 @@ static int wm5100_hw_params(struct snd_pcm_substream *substream,
 	base = dai->driver->base;
 
 	/* Data sizes if not using TDM */
-	wl = snd_pcm_format_width(params_format(params));
+	wl = params_width(params);
 	if (wl < 0)
 		return wl;
 	fl = snd_soc_params_to_frame_size(params);
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 592866d..183c9a4 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -265,7 +265,7 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Set word length */
-	switch (snd_pcm_format_width(params_format(params))) {
+	switch (params_width(params)) {
 	case 16:
 		iface = 0;
 		break;
@@ -280,7 +280,7 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		dev_err(codec->dev, "Unsupported sample size: %i\n",
-			snd_pcm_format_width(params_format(params)));
+			params_width(params));
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 2a696db..f7ccd9f 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1780,7 +1780,7 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 	wm8996->rx_rate[dai->id] = params_rate(params);
 
 	/* Needs looking at for TDM */
-	bits = snd_pcm_format_width(params_format(params));
+	bits = params_width(params);
 	if (bits < 0)
 		return bits;
 	aifdata |= (bits << WM8996_AIF1TX_WL_SHIFT) | bits;
-- 
2.1.0
