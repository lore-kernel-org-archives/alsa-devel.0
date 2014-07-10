From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: Provide a CLOCK_MONOTONIC_RAW
	timestamp type
Date: Thu, 10 Jul 2014 15:04:17 +0200
Message-ID: <1404997458-15377-3-git-send-email-tiwai@suse.de>
References: <1404997458-15377-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A1A0126072A
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 15:04:22 +0200 (CEST)
In-Reply-To: <1404997458-15377-1-git-send-email-tiwai@suse.de>
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

From: Mark Brown <broonie@linaro.org>

For applications which need to synchronise with external timebases such
as broadcast TV applications the kernel monotonic time is not optimal as
it includes adjustments from NTP and so may still include discontinuities
due to that. A raw monotonic time which does not include any adjustments
is available in the kernel from getrawmonotonic() so provide userspace with
a new timestamp type SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW which provides
timestamps based on this as an option.

[dropped tstamp_type assignment code, as it's no longer needed -- tiwai]

Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h         | 11 +++++++++--
 include/uapi/sound/asound.h |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index d854fb31c000..6f3e10ca0e32 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -931,10 +931,17 @@ void snd_pcm_timer_done(struct snd_pcm_substream *substream);
 static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
 				   struct timespec *tv)
 {
-	if (runtime->tstamp_type == SNDRV_PCM_TSTAMP_TYPE_MONOTONIC)
+	switch (runtime->tstamp_type) {
+	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC:
 		ktime_get_ts(tv);
-	else
+		break;
+	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
+		getrawmonotonic(tv);
+		break;
+	default:
 		getnstimeofday(tv);
+		break;
+	}
 }
 
 /*
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 224948342f14..cbf7dc850a46 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -462,7 +462,8 @@ struct snd_xfern {
 enum {
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
-	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,
+	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,    /* monotonic_raw (no NTP) */
+	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 };
 
 /* channel positions */
-- 
2.0.1
