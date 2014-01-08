From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/4] ASoC: simple-card: simple audio card widgets getting
Date: Wed, 8 Jan 2014 15:02:34 +0800
Message-ID: <1389164556-2728-2-git-send-email-Li.Xiubo@freescale.com>
References: <1389164556-2728-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389164556-2728-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 sound/soc/generic/simple-card.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index e473dc9..e7cd9bb 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -125,6 +125,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 				     struct device_node **of_codec,
 				     struct device_node **of_platform)
 {
+	struct asoc_simple_card_widgets *comp;
 	struct device_node *np;
 	char *name;
 	int ret;
@@ -133,6 +134,14 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
+	comp = asoc_simple_card_get_widgets(node);
+	if (!IS_ERR_OR_NULL(comp)) {
+		info->snd_card.dapm_widgets = comp->widgets;
+		info->snd_card.num_dapm_widgets = comp->widgets_cnt;
+	} else if (IS_ERR(comp)) {
+		return PTR_ERR(comp);
+	}
+
 	/* DAPM routes */
 	if (of_property_read_bool(node, "simple-audio-card,routing")) {
 		ret = snd_soc_of_parse_audio_routing(&info->snd_card,
-- 
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
