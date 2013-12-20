From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: Add cpu_dai and codec_dai names NULL check
Date: Fri, 20 Dec 2013 14:39:50 +0800
Message-ID: <1387521591-15262-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The name of cpu DAI maybe omitted, and then strlen() will lead
kernel panic.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 3d190d0..1d87db8 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -142,6 +142,9 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	if (ret < 0)
 		return ret;
 
+	if (!info->cpu_dai.name || !info->codec_dai.name)
+		return -EINVAL;
+
 	/* card name is created from CPU/CODEC dai name */
 	name = devm_kzalloc(dev,
 			    strlen(info->cpu_dai.name)   +
-- 
1.8.4
