From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] alsa-lib: Provide a CLOCK_MONOTONIC_RAW
	timestamp type
Date: Tue,  8 Jul 2014 16:52:32 +0200
Message-ID: <1404831152-8064-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE1C82617A5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 16:54:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

For applications which need to synchronise with external timebases such
as broadcast TV applications the kernel monotonic time is not optimal as
it includes adjustments from NTP and so may still include discontinuities
due to that. A raw monotonic time which does not include any adjustments
is available in the kernel from getrawmonotonic() so provide userspace with
a new timestamp type SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW which provides
timestamps based on this as an option.

Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/sound/asound.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 1774a5c..9061cdd 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -457,7 +457,8 @@ struct snd_xfern {
 enum {
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
-	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,
+	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/* monotonic_raw (no NTP) */
+	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 };
 
 /* channel positions */
-- 
2.0.0
