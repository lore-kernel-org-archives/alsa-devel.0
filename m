From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] ASoC: simple-card: Add support for samplerate and samplewidth constraints
Date: Mon, 2 Mar 2015 16:14:33 +0200
Message-ID: <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha@ti.com>
References: <cover.1425303942.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1425303942.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add DT properties to dailink for setting samplerate and samplewidth
constraints. The DT binding document has been updated.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/sound/simple-card.txt      |  6 ++
 sound/soc/generic/simple-card.c                    | 87 ++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 73bf314..185a466 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -44,6 +44,10 @@ Required dai-link subnodes:
 
 Optional dai-link subnode properties:
 
+- samplewidth-constraints		: List of integers describing supported
+					  sample widths in number of bits.
+- rate-constraints			: List of integers describing supported
+					  sample samplerates in Hz.
 - format				: CPU/CODEC common audio format.
 					  "i2s", "right_j", "left_j" , "dsp_a"
 					  "dsp_b", "ac97", "pdm", "msb", "lsb"
@@ -97,6 +101,8 @@ sound {
 		"MIC_IN", "Microphone Jack",
 		"Headphone Jack", "HP_OUT",
 		"External Speaker", "LINE_OUT";
+	simple-audio-card,samplewidth-constraints = <16 24 32>;
+	simple-audio-card,samplerate-constraints = <22050 44100 88200>;
 
 	simple-audio-card,cpu {
 		sound-dai = <&sh_fsi2 0>;
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d15c919..f718c5e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -8,6 +8,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
@@ -20,12 +21,15 @@
 #include <sound/simple_card.h>
 #include <sound/soc-dai.h>
 #include <sound/soc.h>
+#include <sound/pcm_params.h>
 
 struct simple_card_data {
 	struct snd_soc_card snd_card;
 	struct simple_dai_props {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
+		struct snd_mask *format_constraint_mask;
+		struct snd_pcm_hw_constraint_list *rate_constraint;
 	} *dai_props;
 	unsigned int mclk_fs;
 	int gpio_hp_det;
@@ -41,12 +45,31 @@ struct simple_card_data {
 
 static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		&priv->dai_props[rtd - rtd->card->rtd];
+	struct device *dev = simple_priv_to_dev(priv);
 	int ret;
 
+	if (dai_props->format_constraint_mask) {
+		struct snd_mask *fmt = constrs_mask(&runtime->hw_constraints,
+						    SNDRV_PCM_HW_PARAM_FORMAT);
+		*fmt = *dai_props->format_constraint_mask;
+	}
+
+	if (dai_props->rate_constraint) {
+		ret = snd_pcm_hw_constraint_list(runtime, 0,
+						 SNDRV_PCM_HW_PARAM_RATE,
+						 dai_props->rate_constraint);
+		if (ret) {
+			dev_err(dev, "%s: Seting rate constraint failed: %d\n",
+				__func__, ret);
+			return ret;
+		}
+	}
+
 	ret = clk_prepare_enable(dai_props->cpu_dai.clk);
 	if (ret)
 		return ret;
@@ -264,6 +287,66 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	return 0;
 }
 
+static void asoc_simple_format_mask(u32 width, struct snd_mask *mask)
+{
+	int i;
+
+	for (i = 0; i < SNDRV_PCM_FORMAT_LAST; i++)
+		if (snd_pcm_format_width(i) == width)
+			snd_mask_set(mask, i);
+}
+
+static int asoc_simple_card_parse_constraints(struct device_node *node,
+					      struct simple_card_data *priv,
+					      char *prefix, int idx)
+{
+	struct device *dev = simple_priv_to_dev(priv);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, idx);
+	char prop[128];
+	const u32 *list;
+	u32 len;
+	int i;
+
+	snprintf(prop, sizeof(prop), "%ssamplewidth-constraints", prefix);
+	list = of_get_property(node, prop, &len);
+	len /= sizeof(*list);
+	if (list) {
+		struct snd_mask *mask =
+			devm_kzalloc(dev, sizeof(*mask), GFP_KERNEL);
+
+		if (!mask)
+			return -ENOMEM;
+		snd_mask_none(mask);
+		for (i = 0; i < len; i++) {
+			asoc_simple_format_mask(be32_to_cpu(list[i]), mask);
+			dev_dbg(dev, "%s: samplewidth %u\n", __func__,
+				be32_to_cpu(list[i]));
+		}
+		dai_props->format_constraint_mask = mask;
+	}
+
+	snprintf(prop, sizeof(prop), "%ssamplerate-constraints", prefix);
+	list = of_get_property(node, prop, &len);
+	len /= sizeof(*list);
+	if (list) {
+		struct snd_pcm_hw_constraint_list *constr =
+			devm_kzalloc(dev, sizeof(*constr), GFP_KERNEL);
+		unsigned int *clist =
+			devm_kzalloc(dev, sizeof(int) * len, GFP_KERNEL);
+
+		if (!constr || !clist)
+			return -ENOMEM;
+		constr->count = len;
+		for (i = 0; i < len; i++) {
+			clist[i] = (unsigned int) be32_to_cpu(list[i]);
+			dev_dbg(dev, "%s: samplerate %u\n", __func__, clist[i]);
+		}
+		constr->list = clist;
+		dai_props->rate_constraint = constr;
+	}
+	return 0;
+}
+
 static int asoc_simple_card_parse_daifmt(struct device_node *node,
 					 struct simple_card_data *priv,
 					 struct device_node *codec,
@@ -341,6 +424,10 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		goto dai_link_of_err;
 	}
 
+	ret = asoc_simple_card_parse_constraints(node, priv, prefix, idx);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	ret = asoc_simple_card_parse_daifmt(node, priv,
 					    codec, prefix, idx);
 	if (ret < 0)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
