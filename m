From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ALSA: compress: Fix compress device unregister.
Date: Fri, 13 Sep 2013 17:43:17 +0100
Message-ID: <1379090597-7096-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1379090597-7096-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EA222610A8
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 18:43:45 +0200 (CEST)
In-Reply-To: <1379090597-7096-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

snd_unregister_device() should return the device type and not stream
direction.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/core/compress_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a9ae4f3..fba7e7a 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -849,7 +849,8 @@ static int snd_compress_dev_disconnect(struct snd_device *device)
 	struct snd_compr *compr;
 
 	compr = device->device_data;
-	snd_unregister_device(compr->direction, compr->card, compr->device);
+	snd_unregister_device(SNDRV_DEVICE_TYPE_COMPRESS, compr->card,
+		compr->device);
 	return 0;
 }
 
-- 
1.8.1.2
