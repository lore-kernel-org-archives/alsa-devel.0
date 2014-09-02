From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCHv2 1/4] ASoC: simple-card: add asoc_simple_card_fmt_master() to simplify the code.
Date: Tue, 2 Sep 2014 17:26:06 +0800
Message-ID: <1409649969-15759-2-git-send-email-Li.Xiubo@freescale.com>
References: <1409649969-15759-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409649969-15759-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, jsarha-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 sound/soc/generic/simple-card.c | 61 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 986d2c7..cad2b30 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -163,6 +163,26 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	return 0;
 }
 
+static inline unsigned int
+asoc_simple_card_fmt_master(struct device_node *np,
+			    struct device_node *bitclkmaster,
+			    struct device_node *framemaster)
+{
+	switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
+	case 0x11:
+		return SND_SOC_DAIFMT_CBS_CFS;
+	case 0x10:
+		return SND_SOC_DAIFMT_CBS_CFM;
+	case 0x01:
+		return SND_SOC_DAIFMT_CBM_CFS;
+	default:
+		return SND_SOC_DAIFMT_CBM_CFM;
+	}
+
+	/* Shouldn't be here */
+	return -EINVAL;
+}
+
 static int asoc_simple_card_dai_link_of(struct device_node *node,
 					struct device *dev,
 					struct snd_soc_dai_link *dai_link,
@@ -172,7 +192,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	struct device_node *np = NULL;
 	struct device_node *bitclkmaster = NULL;
 	struct device_node *framemaster = NULL;
-	unsigned int daifmt;
+	unsigned int daifmt, fmt;
 	char *name;
 	char prop[128];
 	char *prefix = "";
@@ -185,6 +205,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 					 &bitclkmaster, &framemaster);
 	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
 
+	/* Parse CPU DAI sub-node */
 	snprintf(prop, sizeof(prop), "%scpu", prefix);
 	np = of_get_child_by_name(node, prop);
 	if (!np) {
@@ -199,23 +220,11 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	dai_props->cpu_dai.fmt = daifmt;
-	switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
-	case 0x11:
-		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFS;
-		break;
-	case 0x10:
-		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFM;
-		break;
-	case 0x01:
-		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBM_CFS;
-		break;
-	default:
-		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBM_CFM;
-		break;
-	}
-
+	fmt = asoc_simple_card_fmt_master(np, bitclkmaster, framemaster);
+	dai_props->cpu_dai.fmt = daifmt | fmt;
 	of_node_put(np);
+
+	/* Parse CODEC DAI sub-node */
 	snprintf(prop, sizeof(prop), "%scodec", prefix);
 	np = of_get_child_by_name(node, prop);
 	if (!np) {
@@ -240,21 +249,9 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 			snd_soc_of_parse_daifmt(np, NULL, NULL, NULL) |
 			(daifmt & ~SND_SOC_DAIFMT_CLOCK_MASK);
 	} else {
-		dai_props->codec_dai.fmt = daifmt;
-		switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
-		case 0x11:
-			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBM_CFM;
-			break;
-		case 0x10:
-			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBM_CFS;
-			break;
-		case 0x01:
-			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBS_CFM;
-			break;
-		default:
-			dai_props->codec_dai.fmt |= SND_SOC_DAIFMT_CBS_CFS;
-			break;
-		}
+		fmt = asoc_simple_card_fmt_master(np, bitclkmaster,
+						  framemaster);
+		dai_props->codec_dai.fmt = daifmt | fmt;
 	}
 
 	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name) {
-- 
1.8.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
