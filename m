From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v5 1/4] ALSA: compress: Replace complex if
	statement with switch
Date: Wed, 20 Apr 2016 13:40:00 +0100
Message-ID: <1461156003-24422-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 63F6E261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 14:40:23 +0200 (CEST)
In-Reply-To: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

A switch statement looks a bit cleaner than an if statement
spread over 3 lines, as such update this to a switch.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a9933c0..507071d 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -288,9 +288,12 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 	stream = &data->stream;
 	mutex_lock(&stream->device->lock);
 	/* write is allowed when stream is running or has been steup */
-	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
-	    stream->runtime->state != SNDRV_PCM_STATE_PREPARED &&
-			stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_SETUP:
+	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_RUNNING:
+		break;
+	default:
 		mutex_unlock(&stream->device->lock);
 		return -EBADFD;
 	}
-- 
2.1.4
