From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add Component level set_jack" to the
	asoc tree
Date: Wed, 30 Aug 2017 18:57:00 +0100
Message-ID: <E1dn7Ea-00016n-Uz@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C0022669DB
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 19:57:05 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add Component level set_jack

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

>From 880f02224c624fa2d6e4f8b2d37410fdc98b35fe Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 24 Aug 2017 00:58:07 +0000
Subject: [PATCH] ASoC: add Component level set_jack

In current ALSA SoC, Codec only has set_jack feature.
Codec will be merged into Component in next generation ALSA SoC,
thus current Codec specific feature need to be merged into it.
This is glue patch for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  4 ++++
 sound/soc/soc-core.c | 11 +++++++++++
 sound/soc/soc-jack.c | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02a510183ab4..18676ab4f87c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -810,6 +810,8 @@ struct snd_soc_component_driver {
 			  int clk_id, int source, unsigned int freq, int dir);
 	int (*set_pll)(struct snd_soc_component *component, int pll_id,
 		       int source, unsigned int freq_in, unsigned int freq_out);
+	int (*set_jack)(struct snd_soc_component *component,
+			struct snd_soc_jack *jack,  void *data);
 
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
@@ -892,6 +894,8 @@ struct snd_soc_component {
 			  int clk_id, int source, unsigned int freq, int dir);
 	int (*set_pll)(struct snd_soc_component *component, int pll_id,
 		       int source, unsigned int freq_in, unsigned int freq_out);
+	int (*set_jack)(struct snd_soc_component *component,
+			struct snd_soc_jack *jack,  void *data);
 
 	/* machine specific init */
 	int (*init)(struct snd_soc_component *component);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 299d23e832ea..78b8886a26d6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3227,6 +3227,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->pcm_free = component->driver->pcm_free;
 	component->set_sysclk = component->driver->set_sysclk;
 	component->set_pll = component->driver->set_pll;
+	component->set_jack = component->driver->set_jack;
 
 	dapm = &component->dapm;
 	dapm->dev = dev;
@@ -3650,6 +3651,14 @@ static int snd_soc_codec_set_pll_(struct snd_soc_component *component,
 	return snd_soc_codec_set_pll(codec, pll_id, source, freq_in, freq_out);
 }
 
+static int snd_soc_codec_set_jack_(struct snd_soc_component *component,
+			       struct snd_soc_jack *jack, void *data)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	return snd_soc_codec_set_jack(codec, jack, data);
+}
+
 static int snd_soc_codec_set_bias_level(struct snd_soc_dapm_context *dapm,
 	enum snd_soc_bias_level level)
 {
@@ -3705,6 +3714,8 @@ int snd_soc_register_codec(struct device *dev,
 		codec->component.set_sysclk = snd_soc_codec_set_sysclk_;
 	if (codec_drv->set_pll)
 		codec->component.set_pll = snd_soc_codec_set_pll_;
+	if (codec_drv->set_jack)
+		codec->component.set_jack = snd_soc_codec_set_jack_;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 
 	dapm = snd_soc_codec_get_dapm(codec);
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 7daf21fee355..2f9f496ab14f 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -40,6 +40,28 @@ int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_jack);
 
+/**
+ * snd_soc_component_set_jack - configure component jack.
+ * @component: COMPONENTs
+ * @jack: structure to use for the jack
+ * @data: can be used if codec driver need extra data for configuring jack
+ *
+ * Configures and enables jack detection function.
+ */
+int snd_soc_component_set_jack(struct snd_soc_component *component,
+			       struct snd_soc_jack *jack, void *data)
+{
+	/* will be removed */
+	if (component->set_jack)
+		return component->set_jack(component, jack, data);
+
+	if (component->driver->set_jack)
+		return component->driver->set_jack(component, jack, data);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_set_jack);
+
 /**
  * snd_soc_card_jack_new - Create a new jack
  * @card:  ASoC card
-- 
2.14.1
