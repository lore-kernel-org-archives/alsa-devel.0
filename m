From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/34] pcm: remove alloca() from
	snd_pcm_direct_initialize_slave
Date: Thu, 14 Jul 2016 23:07:23 +0900
Message-ID: <1468505271-5769-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 59A17265921
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:08 +0200 (CEST)
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
 src/pcm/pcm_direct.c | 63 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index a4b5214..5984d7f 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -913,30 +913,27 @@ static void save_slave_setting(snd_pcm_direct_t *dmix, snd_pcm_t *spcm)
  */
 int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, struct slave_params *params)
 {
-	snd_pcm_hw_params_t *hw_params;
-	snd_pcm_sw_params_t *sw_params;
+	snd_pcm_hw_params_t hw_params = {0};
+	snd_pcm_sw_params_t sw_params = {0};
 	int ret, buffer_is_not_initialized;
 	snd_pcm_uframes_t boundary;
 	struct pollfd fd;
 	int loops = 10;
 
-	snd_pcm_hw_params_alloca(&hw_params);
-	snd_pcm_sw_params_alloca(&sw_params);
-
       __again:
       	if (loops-- <= 0) {
       		SNDERR("unable to find a valid configuration for slave");
       		return -EINVAL;
       	}
-	ret = snd_pcm_hw_params_any(spcm, hw_params);
+	ret = snd_pcm_hw_params_any(spcm, &hw_params);
 	if (ret < 0) {
 		SNDERR("snd_pcm_hw_params_any failed");
 		return ret;
 	}
-	ret = snd_pcm_hw_params_set_access(spcm, hw_params,
+	ret = snd_pcm_hw_params_set_access(spcm, &hw_params,
 					   SND_PCM_ACCESS_MMAP_INTERLEAVED);
 	if (ret < 0) {
-		ret = snd_pcm_hw_params_set_access(spcm, hw_params,
+		ret = snd_pcm_hw_params_set_access(spcm, &hw_params,
 					SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
 		if (ret < 0) {
 			SNDERR("slave plugin does not support mmap interleaved or mmap noninterleaved access");
@@ -946,7 +943,7 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	if (params->format == SND_PCM_FORMAT_UNKNOWN)
 		ret = -EINVAL;
 	else
-		ret = snd_pcm_hw_params_set_format(spcm, hw_params,
+		ret = snd_pcm_hw_params_set_format(spcm, &hw_params,
 						   params->format);
 	if (ret < 0) {
 		static const snd_pcm_format_t dmix_formats[] = {
@@ -965,7 +962,7 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 
 		for (i = 0; i < ARRAY_SIZE(dmix_formats); ++i) {
 			format = dmix_formats[i];
-			ret = snd_pcm_hw_params_set_format(spcm, hw_params,
+			ret = snd_pcm_hw_params_set_format(spcm, &hw_params,
 							   format);
 			if (ret >= 0)
 				break;
@@ -973,7 +970,7 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 		if (ret < 0 && dmix->type != SND_PCM_TYPE_DMIX) {
 			/* TODO: try to choose a good format */
 			ret = INTERNAL(snd_pcm_hw_params_set_format_first)(spcm,
-							hw_params, &format);
+							&hw_params, &format);
 		}
 		if (ret < 0) {
 			SNDERR("requested or auto-format is not available");
@@ -981,13 +978,13 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 		}
 		params->format = format;
 	}
-	ret = INTERNAL(snd_pcm_hw_params_set_channels_near)(spcm, hw_params,
+	ret = INTERNAL(snd_pcm_hw_params_set_channels_near)(spcm, &hw_params,
 					(unsigned int *)&params->channels);
 	if (ret < 0) {
 		SNDERR("requested count of channels is not available");
 		return ret;
 	}
-	ret = INTERNAL(snd_pcm_hw_params_set_rate_near)(spcm, hw_params,
+	ret = INTERNAL(snd_pcm_hw_params_set_rate_near)(spcm, &hw_params,
 					(unsigned int *)&params->rate, 0);
 	if (ret < 0) {
 		SNDERR("requested rate is not available");
@@ -997,14 +994,14 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	buffer_is_not_initialized = 0;
 	if (params->buffer_time > 0) {
 		ret = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(spcm,
-			hw_params, (unsigned int *)&params->buffer_time, 0);
+			&hw_params, (unsigned int *)&params->buffer_time, 0);
 		if (ret < 0) {
 			SNDERR("unable to set buffer time");
 			return ret;
 		}
 	} else if (params->buffer_size > 0) {
 		ret = INTERNAL(snd_pcm_hw_params_set_buffer_size_near)(spcm,
-			hw_params, (snd_pcm_uframes_t *)&params->buffer_size);
+			&hw_params, (snd_pcm_uframes_t *)&params->buffer_size);
 		if (ret < 0) {
 			SNDERR("unable to set buffer size");
 			return ret;
@@ -1015,14 +1012,14 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 
 	if (params->period_time > 0) {
 		ret = INTERNAL(snd_pcm_hw_params_set_period_time_near)(spcm,
-			hw_params, (unsigned int *)&params->period_time, 0);
+			&hw_params, (unsigned int *)&params->period_time, 0);
 		if (ret < 0) {
 			SNDERR("unable to set period_time");
 			return ret;
 		}
 	} else if (params->period_size > 0) {
 		ret = INTERNAL(snd_pcm_hw_params_set_period_size_near)(spcm,
-			hw_params, (snd_pcm_uframes_t *)&params->period_size,
+			&hw_params, (snd_pcm_uframes_t *)&params->period_size,
 			0);
 		if (ret < 0) {
 			SNDERR("unable to set period_size");
@@ -1033,7 +1030,7 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	if (buffer_is_not_initialized && params->periods > 0) {
 		unsigned int periods = params->periods;
 		ret = INTERNAL(snd_pcm_hw_params_set_periods_near)(spcm,
-						hw_params, &params->periods, 0);
+					&hw_params, &params->periods, 0);
 		if (ret < 0) {
 			SNDERR("unable to set requested periods");
 			return ret;
@@ -1052,7 +1049,7 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 		}
 	}
 	
-	ret = snd_pcm_hw_params(spcm, hw_params);
+	ret = snd_pcm_hw_params(spcm, &hw_params);
 	if (ret < 0) {
 		SNDERR("unable to install hw params");
 		return ret;
@@ -1060,34 +1057,34 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 
 	/* store some hw_params values to shared info */
 	dmix->shmptr->hw.format =
-		snd_mask_value(hw_param_mask(hw_params,
+		snd_mask_value(hw_param_mask(&hw_params,
 					     SND_PCM_HW_PARAM_FORMAT));
 	dmix->shmptr->hw.rate =
-		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_RATE);
+		*hw_param_interval(&hw_params, SND_PCM_HW_PARAM_RATE);
 	dmix->shmptr->hw.buffer_size =
-		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_BUFFER_SIZE);
+		*hw_param_interval(&hw_params, SND_PCM_HW_PARAM_BUFFER_SIZE);
 	dmix->shmptr->hw.buffer_time =
-		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_BUFFER_TIME);
+		*hw_param_interval(&hw_params, SND_PCM_HW_PARAM_BUFFER_TIME);
 	dmix->shmptr->hw.period_size =
-		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIOD_SIZE);
+		*hw_param_interval(&hw_params, SND_PCM_HW_PARAM_PERIOD_SIZE);
 	dmix->shmptr->hw.period_time =
-		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIOD_TIME);
+		*hw_param_interval(&hw_params, SND_PCM_HW_PARAM_PERIOD_TIME);
 	dmix->shmptr->hw.periods =
-		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIODS);
+		*hw_param_interval(&hw_params, SND_PCM_HW_PARAM_PERIODS);
 
 
-	ret = snd_pcm_sw_params_current(spcm, sw_params);
+	ret = snd_pcm_sw_params_current(spcm, &sw_params);
 	if (ret < 0) {
 		SNDERR("unable to get current sw_params");
 		return ret;
 	}
 
-	ret = snd_pcm_sw_params_get_boundary(sw_params, &boundary);
+	ret = snd_pcm_sw_params_get_boundary(&sw_params, &boundary);
 	if (ret < 0) {
 		SNDERR("unable to get boundary");
 		return ret;
 	}
-	ret = snd_pcm_sw_params_set_stop_threshold(spcm, sw_params, boundary);
+	ret = snd_pcm_sw_params_set_stop_threshold(spcm, &sw_params, boundary);
 	if (ret < 0) {
 		SNDERR("unable to set stop threshold");
 		return ret;
@@ -1097,7 +1094,7 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	 * the slave timestamp is copied appropriately in dsnoop/dmix/dshare
 	 * based on the tstamp_mode of each client
 	 */
-	ret = snd_pcm_sw_params_set_tstamp_mode(spcm, sw_params,
+	ret = snd_pcm_sw_params_set_tstamp_mode(spcm, &sw_params,
 						SND_PCM_TSTAMP_ENABLE);
 	if (ret < 0) {
 		SNDERR("unable to tstamp mode MMAP");
@@ -1107,12 +1104,12 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	if (dmix->type != SND_PCM_TYPE_DMIX)
 		goto __skip_silencing;
 
-	ret = snd_pcm_sw_params_set_silence_threshold(spcm, sw_params, 0);
+	ret = snd_pcm_sw_params_set_silence_threshold(spcm, &sw_params, 0);
 	if (ret < 0) {
 		SNDERR("unable to set silence threshold");
 		return ret;
 	}
-	ret = snd_pcm_sw_params_set_silence_size(spcm, sw_params, boundary);
+	ret = snd_pcm_sw_params_set_silence_size(spcm, &sw_params, boundary);
 	if (ret < 0) {
 		SNDERR("unable to set silence threshold (please upgrade to 0.9.0rc8+ driver)");
 		return ret;
@@ -1120,7 +1117,7 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 
       __skip_silencing:
 
-	ret = snd_pcm_sw_params(spcm, sw_params);
+	ret = snd_pcm_sw_params(spcm, &sw_params);
 	if (ret < 0) {
 		SNDERR("unable to install sw params (please upgrade to 0.9.0rc8+ driver)");
 		return ret;
-- 
2.7.4
