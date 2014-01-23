From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 8/8] ASoC: simple-card: add off-codec widgets supports.
Date: Thu, 23 Jan 2014 13:02:50 +0800
Message-ID: <1390453370-29194-9-git-send-email-Li.Xiubo@freescale.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d067e0a..4b7ef4d 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -196,6 +196,14 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	priv->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
+	/* off-codec widgets */
+	if (of_property_read_bool(node, "simple-audio-card,widgets")) {
+		ret = snd_soc_of_parse_audio_simple_widgets(&priv->snd_card,
+					"simple-audio-card,widgets");
+		if (ret)
+			return ret;
+	}
+
 	/* DAPM routes */
 	if (of_property_read_bool(node, "simple-audio-card,routing")) {
 		ret = snd_soc_of_parse_audio_routing(&priv->snd_card,
-- 
1.8.4
