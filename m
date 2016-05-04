From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ALSA: compress: Remove pointless NULL check
Date: Wed, 4 May 2016 14:59:09 +0100
Message-ID: <1462370351-15388-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D7D0C265A2B
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

stream can't be NULL here as we have just taken the address of it, so no
need for the check.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 5268546..5215df2 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -392,9 +392,8 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 
 	if (snd_BUG_ON(!data))
 		return -EFAULT;
+
 	stream = &data->stream;
-	if (snd_BUG_ON(!stream))
-		return -EFAULT;
 
 	mutex_lock(&stream->device->lock);
 	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
@@ -799,9 +798,9 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 
 	if (snd_BUG_ON(!data))
 		return -EFAULT;
+
 	stream = &data->stream;
-	if (snd_BUG_ON(!stream))
-		return -EFAULT;
+
 	mutex_lock(&stream->device->lock);
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(SNDRV_COMPRESS_IOCTL_VERSION):
-- 
2.1.4
