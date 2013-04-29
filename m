From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] compress: fix the states to check for allowing
	read
Date: Mon, 29 Apr 2013 14:25:23 +0530
Message-ID: <1367225723-10145-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 18A28261A0D
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 11:28:08 +0200 (CEST)
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
 sound/core/compress_offload.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a0bc47f..7b774b7 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -311,8 +311,16 @@ static ssize_t snd_compr_read(struct file *f, char __user *buf,
 	stream = &data->stream;
 	mutex_lock(&stream->device->lock);
 
-	/* read is allowed when stream is running */
-	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
+	/* read is allowed when stream is running, paused, draining and setup
+	 * (yes setup is state which we transition to after stop, so if user
+	 * wants to read data after stop we allow that
+	 */
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_OPEN:
+	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_XRUN:
+	case SNDRV_PCM_STATE_SUSPENDED:
+	case SNDRV_PCM_STATE_DISCONNECTED:
 		retval = -EBADFD;
 		goto out;
 	}
-- 
1.7.0.4
