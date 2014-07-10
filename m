From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 4/5] pcm: Implement timestamp type
	setup in hw plugin
Date: Thu, 10 Jul 2014 15:09:16 +0200
Message-ID: <1404997757-15500-5-git-send-email-tiwai@suse.de>
References: <1404997757-15500-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F19132610C1
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 15:09:19 +0200 (CEST)
In-Reply-To: <1404997757-15500-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This patch implements the support for sw_params timestamp type in PCM
hw layer.  As gettimestamp() is still unchanged, the resultant
timstamps may be still with CLOCK_MONOTONIC even if you pass monotonic
raw type.  More fixes will follow.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_hw.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index ed8319728130..bafa8debeb0b 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -304,7 +304,8 @@ static int snd_pcm_hw_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 
 	if (params->info != ~0U) {
 		params->info &= ~0xf0000000;
-		params->info |= (pcm->monotonic ? SND_PCM_INFO_MONOTONIC : 0);
+		if (pcm->tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY)
+			params->info |= SND_PCM_INFO_MONOTONIC;
 	}
 	
 	return 0;
@@ -328,7 +329,8 @@ static int snd_pcm_hw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 		return err;
 	}
 	params->info &= ~0xf0000000;
-	params->info |= (pcm->monotonic ? SND_PCM_INFO_MONOTONIC : 0);
+	if (pcm->tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY)
+		params->info |= SND_PCM_INFO_MONOTONIC;
 	err = sync_ptr(hw, 0);
 	if (err < 0)
 		return err;
@@ -435,6 +437,7 @@ static int snd_pcm_hw_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t * params)
 	int old_period_event = sw_get_period_event(params);
 	sw_set_period_event(params, 0);
 	if ((snd_pcm_tstamp_t) params->tstamp_mode == pcm->tstamp_mode &&
+	    (snd_pcm_tstamp_type_t) params->tstamp_type == pcm->tstamp_type &&
 	    params->period_step == pcm->period_step &&
 	    params->start_threshold == pcm->start_threshold &&
 	    params->stop_threshold == pcm->stop_threshold &&
@@ -444,11 +447,33 @@ static int snd_pcm_hw_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t * params)
 		hw->mmap_control->avail_min = params->avail_min;
 		return sync_ptr(hw, 0);
 	}
+	if (params->tstamp_type == SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW &&
+	    hw->version < SNDRV_PROTOCOL_VERSION(2, 0, 12)) {
+		SYSMSG("Kernel doesn't support SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW");
+		return -EINVAL;
+	}
+	if (params->tstamp_type == SND_PCM_TSTAMP_TYPE_MONOTONIC &&
+	    hw->version < SNDRV_PROTOCOL_VERSION(2, 0, 5)) {
+		SYSMSG("Kernel doesn't support SND_PCM_TSTAMP_TYPE_MONOTONIC");
+		return -EINVAL;
+	}
 	if (ioctl(fd, SNDRV_PCM_IOCTL_SW_PARAMS, params) < 0) {
 		err = -errno;
 		SYSMSG("SNDRV_PCM_IOCTL_SW_PARAMS failed (%i)", err);
 		return err;
 	}
+	if ((snd_pcm_tstamp_type_t) params->tstamp_type != pcm->tstamp_type) {
+		if (hw->version < SNDRV_PROTOCOL_VERSION(2, 0, 12)) {
+			int on = (snd_pcm_tstamp_type_t) params->tstamp_type ==
+				SND_PCM_TSTAMP_TYPE_MONOTONIC;
+			if (ioctl(fd, SNDRV_PCM_IOCTL_TSTAMP, &on) < 0) {
+				err = -errno;
+				SNDMSG("TSTAMP failed\n");
+				return err;
+			}
+		}
+		pcm->tstamp_type = params->tstamp_type;
+	}
 	sw_set_period_event(params, old_period_event);
 	hw->mmap_control->avail_min = params->avail_min;
 	if (hw->period_event != old_period_event) {
@@ -1381,7 +1406,8 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
 		       int fd, int mmap_emulation ATTRIBUTE_UNUSED,
 		       int sync_ptr_ioctl)
 {
-	int ver, mode, monotonic = 0;
+	int ver, mode;
+	snd_pcm_tstamp_type_t tstamp_type = SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY;
 	long fmode;
 	snd_pcm_t *pcm = NULL;
 	snd_pcm_hw_t *hw = NULL;
@@ -1429,7 +1455,7 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
 				SNDMSG("TTSTAMP failed\n");
 				return ret;
 			}
-			monotonic = 1;
+			tstamp_type = SND_PCM_TSTAMP_TYPE_MONOTONIC;
 		}
 	} else
 #endif
@@ -1471,7 +1497,8 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
 	pcm->private_data = hw;
 	pcm->poll_fd = fd;
 	pcm->poll_events = info.stream == SND_PCM_STREAM_PLAYBACK ? POLLOUT : POLLIN;
-	pcm->monotonic = monotonic;
+	pcm->tstamp_type = tstamp_type;
+	pcm->monotonic = tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY;
 
 	ret = snd_pcm_hw_mmap_status(pcm);
 	if (ret < 0) {
-- 
2.0.1
