From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 5/8] ASoC: core: set_tdm_slot() will return -ENOTSUPP if no operation provided
Date: Thu, 23 Jan 2014 13:02:47 +0800
Message-ID: <1390453370-29194-6-git-send-email-Li.Xiubo@freescale.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Make it easier for generic code to work with set_tdm_slot() by distinguishing
between the operation not being supported and an error as is done.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fe1df50..393ff06 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3626,7 +3626,7 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 		return dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 				slots, slot_width);
 	else
-		return -EINVAL;
+		return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
 
-- 
1.8.4
