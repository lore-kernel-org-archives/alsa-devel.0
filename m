From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: Intel: atom: make sst_platform_compr_ops const
Date: Thu, 14 Sep 2017 00:08:36 +0530
Message-ID: <1505327916-24603-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it not modified in the file referencing it.
It only stored in the const field 'compr_ops' of a snd_soc_platform_driver
structure. Also, add const to the declaration in the header file.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/intel/atom/sst-mfld-platform-compress.c | 2 +-
 sound/soc/intel/atom/sst-mfld-platform.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-compress.c b/sound/soc/intel/atom/sst-mfld-platform-compress.c
index 1bead81..1dbcab5 100644
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
index cb32cc7..31a58c2 100644
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
1.9.1
