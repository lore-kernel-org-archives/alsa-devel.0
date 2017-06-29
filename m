From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 03/12] pcm: hw: use heler function to
	query status/control data after reading/writing PCM frames
Date: Fri, 30 Jun 2017 08:58:19 +0900
Message-ID: <20170629235828.18076-4-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 11D6D2673F3
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:58:32 +0200 (CEST)
In-Reply-To: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
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

When executing ioctl(2) with SNDRV_PCM_IOCTL_[READ|WRITE][N|I],
applications request ALSA PCM core to handle PCM frames for buffer given
as an argument. This operation moves appl_ptr of runtime of PCM substream
in kernel space. Additionally, for some cases, the operation shifts state
of the runtime.

When alsa-lib applications run with fallback mode from failure of page
mapping of status/control data, the data in user space should be updated.
Current implementation of alsa-lib follows this principle, however for
this purpose, an added helper function can be available.

This commit replaces with the function. In this timing, no need to change
avail_min of runtime, thus this commit also suppresses it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 2b5f08be..50619fe9 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -819,8 +819,10 @@ static snd_pcm_sframes_t snd_pcm_hw_writei(snd_pcm_t *pcm, const void *buffer, s
 	xferi.buf = (char*) buffer;
 	xferi.frames = size;
 	xferi.result = 0; /* make valgrind happy */
-	err = ioctl(fd, SNDRV_PCM_IOCTL_WRITEI_FRAMES, &xferi);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_WRITEI_FRAMES, &xferi) < 0)
+		err = -errno;
+	else
+		err = query_state(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_writei: frames = %li, xferi.result = %li, err = %i\n", size, xferi.result, err);
 #endif
@@ -838,8 +840,10 @@ static snd_pcm_sframes_t snd_pcm_hw_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_
 	memset(&xfern, 0, sizeof(xfern)); /* make valgrind happy */
 	xfern.bufs = bufs;
 	xfern.frames = size;
-	err = ioctl(fd, SNDRV_PCM_IOCTL_WRITEN_FRAMES, &xfern);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_WRITEN_FRAMES, &xfern) < 0)
+		err = -errno;
+	else
+		err = query_state(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_writen: frames = %li, result = %li, err = %i\n", size, xfern.result, err);
 #endif
@@ -857,8 +861,10 @@ static snd_pcm_sframes_t snd_pcm_hw_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_
 	xferi.buf = buffer;
 	xferi.frames = size;
 	xferi.result = 0; /* make valgrind happy */
-	err = ioctl(fd, SNDRV_PCM_IOCTL_READI_FRAMES, &xferi);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_READI_FRAMES, &xferi) < 0)
+		err = -errno;
+	else
+		err = query_state(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_readi: frames = %li, result = %li, err = %i\n", size, xferi.result, err);
 #endif
@@ -876,8 +882,10 @@ static snd_pcm_sframes_t snd_pcm_hw_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_u
 	memset(&xfern, 0, sizeof(xfern)); /* make valgrind happy */
 	xfern.bufs = bufs;
 	xfern.frames = size;
-	err = ioctl(fd, SNDRV_PCM_IOCTL_READN_FRAMES, &xfern);
-	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
+	if (ioctl(fd, SNDRV_PCM_IOCTL_READN_FRAMES, &xfern) < 0)
+		err = -errno;
+	else
+		err = query_state(hw);
 #ifdef DEBUG_RW
 	fprintf(stderr, "hw_readn: frames = %li, result = %li, err = %i\n", size, xfern.result, err);
 #endif
-- 
2.11.0
