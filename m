From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/9] ALSA: compress: allow write when stream is
	setup
Date: Tue, 27 Aug 2013 12:10:37 +0530
Message-ID: <1377585639-29516-8-git-send-email-vinod.koul@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 89A402610C6
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 09:25:50 +0200 (CEST)
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

We should allow write and thus poll as well when stream has been prepared. This
allows usermode to write buffers ahead of time

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index fb570c8..898a1d9 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -263,7 +263,6 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 
 	stream = &data->stream;
 	mutex_lock(&stream->device->lock);
-	/* write is allowed when stream is running or has been steup */
 	 /*
 	  * if the stream is in paused state, return the
 	  * number of bytes consumed as 0
@@ -272,8 +271,11 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 		mutex_unlock(&stream->device->lock);
 		return retval;
 	}
+
+	/* write is allowed when stream is running or prepared or in setup */
 	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
-			stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
+			stream->runtime->state != SNDRV_PCM_STATE_RUNNING &&
+			stream->runtime->state != SNDRV_PCM_STATE_PREPARED) {
 		mutex_unlock(&stream->device->lock);
 		return -EBADFD;
 	}
@@ -380,8 +382,7 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 		return -EFAULT;
 
 	mutex_lock(&stream->device->lock);
-	if (stream->runtime->state == SNDRV_PCM_STATE_PAUSED ||
-			stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
 		retval = -EBADFD;
 		goto out;
 	}
-- 
1.7.0.4
