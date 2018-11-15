From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: amd: remove set but not used variable 'dma_buffer'
Date: Thu, 15 Nov 2018 01:56:35 +0000
Message-ID: <1542246995-180932-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Cc: YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/amd/raven/acp3x-pcm-dma.c: In function 'acp3x_dma_hw_params':
sound/soc/amd/raven/acp3x-pcm-dma.c:333:25: warning:
 variable 'dma_buffer' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
8de1b5ed0337 ("ASoC: amd: add acp3x system resume pm op")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 2e61cef..28a867f 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -330,7 +330,6 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	int status;
 	u64 size;
-	struct snd_dma_buffer *dma_buffer;
 	struct page *pg;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct i2s_stream_instance *rtd = runtime->private_data;
@@ -338,7 +337,6 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 	if (!rtd)
 		return -EINVAL;
 
-	dma_buffer = &substream->dma_buffer;
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
