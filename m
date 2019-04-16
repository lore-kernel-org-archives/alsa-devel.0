From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static
Date: Tue, 16 Apr 2019 22:52:51 +0800
Message-ID: <20190416145251.16800-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Vijendar.Mukunda@amd.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, colin.king@canonical.com, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

sound/soc/amd/raven/acp3x-pcm-dma.c:561:24: warning:
 symbol 'acp3x_dai_i2s_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 1a2e15f..9775bda 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -558,7 +558,7 @@ static int acp3x_dai_i2s_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
+static struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
 	.hw_params = acp3x_dai_i2s_hwparams,
 	.trigger   = acp3x_dai_i2s_trigger,
 	.set_fmt = acp3x_dai_i2s_set_fmt,
-- 
2.7.4
