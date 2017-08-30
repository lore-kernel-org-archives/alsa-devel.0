From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add Component level set_sysclk" to the
	asoc tree
Date: Wed, 30 Aug 2017 18:57:05 +0100
Message-ID: <E1dn7Ef-00019z-KP@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3180B2671BA
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 19:57:08 +0200 (CEST)
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

   ASoC: add Component level set_sysclk

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

>From 9cfeb53411be7c08d7dd19bc4bf0599a6d211390 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 24 Aug 2017 00:57:35 +0000
Subject: [PATCH] ASoC: add Component level set_sysclk

In current ALSA SoC, Codec only has set_sysclk feature.
Codec will be merged into Component in next generation ALSA SoC,
thus current Codec specific feature need to be merged into it.
This is glue patch for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 29 +++++++++++++++++++++++++++++
 sound/soc/soc-core.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2bcb38045dc1..e7c476febf82 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -799,6 +799,16 @@ struct snd_soc_component_driver {
 	int (*pcm_new)(struct snd_soc_pcm_runtime *);
 	void (*pcm_free)(struct snd_pcm *);
 
+	/* component wide operations */
+	int (*set_sysclk)(struct snd_soc_component *component,
+			  int clk_id, int source, unsigned int freq, int dir);
+	int (*set_pll)(struct snd_soc_component *component, int pll_id,
+		       int source, unsigned int freq_in, unsigned int freq_out);
+
+	/* component wide operations */
+	int (*set_sysclk)(struct snd_soc_component *component,
+			  int clk_id, int source, unsigned int freq, int dir);
+
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
 				 struct of_phandle_args *args,
@@ -871,6 +881,14 @@ struct snd_soc_component {
 	int (*pcm_new)(struct snd_soc_pcm_runtime *);
 	void (*pcm_free)(struct snd_pcm *);
 
+	int (*set_sysclk)(struct snd_soc_component *component,
+			  int clk_id, int source, unsigned int freq, int dir);
+	int (*set_pll)(struct snd_soc_component *component, int pll_id,
+		       int source, unsigned int freq_in, unsigned int freq_out);
+
+	int (*set_sysclk)(struct snd_soc_component *component,
+			  int clk_id, int source, unsigned int freq, int dir);
+
 	/* machine specific init */
 	int (*init)(struct snd_soc_component *component);
 
@@ -1465,6 +1483,17 @@ void snd_soc_component_async_complete(struct snd_soc_component *component);
 int snd_soc_component_test_bits(struct snd_soc_component *component,
 	unsigned int reg, unsigned int mask, unsigned int value);
 
+/* component wide operations */
+int snd_soc_component_set_sysclk(struct snd_soc_component *component,
+			int clk_id, int source, unsigned int freq, int dir);
+int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
+			      int source, unsigned int freq_in,
+			      unsigned int freq_out);
+
+/* component wide operations */
+int snd_soc_component_set_sysclk(struct snd_soc_component *component,
+			int clk_id, int source, unsigned int freq, int dir);
+
 #ifdef CONFIG_REGMAP
 
 void snd_soc_component_init_regmap(struct snd_soc_component *component,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b8f96a41b594..046ab9189b36 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2590,11 +2590,9 @@ int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	if (dai->driver && dai->driver->ops->set_sysclk)
 		return dai->driver->ops->set_sysclk(dai, clk_id, freq, dir);
-	else if (dai->codec && dai->codec->driver->set_sysclk)
-		return dai->codec->driver->set_sysclk(dai->codec, clk_id, 0,
-						      freq, dir);
-	else
-		return -ENOTSUPP;
+
+	return snd_soc_component_set_sysclk(dai->component, clk_id, 0,
+					    freq, dir);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
 
@@ -2619,6 +2617,32 @@ int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_sysclk);
 
+/**
+ * snd_soc_component_set_sysclk - configure COMPONENT system or master clock.
+ * @component: COMPONENT
+ * @clk_id: DAI specific clock ID
+ * @source: Source for the clock
+ * @freq: new clock frequency in Hz
+ * @dir: new clock direction - input/output.
+ *
+ * Configures the CODEC master (MCLK) or system (SYSCLK) clocking.
+ */
+int snd_soc_component_set_sysclk(struct snd_soc_component *component, int clk_id,
+			     int source, unsigned int freq, int dir)
+{
+	/* will be removed */
+	if (component->set_sysclk)
+		return component->set_sysclk(component, clk_id, source,
+					     freq, dir);
+
+	if (component->driver->set_sysclk)
+		return component->driver->set_sysclk(component, clk_id, source,
+						 freq, dir);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_set_sysclk);
+
 /**
  * snd_soc_dai_set_clkdiv - configure DAI clock dividers.
  * @dai: DAI
@@ -3176,6 +3200,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->resume = component->driver->resume;
 	component->pcm_new = component->driver->pcm_new;
 	component->pcm_free = component->driver->pcm_free;
+	component->set_sysclk = component->driver->set_sysclk;
 
 	dapm = &component->dapm;
 	dapm->dev = dev;
@@ -3582,6 +3607,14 @@ static int snd_soc_codec_drv_read(struct snd_soc_component *component,
 	return 0;
 }
 
+static int snd_soc_codec_set_sysclk_(struct snd_soc_component *component,
+			  int clk_id, int source, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	return snd_soc_codec_set_sysclk(codec, clk_id, source, freq, dir);
+}
+
 static int snd_soc_codec_set_bias_level(struct snd_soc_dapm_context *dapm,
 	enum snd_soc_bias_level level)
 {
@@ -3633,6 +3666,8 @@ int snd_soc_register_codec(struct device *dev,
 		codec->component.write = snd_soc_codec_drv_write;
 	if (codec_drv->read)
 		codec->component.read = snd_soc_codec_drv_read;
+	if (codec_drv->set_sysclk)
+		codec->component.set_sysclk = snd_soc_codec_set_sysclk_;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 
 	dapm = snd_soc_codec_get_dapm(codec);
-- 
2.14.1
