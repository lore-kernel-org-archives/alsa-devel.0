From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 3/6] ALSA: compress: Replace complex if
	statement with switch
Date: Wed, 6 Apr 2016 11:21:52 +0100
Message-ID: <1459938115-25456-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 78CA0260870
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 12:21:52 +0200 (CEST)
In-Reply-To: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
---
 sound/core/compress_offload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 0b93121..65d94d6 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -303,9 +303,12 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
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
