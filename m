From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add Component level set_pll" to the
	asoc tree
Date: Wed, 30 Aug 2017 18:57:03 +0100
Message-ID: <E1dn7Ed-000183-8q@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BE1A4266C5E
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

   ASoC: add Component level set_pll

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

>From 47bdbaa2c9a6dd7b112fb403b05dd9293b35a41c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 24 Aug 2017 00:57:51 +0000
Subject: [PATCH] ASoC: add Component level set_pll

In current ALSA SoC, Codec only has set_pll feature.
Codec will be merged into Component in next generation ALSA SoC,
thus current Codec specific feature need to be merged into it.
This is glue patch for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  7 +++++++
 sound/soc/soc-core.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e7c476febf82..02a510183ab4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -808,6 +808,8 @@ struct snd_soc_component_driver {
 	/* component wide operations */
 	int (*set_sysclk)(struct snd_soc_component *component,
 			  int clk_id, int source, unsigned int freq, int dir);
+	int (*set_pll)(struct snd_soc_component *component, int pll_id,
+		       int source, unsigned int freq_in, unsigned int freq_out);
 
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
@@ -888,6 +890,8 @@ struct snd_soc_component {
 
 	int (*set_sysclk)(struct snd_soc_component *component,
 			  int clk_id, int source, unsigned int freq, int dir);
+	int (*set_pll)(struct snd_soc_component *component, int pll_id,
+		       int source, unsigned int freq_in, unsigned int freq_out);
 
 	/* machine specific init */
 	int (*init)(struct snd_soc_component *component);
@@ -1493,6 +1497,9 @@ int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
 /* component wide operations */
 int snd_soc_component_set_sysclk(struct snd_soc_component *component,
 			int clk_id, int source, unsigned int freq, int dir);
+int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
+			      int source, unsigned int freq_in,
+			      unsigned int freq_out);
 
 #ifdef CONFIG_REGMAP
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 046ab9189b36..299d23e832ea 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2679,11 +2679,9 @@ int snd_soc_dai_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	if (dai->driver && dai->driver->ops->set_pll)
 		return dai->driver->ops->set_pll(dai, pll_id, source,
 					 freq_in, freq_out);
-	else if (dai->codec && dai->codec->driver->set_pll)
-		return dai->codec->driver->set_pll(dai->codec, pll_id, source,
-						   freq_in, freq_out);
-	else
-		return -EINVAL;
+
+	return snd_soc_component_set_pll(dai->component, pll_id, source,
+					 freq_in, freq_out);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
 
@@ -2708,6 +2706,33 @@ int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_pll);
 
+/*
+ * snd_soc_component_set_pll - configure component PLL.
+ * @component: COMPONENT
+ * @pll_id: DAI specific PLL ID
+ * @source: DAI specific source for the PLL
+ * @freq_in: PLL input clock frequency in Hz
+ * @freq_out: requested PLL output clock frequency in Hz
+ *
+ * Configures and enables PLL to generate output clock based on input clock.
+ */
+int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
+			      int source, unsigned int freq_in,
+			      unsigned int freq_out)
+{
+	/* will be removed */
+	if (component->set_pll)
+		return component->set_pll(component, pll_id, source,
+					      freq_in, freq_out);
+
+	if (component->driver->set_pll)
+		return component->driver->set_pll(component, pll_id, source,
+					      freq_in, freq_out);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_set_pll);
+
 /**
  * snd_soc_dai_set_bclk_ratio - configure BCLK to sample rate ratio.
  * @dai: DAI
@@ -3201,6 +3226,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->pcm_new = component->driver->pcm_new;
 	component->pcm_free = component->driver->pcm_free;
 	component->set_sysclk = component->driver->set_sysclk;
+	component->set_pll = component->driver->set_pll;
 
 	dapm = &component->dapm;
 	dapm->dev = dev;
@@ -3615,6 +3641,15 @@ static int snd_soc_codec_set_sysclk_(struct snd_soc_component *component,
 	return snd_soc_codec_set_sysclk(codec, clk_id, source, freq, dir);
 }
 
+static int snd_soc_codec_set_pll_(struct snd_soc_component *component,
+				  int pll_id, int source, unsigned int freq_in,
+				  unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	return snd_soc_codec_set_pll(codec, pll_id, source, freq_in, freq_out);
+}
+
 static int snd_soc_codec_set_bias_level(struct snd_soc_dapm_context *dapm,
 	enum snd_soc_bias_level level)
 {
@@ -3668,6 +3703,8 @@ int snd_soc_register_codec(struct device *dev,
 		codec->component.read = snd_soc_codec_drv_read;
 	if (codec_drv->set_sysclk)
 		codec->component.set_sysclk = snd_soc_codec_set_sysclk_;
+	if (codec_drv->set_pll)
+		codec->component.set_pll = snd_soc_codec_set_pll_;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 
 	dapm = snd_soc_codec_get_dapm(codec);
-- 
2.14.1
