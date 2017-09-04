From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH v2] ALSA: hda: Fix forget to free resource in error handling
 code path in hda_codec_driver_probe
Date: Mon, 4 Sep 2017 23:17:09 +0800
Message-ID: <20170904151709.GA19742@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When hda_codec_driver_probe meet error and return failure, we need
to free resource with patch_ops.free, or we will get resource leak.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes v1-v2:
 1: Fix calling patch_ops.free after module_put, reported by Takashi Iwai.

 Hi! Takashi Iwai
 Because the only one calling site of patch_ops.free is in
 hda_codec_driver_remove, and if hda_codec_driver_probe return
 failure, we will no chance to call the hda_codec_driver_remove,
 so I think we don't need to care below case:
 "Or, for safety, we may put an internal flag to indicate that the codec
  free got already called, and check it at before calling
  patch_ops.free, too."

 Thanks!

 sound/pci/hda/hda_bind.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 6efadbf..d361bb7 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -100,7 +100,7 @@ static int hda_codec_driver_probe(struct device *dev)
 	if (patch) {
 		err = patch(codec);
 		if (err < 0)
-			goto error_module;
+			goto error_module_put;
 	}
 
 	err = snd_hda_codec_build_pcms(codec);
@@ -120,6 +120,9 @@ static int hda_codec_driver_probe(struct device *dev)
 	return 0;
 
  error_module:
+	if (codec->patch_ops.free)
+		codec->patch_ops.free(codec);
+ error_module_put:
 	module_put(owner);
 
  error:
-- 
1.8.5.6.2.g3d8a54e.dirty
