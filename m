From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: amd: fix memory leak of i2s_data on error return
Date: Wed, 14 Nov 2018 21:31:48 +0000
Message-ID: <20181114213148.14977-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Currently when snd_pcm_hw_constraint_integer fails there is
a memory leak of i2s_data on the error return path. Fix this by
kfree'ing i2s_data before returning.

Detected by CoverityScan, CID#1475479 ("Resource leak")

Fixes: 0b87d6bcd648 ("ASoC: amd: add acp3x pcm driver dma ops")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 2e61cef00f41..b16cdd187139 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -309,6 +309,7 @@ static int acp3x_dma_open(struct snd_pcm_substream *substream)
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
 		dev_err(component->dev, "set integer constraint failed\n");
+		kfree(i2s_data);
 		return ret;
 	}
 
-- 
2.19.1
