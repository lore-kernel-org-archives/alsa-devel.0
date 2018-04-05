From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Conversion to int16_t and resolution loss with
 rate converter plugins
Date: Thu, 5 Apr 2018 08:17:21 +0200
Message-ID: <3a7d4f82-07af-cffb-a757-a258242b0199@ivitera.com>
References: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------98EB5B18299C866D35CFD7F6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 17835267654
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 08:17:27 +0200 (CEST)
In-Reply-To: <MWHPR21MB0478EFE0FDB4BD2A0A7293D0D8BB0@MWHPR21MB0478.namprd21.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Flavio Protasio Ribeiro <flaviopr@microsoft.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------98EB5B18299C866D35CFD7F6
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit



Dne 5.4.2018 v 05:05 Flavio Protasio Ribeiro napsal(a):
> Hi Folks,
> 
> 
> 
> The libsamplerate and speex rate converter plugins only implement the
> convert_s16 callback from snd_pcm_rate_ops_t. This has ALSA convert
> the buffer to int16_t before handing it over to the plugin for
> resampling. On devices with more than 16 effective bits, this implies
> words gets truncated and bits are lost.
> 
> 
> 
> Specifically for libsamplerate, the resampling is internally
> implemented with floats, so truncating to 16 bits does not offer a
> computational benefit.
> 
> 
> 
> I get why only convert_s16 is implemented for plugins that aren't
> part of the main alsa-lib package. The more generic convert callback
> comes with the burden having the plugin support conversion from/to
> any of the ALSA data types (or alternatively, having the plugin
> source include plugin_ops.h and its dependencies). So here's what I
> propose: replace convert_s16 with a convert_s32 callback which uses
> int32_t instead of int16_t. This would preserve all bits from the
> device and keep the plugin interface simple. Of course this means
> plugins have to be updated to use convert_s32 and rebuilt.
> 
> 

Hi,

Many years ago I tried to extend the rate API to float, the native 
formats of libsamplerate and speex.

I go stuck on float support of all platforms, perhaps you can get 
something from the discussion and patches.

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-June/041059.html

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-July/041503.html

If we succeed in adding >16 bit API to the rate plugin, perhaps 
supporting libsoxr would be the next step which would bring great value 
(performance vs. CPU load) to alsa-lib. Unfortunately that is not just 
about conversion, there are other quirks to iron out...

Anyway, thanks a lot and good luck to your very useful endeavour.

Best regards,

Pavel.


--------------98EB5B18299C866D35CFD7F6
Content-Type: text/x-patch;
 name="0001-Support-for-float-samples-in-rate-converters.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Support-for-float-samples-in-rate-converters.patch"

>From cf3b349ea2a2f55e9cfdece3d8123edc3d620719 Mon Sep 17 00:00:00 2001
From: Pavel Hofman <pavel.hofman@ivitera.com>
Date: Tue, 28 Jun 2011 08:50:23 +0200
Subject: [PATCH - rate plugin 1/1] Support for float samples in rate converters

