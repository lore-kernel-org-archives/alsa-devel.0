From: jassisinghbrar@gmail.com
Subject: [PATCH 1/2] ALSA: pcm - Ensure wakeup at each periodic
	interrupt
Date: Thu, 17 Dec 2009 15:00:02 +0900
Message-ID: <1261029602-14407-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id BA8E5103831
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 07:07:54 +0100 (CET)
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
Cc: tiwai@suse.de, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

The check for at least 'avail_min' available data before calling wake_up
doesn't always hold good as it does not guarantee callbacks at each periodic
interrupt.

An example of such situation is snd_pcm_lib_read1/write1 consuming some space
of the period and going to sleep from wait_for_avail_min upon syncing with
the DMA pointer. Clearly just the remainder of period size is needed, but
wake_up is called only after _two_ periodic interrupts from that point.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/core/pcm_lib.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 30f4108..ee2d7b9 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -189,7 +189,7 @@ snd_pcm_update_hw_ptr_pos(struct snd_pcm_substream *substream,
 static int snd_pcm_update_hw_ptr_post(struct snd_pcm_substream *substream,
 				      struct snd_pcm_runtime *runtime)
 {
-	snd_pcm_uframes_t avail;
+	snd_pcm_uframes_t avail, prd_short;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		avail = snd_pcm_playback_avail(runtime);
@@ -208,8 +208,14 @@ static int snd_pcm_update_hw_ptr_post(struct snd_pcm_substream *substream,
 			return -EPIPE;
 		}
 	}
-	if (avail >= runtime->control->avail_min)
+
+	prd_short = runtime->period_size
+			- runtime->status->hw_ptr % runtime->period_size;
+
+	if (avail >= runtime->control->avail_min
+			|| avail >= prd_short)
 		wake_up(&runtime->sleep);
+
 	return 0;
 }
 
-- 
1.6.2.5
