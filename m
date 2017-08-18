From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/14] ASoC: blackfin: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 17:35:58 +0530
Message-ID: <1503057971-16033-2-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/blackfin/bf6xx-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
index bd3b4d4..819cff1 100644
--- a/sound/soc/blackfin/bf6xx-i2s.c
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -164,7 +164,7 @@ static int bfin_i2s_resume(struct snd_soc_dai *dai)
 #define BFIN_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
 		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops bfin_i2s_dai_ops = {
+static const struct snd_soc_dai_ops bfin_i2s_dai_ops = {
 	.hw_params	= bfin_i2s_hw_params,
 	.set_fmt	= bfin_i2s_set_dai_fmt,
 };
-- 
1.9.1