Some rate converters have native float resolution, no need
to loose information by converting to s16.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/include/pcm_rate.h b/include/pcm_rate.h
index 4d70df2..e92900b 100644
--- a/include/pcm_rate.h
+++ b/include/pcm_rate.h
@@ -91,6 +91,11 @@ typedef struct snd_pcm_rate_ops {
 	void (*convert_s16)(void *obj, int16_t *dst, unsigned int dst_frames,
 			    const int16_t *src, unsigned int src_frames);
 	/**
+	 * convert a float interleaved-data array; exclusive with convert
+	 */
+	void (*convert_float)(void *obj, float *dst, unsigned int dst_frames,
+			    const float *src, unsigned int src_frames);
+	/**
 	 * compute the frame size for input
 	 */
 	snd_pcm_uframes_t (*input_frames)(void *obj, snd_pcm_uframes_t frames);
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 70e30e5..9f4ec23 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -35,7 +35,7 @@
 #include "iatomic.h"
 
 #include "plugin_ops.h"
-
+typedef float float_t;
 #if 0
 #define DEBUG_REFINE
 #endif
@@ -66,8 +66,8 @@ struct _snd_pcm_rate {
 	snd_pcm_rate_ops_t ops;
 	unsigned int get_idx;
 	unsigned int put_idx;
-	int16_t *src_buf;
-	int16_t *dst_buf;
+	void *src_buf;
+	void *dst_buf;
 	int start_pending; /* start is triggered but not commited to slave */
 	snd_htimestamp_t trigger_tstamp;
 	unsigned int plugin_version;
@@ -310,13 +310,23 @@ static int snd_pcm_rate_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 		rate->sareas[chn].step = swidth;
 	}
 
-	if (rate->ops.convert_s16) {
+	if (rate->ops.convert_float) {
+		rate->get_idx = snd_pcm_linear_get_index(rate->info.in.format, SND_PCM_FORMAT_S32);
+		rate->put_idx = snd_pcm_linear_put_index(SND_PCM_FORMAT_S32, rate->info.out.format);
+		free(rate->src_buf);
+		rate->src_buf = (float_t *) malloc(channels * rate->info.in.period_size * sizeof(float_t));
+		free(rate->dst_buf);
+		rate->dst_buf = (float_t *) malloc(channels * rate->info.out.period_size * sizeof(float_t));
+		if (! rate->src_buf || ! rate->dst_buf)
+			goto error;
+	}
+	else if (rate->ops.convert_s16) {
 		rate->get_idx = snd_pcm_linear_get_index(rate->info.in.format, SND_PCM_FORMAT_S16);
 		rate->put_idx = snd_pcm_linear_put_index(SND_PCM_FORMAT_S16, rate->info.out.format);
 		free(rate->src_buf);
-		rate->src_buf = malloc(channels * rate->info.in.period_size * 2);
+		rate->src_buf = (int16_t *) malloc(channels * rate->info.in.period_size * 2);
 		free(rate->dst_buf);
-		rate->dst_buf = malloc(channels * rate->info.out.period_size * 2);
+		rate->dst_buf = (int16_t *) malloc(channels * rate->info.out.period_size * 2);
 		if (! rate->src_buf || ! rate->dst_buf)
 			goto error;
 	}
@@ -503,6 +513,85 @@ static void convert_from_s16(snd_pcm_rate_t *rate, const int16_t *buf,
 		}
 	}
 }
