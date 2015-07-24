From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Use params_width() at appropriate
	places" to the asoc tree
Date: Fri, 24 Jul 2015 18:31:57 +0100
Message-ID: <E1ZIgpB-0001lA-C2@debutante>
References: <1437725485.4914.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AA512605CB
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 19:32:04 +0200 (CEST)
In-Reply-To: <1437725485.4914.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Use params_width() at appropriate places

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0a3dcb509ae7701ba3eaf470cad91827821daf41 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 24 Jul 2015 16:11:25 +0800
Subject: [PATCH] ASoC: Use params_width() at appropriate places

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98925.c | 2 +-
 sound/soc/codecs/pcm512x.c  | 4 ++--
 sound/soc/codecs/wm2200.c   | 2 +-
 sound/soc/codecs/wm5100.c   | 2 +-
 sound/soc/codecs/wm8776.c   | 4 ++--
 sound/soc/codecs/wm8996.c   | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index aad664225dc3..a29e499d2f65 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -432,7 +432,7 @@ static int max98925_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
 
-	switch (snd_pcm_format_width(params_format(params))) {
+	switch (params_width(params)) {
 	case 16:
 		regmap_update_bits(max98925->regmap,
 				MAX98925_FORMAT,
diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index de16429f0a43..047c48953a20 100644
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
index c83083285e53..c51bc18b22ea 100644
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
index 4c10cd88c1af..05d25a62e267 100644
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
index ece9b4456767..501c3349c34d 100644
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
index 3dd063f682b2..04b25cbdc6a6 100644
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
2.1.4
