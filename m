From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/34] pcm: change code formatting for
	snd_pcm_direct_initialize_slave()
Date: Thu, 14 Jul 2016 23:07:22 +0900
Message-ID: <1468505271-5769-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 40E85265906
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

This commit applies code format according to typical and moderate rule,
for snd_pcm_direct_initialize_slave().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_direct.c | 67 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index fb3531c..a4b5214 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -933,9 +933,11 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 		SNDERR("snd_pcm_hw_params_any failed");
 		return ret;
 	}
-	ret = snd_pcm_hw_params_set_access(spcm, hw_params, SND_PCM_ACCESS_MMAP_INTERLEAVED);
+	ret = snd_pcm_hw_params_set_access(spcm, hw_params,
+					   SND_PCM_ACCESS_MMAP_INTERLEAVED);
 	if (ret < 0) {
-		ret = snd_pcm_hw_params_set_access(spcm, hw_params, SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
+		ret = snd_pcm_hw_params_set_access(spcm, hw_params,
+					SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
 		if (ret < 0) {
 			SNDERR("slave plugin does not support mmap interleaved or mmap noninterleaved access");
 			return ret;
@@ -949,9 +951,11 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	if (ret < 0) {
 		static const snd_pcm_format_t dmix_formats[] = {
 			SND_PCM_FORMAT_S32,
-			SND_PCM_FORMAT_S32 ^ SND_PCM_FORMAT_S32_LE ^ SND_PCM_FORMAT_S32_BE,
+			SND_PCM_FORMAT_S32 ^ SND_PCM_FORMAT_S32_LE ^
+							SND_PCM_FORMAT_S32_BE,
 			SND_PCM_FORMAT_S16,
-			SND_PCM_FORMAT_S16 ^ SND_PCM_FORMAT_S16_LE ^ SND_PCM_FORMAT_S16_BE,
+			SND_PCM_FORMAT_S16 ^ SND_PCM_FORMAT_S16_LE ^
+							SND_PCM_FORMAT_S16_BE,
 			SND_PCM_FORMAT_S24_LE,
 			SND_PCM_FORMAT_S24_3LE,
 			SND_PCM_FORMAT_U8,
@@ -959,15 +963,17 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 		snd_pcm_format_t format;
 		unsigned int i;
 
-		for (i = 0; i < sizeof dmix_formats / sizeof dmix_formats[0]; ++i) {
+		for (i = 0; i < ARRAY_SIZE(dmix_formats); ++i) {
 			format = dmix_formats[i];
-			ret = snd_pcm_hw_params_set_format(spcm, hw_params, format);
+			ret = snd_pcm_hw_params_set_format(spcm, hw_params,
+							   format);
 			if (ret >= 0)
 				break;
 		}
 		if (ret < 0 && dmix->type != SND_PCM_TYPE_DMIX) {
 			/* TODO: try to choose a good format */
-			ret = INTERNAL(snd_pcm_hw_params_set_format_first)(spcm, hw_params, &format);
+			ret = INTERNAL(snd_pcm_hw_params_set_format_first)(spcm,
+							hw_params, &format);
 		}
 		if (ret < 0) {
 			SNDERR("requested or auto-format is not available");
@@ -975,12 +981,14 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 		}
 		params->format = format;
 	}
-	ret = INTERNAL(snd_pcm_hw_params_set_channels_near)(spcm, hw_params, (unsigned int *)&params->channels);
+	ret = INTERNAL(snd_pcm_hw_params_set_channels_near)(spcm, hw_params,
+					(unsigned int *)&params->channels);
 	if (ret < 0) {
 		SNDERR("requested count of channels is not available");
 		return ret;
 	}
-	ret = INTERNAL(snd_pcm_hw_params_set_rate_near)(spcm, hw_params, (unsigned int *)&params->rate, 0);
+	ret = INTERNAL(snd_pcm_hw_params_set_rate_near)(spcm, hw_params,
+					(unsigned int *)&params->rate, 0);
 	if (ret < 0) {
 		SNDERR("requested rate is not available");
 		return ret;
@@ -988,13 +996,15 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 
 	buffer_is_not_initialized = 0;
 	if (params->buffer_time > 0) {
-		ret = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(spcm, hw_params, (unsigned int *)&params->buffer_time, 0);
+		ret = INTERNAL(snd_pcm_hw_params_set_buffer_time_near)(spcm,
+			hw_params, (unsigned int *)&params->buffer_time, 0);
 		if (ret < 0) {
 			SNDERR("unable to set buffer time");
 			return ret;
 		}
 	} else if (params->buffer_size > 0) {
-		ret = INTERNAL(snd_pcm_hw_params_set_buffer_size_near)(spcm, hw_params, (snd_pcm_uframes_t *)&params->buffer_size);
+		ret = INTERNAL(snd_pcm_hw_params_set_buffer_size_near)(spcm,
+			hw_params, (snd_pcm_uframes_t *)&params->buffer_size);
 		if (ret < 0) {
 			SNDERR("unable to set buffer size");
 			return ret;
@@ -1004,13 +1014,16 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	}
 
 	if (params->period_time > 0) {
-		ret = INTERNAL(snd_pcm_hw_params_set_period_time_near)(spcm, hw_params, (unsigned int *)&params->period_time, 0);
+		ret = INTERNAL(snd_pcm_hw_params_set_period_time_near)(spcm,
+			hw_params, (unsigned int *)&params->period_time, 0);
 		if (ret < 0) {
 			SNDERR("unable to set period_time");
 			return ret;
 		}
 	} else if (params->period_size > 0) {
-		ret = INTERNAL(snd_pcm_hw_params_set_period_size_near)(spcm, hw_params, (snd_pcm_uframes_t *)&params->period_size, 0);
+		ret = INTERNAL(snd_pcm_hw_params_set_period_size_near)(spcm,
+			hw_params, (snd_pcm_uframes_t *)&params->period_size,
+			0);
 		if (ret < 0) {
 			SNDERR("unable to set period_size");
 			return ret;
@@ -1019,7 +1032,8 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	
 	if (buffer_is_not_initialized && params->periods > 0) {
 		unsigned int periods = params->periods;
-		ret = INTERNAL(snd_pcm_hw_params_set_periods_near)(spcm, hw_params, &params->periods, 0);
+		ret = INTERNAL(snd_pcm_hw_params_set_periods_near)(spcm,
+						hw_params, &params->periods, 0);
 		if (ret < 0) {
 			SNDERR("unable to set requested periods");
 			return ret;
@@ -1045,13 +1059,21 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	}
 
 	/* store some hw_params values to shared info */
-	dmix->shmptr->hw.format = snd_mask_value(hw_param_mask(hw_params, SND_PCM_HW_PARAM_FORMAT));
-	dmix->shmptr->hw.rate = *hw_param_interval(hw_params, SND_PCM_HW_PARAM_RATE);
-	dmix->shmptr->hw.buffer_size = *hw_param_interval(hw_params, SND_PCM_HW_PARAM_BUFFER_SIZE);
-	dmix->shmptr->hw.buffer_time = *hw_param_interval(hw_params, SND_PCM_HW_PARAM_BUFFER_TIME);
-	dmix->shmptr->hw.period_size = *hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIOD_SIZE);
-	dmix->shmptr->hw.period_time = *hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIOD_TIME);
-	dmix->shmptr->hw.periods = *hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIODS);
+	dmix->shmptr->hw.format =
+		snd_mask_value(hw_param_mask(hw_params,
+					     SND_PCM_HW_PARAM_FORMAT));
+	dmix->shmptr->hw.rate =
+		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_RATE);
+	dmix->shmptr->hw.buffer_size =
+		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_BUFFER_SIZE);
+	dmix->shmptr->hw.buffer_time =
+		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_BUFFER_TIME);
+	dmix->shmptr->hw.period_size =
+		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIOD_SIZE);
+	dmix->shmptr->hw.period_time =
+		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIOD_TIME);
+	dmix->shmptr->hw.periods =
+		*hw_param_interval(hw_params, SND_PCM_HW_PARAM_PERIODS);
 
 
 	ret = snd_pcm_sw_params_current(spcm, sw_params);
@@ -1107,7 +1129,8 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 	if (dmix->type == SND_PCM_TYPE_DSHARE) {
 		const snd_pcm_channel_area_t *dst_areas;
 		dst_areas = snd_pcm_mmap_areas(spcm);
-		snd_pcm_areas_silence(dst_areas, 0, spcm->channels, spcm->buffer_size, spcm->format);
+		snd_pcm_areas_silence(dst_areas, 0, spcm->channels,
+				      spcm->buffer_size, spcm->format);
 	}
 	
 	ret = snd_pcm_start(spcm);
-- 
2.7.4
