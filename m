From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 1/5] pcm: Provide a
	CLOCK_MONOTONIC_RAW timestamp type
Date: Thu, 10 Jul 2014 15:09:13 +0200
Message-ID: <1404997757-15500-2-git-send-email-tiwai@suse.de>
References: <1404997757-15500-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A699126072A
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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asound.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 1774a5c3ef10..9061cdd5b69f 100644
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
2.0.1
