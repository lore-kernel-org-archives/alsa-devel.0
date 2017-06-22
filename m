From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 4/9] pcm: add a helper function
	to query status of PCM substream
Date: Thu, 22 Jun 2017 23:43:29 +0900
Message-ID: <20170622144334.1306-5-o-takashi@sakamocchi.jp>
References: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id CAA88266D6B
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 16:43:43 +0200 (CEST)
In-Reply-To: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When applications requests queueing/dequeueing some PCM frames by PCM
read/write operations, ALSA PCM core handles the request and moves
application-side position on PCM buffer. Usually, this can be visible
from user space because page frame for the position can be mapped into
process' VMA.

However, when mapping operation results in failure, applications need
to execute ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR to get current position.
This is important task for the applications to maintain runtime of PCM
substream.

This commit adds a helper function to unify relevant the codes for
readability. Original implementation has a side effect to issue the
size of avail_min. This commit add a flag to purge the effect.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 7da2db5b..23211cba 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -160,6 +160,16 @@ static int sync_applptr(snd_pcm_hw_t *hw)
 	return sync_ptr1(hw, &ptr, 0);
 }
 
+static int query_status(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_status_fallbacked)
+		return 0;
+
+	return sync_ptr1(hw, hw->sync_ptr,
+			 SNDRV_PCM_SYNC_PTR_APPL |
+			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int snd_pcm_hw_clear_timer_queue(snd_pcm_hw_t *hw)
 {
 	if (hw->period_timer_need_poll) {
@@ -814,8 +824,10 @@ static snd_pcm_sframes_t snd_pcm_hw_writei(snd_pcm_t *pcm, const void *buffer, s
 	xferi.buf = (char*) buffer;
 	xferi.frames = size;
 	xferi.result = 0; /* make valgrind happy */
-	err = ioctl(fd, SNDRV_PCM_IOCTL_WRITEI_FRAMES, &xferi);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_WRITEI_FRAMES, &xferi) < 0)
+		err = -errno;
+	else
+		err = query_status(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_writei: frames = %li, xferi.result = %li, err = %i\n", size, xferi.result, err);
 #endif
@@ -833,8 +845,10 @@ static snd_pcm_sframes_t snd_pcm_hw_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_
 	memset(&xfern, 0, sizeof(xfern)); /* make valgrind happy */
 	xfern.bufs = bufs;
 	xfern.frames = size;
-	err = ioctl(fd, SNDRV_PCM_IOCTL_WRITEN_FRAMES, &xfern);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_WRITEN_FRAMES, &xfern) < 0)
+		err = -errno;
+	else
+		err = query_status(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_writen: frames = %li, result = %li, err = %i\n", size, xfern.result, err);
 #endif
@@ -852,8 +866,10 @@ static snd_pcm_sframes_t snd_pcm_hw_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_
 	xferi.buf = buffer;
 	xferi.frames = size;
 	xferi.result = 0; /* make valgrind happy */
-	err = ioctl(fd, SNDRV_PCM_IOCTL_READI_FRAMES, &xferi);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_READI_FRAMES, &xferi) < 0)
+		err = -errno;
+	else
+		err = query_status(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_readi: frames = %li, result = %li, err = %i\n", size, xferi.result, err);
 #endif
@@ -871,8 +887,10 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
 	memset(&xfern, 0, sizeof(xfern)); /* make valgrind happy */
 	xfern.bufs = bufs;
 	xfern.frames = size;
-	err = ioctl(fd, SNDRV_PCM_IOCTL_READN_FRAMES, &xfern);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_READN_FRAMES, &xfern) < 0)
+		err = -errno;
+	else
+		err = query_status(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_readn: frames = %li, result = %li, err = %i\n", size, xfern.result, err);
 #endif
-- 
2.11.0
