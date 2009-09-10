From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: [PATCH 1/1] pcm_hw: Always use delay ioctl in
	snd_pcm_delay()
Date: Fri, 11 Sep 2009 01:07:21 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.0909110103400.3417@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
	[195.197.172.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 51F0624427
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 00:06:33 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

As the result of snd_pcm_delay() is affected not only by hw_ptr
and appl_ptr, but also by 'runtime->delay' property,
either SNDRV_PCM_IOCTL_DELAY or SNDRV_PCM_IOCTL_STATUS ioctl
must be used to get the correct result.

Previously 'runtime->delay' was ignored in case 'hw->sync_ptr'
was used.

Signed-off-by: Kai Vehmanen <kvehmanen@eca.cx>

---
  src/pcm/pcm_hw.c |   22 ----------------------
  1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index c46d14f..8abb204 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -507,28 +507,6 @@ static int snd_pcm_hw_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
  {
  	snd_pcm_hw_t *hw = pcm->private_data;
  	int fd = hw->fd, err;
-	if (hw->sync_ptr) {
-		err = sync_ptr1(hw, SNDRV_PCM_SYNC_PTR_HWSYNC);
-		if (err < 0)
-			return err;
-		switch (FAST_PCM_STATE(hw)) {
-		case SNDRV_PCM_STATE_RUNNING:
-		case SNDRV_PCM_STATE_DRAINING:
-		case SNDRV_PCM_STATE_PAUSED:
-		case SNDRV_PCM_STATE_PREPARED:
-		case SNDRV_PCM_STATE_SUSPENDED:
-			break;
-		case SNDRV_PCM_STATE_XRUN:
-			return -EPIPE;
-		default:
-			return -EBADFD;
-		}
-		if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-			*delayp = snd_pcm_mmap_playback_hw_avail(pcm);
-		else
-			*delayp = snd_pcm_mmap_capture_avail(pcm);
-		return 0;
-	}
  	if (ioctl(fd, SNDRV_PCM_IOCTL_DELAY, delayp) < 0) {
  		err = -errno;
  		SYSMSG("SNDRV_PCM_IOCTL_DELAY failed");
-- 
1.5.6.5
