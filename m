From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 07/14] ASoC: mediatek: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 17:36:04 +0530
Message-ID: <1503057971-16033-8-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_soc_dai_ops are not supposed to change at runtime. All functions
working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
const snd_soc_dai_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index bc5d4db..10dcd69 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -595,7 +595,7 @@ static int mt2701_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 };
 
 /* MRG BE DAIs */
-static struct snd_soc_dai_ops mt2701_btmrg_ops = {
+static const struct snd_soc_dai_ops mt2701_btmrg_ops = {
 	.startup = mt2701_btmrg_startup,
 	.shutdown = mt2701_btmrg_shutdown,
 	.hw_params = mt2701_btmrg_hw_params,
-- 
1.9.1
