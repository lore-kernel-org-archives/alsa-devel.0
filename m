From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: arizona: Free speaker thermal IRQs
	in CODEC remove
Date: Fri, 15 Apr 2016 13:11:56 +0100
Message-ID: <1460722317-31486-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 33C61265074
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 14:11:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The thermal warning IRQs for the speaker are requested in CODEC probe
but never freed. This patch frees them in CODEC remove.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
index d8a6823..7b82550 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -251,6 +251,18 @@ int arizona_init_spk(struct snd_soc_codec *codec)
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
index 1ea8e4e..ce0531b 100644
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
index 6b8b557..c10f71e 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1140,6 +1140,9 @@ static int cs47l24_codec_remove(struct snd_soc_codec *codec)
 	priv->core.arizona->dapm = NULL;
 
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
+
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a8b3e3f..59fd3e8 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1960,6 +1960,8 @@ static int wm5102_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 83ba70f..2728ac5 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2298,6 +2298,8 @@ static int wm5110_codec_remove(struct snd_soc_codec *codec)
 
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
 
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 52d766e..6b0785b 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1072,6 +1072,8 @@ static int wm8997_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 0123960..449f666 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1324,6 +1324,8 @@ static int wm8998_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_spk(codec);
+
 	return 0;
 }
 
-- 
2.1.4
