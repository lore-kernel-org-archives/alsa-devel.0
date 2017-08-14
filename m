From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 03/10] ASoC: fsl: constify snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:26 +0530
Message-ID: <1502690193-29059-4-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/fsl/fsl_dma.c     | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c | 2 +-
 sound/soc/fsl/mpc5200_dma.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index ccadefc..dc71942 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -870,7 +870,7 @@ static struct device_node *find_ssi_node(struct device_node *dma_channel_np)
 	return NULL;
 }
 
-static struct snd_pcm_ops fsl_dma_ops = {
+static const struct snd_pcm_ops fsl_dma_ops = {
 	.open   	= fsl_dma_open,
 	.close  	= fsl_dma_close,
 	.ioctl  	= snd_pcm_lib_ioctl,
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 92410f7..9ce3761 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -227,7 +227,7 @@ static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_pcm_ops imx_pcm_ops = {
+static const struct snd_pcm_ops imx_pcm_ops = {
 	.open		= snd_imx_open,
 	.close		= snd_imx_close,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 1f7e70b..66042ce 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -287,7 +287,7 @@ static int psc_dma_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops psc_dma_ops = {
+static const struct snd_pcm_ops psc_dma_ops = {
 	.open		= psc_dma_open,
 	.close		= psc_dma_close,
 	.hw_free	= psc_dma_hw_free,
-- 
1.9.1
