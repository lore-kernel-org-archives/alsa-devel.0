From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nuc900: Fix a loop timeout test" to the asoc tree
Date: Mon, 11 Dec 2017 12:14:04 +0000
Message-ID: <E1eOMyC-0004dm-GN@debutante>
References: <20170717081605.a6merkvdy4ngdiqj@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170717081605.a6merkvdy4ngdiqj@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nuc900: Fix a loop timeout test

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 65a12b3aafed5fc59f4ce41b22b752b1729e6701 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 9 Dec 2017 14:52:28 +0300
Subject: [PATCH] ASoC: nuc900: Fix a loop timeout test

We should be finishing the loop with timeout set to zero but because
this is a post-op we finish with timeout == -1.

Fixes: 1082e2703a2d ("ASoC: NUC900/audio: add nuc900 audio driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/nuc900/nuc900-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 71fce7c85c93..81b09d740ed9 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -67,7 +67,7 @@ static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
 
 	/* polling the AC_R_FINISH */
 	while (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_R_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
 
 	if (!timeout) {
@@ -121,7 +121,7 @@ static void nuc900_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 
 	/* polling the AC_W_FINISH */
 	while ((AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_W_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
 
 	if (!timeout)
-- 
2.15.1

