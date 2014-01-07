From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/2] ASoC: simple-card: fix the DAPM routes map parsing
Date: Tue, 7 Jan 2014 09:13:42 +0800
Message-ID: <1389057222-16686-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

The simple-card's DAPM route maping is optional.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

Resend this patch.



 sound/soc/generic/simple-card.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c0d92813..33c816c 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -138,10 +138,12 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
 
 	/* DAPM routes */
-	ret = snd_soc_of_parse_audio_routing(&info->snd_card,
+	if (of_property_read_bool(node, "simple-audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(&info->snd_card,
 					"simple-audio-routing");
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	/* CPU sub-node */
 	ret = -EINVAL;
-- 
1.8.4
