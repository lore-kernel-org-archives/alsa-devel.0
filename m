From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Provide CODEC clocking operations
	and API calls
Date: Mon,  7 Mar 2011 21:07:18 +0000
Message-ID: <1299532039-10637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D883C10381C
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 22:06:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When multi component systems use DAIless amplifiers which require clocking
configuration it is at best hard to use the current clocking API as this
requires a DAI even though the device may not even have one. Address this
by adding set_sysclk() and set_pll() operations and APIs for CODECs.

In order to avoid issues with devices which could be used either with or
without DAIs make the DAI variants call through to their CODEC counterparts
if there is no DAI specific operation. Converting over entirely would create
problems for multi-DAI devices which offer per-DAI clocking setup.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   11 +++++++++++
 sound/soc/soc-core.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 363e3a8..8b097f7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -260,6 +260,11 @@ enum snd_soc_compress_type {
 	SND_SOC_RBTREE_COMPRESSION
 };
 
+int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+			     unsigned int freq, int dir);
+int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
+			  unsigned int freq_in, unsigned int freq_out);
+
 int snd_soc_register_card(struct snd_soc_card *card);
 int snd_soc_unregister_card(struct snd_soc_card *card);
 int snd_soc_suspend(struct device *dev);
@@ -569,6 +574,12 @@ struct snd_soc_codec_driver {
 	const struct snd_soc_dapm_route *dapm_routes;
 	int num_dapm_routes;
 
+	/* codec wide operations */
+	int (*set_sysclk)(struct snd_soc_codec *codec,
+			  int clk_id, unsigned int freq, int dir);
+	int (*set_pll)(struct snd_soc_codec *codec, int pll_id, int source,
+		unsigned int freq_in, unsigned int freq_out);
+
 	/* codec IO */
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 286a385..9b482dd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3062,12 +3062,34 @@ int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	if (dai->driver && dai->driver->ops->set_sysclk)
 		return dai->driver->ops->set_sysclk(dai, clk_id, freq, dir);
+	else if (dai->codec && dai->codec->driver->set_sysclk)
+		return dai->codec->driver->set_sysclk(dai->codec, clk_id,
+						      freq, dir);
 	else
 		return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
 
 /**
+ * snd_soc_codec_set_sysclk - configure CODEC system or master clock.
+ * @codec: CODEC
+ * @clk_id: DAI specific clock ID
+ * @freq: new clock frequency in Hz
+ * @dir: new clock direction - input/output.
+ *
+ * Configures the CODEC master (MCLK) or system (SYSCLK) clocking.
+ */
+int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+	unsigned int freq, int dir)
+{
+	if (codec->driver->set_sysclk)
+		return codec->driver->set_sysclk(codec, clk_id, freq, dir);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_sysclk);
+
+/**
  * snd_soc_dai_set_clkdiv - configure DAI clock dividers.
  * @dai: DAI
  * @div_id: DAI specific clock divider ID
@@ -3103,11 +3125,35 @@ int snd_soc_dai_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	if (dai->driver && dai->driver->ops->set_pll)
 		return dai->driver->ops->set_pll(dai, pll_id, source,
 					 freq_in, freq_out);
+	else if (dai->codec && dai->codec->driver->set_pll)
+		return dai->codec->driver->set_pll(dai->codec, pll_id, source,
+						   freq_in, freq_out);
 	else
 		return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
 
+/*
+ * snd_soc_codec_set_pll - configure codec PLL.
+ * @codec: CODEC
+ * @pll_id: DAI specific PLL ID
+ * @source: DAI specific source for the PLL
+ * @freq_in: PLL input clock frequency in Hz
+ * @freq_out: requested PLL output clock frequency in Hz
+ *
+ * Configures and enables PLL to generate output clock based on input clock.
+ */
+int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
+			  unsigned int freq_in, unsigned int freq_out)
+{
+	if (codec->driver->set_pll)
+		return codec->driver->set_pll(codec, pll_id, source,
+					      freq_in, freq_out);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_set_pll);
+
 /**
  * snd_soc_dai_set_fmt - configure DAI hardware audio format.
  * @dai: DAI
-- 
1.7.2.3
