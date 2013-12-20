From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: soc-core: Fix the DAI name getting.
Date: Fri, 20 Dec 2013 14:39:51 +0800
Message-ID: <1387521591-15262-2-git-send-email-Li.Xiubo@freescale.com>
References: <1387521591-15262-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387521591-15262-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>From "ASoC: make snd_soc_dai_link more symmetrical", can we see that
the name of CPU DAI maybe omitted. If the DAI name is omitted, try to
use the component name instead.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a66783e..be88df5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4617,10 +4617,14 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 
 			if (id < 0 || id >= pos->num_dai) {
 				ret = -EINVAL;
-			} else {
-				*dai_name = pos->dai_drv[id].name;
-				ret = 0;
+				break;
 			}
+
+			ret = 0;
+
+			*dai_name = pos->dai_drv[id].name;
+			if (!*dai_name)
+				*dai_name = pos->name;
 		}
 
 		break;
-- 
1.8.4
