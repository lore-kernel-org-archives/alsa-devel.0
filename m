From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: cleanup asoc_simple_card_parse_of() code
Date: Fri, 27 Dec 2013 11:14:38 +0800
Message-ID: <1388114078-24517-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz
Cc: shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com, fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Since there is only one common format via "simple-audio-card,format"
for simple card driver(CPU & CODEC DAI), there is no need to do the
INV mask.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d340320..8189e68 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -135,7 +135,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 
 	/* get CPU/CODEC common format via simple-audio-card,format */
 	info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
-		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
+		SND_SOC_DAIFMT_FORMAT_MASK;
 
 	ret = asoc_simple_card_get_component(node, info);
 	if (ret)
-- 
1.8.4
