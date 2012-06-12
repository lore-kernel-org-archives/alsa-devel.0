From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 1/2] alsa: compress_core: don't wake up on pause
Date: Tue, 12 Jun 2012 16:16:17 +0530
Message-ID: <1339497978-12213-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F8BF24414
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2012 12:54:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, Namarta Kohli <namartax.kohli@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

during pause the core should maintain the status-quo on the device and pointers
and not wake up. If app needs it should call DROP explcitly.

Signed-off-by: Namarta Kohli <namartax.kohli@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/core/compress_offload.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a68aed7..375f7a0 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -502,10 +502,8 @@ static int snd_compr_pause(struct snd_compr_stream *stream)
 	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
 		return -EPERM;
 	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_PAUSE_PUSH);
-	if (!retval) {
+	if (!retval)
 		stream->runtime->state = SNDRV_PCM_STATE_PAUSED;
-		wake_up(&stream->runtime->sleep);
-	}
 	return retval;
 }
 
-- 
1.7.0.4
