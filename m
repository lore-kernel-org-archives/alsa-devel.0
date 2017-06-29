From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 09/12] pcm: hw: add a helper function
	to issue appl_ptr without sub-effects
Date: Fri, 30 Jun 2017 08:58:25 +0900
Message-ID: <20170629235828.18076-10-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id AAFD82673FD
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:58:35 +0200 (CEST)
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

After starting, PCM substream shift its state to running and applications
can move appl_ptr by several ways. When status and control data of runtime
of the PCM substream is not mapped, the applications should issue appl_ptr
to kernel land. In this case, when any PCM frames is handled by mmap
operation, the applications should issue appl_ptr to update.

This commit adds a helper function for this purpose. To avoid unexpected
change of avail_min, this commit uses a flag just to update appl_ptr.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 43c37b83..aacfa669 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -151,6 +151,15 @@ static int sync_ptr(snd_pcm_hw_t *hw, unsigned int flags)
 	return 0;
 }
 
+static int issue_applptr(snd_pcm_hw_t *hw)
+{
+	if (!hw->mmap_control_fallbacked)
+		return 0;
+
+	/* Avoid unexpected change of avail_min in kernel space. */
+	return sync_ptr1(hw, SNDRV_PCM_SYNC_PTR_AVAIL_MIN);
+}
+
 static int request_hwsync(snd_pcm_hw_t *hw)
 {
 	if (!hw->mmap_status_fallbacked)
@@ -653,7 +662,7 @@ static int snd_pcm_hw_start(snd_pcm_t *pcm)
 	assert(pcm->stream != SND_PCM_STREAM_PLAYBACK ||
 	       snd_pcm_mmap_playback_hw_avail(pcm) > 0);
 #endif
-	sync_ptr(hw, 0);
+	issue_applptr(hw);
 	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_START) < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_START failed (%i)", err);
@@ -1069,7 +1078,7 @@ static snd_pcm_sframes_t snd_pcm_hw_mmap_commit(snd_pcm_t *pcm,
 	snd_pcm_hw_t *hw = pcm->private_data;
 
 	snd_pcm_mmap_appl_forward(pcm, size);
-	sync_ptr(hw, 0);
+	issue_applptr(hw);
 #ifdef DEBUG_MMAP
 	fprintf(stderr, "appl_forward: hw_ptr = %li, appl_ptr = %li, size = %li\n", *pcm->hw.ptr, *pcm->appl.ptr, size);
 #endif
-- 
2.11.0
