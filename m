From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ALSA: compress: Fix poll error return codes
Date: Wed, 4 May 2016 14:59:10 +0100
Message-ID: <1462370351-15388-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B55D7265A03
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 16:12:56 +0200 (CEST)
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

We can't return a negative error code from the poll callback the return
type is unsigned and is checked against the poll specific flags we need
to return POLLERR if we encounter an error.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 5215df2..f56f4e3 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -391,13 +391,13 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 	int retval = 0;
 
 	if (snd_BUG_ON(!data))
-		return -EFAULT;
+		return POLLERR;
 
 	stream = &data->stream;
 
 	mutex_lock(&stream->device->lock);
 	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
-		retval = -EBADFD;
+		retval = snd_compr_get_poll(stream) | POLLERR;
 		goto out;
 	}
 	poll_wait(f, &stream->runtime->sleep, wait);
-- 
2.1.4
