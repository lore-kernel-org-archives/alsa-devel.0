From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib v2 1/6] pcm: hw: add a helper function
	to query status/control data
Date: Fri, 30 Jun 2017 20:37:24 +0900
Message-ID: <20170630113729.13656-2-o-takashi@sakamocchi.jp>
References: <20170630113729.13656-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id EE8ED266EB6
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:37:33 +0200 (CEST)
In-Reply-To: <20170630113729.13656-1-o-takashi@sakamocchi.jp>
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

When executing ioctl(2) with some commands, applications can request
ALSA PCM core to change appl_ptr in kernel space. Below is a list of
such operations:
 - SNDRV_PCM_IOCTL_PREPARE
 - SNDRV_PCM_IOCTL_RESET
 - SNDRV_PCM_IOCTL_REWIND
 - SNDRV_PCM_IOCTL_FORWARD
 - SNDRV_PCM_IOCTL_WRITEI_FRAMES
 - SNDRV_PCM_IOCTL_WRITEN_FRAMES
 - SNDRV_PCM_IOCTL_READI_FRAMES
 - SNDRV_PCM_IOCTL_READN_FRAMES

After these operations, the value of appl_ptr should be synchronized
between kernel/user spaces.

This commit adds a helper function to query status and control data
without issuing the control data just in fallback from failure of control
mapping.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index f03bc589..9963523c 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -151,6 +151,20 @@ static int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
 	return 0;
 }
 
+static int query_status_and_control_data(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_control_fallbacked)
+		return 0;
+
+	/*
+	 * Query both of control/status data to avoid unexpected change of
+	 * control data in kernel space.
+	 */
+	return sync_ptr1(hw,
+			 SNDRV_PCM_SYNC_PTR_APPL |
+			 SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int snd_pcm_hw_clear_timer_queue(snd_pcm_hw_t *hw)
 {
 	if (hw->period_timer_need_poll) {
@@ -601,7 +615,7 @@ static int snd_pcm_hw_prepare(snd_pcm_t *pcm)
 		SYSMSG("SNDRV_PCM_IOCTL_PREPARE failed (%i)", err);
 		return err;
 	}
-	return sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	return query_status_and_control_data(hw);
 }
 
 static int snd_pcm_hw_reset(snd_pcm_t *pcm)
@@ -613,7 +627,7 @@ static int snd_pcm_hw_reset(snd_pcm_t *pcm)
 		SYSMSG("SNDRV_PCM_IOCTL_RESET failed (%i)", err);
 		return err;
 	}
-	return sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	return query_status_and_control_data(hw);
 }
 
 static int snd_pcm_hw_start(snd_pcm_t *pcm)
@@ -688,7 +702,7 @@ static snd_pcm_sframes_t snd_pcm_hw_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t fra
 		SYSMSG("SNDRV_PCM_IOCTL_REWIND failed (%i)", err);
 		return err;
 	}
-	err = sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	err = query_status_and_control_data(hw);
 	if (err < 0)
 		return err;
 	return frames;
@@ -709,7 +723,7 @@ static snd_pcm_sframes_t snd_pcm_hw_forward(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 			SYSMSG("SNDRV_PCM_IOCTL_FORWARD failed (%i)", err);
 			return err;
 		}
-		err = sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+		err = query_status_and_control_data(hw);
 		if (err < 0)
 			return err;
 		return frames;
@@ -805,8 +819,10 @@ static snd_pcm_sframes_t snd_pcm_hw_writei(snd_pcm_t *pcm, const void *buffer, s
 	xferi.buf = (char*) buffer;
 	xferi.frames = size;
 	xferi.result = 0; /* make valgrind happy */
-	err = ioctl(fd, SNDRV_PCM_IOCTL_WRITEI_FRAMES, &xferi);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_WRITEI_FRAMES, &xferi) < 0)
+		err = -errno;
+	else
+		err = query_status_and_control_data(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_writei: frames = %li, xferi.result = %li, err = %i\n", size, xferi.result, err);
 #endif
@@ -824,8 +840,10 @@ static snd_pcm_sframes_t snd_pcm_hw_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_
 	memset(&xfern, 0, sizeof(xfern)); /* make valgrind happy */
 	xfern.bufs = bufs;
 	xfern.frames = size;
-	err = ioctl(fd, SNDRV_PCM_IOCTL_WRITEN_FRAMES, &xfern);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_WRITEN_FRAMES, &xfern) < 0)
+		err = -errno;
+	else
+		err = query_status_and_control_data(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_writen: frames = %li, result = %li, err = %i\n", size, xfern.result, err);
 #endif
@@ -843,8 +861,10 @@ static snd_pcm_sframes_t snd_pcm_hw_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_
 	xferi.buf = buffer;
 	xferi.frames = size;
 	xferi.result = 0; /* make valgrind happy */
-	err = ioctl(fd, SNDRV_PCM_IOCTL_READI_FRAMES, &xferi);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_READI_FRAMES, &xferi) < 0)
+		err = -errno;
+	else
+		err = query_status_and_control_data(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_readi: frames = %li, result = %li, err = %i\n", size, xferi.result, err);
 #endif
@@ -862,8 +882,10 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
 	memset(&xfern, 0, sizeof(xfern)); /* make valgrind happy */
 	xfern.bufs = bufs;
 	xfern.frames = size;
-	err = ioctl(fd, SNDRV_PCM_IOCTL_READN_FRAMES, &xfern);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_READN_FRAMES, &xfern) < 0)
+		err = -errno;
+	else
+		err = query_status_and_control_data(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_readn: frames = %li, result = %li, err = %i\n", size, xfern.result, err);
 #endif
-- 
2.11.0
