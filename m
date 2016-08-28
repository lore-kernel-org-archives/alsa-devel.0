From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] ASoC: Intel: Atom: add a missing star in a memcpy call
Date: Sun, 28 Aug 2016 19:39:45 +0200
Message-ID: <20160828173945.27721-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
List-Id: alsa-devel@alsa-project.org

In sst_prepare_and_post_msg(), when a response is received in "block",
the following code gets executed:

    *data = kzalloc(block->size, GFP_KERNEL);
    memcpy(data, (void *) block->data, block->size);

The memcpy() call overwrites the content of the *data pointer instead of
filling the newly-allocated memory (which pointer is hold by *data).
Fix this by using *data in the memcpy() call.

Fixes: 60dc8dbacb00 ("ASoC: Intel: sst: Add some helper functions")
Cc: stable@vger.kernel.org # 3.19.x
Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 sound/soc/intel/atom/sst/sst_pvt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index adb32fefd693..7c398b7c9d4b 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -289,7 +289,7 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
 				ret = -ENOMEM;
 				goto out;
 			} else
-				memcpy(data, (void *) block->data, block->size);
+				memcpy(*data, (void *) block->data, block->size);
 		}
 	}
 out:
-- 
2.9.3
