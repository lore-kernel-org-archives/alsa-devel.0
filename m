From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: constify snd_pcm_ops structures" to the asoc tree
Date: Mon, 14 Aug 2017 17:44:24 +0100
Message-ID: <E1dhITY-0005UU-8j@finisterre>
References: <1502690193-29059-4-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502690193-29059-4-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: constify snd_pcm_ops structures

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

>From b6ed072028705620ea2937ddafd77a202df034af Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Mon, 14 Aug 2017 11:26:26 +0530
Subject: [PATCH] ASoC: fsl: constify snd_pcm_ops structures

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_dma.c     | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c | 2 +-
 sound/soc/fsl/mpc5200_dma.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index ed8ea002902d..979ed1b3ecc4 100644
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
index 92410f7ca1fa..9ce37616ef5d 100644
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
index 1f7e70bfbd55..66042ce86edc 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -287,7 +287,7 @@ psc_dma_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_pcm_ops psc_dma_ops = {
+static const struct snd_pcm_ops psc_dma_ops = {
 	.open		= psc_dma_open,
 	.close		= psc_dma_close,
 	.hw_free	= psc_dma_hw_free,
-- 
2.13.2
