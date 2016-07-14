From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/34] pcm: change code formatting for
	snd_pcm_set_params()
Date: Thu, 14 Jul 2016 23:07:18 +0900
Message-ID: <1468505271-5769-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C7B19265873
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

This commit applies code format according to typical and moderate rule,
for snd_pcm_set_params().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm.c | 193 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 114 insertions(+), 79 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 6c34719..64f841d 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -8291,142 +8291,177 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
                        int soft_resample,
                        unsigned int latency)
 {
-        snd_pcm_hw_params_t *params, params_saved;
-        snd_pcm_sw_params_t *swparams;
-        const char *s = snd_pcm_stream_name(snd_pcm_stream(pcm));
-        snd_pcm_uframes_t buffer_size, period_size;
-        unsigned int rrate, period_time;
-        int err;
+	snd_pcm_hw_params_t *params, params_saved;
+	snd_pcm_sw_params_t *swparams;
+	const char *s = snd_pcm_stream_name(snd_pcm_stream(pcm));
+	snd_pcm_uframes_t buffer_size, period_size;
+	unsigned int rrate, period_time;
+	int err;
 
-        snd_pcm_hw_params_alloca(&params);
-        snd_pcm_sw_params_alloca(&swparams);
+	snd_pcm_hw_params_alloca(&params);
+	snd_pcm_sw_params_alloca(&swparams);
 
 	assert(pcm);
 	/* choose all parameters */
 	err = snd_pcm_hw_params_any(pcm, params);
 	if (err < 0) {
-	        SNDERR("Broken configuration for %s: no configurations available", s);
-	        return err;
-        }
-        /* set software resampling */
-        err = snd_pcm_hw_params_set_rate_resample(pcm, params, soft_resample);
-        if (err < 0) {
-                SNDERR("Resampling setup failed for %s: %s", s, snd_strerror(err));
-                return err;
+		SNDERR("Broken configuration for %s: no configurations available",
+		       s);
+		return err;
         }
+	/* set software resampling */
+	err = snd_pcm_hw_params_set_rate_resample(pcm, params, soft_resample);
+	if (err < 0) {
+		SNDERR("Resampling setup failed for %s: %s",
+		       s, snd_strerror(err));
+		return err;
+	}
 	/* set the selected read/write format */
 	err = snd_pcm_hw_params_set_access(pcm, params, access);
 	if (err < 0) {
-		SNDERR("Access type not available for %s: %s", s, snd_strerror(err));
+		SNDERR("Access type not available for %s: %s",
+		       s, snd_strerror(err));
 		return err;
 	}
 	/* set the sample format */
 	err = snd_pcm_hw_params_set_format(pcm, params, format);
 	if (err < 0) {
-		SNDERR("Sample format not available for %s: %s", s, snd_strerror(err));
+		SNDERR("Sample format not available for %s: %s",
+		       s, snd_strerror(err));
 		return err;
 	}
 	/* set the count of channels */
 	err = snd_pcm_hw_params_set_channels(pcm, params, channels);
 	if (err < 0) {
-		SNDERR("Channels count (%i) not available for %s: %s", channels, s, snd_strerror(err));
+		SNDERR("Channels count (%i) not available for %s: %s",
+		       channels, s, snd_strerror(err));
 		return err;
 	}
 	/* set the stream rate */
 	rrate = rate;
 	err = INTERNAL(snd_pcm_hw_params_set_rate_near)(pcm, params, &rrate, 0);
 	if (err < 0) {
-		SNDERR("Rate %iHz not available for playback: %s", rate, snd_strerror(err));
+		SNDERR("Rate %iHz not available for playback: %s",
+		       rate, snd_strerror(err));
 		return err;
 	}
 	if (rrate != rate) {
-		SNDERR("Rate doesn't match (requested %iHz, get %iHz)", rate, rrate);
+		SNDERR("Rate doesn't match (requested %iHz, get %iHz)",
+		       rate, rrate);
 		return -EINVAL;
 	}
 	/* set the buffer time */
 	params_saved = *params;
-	err = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(pcm, params, &latency, NULL);
+	err = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(pcm, params,
+							&latency, NULL);
 	if (err < 0) {
-	        /* error path -> set period size as first */
+		/* error path -> set period size as first */
 		*params = params_saved;
-        	/* set the period time */
-        	period_time = latency / 4;
-        	err = INTERNAL(snd_pcm_hw_params_set_period_time_near)(pcm, params, &period_time, NULL);
-        	if (err < 0) {
-        		SNDERR("Unable to set period time %i for %s: %s", period_time, s, snd_strerror(err));
-        		return err;
-        	}
-                err = INTERNAL(snd_pcm_hw_params_get_period_size)(params, &period_size, NULL);
-                if (err < 0) {
-                	SNDERR("Unable to get period size for %s: %s", s, snd_strerror(err));
-                	return err;
-        	}
-        	buffer_size = period_size * 4;
-        	err = INTERNAL(snd_pcm_hw_params_set_buffer_size_near)(pcm, params, &buffer_size);
-                if (err < 0) {
-                	SNDERR("Unable to set buffer size %lu %s: %s", buffer_size, s, snd_strerror(err));
-                	return err;
-        	}
-        	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params, &buffer_size);
-        	if (err < 0) {
-        		SNDERR("Unable to get buffer size for %s: %s", s, snd_strerror(err));
-        		return err;
-        	}
+		/* set the period time */
+		period_time = latency / 4;
+		err = INTERNAL(snd_pcm_hw_params_set_period_time_near)(pcm,
+						params, &period_time, NULL);
+		if (err < 0) {
+			SNDERR("Unable to set period time %i for %s: %s",
+			       period_time, s, snd_strerror(err));
+			return err;
+		}
+		err = INTERNAL(snd_pcm_hw_params_get_period_size)(params,
+							&period_size, NULL);
+		if (err < 0) {
+			SNDERR("Unable to get period size for %s: %s",
+							s, snd_strerror(err));
+			return err;
+		}
+		buffer_size = period_size * 4;
+		err = INTERNAL(snd_pcm_hw_params_set_buffer_size_near)(pcm,
+							params, &buffer_size);
+		if (err < 0) {
+			SNDERR("Unable to set buffer size %lu %s: %s",
+					buffer_size, s, snd_strerror(err));
+			return err;
+		}
+		err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params,
+								&buffer_size);
+		if (err < 0) {
+			SNDERR("Unable to get buffer size for %s: %s",
+			       s, snd_strerror(err));
+			return err;
+		}
 	} else {
-	        /* standard configuration buffer_time -> periods */
-        	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params, &buffer_size);
-        	if (err < 0) {
-        		SNDERR("Unable to get buffer size for %s: %s", s, snd_strerror(err));
-        		return err;
-        	}
-        	err = INTERNAL(snd_pcm_hw_params_get_buffer_time)(params, &latency, NULL);
-        	if (err < 0) {
-        		SNDERR("Unable to get buffer time (latency) for %s: %s", s, snd_strerror(err));
-        		return err;
-        	}
-        	/* set the period time */
-        	period_time = latency / 4;
-        	err = INTERNAL(snd_pcm_hw_params_set_period_time_near)(pcm, params, &period_time, NULL);
-        	if (err < 0) {
-        		SNDERR("Unable to set period time %i for %s: %s", period_time, s, snd_strerror(err));
-        		return err;
-        	}
-                err = INTERNAL(snd_pcm_hw_params_get_period_size)(params, &period_size, NULL);
-                if (err < 0) {
-                	SNDERR("Unable to get period size for %s: %s", s, snd_strerror(err));
-                	return err;
-        	}
-        }
+		/* standard configuration buffer_time -> periods */
+		err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(params,
+								&buffer_size);
+		if (err < 0) {
+			SNDERR("Unable to get buffer size for %s: %s",
+							s, snd_strerror(err));
+			return err;
+		}
+		err = INTERNAL(snd_pcm_hw_params_get_buffer_time)(params,
+							&latency, NULL);
+		if (err < 0) {
+			SNDERR("Unable to get buffer time (latency) for %s: %s",
+			       s, snd_strerror(err));
+			return err;
+		}
+		/* set the period time */
+		period_time = latency / 4;
+		err = INTERNAL(snd_pcm_hw_params_set_period_time_near)(pcm,
+						params, &period_time, NULL);
+		if (err < 0) {
+			SNDERR("Unable to set period time %i for %s: %s",
+			       period_time, s, snd_strerror(err));
+			return err;
+		}
+		err = INTERNAL(snd_pcm_hw_params_get_period_size)(params,
+							&period_size, NULL);
+		if (err < 0) {
+			SNDERR("Unable to get period size for %s: %s",
+			       s, snd_strerror(err));
+			return err;
+		}
+	}
 	/* write the parameters to device */
 	err = snd_pcm_hw_params(pcm, params);
 	if (err < 0) {
-		SNDERR("Unable to set hw params for %s: %s", s, snd_strerror(err));
+		SNDERR("Unable to set hw params for %s: %s",
+		       s, snd_strerror(err));
 		return err;
 	}
 
 	/* get the current swparams */
 	err = snd_pcm_sw_params_current(pcm, swparams);
 	if (err < 0) {
-		SNDERR("Unable to determine current swparams for %s: %s", s, snd_strerror(err));
+		SNDERR("Unable to determine current swparams for %s: %s",
+		       s, snd_strerror(err));
 		return err;
 	}
