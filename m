From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add mclk-fs support to audio graph card" to the asoc tree
Date: Fri, 10 Nov 2017 21:29:25 +0000
Message-ID: <E1eDGrd-0004SJ-Tk@debutante>
References: <1510236478-2351-3-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510236478-2351-3-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add mclk-fs support to audio graph card

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 757652dd597139adb09e196a93db93feb6fb8a64 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 9 Nov 2017 15:07:58 +0100
Subject: [PATCH] ASoC: add mclk-fs support to audio graph card

Add mclk-fs support to audio graph card
as it was previously implemented in simple card.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 47 ++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 488c52f9405f..1b6164249341 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -29,7 +29,9 @@ struct graph_card_data {
 	struct graph_dai_props {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
+		unsigned int mclk_fs;
 	} *dai_props;
+	unsigned int mclk_fs;
 	struct snd_soc_dai_link *dai_link;
 	struct gpio_desc *pa_gpio;
 };
@@ -95,9 +97,43 @@ static void asoc_graph_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(&dai_props->codec_dai);
 }
 
+static int asoc_graph_card_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+	unsigned int mclk, mclk_fs = 0;
+	int ret = 0;
+
+	if (priv->mclk_fs)
+		mclk_fs = priv->mclk_fs;
+	else if (dai_props->mclk_fs)
+		mclk_fs = dai_props->mclk_fs;
+
+	if (mclk_fs) {
+		mclk = params_rate(params) * mclk_fs;
+		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+					     SND_SOC_CLOCK_IN);
+		if (ret && ret != -ENOTSUPP)
+			goto err;
+
+		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+					     SND_SOC_CLOCK_OUT);
+		if (ret && ret != -ENOTSUPP)
+			goto err;
+	}
+	return 0;
+err:
+	return ret;
+}
+
 static const struct snd_soc_ops asoc_graph_card_ops = {
 	.startup = asoc_graph_card_startup,
 	.shutdown = asoc_graph_card_shutdown,
+	.hw_params = asoc_graph_card_hw_params,
 };
 
 static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
@@ -146,10 +182,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	/*
-	 * we need to consider "mclk-fs" around here
-	 * see simple-card
-	 */
+	of_property_read_u32(rcpu_ep, "mclk-fs", &dai_props->mclk_fs);
 
 	ret = asoc_simple_card_parse_graph_cpu(cpu_ep, dai_link);
 	if (ret < 0)
@@ -217,10 +250,8 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * we need to consider "mclk-fs" around here
-	 * see simple-card
-	 */
+	/* Factor to mclk, used in hw_params() */
+	of_property_read_u32(node, "mclk-fs", &priv->mclk_fs);
 
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
-- 
2.15.0
