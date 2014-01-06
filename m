From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: fix the DAPM routes map parsing
Date: Mon, 6 Jan 2014 13:41:46 +0800
Message-ID: <1388986906-32139-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

The simple-card's DAPM route maping is optional. For example, the spdif has
no need of this.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index e86ddf5..889908a 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -145,10 +145,12 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
 	/* DAPM routes */
-	ret = snd_soc_of_parse_audio_routing(&info->snd_card,
+	if (of_property_read_bool(node, "simple-audio-card,routing")) {
+		ret = snd_soc_of_parse_audio_routing(&info->snd_card,
 					"simple-audio-card,routing");
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	/* CPU sub-node */
 	ret = -EINVAL;
-- 
1.8.4
