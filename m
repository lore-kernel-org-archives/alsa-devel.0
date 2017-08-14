From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: constify snd_pcm_ops structures" to the asoc tree
Date: Mon, 14 Aug 2017 17:43:26 +0100
Message-ID: <E1dhISc-0005GT-Sc@finisterre>
References: <1502690193-29059-10-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502690193-29059-10-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh: constify snd_pcm_ops structures

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

>From b23bd34c402d08a2c1d6facdba4a75e016601c12 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Mon, 14 Aug 2017 11:26:32 +0530
Subject: [PATCH] ASoC: sh: constify snd_pcm_ops structures

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/dma-sh7760.c | 2 +-
 sound/soc/sh/fsi.c        | 2 +-
 sound/soc/sh/rcar/core.c  | 2 +-
 sound/soc/sh/siu_pcm.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 81c743322445..35788a6db963 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -294,7 +294,7 @@ static snd_pcm_uframes_t camelot_pos(struct snd_pcm_substream *substream)
 	return bytes_to_frames(runtime, pos);
 }
 
-static struct snd_pcm_ops camelot_pcm_ops = {
+static const struct snd_pcm_ops camelot_pcm_ops = {
 	.open		= camelot_pcm_open,
 	.close		= camelot_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 90021b8a799a..5d7d9fe8bc98 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1755,7 +1755,7 @@ static snd_pcm_uframes_t fsi_pointer(struct snd_pcm_substream *substream)
 	return fsi_sample2frame(fsi, io->buff_sample_pos);
 }
 
-static struct snd_pcm_ops fsi_pcm_ops = {
+static const struct snd_pcm_ops fsi_pcm_ops = {
 	.open		= fsi_pcm_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= fsi_hw_params,
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index e50f7e7981c8..08f3a06978e1 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1158,7 +1158,7 @@ static snd_pcm_uframes_t rsnd_pointer(struct snd_pcm_substream *substream)
 	return pointer;
 }
 
-static struct snd_pcm_ops rsnd_pcm_ops = {
+static const struct snd_pcm_ops rsnd_pcm_ops = {
 	.open		= rsnd_pcm_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= rsnd_hw_params,
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 82902f56e82f..3118cb0ee3f2 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -593,7 +593,7 @@ static void siu_pcm_free(struct snd_pcm *pcm)
 	dev_dbg(pcm->card->dev, "%s\n", __func__);
 }
 
-static struct snd_pcm_ops siu_pcm_ops = {
+static const struct snd_pcm_ops siu_pcm_ops = {
 	.open		= siu_pcm_open,
 	.close		= siu_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
2.13.2
