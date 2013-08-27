From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/9] ALSA: compress: dont write when stream is
	paused
Date: Tue, 27 Aug 2013 12:10:36 +0530
Message-ID: <1377585639-29516-7-git-send-email-vinod.koul@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D5B6264F1E
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 09:25:49 +0200 (CEST)
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

and return bytes written as 0 and not error

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 417a456..fb570c8 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -256,7 +256,7 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 	struct snd_compr_file *data = f->private_data;
 	struct snd_compr_stream *stream;
 	size_t avail;
-	int retval;
+	int retval = 0;
 
 	if (snd_BUG_ON(!data))
 		return -EFAULT;
@@ -264,6 +264,14 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 	stream = &data->stream;
 	mutex_lock(&stream->device->lock);
 	/* write is allowed when stream is running or has been steup */
+	 /*
+	  * if the stream is in paused state, return the
+	  * number of bytes consumed as 0
+	  */
+	if (stream->runtime->state == SNDRV_PCM_STATE_PAUSED) {
+		mutex_unlock(&stream->device->lock);
+		return retval;
+	}
 	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
 			stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
 		mutex_unlock(&stream->device->lock);
-- 
1.7.0.4
