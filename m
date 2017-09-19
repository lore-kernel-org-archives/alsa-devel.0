From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: make sst_platform_compr_ops const" to the asoc tree
Date: Tue, 19 Sep 2017 14:46:23 +0100
Message-ID: <E1duIr1-0008EE-PF@debutante>
References: <1505327916-24603-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505327916-24603-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: make sst_platform_compr_ops const

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

>From 86cb5dee237be6cf6c432299b829a5e85ed35029 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 14 Sep 2017 00:08:36 +0530
Subject: [PATCH] ASoC: Intel: atom: make sst_platform_compr_ops const

Make this const as it not modified in the file referencing it.
It only stored in the const field 'compr_ops' of a snd_soc_platform_driver
structure. Also, add const to the declaration in the header file.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-compress.c | 2 +-
 sound/soc/intel/atom/sst-mfld-platform.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-compress.c b/sound/soc/intel/atom/sst-mfld-platform-compress.c
index 1bead81bb510..1dbcab5a6ff0 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-compress.c
@@ -259,7 +259,7 @@ static int sst_platform_compr_set_metadata(struct snd_compr_stream *cstream,
 	return stream->compr_ops->set_metadata(sst->dev, stream->id, metadata);
 }
 
-struct snd_compr_ops sst_platform_compr_ops = {
+const struct snd_compr_ops sst_platform_compr_ops = {
 
 	.open = sst_platform_compr_open,
 	.free = sst_platform_compr_free,
diff --git a/sound/soc/intel/atom/sst-mfld-platform.h b/sound/soc/intel/atom/sst-mfld-platform.h
index cb32cc7e5ec1..31a58c25472c 100644
--- a/sound/soc/intel/atom/sst-mfld-platform.h
+++ b/sound/soc/intel/atom/sst-mfld-platform.h
@@ -25,7 +25,7 @@
 #include "sst-atom-controls.h"
 
 extern struct sst_device *sst;
-extern struct snd_compr_ops sst_platform_compr_ops;
+extern const struct snd_compr_ops sst_platform_compr_ops;
 
 #define SST_MONO		1
 #define SST_STEREO		2
-- 
2.14.1
