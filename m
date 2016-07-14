From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/34] pcm: remove alloca() from
	snd_pcm_set_params()
Date: Thu, 14 Jul 2016 23:07:19 +0900
Message-ID: <1468505271-5769-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C58F626582F
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:06 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
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

Both of alloca() and automatic variables keeps storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm.c | 52 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 64f841d..4cace0b 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -8291,47 +8291,44 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
                        int soft_resample,
                        unsigned int latency)
 {
-	snd_pcm_hw_params_t *params, params_saved;
-	snd_pcm_sw_params_t *swparams;
+	snd_pcm_hw_params_t params_saved, params = {0};
+	snd_pcm_sw_params_t swparams = {0};
 	const char *s = snd_pcm_stream_name(snd_pcm_stream(pcm));
 	snd_pcm_uframes_t buffer_size, period_size;
 	unsigned int rrate, period_time;
 	int err;
 
-	snd_pcm_hw_params_alloca(&params);
-	snd_pcm_sw_params_alloca(&swparams);
-
 	assert(pcm);
 	/* choose all parameters */
-	err = snd_pcm_hw_params_any(pcm, params);
+	err = snd_pcm_hw_params_any(pcm, &params);
 	if (err < 0) {
 		SNDERR("Broken configuration for %s: no configurations available",
 		       s);
 		return err;
         }
 	/* set software resampling */
-	err = snd_pcm_hw_params_set_rate_resample(pcm, params, soft_resample);
+	err = snd_pcm_hw_params_set_rate_resample(pcm, &params, soft_resample);
 	if (err < 0) {
 		SNDERR("Resampling setup failed for %s: %s",
 		       s, snd_strerror(err));
 		return err;
 	}
 	/* set the selected read/write format */
-	err = snd_pcm_hw_params_set_access(pcm, params, access);
+	err = snd_pcm_hw_params_set_access(pcm, &params, access);
 	if (err < 0) {
 		SNDERR("Access type not available for %s: %s",
 		       s, snd_strerror(err));
 		return err;
 	}
 	/* set the sample format */
-	err = snd_pcm_hw_params_set_format(pcm, params, format);
+	err = snd_pcm_hw_params_set_format(pcm, &params, format);
 	if (err < 0) {
 		SNDERR("Sample format not available for %s: %s",
 		       s, snd_strerror(err));
 		return err;
 	}
 	/* set the count of channels */
-	err = snd_pcm_hw_params_set_channels(pcm, params, channels);
+	err = snd_pcm_hw_params_set_channels(pcm, &params, channels);
 	if (err < 0) {
 		SNDERR("Channels count (%i) not available for %s: %s",
 		       channels, s, snd_strerror(err));
@@ -8339,7 +8336,8 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 	}
 	/* set the stream rate */
 	rrate = rate;
-	err = INTERNAL(snd_pcm_hw_params_set_rate_near)(pcm, params, &rrate, 0);
+	err = INTERNAL(snd_pcm_hw_params_set_rate_near)(pcm, &params, &rrate,
+							0);
 	if (err < 0) {
 		SNDERR("Rate %iHz not available for playback: %s",
 		       rate, snd_strerror(err));
@@ -8351,22 +8349,22 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 		return -EINVAL;
 	}
 	/* set the buffer time */
-	params_saved = *params;
-	err = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(pcm, params,
+	params_saved = params;
+	err = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(pcm, &params,
 							&latency, NULL);
 	if (err < 0) {
 		/* error path -> set period size as first */
-		*params = params_saved;
+		params = params_saved;
 		/* set the period time */
 		period_time = latency / 4;
 		err = INTERNAL(snd_pcm_hw_params_set_period_time_near)(pcm,
-						params, &period_time, NULL);
+						&params, &period_time, NULL);
 		if (err < 0) {
 			SNDERR("Unable to set period time %i for %s: %s",
 			       period_time, s, snd_strerror(err));
 			return err;
 		}
-		err = INTERNAL(snd_pcm_hw_params_get_period_size)(params,
+		err = INTERNAL(snd_pcm_hw_params_get_period_size)(&params,
 							&period_size, NULL);
 		if (err < 0) {
 			SNDERR("Unable to get period size for %s: %s",
@@ -8375,13 +8373,13 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 		}
 		buffer_size = period_size * 4;
 		err = INTERNAL(snd_pcm_hw_params_set_buffer_size_near)(pcm,
-							params, &buffer_size);
+							&params, &buffer_size);
 		if (err < 0) {
 			SNDERR("Unable to set buffer size %lu %s: %s",
 					buffer_size, s, snd_strerror(err));
 			return err;
 		}
-		err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params,
+		err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(&params,
 								&buffer_size);
 		if (err < 0) {
 			SNDERR("Unable to get buffer size for %s: %s",
@@ -8390,14 +8388,14 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 		}
 	} else {
 		/* standard configuration buffer_time -> periods */
-		err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params,
+		err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(&params,
 								&buffer_size);
 		if (err < 0) {
 			SNDERR("Unable to get buffer size for %s: %s",
 							s, snd_strerror(err));
 			return err;
 		}
-		err = INTERNAL(snd_pcm_hw_params_get_buffer_time)(params,
+		err = INTERNAL(snd_pcm_hw_params_get_buffer_time)(&params,
 							&latency, NULL);
 		if (err < 0) {
 			SNDERR("Unable to get buffer time (latency) for %s: %s",
@@ -8407,13 +8405,13 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 		/* set the period time */
 		period_time = latency / 4;
 		err = INTERNAL(snd_pcm_hw_params_set_period_time_near)(pcm,
-						params, &period_time, NULL);
+						&params, &period_time, NULL);
 		if (err < 0) {
 			SNDERR("Unable to set period time %i for %s: %s",
 			       period_time, s, snd_strerror(err));
 			return err;
 		}
-		err = INTERNAL(snd_pcm_hw_params_get_period_size)(params,
+		err = INTERNAL(snd_pcm_hw_params_get_period_size)(&params,
 							&period_size, NULL);
 		if (err < 0) {
 			SNDERR("Unable to get period size for %s: %s",
@@ -8422,7 +8420,7 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 		}
 	}
 	/* write the parameters to device */
-	err = snd_pcm_hw_params(pcm, params);
+	err = snd_pcm_hw_params(pcm, &params);
 	if (err < 0) {
 		SNDERR("Unable to set hw params for %s: %s",
 		       s, snd_strerror(err));
@@ -8430,7 +8428,7 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 	}
 
 	/* get the current swparams */
-	err = snd_pcm_sw_params_current(pcm, swparams);
+	err = snd_pcm_sw_params_current(pcm, &swparams);
 	if (err < 0) {
 		SNDERR("Unable to determine current swparams for %s: %s",
 		       s, snd_strerror(err));
@@ -8440,7 +8438,7 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 	 * start the transfer when the buffer is almost full:
 	 * (buffer_size / avail_min) * avail_min
 	 */
-	err = snd_pcm_sw_params_set_start_threshold(pcm, swparams,
+	err = snd_pcm_sw_params_set_start_threshold(pcm, &swparams,
 				(buffer_size / period_size) * period_size);
 	if (err < 0) {
 		SNDERR("Unable to set start threshold mode for %s: %s",
@@ -8451,14 +8449,14 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
 	 * allow the transfer when at least period_size samples can be
 	 * processed
 	 */
-	err = snd_pcm_sw_params_set_avail_min(pcm, swparams, period_size);
+	err = snd_pcm_sw_params_set_avail_min(pcm, &swparams, period_size);
 	if (err < 0) {
 		SNDERR("Unable to set avail min for %s: %s",
 		       s, snd_strerror(err));
 		return err;
 	}
 	/* write the parameters to the playback device */
-	err = snd_pcm_sw_params(pcm, swparams);
+	err = snd_pcm_sw_params(pcm, &swparams);
 	if (err < 0) {
 		SNDERR("Unable to set sw params for %s: %s",
 		       s, snd_strerror(err));
-- 
2.7.4
