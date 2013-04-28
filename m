From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: compress: fix the states to check for
	allowing read
Date: Sun, 28 Apr 2013 13:35:22 +0530
Message-ID: <1367136322-24531-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AA5B261645
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2013 10:38:05 +0200 (CEST)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

for reading compressed data, we need to allow when we are paused, draining or
stopped.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

---
 sound/core/compress_offload.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a0bc47f..5389b9a 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -311,8 +311,14 @@ static ssize_t snd_compr_read(struct file *f, char __user *buf,
 	stream = &data->stream;
 	mutex_lock(&stream->device->lock);
 
-	/* read is allowed when stream is running */
-	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
+	/* read is allowed when stream is running, paused, draining and setup
+	 * (yes setup is state which we transistion to after stop, so if user
+	 * wants to read data after stop we allow that
+	 */
+	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING ||
+			stream->runtime->state != SNDRV_PCM_STATE_DRAINING ||
+			stream->runtime->state != SNDRV_PCM_STATE_PAUSED ||
+			stream->runtime->state != SNDRV_PCM_STATE_SETUP) {
 		retval = -EBADFD;
 		goto out;
 	}
-- 
1.7.0.4
