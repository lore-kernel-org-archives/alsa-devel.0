From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH v2 1/1] ASoC: Intel: Atom: add a missing star in a memcpy call
Date: Sun, 28 Aug 2016 21:10:04 +0200
Message-ID: <20160828191004.5832-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In sst_prepare_and_post_msg(), when a response is received in "block",
the following code gets executed:

    *data = kzalloc(block->size, GFP_KERNEL);
    memcpy(data, (void *) block->data, block->size);

The memcpy() call overwrites the content of the *data pointer instead of
filling the newly-allocated memory (which pointer is hold by *data).
Fix this by merging kzalloc+memcpy into a single kmemdup() call.

Thanks Joe Perches for suggesting using kmemdup()

Fixes: 60dc8dbacb00 ("ASoC: Intel: sst: Add some helper functions")
Cc: stable@vger.kernel.org # 3.19.x
Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 sound/soc/intel/atom/sst/sst_pvt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index adb32fefd693..b1e6b8f34a6a 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -279,17 +279,15 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
 
 	if (response) {
 		ret = sst_wait_timeout(sst, block);
-		if (ret < 0) {
+		if (ret < 0)
 			goto out;
-		} else if(block->data) {
-			if (!data)
-				goto out;
-			*data = kzalloc(block->size, GFP_KERNEL);
-			if (!(*data)) {
+
+		if (data && block->data) {
+			*data = kmemdup(block->data, block->size, GFP_KERNEL);
+			if (!*data) {
 				ret = -ENOMEM;
 				goto out;
-			} else
-				memcpy(data, (void *) block->data, block->size);
+			}
 		}
 	}
 out:
-- 
2.9.3
