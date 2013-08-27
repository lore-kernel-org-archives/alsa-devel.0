From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/9] ALSA: compress: use snprint instread of
	sprintf
Date: Tue, 27 Aug 2013 12:10:34 +0530
Message-ID: <1377585639-29516-5-git-send-email-vinod.koul@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 81E2E264F1D
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 09:25:45 +0200 (CEST)
In-Reply-To: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

To prevent possiblity of exceeding buffer size

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index e640f8c..1e722c2 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -871,7 +871,7 @@ static int snd_compress_dev_register(struct snd_device *device)
 		return -EBADFD;
 	compr = device->device_data;
 
-	sprintf(str, "comprC%iD%i", compr->card->number, compr->device);
+	snprintf(str, sizeof(str), "comprC%iD%i", compr->card->number, compr->device);
 	pr_debug("reg %s for device %s, direction %d\n", str, compr->name,
 			compr->direction);
 	/* register compressed device */
-- 
1.7.0.4
