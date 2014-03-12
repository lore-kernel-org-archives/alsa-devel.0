From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH v2] ASoC: simple-card: overwrite cpu_dai->fmt with codec_dai->fmt
Date: Wed, 12 Mar 2014 11:02:11 +0800
Message-ID: <1394593331-22867-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: broonie@kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, devicetree@vger.kernel.org, Li.Xiubo@freescale.com, moinejf@free.fr, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The current simple-card driver separates the daimft for cpu_dai and codec_dai.
So we might get different values for them (0x4003 and 0x1003 for example):

asoc-simple-card sound-cs42888.12: cpu : 2024000.esai / 4003 / 132000000
asoc-simple-card sound-cs42888.12: codec : cs42888 / 1003 / 24576000
asoc-simple-card sound-cs42888.12: cs42888 <-> 2024000.esai mapping ok

This is not allowed at all as we need to keep the DAIFMT settings identical
for both the ends of the link.

Thus this patch fixes it by overwriting the cpu_dai->fmt with codec_dai->fmt
since we defined the DAIFMT_MASTER basing on CODEC at the first place while
the other bits are same.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---

Changelog
v2:
 * Keep the fmt identical for both CPU and CODEC sides.
 * Appended warning to binding doc.

 .../devicetree/bindings/sound/simple-card.txt        |  6 ++++++
 sound/soc/generic/simple-card.c                      | 20 ++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index b30c222..881914b1 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -43,6 +43,12 @@ Optional CPU/CODEC subnodes properties:
 					  clock node (= common clock), or "system-clock-frequency"
 					  (if system doens't support common clock)
 
+Note:
+ * For 'format', 'frame-master', 'bitclock-master', 'bitclock-inversion' and
+   'frame-inversion', the simple card will use the settings of CODEC for both
+   CPU and CODEC sides as we need to keep the settings identical for both ends
+   of the link.
+
 Example:
 
 sound {
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 5dd4769..09591ab 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -157,6 +157,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 				     struct device *dev)
 {
 	struct snd_soc_dai_link *dai_link = priv->snd_card.dai_link;
+	struct asoc_simple_dai *codec_dai = &priv->codec_dai;
+	struct asoc_simple_dai *cpu_dai = &priv->cpu_dai;
 	struct device_node *np;
 	char *name;
 	int ret;
@@ -189,7 +191,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	np = of_get_child_by_name(node, "simple-audio-card,cpu");
 	if (np)
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
-						  &priv->cpu_dai,
+						  cpu_dai,
 						  &dai_link->cpu_of_node,
 						  &dai_link->cpu_dai_name);
 	if (ret < 0)
@@ -200,12 +202,18 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	np = of_get_child_by_name(node, "simple-audio-card,codec");
 	if (np)
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
-						  &priv->codec_dai,
+						  codec_dai,
 						  &dai_link->codec_of_node,
 						  &dai_link->codec_dai_name);
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * overwrite cpu_dai->fmt as its DAIFMT_MASTER bit is based on CODEC
+	 * while the other bits should be identical unless buggy SW/HW design.
+	 */
+	cpu_dai->fmt = codec_dai->fmt;
+
 	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name)
 		return -EINVAL;
 
@@ -227,12 +235,12 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	dev_dbg(dev, "platform : %04x\n", priv->daifmt);
 	dev_dbg(dev, "cpu : %s / %04x / %d\n",
 		dai_link->cpu_dai_name,
-		priv->cpu_dai.fmt,
-		priv->cpu_dai.sysclk);
+		cpu_dai->fmt,
+		cpu_dai->sysclk);
 	dev_dbg(dev, "codec : %s / %04x / %d\n",
 		dai_link->codec_dai_name,
-		priv->codec_dai.fmt,
-		priv->codec_dai.sysclk);
+		codec_dai->fmt,
+		codec_dai->sysclk);
 
 	/*
 	 * soc_bind_dai_link() will check cpu name
-- 
1.8.4


