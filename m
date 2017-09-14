From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH] ALSA: compress: Remove unused variable
Date: Thu, 14 Sep 2017 17:49:40 +0530
Message-ID: <20170914121940.30171-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 45592266BCA
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 14:19:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>
List-Id: alsa-devel@alsa-project.org

Commit 04c5d5a430fc ("ALSA: compress: Embed struct device") removed
the statement that used 'str' but didn't remove the variable itself.
So remove it.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/core/compress_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index fec1dfdb14ad..4490a699030b 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -948,14 +948,13 @@ static const struct file_operations snd_compr_file_ops = {
 static int snd_compress_dev_register(struct snd_device *device)
 {
 	int ret = -EINVAL;
-	char str[16];
 	struct snd_compr *compr;
 
 	if (snd_BUG_ON(!device || !device->device_data))
 		return -EBADFD;
 	compr = device->device_data;
 
-	pr_debug("reg %s for device %s, direction %d\n", str, compr->name,
+	pr_debug("reg device %s, direction %d\n", compr->name,
 			compr->direction);
 	/* register compressed device */
 	ret = snd_register_device(SNDRV_DEVICE_TYPE_COMPRESS,
-- 
2.14.1
