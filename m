From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 3/6] ASoC: simple-card: simple audio card widgets getting
Date: Mon, 13 Jan 2014 13:53:55 +0800
Message-ID: <1389592438-13761-4-git-send-email-Li.Xiubo@freescale.com>
References: <1389592438-13761-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389592438-13761-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index b7dc63e..dbd93cc 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -125,6 +125,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 				     struct device_node **of_codec,
 				     struct device_node **of_platform)
 {
+	struct snd_soc_widgets *wdg;
 	struct device_node *np;
 	char *name;
 	int ret;
@@ -133,6 +134,14 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
+	wdg = snd_soc_get_widgets(node);
+	if (!IS_ERR_OR_NULL(wdg)) {
+		info->snd_card.dapm_widgets = wdg->widgets;
+		info->snd_card.num_dapm_widgets = wdg->cnt;
+	} else if (IS_ERR(wdg)) {
+		return PTR_ERR(wdg);
+	}
+
 	/* DAPM routes */
 	if (of_property_read_bool(node, "simple-audio-card,routing")) {
 		ret = snd_soc_of_parse_audio_routing(&info->snd_card,
-- 
1.8.4
