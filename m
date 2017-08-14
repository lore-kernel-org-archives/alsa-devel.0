From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 09/10] ASoC: sh: constify snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:32 +0530
Message-ID: <1502690193-29059-10-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/sh/dma-sh7760.c | 2 +-
 sound/soc/sh/fsi.c        | 2 +-
 sound/soc/sh/rcar/core.c  | 2 +-
 sound/soc/sh/siu_pcm.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 8fad444..df92f38 100644
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
index 7c4bdd8..094e285 100644
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
index 3f2ced2..6f24dd1 100644
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
index 82902f5..3118cb0 100644
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
1.9.1
