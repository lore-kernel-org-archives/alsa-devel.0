From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: make snd_pcm_hardware const" to the asoc tree
Date: Thu, 17 Aug 2017 18:13:46 +0100
Message-ID: <E1diOMc-0000BR-5U@debutante>
References: <1502964972-22722-2-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502964972-22722-2-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: make snd_pcm_hardware const

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f77bb3b778e85d3477a9e3e0236545663f16793e Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 17 Aug 2017 15:46:07 +0530
Subject: [PATCH] ASoC: fsl: make snd_pcm_hardware const

Make these const as they are only passed as the 2nd argument to the
function snd_soc_set_runtime_hwparams, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc_dma.c | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 2baf19608bd0..e1b97e59275a 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -20,7 +20,7 @@
 
 #define FSL_ASRC_DMABUF_SIZE	(256 * 1024)
 
-static struct snd_pcm_hardware snd_imx_hardware = {
+static const struct snd_pcm_hardware snd_imx_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP |
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index aef1f7819c40..4e5fefee111e 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -154,7 +154,7 @@ static snd_pcm_uframes_t snd_imx_pcm_pointer(struct snd_pcm_substream *substream
 	return bytes_to_frames(substream->runtime, iprtd->offset);
 }
 
-static struct snd_pcm_hardware snd_imx_hardware = {
+static const struct snd_pcm_hardware snd_imx_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP |
-- 
2.13.3
