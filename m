From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v6 RESEND 5/5] ALSA: compress: Replace complex
	if statement with switch
Date: Wed, 4 May 2016 14:59:11 +0100
Message-ID: <1462370351-15388-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 330E82651C9
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 16:12:57 +0200 (CEST)
In-Reply-To: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A switch statement looks a bit cleaner than an if statement
spread over 3 lines, as such update this to a switch.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index f56f4e3..9b3334b 100644
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
