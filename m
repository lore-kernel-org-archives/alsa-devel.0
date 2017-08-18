From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 10/14] ASoC: spear: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 17:36:07 +0530
Message-ID: <1503057971-16033-11-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/spear/spdif_in.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 977a078..293f69d 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -151,7 +151,7 @@ static int spdif_in_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static struct snd_soc_dai_ops spdif_in_dai_ops = {
+static const struct snd_soc_dai_ops spdif_in_dai_ops = {
 	.shutdown	= spdif_in_shutdown,
 	.trigger	= spdif_in_trigger,
 	.hw_params	= spdif_in_hw_params,
-- 
1.9.1
