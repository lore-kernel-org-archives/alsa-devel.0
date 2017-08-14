From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 05/10] ASoC: nuc900: constify snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:28 +0530
Message-ID: <1502690193-29059-6-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502690193-29059-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502690193-29059-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/nuc900/nuc900-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 2cca055..7f2d55d 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -271,7 +271,7 @@ static int nuc900_dma_mmap(struct snd_pcm_substream *substream,
 			   runtime->dma_addr, runtime->dma_bytes);
 }
 
-static struct snd_pcm_ops nuc900_dma_ops = {
+static const struct snd_pcm_ops nuc900_dma_ops = {
 	.open		= nuc900_dma_open,
 	.close		= nuc900_dma_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
