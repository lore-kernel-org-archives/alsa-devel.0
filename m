From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: alsa-lib rate plugins - float samples - patches
Date: Tue, 28 Jun 2011 09:11:02 +0200
Message-ID: <4E097E86.3020001@ivitera.com>
References: <4DFEF830.6040400@ivitera.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000009060503020103050906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (twistwrist.pilsfree.net [78.108.108.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D15C24430
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 09:11:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 99C5EA1A40B1C
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 09:11:02 +0200 (CEST)
Received: from cable.insite.cz ([10.109.23.231])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jenov7tfyCtH for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 09:11:02 +0200 (CEST)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id 71952A1A32346
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 09:11:02 +0200 (CEST)
In-Reply-To: <4DFEF830.6040400@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000009060503020103050906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dne 20.6.2011 09:35, Pavel Hofman napsal(a):
> Hi,
> 
> This is probably a question for Jaroslav Kysela. The better-quality rate
> plugins offer float resolution, but currently we are deliberately
> loosing information by down-converting to s16 in plugin_rate API
> (convert_s16). In rate_samplerate.c, the samples are up-converted to
> float before calling the libsamplerate API. Speex offers float API too,
> while we are using the int16 one.
> 
> There are two ways to handle this:
> 
> A. Implementing the generic "convert" API function for these plugins,
> handling the sample - float conversion in each plugin individually.
> 
> B. Extending the pcm_rate API (pcm_rate.h) with a new optional function
> convert_float.
> 
> Since the conversion from general sample format to float is not trivial
> (using the plugin_ops.h operations), I would be inclined to suggest the
> extension (well I have it hacked already :-) ). On the other hand, the
> conversion routine can be located in some common code shared by all the
> plugins involved and we could keep the existing API, using the generic
> convert function.

I am attaching preliminary patches. May I ask for help with adding a new
API version number if you find it necessary? I am afraid this is beyond
my skills.

The patches are not checkpatched yet.

After these patches are finished, I would like to work on implementing
the SoX resampler algorithm which features excellent CPU
consumption/resampling quality ratio.

Thanks a lot.

Pavel.

--------------000009060503020103050906
Content-Type: text/x-diff;
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


--------------000009060503020103050906
Content-Type: text/x-diff;
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


--------------000009060503020103050906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000009060503020103050906--