-	/* start the transfer when the buffer is almost full: */
-	/* (buffer_size / avail_min) * avail_min */
-	err = snd_pcm_sw_params_set_start_threshold(pcm, swparams, (buffer_size / period_size) * period_size);
+	/*
+	 * start the transfer when the buffer is almost full:
+	 * (buffer_size / avail_min) * avail_min
+	 */
+	err = snd_pcm_sw_params_set_start_threshold(pcm, swparams,
+				(buffer_size / period_size) * period_size);
 	if (err < 0) {
-		SNDERR("Unable to set start threshold mode for %s: %s", s, snd_strerror(err));
+		SNDERR("Unable to set start threshold mode for %s: %s",
+		       s, snd_strerror(err));
 		return err;
 	}
-	/* allow the transfer when at least period_size samples can be processed */
+	/*
+	 * allow the transfer when at least period_size samples can be
+	 * processed
+	 */
 	err = snd_pcm_sw_params_set_avail_min(pcm, swparams, period_size);
 	if (err < 0) {
-		SNDERR("Unable to set avail min for %s: %s", s, snd_strerror(err));
+		SNDERR("Unable to set avail min for %s: %s",
+		       s, snd_strerror(err));
 		return err;
 	}
 	/* write the parameters to the playback device */
 	err = snd_pcm_sw_params(pcm, swparams);
 	if (err < 0) {
-		SNDERR("Unable to set sw params for %s: %s", s, snd_strerror(err));
+		SNDERR("Unable to set sw params for %s: %s",
+		       s, snd_strerror(err));
 		return err;
 	}
 	return 0;
-- 
2.7.4
