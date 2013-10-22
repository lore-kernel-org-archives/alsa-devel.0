From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [COMPRESS] [PATCH] ALSA: compress_core: don't return
	-EBADFD from	poll if paused
Date: Tue, 22 Oct 2013 11:26:48 +0100
Message-ID: <20131022102631.GA7466@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ABD2C260323
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 12:35:50 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Pausing audio playback is not an illegal state so it doesn't
seem sensible for poll() to return -EBADFD on a paused stream.
There's also no reason to assume that we can't write more data
to the DSP while playback is paused. Remove the -EBADFD so that
a stream in paused state will still report the buffer
availability from poll(). It is up to the user process to
manage its state so that it knows whether it is paused or not.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index bea523a..30ca133 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -384,8 +384,7 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 		return -EFAULT;
 
 	mutex_lock(&stream->device->lock);
-	if (stream->runtime->state == SNDRV_PCM_STATE_PAUSED ||
-			stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
 		retval = -EBADFD;
 		goto out;
 	}
-- 
1.7.2.5
