From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 2/3] ASoC: fsl_utils: fix a leaked reference by adding missing of_node_put
Date: Tue, 26 Feb 2019 16:17:50 +0800
Message-ID: <1551169071-11639-2-git-send-email-wen.yang99@zte.com.cn>
References: <1551169071-11639-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551169071-11639-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, linuxppc-dev@lists.ozlabs.org, wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./sound/soc/fsl/fsl_utils.c:74:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 38, but without a corresponding     object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/fsl/fsl_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 9981668..040d06b 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -71,6 +71,7 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 	iprop = of_get_property(dma_np, "cell-index", NULL);
 	if (!iprop) {
 		of_node_put(dma_np);
+		of_node_put(dma_channel_np);
 		return -EINVAL;
 	}
 	*dma_id = be32_to_cpup(iprop);
-- 
2.9.5
