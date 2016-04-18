From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Free speaker thermal IRQs in
	CODEC remove" to the asoc tree
Date: Mon, 18 Apr 2016 14:10:08 +0100
Message-ID: <E1as8wK-0001uO-2w@debutante>
References: <1460722317-31486-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0016265112
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 15:10:14 +0200 (CEST)
In-Reply-To: <1460722317-31486-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Free speaker thermal IRQs in CODEC remove

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

>From 54dca7015a7d6c09d34623c6ec61de30896186dd Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 15 Apr 2016 13:11:56 +0100
Subject: [PATCH] ASoC: arizona: Free speaker thermal IRQs in CODEC remove

The thermal warning IRQs for the speaker are requested in CODEC probe
but never freed. This patch frees them in CODEC remove.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 12 ++++++++++++
 sound/soc/codecs/arizona.h |  2 ++
 sound/soc/codecs/cs47l24.c |  3 +++
 sound/soc/codecs/wm5102.c  |  2 ++
 sound/soc/codecs/wm5110.c  |  2 ++
 sound/soc/codecs/wm8997.c  |  2 ++
 sound/soc/codecs/wm8998.c  |  2 ++
 7 files changed, 25 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 92d22a018d68..83959312f7a0 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -249,6 +249,18 @@ int arizona_init_spk(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(arizona_init_spk);
 
+int arizona_free_spk(struct snd_soc_codec *codec)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+
+	arizona_free_irq(arizona, ARIZONA_IRQ_SPK_OVERHEAT_WARN, arizona);
+	arizona_free_irq(arizona, ARIZONA_IRQ_SPK_OVERHEAT, arizona);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_free_spk);
+
 static const struct snd_soc_dapm_route arizona_mono_routes[] = {
 	{ "OUT1R", NULL, "OUT1L" },
 	{ "OUT2R", NULL, "OUT2L" },
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 1ea8e4ecf8d4..ce0531b8c632 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -307,6 +307,8 @@ extern int arizona_init_spk(struct snd_soc_codec *codec);
 extern int arizona_init_gpio(struct snd_soc_codec *codec);
 extern int arizona_init_mono(struct snd_soc_codec *codec);
 
+extern int arizona_free_spk(struct snd_soc_codec *codec);
+
 extern int arizona_init_dai(struct arizona_priv *priv, int dai);
 
 int arizona_set_output_mode(struct snd_soc_codec *codec, int output,
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 576087bda330..00e9b6fc1b5c 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1108,6 +1108,9 @@ static int cs47l24_codec_remove(struct snd_soc_codec *codec)
 	priv->core.arizona->dapm = NULL;
 
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
+
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a8b3e3f701f9..59fd3e8bf899 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1960,6 +1960,8 @@ static int wm5102_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 83ba70fe16e6..2728ac545ffe 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2298,6 +2298,8 @@ static int wm5110_codec_remove(struct snd_soc_codec *codec)
 
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
 
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 52d766efe14f..6b0785b5a5c5 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1072,6 +1072,8 @@ static int wm8997_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 012396074a8a..449f66636205 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1324,6 +1324,8 @@ static int wm8998_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
-- 
2.8.0.rc3