+static void convert_to_float(snd_pcm_rate_t *rate, float_t *buf,
+			   const snd_pcm_channel_area_t *areas,
+			   snd_pcm_uframes_t offset, unsigned int frames,
+			   unsigned int channels)
+{
+#ifndef DOC_HIDDEN
+#define GET32_LABELS
+#include "plugin_ops.h"
+#undef GET32_LABELS
+#endif /* DOC_HIDDEN */
+	void *get32 = get32_labels[rate->get_idx];
+	const char *src;
+	int32_t sample;
+	const char *srcs[channels];
+	int src_step[channels];
+	unsigned int c;
+
+	for (c = 0; c < channels; c++) {
+		srcs[c] = snd_pcm_channel_area_addr(areas + c, offset);
+		src_step[c] = snd_pcm_channel_area_step(areas + c);
+	}
+
+	while (frames--) {
+		for (c = 0; c < channels; c++) {
+			src = srcs[c];
+			// converting the source format to int32 first
+			goto *get32;
+#ifndef DOC_HIDDEN
+#define GET32_END after_get
+#include "plugin_ops.h"
+#undef GET32_END
+#endif /* DOC_HIDDEN */
+		after_get:
+			// converting to float for the plugin
+			*buf++ = (float_t) sample;
+			srcs[c] += src_step[c];
+		}
+	}
+}
+
+static void convert_from_float(snd_pcm_rate_t *rate, const float_t *buf,
+			     const snd_pcm_channel_area_t *areas,
+			     snd_pcm_uframes_t offset, unsigned int frames,
+			     unsigned int channels)
+{
+#ifndef DOC_HIDDEN
+#define PUT32_LABELS
+#include "plugin_ops.h"
+#undef PUT32_LABELS
+#endif /* DOC_HIDDEN */
+	void *put32 = put32_labels[rate->put_idx];
+	char *dst;
+	int32_t sample;
+	char *dsts[channels];
+	int dst_step[channels];
+	unsigned int c;
+
+	for (c = 0; c < channels; c++) {
+		dsts[c] = snd_pcm_channel_area_addr(areas + c, offset);
+		dst_step[c] = snd_pcm_channel_area_step(areas + c);
+	}
+
+	while (frames--) {
+		for (c = 0; c < channels; c++) {
+			dst = dsts[c];
+			// plugin returned float, converting to int32 first
+			sample = (int32_t) *buf++;
+			// converting int32 to the destination format
+			goto *put32;
+#ifndef DOC_HIDDEN
+#define PUT32_END after_put
+#include "plugin_ops.h"
+#undef PUT32_END
+#endif /* DOC_HIDDEN */
+		after_put:
+			dsts[c] += dst_step[c];
+		}
+	}
+}
 
 static void do_convert(const snd_pcm_channel_area_t *dst_areas,
 		       snd_pcm_uframes_t dst_offset, unsigned int dst_frames,
@@ -511,18 +600,36 @@ static void do_convert(const snd_pcm_channel_area_t *dst_areas,
 		       unsigned int channels,
 		       snd_pcm_rate_t *rate)
 {
-	if (rate->ops.convert_s16) {
+	if (rate->ops.convert_float) {
+		const float_t *src;
+		float_t *dst;
+		if (! rate->src_buf)
+			src = src_areas->addr + src_offset * sizeof(float_t) * channels;
+		else {
+			convert_to_float(rate, rate->src_buf, src_areas, src_offset,
+				       src_frames, channels);
+			src = rate->src_buf;
+		}
+		if (! rate->dst_buf)
+			dst = dst_areas->addr + dst_offset * sizeof(float_t) * channels;
+		else
+			dst = rate->dst_buf;
+		rate->ops.convert_float(rate->obj, dst, dst_frames, src, src_frames);
+		if (dst == rate->dst_buf)
+			convert_from_float(rate, rate->dst_buf, dst_areas, dst_offset,
+					 dst_frames, channels);
+	} else if (rate->ops.convert_s16) {
 		const int16_t *src;
 		int16_t *dst;
 		if (! rate->src_buf)
-			src = src_areas->addr + src_offset * 2 * channels;
+			src = src_areas->addr + src_offset * sizeof(int16_t) * channels;
 		else {
 			convert_to_s16(rate, rate->src_buf, src_areas, src_offset,
 				       src_frames, channels);
 			src = rate->src_buf;
 		}
 		if (! rate->dst_buf)
-			dst = dst_areas->addr + dst_offset * 2 * channels;
+			dst = dst_areas->addr + dst_offset * sizeof(int16_t) * channels;
 		else
 			dst = rate->dst_buf;
 		rate->ops.convert_s16(rate->obj, dst, dst_frames, src, src_frames);
@@ -1409,7 +1516,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	}
 #endif
 
-	if (! rate->ops.init || ! (rate->ops.convert || rate->ops.convert_s16) ||
+	if (! rate->ops.init || ! (rate->ops.convert || rate->ops.convert_s16 || rate->ops.convert_float) ||
 	    ! rate->ops.input_frames || ! rate->ops.output_frames) {
 		SNDERR("Inproper rate plugin %s initialization", type);
 		snd_pcm_close(pcm);
-- 
1.7.0.4


--------------98EB5B18299C866D35CFD7F6
Content-Type: text/x-patch;
 name="0001-Using-float-instead-of-s16-for-libsamplerate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Using-float-instead-of-s16-for-libsamplerate.patch"

>From 34fb26dc0a95f7d1950abe2582cf79219d1876a9 Mon Sep 17 00:00:00 2001
From: Pavel Hofman <pavel.hofman@ivitera.com>
Date: Tue, 28 Jun 2011 08:55:08 +0200
Subject: [PATCH - resample 1/1] Using float instead of s16 for libsamplerate

Natively libsamplerate operates in floats. Using the new convert_float API instead of dropping resoluton in convert_s16.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/rate/rate_samplerate.c b/rate/rate_samplerate.c
index 53a0627..c612983 100644
--- a/rate/rate_samplerate.c
+++ b/rate/rate_samplerate.c
@@ -23,12 +23,12 @@
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_rate.h>
 
+typedef float float_t;
+
 struct rate_src {
 	double ratio;
 	int converter;
 	unsigned int channels;
-	float *src_buf;
-	float *dst_buf;
 	SRC_STATE *state;
 	SRC_DATA data;
 };
@@ -53,9 +53,6 @@ static void pcm_src_free(void *obj)
 {
 	struct rate_src *rate = obj;
 
-	free(rate->src_buf);
-	free(rate->dst_buf);
-	rate->src_buf = rate->dst_buf = NULL;
 
 	if (rate->state) {
 		src_delete(rate->state);
@@ -79,17 +76,6 @@ static int pcm_src_init(void *obj, snd_pcm_rate_info_t *info)
 
 	rate->ratio = (double)info->out.rate / (double)info->in.rate;
 
-	free(rate->src_buf);
-	rate->src_buf = malloc(sizeof(float) * rate->channels * info->in.period_size);
-	free(rate->dst_buf);
-	rate->dst_buf = malloc(sizeof(float) * rate->channels * info->out.period_size);
-	if (! rate->src_buf || ! rate->dst_buf) {
-		pcm_src_free(rate);
-		return -ENOMEM;
-	}
-
-	rate->data.data_in = rate->src_buf;
-	rate->data.data_out = rate->dst_buf;
 	rate->data.src_ratio = rate->ratio;
 	rate->data.end_of_input = 0;
 
@@ -112,8 +98,8 @@ static void pcm_src_reset(void *obj)
 	src_reset(rate->state);
 }
 
-static void pcm_src_convert_s16(void *obj, int16_t *dst, unsigned int dst_frames,
-				const int16_t *src, unsigned int src_frames)
+static void pcm_src_convert_float(void *obj, float_t *dst, unsigned int dst_frames,
+				const float_t *src, unsigned int src_frames)
 {
 	struct rate_src *rate = obj;
 	unsigned int ofs;
@@ -121,15 +107,17 @@ static void pcm_src_convert_s16(void *obj, int16_t *dst, unsigned int dst_frames
 	rate->data.input_frames = src_frames;
 	rate->data.output_frames = dst_frames;
 	rate->data.end_of_input = 0;
+	rate->data.data_in = src;
+	rate->data.data_out = dst;
+
 	
-	src_short_to_float_array(src, rate->src_buf, src_frames * rate->channels);
 	src_process(rate->state, &rate->data);
 	if (rate->data.output_frames_gen < dst_frames)
 		ofs = dst_frames - rate->data.output_frames_gen;
 	else
 		ofs = 0;
-	src_float_to_short_array(rate->dst_buf, dst + ofs * rate->channels,
-				 rate->data.output_frames_gen * rate->channels);
+	/*src_float_to_short_array(rate->dst_buf, dst + ofs * rate->channels,
+				 rate->data.output_frames_gen * rate->channels); */
 }
 
 static void pcm_src_close(void *obj)
@@ -157,7 +145,7 @@ static snd_pcm_rate_ops_t pcm_src_ops = {
 	.free = pcm_src_free,
 	.reset = pcm_src_reset,
 	.adjust_pitch = pcm_src_adjust_pitch,
-	.convert_s16 = pcm_src_convert_s16,
+	.convert_float = pcm_src_convert_float,
 	.input_frames = input_frames,
 	.output_frames = output_frames,
 #if SND_PCM_RATE_PLUGIN_VERSION >= 0x010002
-- 
1.7.0.4


--------------98EB5B18299C866D35CFD7F6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------98EB5B18299C866D35CFD7F6--
