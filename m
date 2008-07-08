From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 01/02] asoc: core - add Digital Audio Interface
	(DAI)	control functions.
Date: Tue, 08 Jul 2008 13:19:13 +0100
Message-ID: <1215519553.4882.208.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C63C9243B8
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jul 2008 14:19:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch adds several functions for DAI control and config
and replaces the current method of calling function pointers within
the DAI struct.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   21 ++++++++
 sound/soc/soc-core.c |  140 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 153 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 778e57e..1890d87 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -256,6 +256,27 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	struct snd_ac97_bus_ops *ops, int num);
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
 
+/* Digital Audio Interface clocking API.*/
+int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+	unsigned int freq, int dir);
+
+int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
+	int div_id, int div);
+
+int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
+	int pll_id, unsigned int freq_in, unsigned int freq_out);
+
+/* Digital Audio interface formatting */
+int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
+
+int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int mask, int slots);
+
+int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
+
+/* Digital Audio Interface mute */
+int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute);
+
 /*
  *Controls
  */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4d626b4..83f1190 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -434,8 +434,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		else {
 			codec_dai->pop_wait = 0;
 			cancel_delayed_work(&socdev->delayed_work);
-			if (codec_dai->dai_ops.digital_mute)
-				codec_dai->dai_ops.digital_mute(codec_dai, 0);
+			snd_soc_dai_digital_mute(codec_dai, 0);
 		}
 	} else {
 		/* no delayed work - do we need to power up codec */
@@ -454,8 +453,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 					SND_SOC_DAPM_STREAM_START);
 
 			snd_soc_dapm_set_bias_level(socdev, SND_SOC_BIAS_ON);
-			if (codec_dai->dai_ops.digital_mute)
-				codec_dai->dai_ops.digital_mute(codec_dai, 0);
+			snd_soc_dai_digital_mute(codec_dai, 0);
 
 		} else {
 			/* codec already powered - power on widgets */
@@ -467,8 +465,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 				snd_soc_dapm_stream_event(codec,
 					codec_dai->capture.stream_name,
 					SND_SOC_DAPM_STREAM_START);
-			if (codec_dai->dai_ops.digital_mute)
-				codec_dai->dai_ops.digital_mute(codec_dai, 0);
+
+			snd_soc_dai_digital_mute(codec_dai, 0);
 		}
 	}
 
@@ -566,8 +564,8 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&pcm_mutex);
 
 	/* apply codec digital mute */
-	if (!codec->active && codec_dai->dai_ops.digital_mute)
-		codec_dai->dai_ops.digital_mute(codec_dai, 1);
+	if (!codec->active)
+		snd_soc_dai_digital_mute(codec_dai, 1);
 
 	/* free any machine hw params */
 	if (machine->ops && machine->ops->hw_free)
@@ -1703,6 +1701,132 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 
+/**
+ * snd_soc_dai_set_sysclk - configure DAI system or master clock.
+ * @dai: DAI
+ * @clk_id: DAI specific clock ID
+ * @freq: new clock frequency in Hz
+ * @dir: new clock direction - input/output.
+ *
+ * Configures the DAI master (MCLK) or system (SYSCLK) clocking.
+ */
+int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+	unsigned int freq, int dir)
+{
+	if (dai->dai_ops.set_sysclk)
+		return dai->dai_ops.set_sysclk(dai, clk_id, freq, dir);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
+
+/**
+ * snd_soc_dai_set_clkdiv - configure DAI clock dividers.
+ * @dai: DAI
+ * @clk_id: DAI specific clock divider ID
+ * @div: new clock divisor.
+ *
+ * Configures the clock dividers. This is used to derive the best DAI bit and
+ * frame clocks from the system or master clock. It's best to set the DAI bit
+ * and frame clocks as low as possible to save system power.
+ */
+int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
+	int div_id, int div)
+{
+	if (dai->dai_ops.set_clkdiv)
+		return dai->dai_ops.set_clkdiv(dai, div_id, div);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_clkdiv);
+
+/**
+ * snd_soc_dai_set_pll - configure DAI PLL.
+ * @dai: DAI
+ * @pll_id: DAI specific PLL ID
+ * @freq_in: PLL input clock frequency in Hz
+ * @freq_out: requested PLL output clock frequency in Hz
+ *
+ * Configures and enables PLL to generate output clock based on input clock.
+ */
+int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
+	int pll_id, unsigned int freq_in, unsigned int freq_out)
+{
+	if (dai->dai_ops.set_pll)
+		return dai->dai_ops.set_pll(dai, pll_id, freq_in, freq_out);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
+
+/**
+ * snd_soc_dai_set_fmt - configure DAI hardware audio format.
+ * @dai: DAI
+ * @clk_id: DAI specific clock ID
+ * @fmt: SND_SOC_DAIFMT_ format value.
+ *
+ * Configures the DAI hardware format and clocking.
+ */
+int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	if (dai->dai_ops.set_fmt)
+		return dai->dai_ops.set_fmt(dai, fmt);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
+
+/**
+ * snd_soc_dai_set_tdm_slot - configure DAI TDM.
+ * @dai: DAI
+ * @mask: DAI specific mask representing used slots.
+ * @slots: Number of slots in use.
+ *
+ * Configures a DAI for TDM operation. Both mask and slots are codec and DAI
+ * specific.
+ */
+int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int mask, int slots)
+{
+	if (dai->dai_ops.set_sysclk)
+		return dai->dai_ops.set_tdm_slot(dai, mask, slots);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
+
+/**
+ * snd_soc_dai_set_tristate - configure DAI system or master clock.
+ * @dai: DAI
+ * @tristate: tristate enable
+ *
+ * Tristates the DAI so that others can use it.
+ */
+int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate)
+{
+	if (dai->dai_ops.set_sysclk)
+		return dai->dai_ops.set_tristate(dai, tristate);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_set_tristate);
+
+/**
+ * snd_soc_dai_digital_mute - configure DAI system or master clock.
+ * @dai: DAI
+ * @mute: mute enable
+ *
+ * Mutes the DAI DAC.
+ */
+int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	if (dai->dai_ops.digital_mute)
+		return dai->dai_ops.digital_mute(dai, mute);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
+
 static int __devinit snd_soc_init(void)
 {
 	printk(KERN_INFO "ASoC version %s\n", SND_SOC_VERSION);
-- 
1.5.4.2
