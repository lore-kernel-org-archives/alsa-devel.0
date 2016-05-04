From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ALSA: pcm: Fix poll error return codes
Date: Wed, 4 May 2016 14:59:07 +0100
Message-ID: <1462370351-15388-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id F068826599E
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 16:12:53 +0200 (CEST)
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
 sound/core/pcm_native.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9106d8e..c61fd50 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3161,7 +3161,7 @@ static unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
 
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
-		return -ENXIO;
+		return POLLOUT | POLLWRNORM | POLLERR;
 	runtime = substream->runtime;
 
 	poll_wait(file, &runtime->sleep, wait);
@@ -3200,7 +3200,7 @@ static unsigned int snd_pcm_capture_poll(struct file *file, poll_table * wait)
 
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
-		return -ENXIO;
+		return POLLIN | POLLRDNORM | POLLERR;
 	runtime = substream->runtime;
 
 	poll_wait(file, &runtime->sleep, wait);
-- 
2.1.4
