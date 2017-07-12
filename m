From: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH - alsa-lib 2/2] cleanup: Use uint*_t instead of
	u_int*_t everythwere
Date: Wed, 12 Jul 2017 10:45:19 +0200
Message-ID: <20170712084519.11389-2-ncopa@alpinelinux.org>
References: <20170712084519.11389-1-ncopa@alpinelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170712084519.11389-1-ncopa@alpinelinux.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Natanael Copa <ncopa@alpinelinux.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the standard uint{8,16,32,64}_t everywhere instead of the
non-standard u_int{8,16,32,64}_t.

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>

diff --git a/include/pcm.h b/include/pcm.h
index 0be1a321..d4f15433 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -1108,10 +1108,10 @@ int snd_pcm_format_width(snd_pcm_format_t format);			/* in bits */
 int snd_pcm_format_physical_width(snd_pcm_format_t format);		/* in bits */
 snd_pcm_format_t snd_pcm_build_linear_format(int width, int pwidth, int unsignd, int big_endian);
 ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples);
-u_int8_t snd_pcm_format_silence(snd_pcm_format_t format);
-u_int16_t snd_pcm_format_silence_16(snd_pcm_format_t format);
-u_int32_t snd_pcm_format_silence_32(snd_pcm_format_t format);
-u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format);
+uint8_t snd_pcm_format_silence(snd_pcm_format_t format);
+uint16_t snd_pcm_format_silence_16(snd_pcm_format_t format);
+uint32_t snd_pcm_format_silence_32(snd_pcm_format_t format);
+uint64_t snd_pcm_format_silence_64(snd_pcm_format_t format);
 int snd_pcm_format_set_silence(snd_pcm_format_t format, void *buf, unsigned int samples);
 
 snd_pcm_sframes_t snd_pcm_bytes_to_frames(snd_pcm_t *pcm, ssize_t bytes);
diff --git a/include/type_compat.h b/include/type_compat.h
index 0c10aed7..35973b1e 100644
--- a/include/type_compat.h
+++ b/include/type_compat.h
@@ -47,18 +47,6 @@
 #ifndef __le64
 #define __le64	uint64_t
 #endif
-#ifndef u_int8_t
-#define u_int8_t	uint8_t
-#endif
-#ifndef u_int16_t
-#define u_int16_t	uint16_t
-#endif
-#ifndef u_int32_t
-#define u_int32_t	uint32_t
-#endif
-#ifndef u_int32_t
-#define u_int32_t	uint64_t
-#endif
 #ifndef __kernel_pid_t
 #define __kernel_pid_t	pid_t
 #endif
diff --git a/src/pcm/interval.c b/src/pcm/interval.c
index 6e398084..74ec3204 100644
--- a/src/pcm/interval.c
+++ b/src/pcm/interval.c
@@ -26,7 +26,7 @@
 #include <limits.h>
 #include "pcm_local.h"
 
-static inline void div64_32(u_int64_t *n, u_int32_t d, u_int32_t *rem)
+static inline void div64_32(uint64_t *n, uint32_t d, uint32_t *rem)
 {
 	*rem = *n % d;
 	*n /= d;
@@ -88,7 +88,7 @@ static inline unsigned int sub(unsigned int a, unsigned int b)
 static inline unsigned int muldiv32(unsigned int a, unsigned int b,
 				    unsigned int c, unsigned int *r)
 {
-	u_int64_t n = (u_int64_t) a * b;
+	uint64_t n = (uint64_t) a * b;
 	if (c == 0) {
 		assert(n > 0);
 		*r = 0;
diff --git a/src/pcm/mask_inline.h b/src/pcm/mask_inline.h
index f656568d..04c7ee6e 100644
--- a/src/pcm/mask_inline.h
+++ b/src/pcm/mask_inline.h
@@ -29,7 +29,7 @@
 #define MASK_OFS(i)	((i) >> 5)
 #define MASK_BIT(i)	(1U << ((i) & 31))
 
-MASK_INLINE unsigned int ld2(u_int32_t v)
+MASK_INLINE unsigned int ld2(uint32_t v)
 {
         unsigned r = 0;
 
@@ -54,7 +54,7 @@ MASK_INLINE unsigned int ld2(u_int32_t v)
         return r;
 }
 
-MASK_INLINE unsigned int hweight32(u_int32_t v)
+MASK_INLINE unsigned int hweight32(uint32_t v)
 {
         v = (v & 0x55555555) + ((v >> 1) & 0x55555555);
         v = (v & 0x33333333) + ((v >> 2) & 0x33333333);
@@ -75,7 +75,7 @@ MASK_INLINE void snd_mask_none(snd_mask_t *mask)
 
 MASK_INLINE void snd_mask_any(snd_mask_t *mask)
 {
-	memset(mask, 0xff, MASK_SIZE * sizeof(u_int32_t));
+	memset(mask, 0xff, MASK_SIZE * sizeof(uint32_t));
 }
 
 MASK_INLINE int snd_mask_empty(const snd_mask_t *mask)
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 2b4ce8ec..fc7bd52c 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -2894,7 +2894,7 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
 	char *dst;
 	unsigned int dst_step;
 	int width;
-	u_int64_t silence;
+	uint64_t silence;
 	if (!dst_area->addr)
 		return 0;
 	dst = snd_pcm_channel_area_addr(dst_area, dst_offset);
@@ -2902,7 +2902,7 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
 	silence = snd_pcm_format_silence_64(format);
 	if (dst_area->step == (unsigned int) width) {
 		unsigned int dwords = samples * width / 64;
-		u_int64_t *dstp = (u_int64_t *)dst;
+		uint64_t *dstp = (uint64_t *)dst;
 		samples -= dwords * 64 / width;
 		while (dwords-- > 0)
 			*dstp++ = silence;
@@ -2912,8 +2912,8 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
 	dst_step = dst_area->step / 8;
 	switch (width) {
 	case 4: {
-		u_int8_t s0 = silence & 0xf0;
-		u_int8_t s1 = silence & 0x0f;
+		uint8_t s0 = silence & 0xf0;
+		uint8_t s1 = silence & 0x0f;
 		int dstbit = dst_area->first % 8;
 		int dstbit_step = dst_area->step % 8;
 		while (samples-- > 0) {
@@ -2934,7 +2934,7 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
 		break;
 	}
 	case 8: {
-		u_int8_t sil = silence;
+		uint8_t sil = silence;
 		while (samples-- > 0) {
 			*dst = sil;
 			dst += dst_step;
@@ -2942,9 +2942,9 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
 		break;
 	}
 	case 16: {
-		u_int16_t sil = silence;
+		uint16_t sil = silence;
 		while (samples-- > 0) {
-			*(u_int16_t*)dst = sil;
+			*(uint16_t*)dst = sil;
 			dst += dst_step;
 		}
 		break;
@@ -2961,16 +2961,16 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
 #endif
 		break;
 	case 32: {
-		u_int32_t sil = silence;
+		uint32_t sil = silence;
 		while (samples-- > 0) {
-			*(u_int32_t*)dst = sil;
+			*(uint32_t*)dst = sil;
 			dst += dst_step;
 		}
 		break;
 	}
 	case 64: {
 		while (samples-- > 0) {
-			*(u_int64_t*)dst = silence;
+			*(uint64_t*)dst = silence;
 			dst += dst_step;
 		}
 		break;
@@ -3114,7 +3114,7 @@ int snd_pcm_area_copy(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes_t
 	}
 	case 16: {
 		while (samples-- > 0) {
-			*(u_int16_t*)dst = *(const u_int16_t*)src;
+			*(uint16_t*)dst = *(const uint16_t*)src;
 			src += src_step;
 			dst += dst_step;
 		}
@@ -3131,7 +3131,7 @@ int snd_pcm_area_copy(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes_t
 		break;
 	case 32: {
 		while (samples-- > 0) {
-			*(u_int32_t*)dst = *(const u_int32_t*)src;
+			*(uint32_t*)dst = *(const uint32_t*)src;
 			src += src_step;
 			dst += dst_step;
 		}
@@ -3139,7 +3139,7 @@ int snd_pcm_area_copy(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes_t
 	}
 	case 64: {
 		while (samples-- > 0) {
-			*(u_int64_t*)dst = *(const u_int64_t*)src;
+			*(uint64_t*)dst = *(const uint64_t*)src;
 			src += src_step;
 			dst += dst_step;
 		}
diff --git a/src/pcm/pcm_iec958.c b/src/pcm/pcm_iec958.c
index 86ac9cfd..115092de 100644
--- a/src/pcm/pcm_iec958.c
+++ b/src/pcm/pcm_iec958.c
@@ -102,7 +102,7 @@ static unsigned int iec958_parity(unsigned int data)
  *     31   = parity
  */
 
-static inline u_int32_t iec958_subframe(snd_pcm_iec958_t *iec, u_int32_t data, int channel)
+static inline uint32_t iec958_subframe(snd_pcm_iec958_t *iec, uint32_t data, int channel)
 {
 	unsigned int byte = iec->counter >> 3;
 	unsigned int mask = 1 << (iec->counter - (byte << 3));
@@ -132,7 +132,7 @@ static inline u_int32_t iec958_subframe(snd_pcm_iec958_t *iec, u_int32_t data, i
 	return data;
 }
 
-static inline int32_t iec958_to_s32(snd_pcm_iec958_t *iec, u_int32_t data)
+static inline int32_t iec958_to_s32(snd_pcm_iec958_t *iec, uint32_t data)
 {
 	if (iec->byteswap)
 		data = bswap_32(data);
@@ -155,7 +155,7 @@ static void snd_pcm_iec958_decode(snd_pcm_iec958_t *iec,
 	void *put = put32_labels[iec->getput_idx];
 	unsigned int channel;
 	for (channel = 0; channel < channels; ++channel) {
-		const u_int32_t *src;
+		const uint32_t *src;
 		char *dst;
 		int src_step, dst_step;
 		snd_pcm_uframes_t frames1;
@@ -163,7 +163,7 @@ static void snd_pcm_iec958_decode(snd_pcm_iec958_t *iec,
 		const snd_pcm_channel_area_t *dst_area = &dst_areas[channel];
 		src = snd_pcm_channel_area_addr(src_area, src_offset);
 		dst = snd_pcm_channel_area_addr(dst_area, dst_offset);
-		src_step = snd_pcm_channel_area_step(src_area) / sizeof(u_int32_t);
+		src_step = snd_pcm_channel_area_step(src_area) / sizeof(uint32_t);
 		dst_step = snd_pcm_channel_area_step(dst_area);
 		frames1 = frames;
 		while (frames1-- > 0) {
@@ -195,7 +195,7 @@ static void snd_pcm_iec958_encode(snd_pcm_iec958_t *iec,
 	int counter = iec->counter;
 	for (channel = 0; channel < channels; ++channel) {
 		const char *src;
-		u_int32_t *dst;
+		uint32_t *dst;
 		int src_step, dst_step;
 		snd_pcm_uframes_t frames1;
 		const snd_pcm_channel_area_t *src_area = &src_areas[channel];
@@ -203,7 +203,7 @@ static void snd_pcm_iec958_encode(snd_pcm_iec958_t *iec,
 		src = snd_pcm_channel_area_addr(src_area, src_offset);
 		dst = snd_pcm_channel_area_addr(dst_area, dst_offset);
 		src_step = snd_pcm_channel_area_step(src_area);
-		dst_step = snd_pcm_channel_area_step(dst_area) / sizeof(u_int32_t);
+		dst_step = snd_pcm_channel_area_step(dst_area) / sizeof(uint32_t);
 		frames1 = frames;
 		iec->counter = counter;
 		while (frames1-- > 0) {
diff --git a/src/pcm/pcm_linear.c b/src/pcm/pcm_linear.c
index 50df7794..9b1d9638 100644
--- a/src/pcm/pcm_linear.c
+++ b/src/pcm/pcm_linear.c
@@ -183,7 +183,7 @@ void snd_pcm_linear_getput(const snd_pcm_channel_area_t *dst_areas, snd_pcm_ufra
 	void *get = get32_labels[get_idx];
 	void *put = put32_labels[put_idx];
 	unsigned int channel;
-	u_int32_t sample = 0;
+	uint32_t sample = 0;
 	for (channel = 0; channel < channels; ++channel) {
 		const char *src;
 		char *dst;
diff --git a/src/pcm/pcm_misc.c b/src/pcm/pcm_misc.c
index 7d2b05db..a321c87e 100644
--- a/src/pcm/pcm_misc.c
+++ b/src/pcm/pcm_misc.c
@@ -387,7 +387,7 @@ ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples)
  * \param format Sample format
  * \return silence 64 bit word
  */
-u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
+uint64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 {
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S8:
@@ -467,7 +467,7 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	{
 		union {
 			float f[2];
-			u_int64_t i;
+			uint64_t i;
 		} u;
 		u.f[0] = u.f[1] = 0.0;
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -480,7 +480,7 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	{
 		union {
 			double f;
-			u_int64_t i;
+			uint64_t i;
 		} u;
 		u.f = 0.0;
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -493,7 +493,7 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	{
 		union {
 			float f[2];
-			u_int64_t i;
+			uint64_t i;
 		} u;
 		u.f[0] = u.f[1] = 0.0;
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -506,7 +506,7 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	{
 		union {
 			double f;
-			u_int64_t i;
+			uint64_t i;
 		} u;
 		u.f = 0.0;
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -539,10 +539,10 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
  * \param format Sample format
  * \return silence 32 bit word
  */
-u_int32_t snd_pcm_format_silence_32(snd_pcm_format_t format)
+uint32_t snd_pcm_format_silence_32(snd_pcm_format_t format)
 {
 	assert(snd_pcm_format_physical_width(format) <= 32);
-	return (u_int32_t)snd_pcm_format_silence_64(format);
+	return (uint32_t)snd_pcm_format_silence_64(format);
 }
 
 /**
@@ -550,10 +550,10 @@ u_int32_t snd_pcm_format_silence_32(snd_pcm_format_t format)
  * \param format Sample format
  * \return silence 16 bit word
  */
-u_int16_t snd_pcm_format_silence_16(snd_pcm_format_t format)
+uint16_t snd_pcm_format_silence_16(snd_pcm_format_t format)
 {
 	assert(snd_pcm_format_physical_width(format) <= 16);
-	return (u_int16_t)snd_pcm_format_silence_64(format);
+	return (uint16_t)snd_pcm_format_silence_64(format);
 }
 
 /**
@@ -561,10 +561,10 @@ u_int16_t snd_pcm_format_silence_16(snd_pcm_format_t format)
  * \param format Sample format
  * \return silence 8 bit word
  */
-u_int8_t snd_pcm_format_silence(snd_pcm_format_t format)
+uint8_t snd_pcm_format_silence(snd_pcm_format_t format)
 {
 	assert(snd_pcm_format_physical_width(format) <= 8);
-	return (u_int8_t)snd_pcm_format_silence_64(format);
+	return (uint8_t)snd_pcm_format_silence_64(format);
 }
 
 /**
@@ -580,7 +580,7 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		return 0;
 	switch (snd_pcm_format_physical_width(format)) {
 	case 4: {
-		u_int8_t silence = snd_pcm_format_silence_64(format);
+		uint8_t silence = snd_pcm_format_silence_64(format);
 		unsigned int samples1;
 		if (samples % 2 != 0)
 			return -EINVAL;
@@ -589,13 +589,13 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		break;
 	}
 	case 8: {
-		u_int8_t silence = snd_pcm_format_silence_64(format);
+		uint8_t silence = snd_pcm_format_silence_64(format);
 		memset(data, silence, samples);
 		break;
 	}
 	case 16: {
-		u_int16_t silence = snd_pcm_format_silence_64(format);
-		u_int16_t *pdata = (u_int16_t *)data;
+		uint16_t silence = snd_pcm_format_silence_64(format);
+		uint16_t *pdata = (uint16_t *)data;
 		if (! silence)
 			memset(data, 0, samples * 2);
 		else {
@@ -605,8 +605,8 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		break;
 	}
 	case 24: {
-		u_int32_t silence = snd_pcm_format_silence_64(format);
-		u_int8_t *pdata = (u_int8_t *)data;
+		uint32_t silence = snd_pcm_format_silence_64(format);
+		uint8_t *pdata = (uint8_t *)data;
 		if (! silence)
 			memset(data, 0, samples * 3);
 		else {
@@ -625,8 +625,8 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		break;
 	}
 	case 32: {
-		u_int32_t silence = snd_pcm_format_silence_64(format);
-		u_int32_t *pdata = (u_int32_t *)data;
+		uint32_t silence = snd_pcm_format_silence_64(format);
+		uint32_t *pdata = (uint32_t *)data;
 		if (! silence)
 			memset(data, 0, samples * 4);
 		else {
@@ -636,8 +636,8 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		break;
 	}
 	case 64: {
-		u_int64_t silence = snd_pcm_format_silence_64(format);
-		u_int64_t *pdata = (u_int64_t *)data;
+		uint64_t silence = snd_pcm_format_silence_64(format);
+		uint64_t *pdata = (uint64_t *)data;
 		if (! silence)
 			memset(data, 0, samples * 8);
 		else {
diff --git a/src/pcm/pcm_rate_linear.c b/src/pcm/pcm_rate_linear.c
index 70399e0d..b20c715a 100644
--- a/src/pcm/pcm_rate_linear.c
+++ b/src/pcm/pcm_rate_linear.c
@@ -346,7 +346,7 @@ static int linear_init(void *obj, snd_pcm_rate_info_t *info)
 			rate->func = linear_shrink;
 		/* pitch is get_increment */
 	}
-	rate->pitch = (((u_int64_t)info->out.rate * LINEAR_DIV) +
+	rate->pitch = (((uint64_t)info->out.rate * LINEAR_DIV) +
 		       (info->in.rate / 2)) / info->in.rate;
 	rate->channels = info->channels;
 
@@ -363,7 +363,7 @@ static int linear_adjust_pitch(void *obj, snd_pcm_rate_info_t *info)
 	struct rate_linear *rate = obj;
 	snd_pcm_uframes_t cframes;
 
-	rate->pitch = (((u_int64_t)info->out.period_size * LINEAR_DIV) +
+	rate->pitch = (((uint64_t)info->out.period_size * LINEAR_DIV) +
 		       (info->in.period_size/2) ) / info->in.period_size;
 			
 	cframes = input_frames(rate, info->out.period_size);
diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 508d5b0f..1bb83d2f 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -190,7 +190,7 @@ static void snd_pcm_route_convert1_one_getput(const snd_pcm_channel_area_t *dst_
 	const char *src;
 	char *dst;
 	int src_step, dst_step;
-	u_int32_t sample = 0;
+	uint32_t sample = 0;
 	for (srcidx = 0; srcidx < ttable->nsrcs && srcidx < src_channels; ++srcidx) {
 		unsigned int channel = ttable->srcs[srcidx].channel;
 		if (channel >= src_channels)
diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
index eb8c2c4f..69e7f2cf 100644
--- a/src/pcm/plugin_ops.h
+++ b/src/pcm/plugin_ops.h
@@ -21,13 +21,13 @@
 
 #ifndef SX_INLINES
 #define SX_INLINES
-static inline u_int32_t sx24(u_int32_t x)
+static inline uint32_t sx24(uint32_t x)
 {
 	if(x&0x00800000)
 		return x|0xFF000000;
 	return x&0x00FFFFFF;
 }
-static inline u_int32_t sx24s(u_int32_t x)
+static inline uint32_t sx24s(uint32_t x)
 {
 	if(x&0x00008000)
 		return x|0x000000FF;
@@ -35,10 +35,10 @@ static inline u_int32_t sx24s(u_int32_t x)
 }
 #endif
 
-#define as_u8(ptr) (*(u_int8_t*)(ptr))
-#define as_u16(ptr) (*(u_int16_t*)(ptr))
-#define as_u32(ptr) (*(u_int32_t*)(ptr))
-#define as_u64(ptr) (*(u_int64_t*)(ptr))
+#define as_u8(ptr) (*(uint8_t*)(ptr))
+#define as_u16(ptr) (*(uint16_t*)(ptr))
+#define as_u32(ptr) (*(uint32_t*)(ptr))
+#define as_u64(ptr) (*(uint64_t*)(ptr))
 #define as_s8(ptr) (*(int8_t*)(ptr))
 #define as_s16(ptr) (*(int16_t*)(ptr))
 #define as_s32(ptr) (*(int32_t*)(ptr))
@@ -46,10 +46,10 @@ static inline u_int32_t sx24s(u_int32_t x)
 #define as_float(ptr) (*(float_t*)(ptr))
 #define as_double(ptr) (*(double_t*)(ptr))
 
-#define as_u8c(ptr) (*(const u_int8_t*)(ptr))
-#define as_u16c(ptr) (*(const u_int16_t*)(ptr))
-#define as_u32c(ptr) (*(const u_int32_t*)(ptr))
-#define as_u64c(ptr) (*(const u_int64_t*)(ptr))
+#define as_u8c(ptr) (*(const uint8_t*)(ptr))
+#define as_u16c(ptr) (*(const uint16_t*)(ptr))
+#define as_u32c(ptr) (*(const uint32_t*)(ptr))
+#define as_u64c(ptr) (*(const uint64_t*)(ptr))
 #define as_s8c(ptr) (*(const int8_t*)(ptr))
 #define as_s16c(ptr) (*(const int16_t*)(ptr))
 #define as_s32c(ptr) (*(const int32_t*)(ptr))
@@ -57,18 +57,18 @@ static inline u_int32_t sx24s(u_int32_t x)
 #define as_floatc(ptr) (*(const float_t*)(ptr))
 #define as_doublec(ptr) (*(const double_t*)(ptr))
 
-#define _get_triple_le(ptr) (*(u_int8_t*)(ptr) | (u_int32_t)*((u_int8_t*)(ptr) + 1) << 8 | (u_int32_t)*((u_int8_t*)(ptr) + 2) << 16)
-#define _get_triple_be(ptr) ((u_int32_t)*(u_int8_t*)(ptr) << 16 | (u_int32_t)*((u_int8_t*)(ptr) + 1) << 8 | *((u_int8_t*)(ptr) + 2))
+#define _get_triple_le(ptr) (*(uint8_t*)(ptr) | (uint32_t)*((uint8_t*)(ptr) + 1) << 8 | (uint32_t)*((uint8_t*)(ptr) + 2) << 16)
+#define _get_triple_be(ptr) ((uint32_t)*(uint8_t*)(ptr) << 16 | (uint32_t)*((uint8_t*)(ptr) + 1) << 8 | *((uint8_t*)(ptr) + 2))
 #define _put_triple_le(ptr,val) do { \
-	u_int8_t *_tmp = (u_int8_t *)(ptr); \
-	u_int32_t _val = (val); \
+	uint8_t *_tmp = (uint8_t *)(ptr); \
+	uint32_t _val = (val); \
 	_tmp[0] = _val; \
 	_tmp[1] = _val >> 8; \
 	_tmp[2] = _val >> 16; \
 } while(0)
 #define _put_triple_be(ptr,val) do { \
-	u_int8_t *_tmp = (u_int8_t *)(ptr); \
-	u_int32_t _val = (val); \
+	uint8_t *_tmp = (uint8_t *)(ptr); \
+	uint32_t _val = (val); \
 	_tmp[0] = _val >> 16; \
 	_tmp[1] = _val >> 8; \
 	_tmp[2] = _val; \
@@ -243,45 +243,45 @@ static void *const conv_labels[4 * 2 * 2 * 4 * 2] = {
 #ifdef CONV_END
 while(0) {
 conv_xxx1_xxx1: as_u8(dst) = as_u8c(src); goto CONV_END;
-conv_xxx1_xx10: as_u16(dst) = (u_int16_t)as_u8c(src) << 8; goto CONV_END;
-conv_xxx1_xx01: as_u16(dst) = (u_int16_t)as_u8c(src); goto CONV_END;
-conv_xxx1_x100: as_u32(dst) = sx24((u_int32_t)as_u8c(src) << 16); goto CONV_END;
-conv_xxx1_001x: as_u32(dst) = sx24s((u_int32_t)as_u8c(src) << 8); goto CONV_END;
-conv_xxx1_1000: as_u32(dst) = (u_int32_t)as_u8c(src) << 24; goto CONV_END;
-conv_xxx1_0001: as_u32(dst) = (u_int32_t)as_u8c(src); goto CONV_END;
+conv_xxx1_xx10: as_u16(dst) = (uint16_t)as_u8c(src) << 8; goto CONV_END;
+conv_xxx1_xx01: as_u16(dst) = (uint16_t)as_u8c(src); goto CONV_END;
+conv_xxx1_x100: as_u32(dst) = sx24((uint32_t)as_u8c(src) << 16); goto CONV_END;
+conv_xxx1_001x: as_u32(dst) = sx24s((uint32_t)as_u8c(src) << 8); goto CONV_END;
+conv_xxx1_1000: as_u32(dst) = (uint32_t)as_u8c(src) << 24; goto CONV_END;
+conv_xxx1_0001: as_u32(dst) = (uint32_t)as_u8c(src); goto CONV_END;
 conv_xxx1_xxx9: as_u8(dst) = as_u8c(src) ^ 0x80; goto CONV_END;
-conv_xxx1_xx90: as_u16(dst) = (u_int16_t)(as_u8c(src) ^ 0x80) << 8; goto CONV_END;
-conv_xxx1_xx09: as_u16(dst) = (u_int16_t)(as_u8c(src) ^ 0x80); goto CONV_END;
-conv_xxx1_x900: as_u32(dst) = sx24((u_int32_t)(as_u8c(src) ^ 0x80) << 16); goto CONV_END;
-conv_xxx1_009x: as_u32(dst) = sx24s((u_int32_t)(as_u8c(src) ^ 0x80) << 8); goto CONV_END;
-conv_xxx1_9000: as_u32(dst) = (u_int32_t)(as_u8c(src) ^ 0x80) << 24; goto CONV_END;
-conv_xxx1_0009: as_u32(dst) = (u_int32_t)(as_u8c(src) ^ 0x80); goto CONV_END;
+conv_xxx1_xx90: as_u16(dst) = (uint16_t)(as_u8c(src) ^ 0x80) << 8; goto CONV_END;
+conv_xxx1_xx09: as_u16(dst) = (uint16_t)(as_u8c(src) ^ 0x80); goto CONV_END;
+conv_xxx1_x900: as_u32(dst) = sx24((uint32_t)(as_u8c(src) ^ 0x80) << 16); goto CONV_END;
+conv_xxx1_009x: as_u32(dst) = sx24s((uint32_t)(as_u8c(src) ^ 0x80) << 8); goto CONV_END;
+conv_xxx1_9000: as_u32(dst) = (uint32_t)(as_u8c(src) ^ 0x80) << 24; goto CONV_END;
+conv_xxx1_0009: as_u32(dst) = (uint32_t)(as_u8c(src) ^ 0x80); goto CONV_END;
 conv_xx12_xxx1: as_u8(dst) = as_u16c(src) >> 8; goto CONV_END;
 conv_xx12_xx12: as_u16(dst) = as_u16c(src); goto CONV_END;
 conv_xx12_xx21: as_u16(dst) = bswap_16(as_u16c(src)); goto CONV_END;
-conv_xx12_x120: as_u32(dst) = sx24((u_int32_t)as_u16c(src) << 8); goto CONV_END;
-conv_xx12_021x: as_u32(dst) = sx24s((u_int32_t)bswap_16(as_u16c(src)) << 8); goto CONV_END;
-conv_xx12_1200: as_u32(dst) = (u_int32_t)as_u16c(src) << 16; goto CONV_END;
-conv_xx12_0021: as_u32(dst) = (u_int32_t)bswap_16(as_u16c(src)); goto CONV_END;
+conv_xx12_x120: as_u32(dst) = sx24((uint32_t)as_u16c(src) << 8); goto CONV_END;
+conv_xx12_021x: as_u32(dst) = sx24s((uint32_t)bswap_16(as_u16c(src)) << 8); goto CONV_END;
+conv_xx12_1200: as_u32(dst) = (uint32_t)as_u16c(src) << 16; goto CONV_END;
+conv_xx12_0021: as_u32(dst) = (uint32_t)bswap_16(as_u16c(src)); goto CONV_END;
 conv_xx12_xxx9: as_u8(dst) = (as_u16c(src) >> 8) ^ 0x80; goto CONV_END;
 conv_xx12_xx92: as_u16(dst) = as_u16c(src) ^ 0x8000; goto CONV_END;
 conv_xx12_xx29: as_u16(dst) = bswap_16(as_u16c(src)) ^ 0x80; goto CONV_END;
-conv_xx12_x920: as_u32(dst) = sx24((u_int32_t)(as_u16c(src) ^ 0x8000) << 8); goto CONV_END;
-conv_xx12_029x: as_u32(dst) = sx24s((u_int32_t)(bswap_16(as_u16c(src)) ^ 0x80) << 8); goto CONV_END;
-conv_xx12_9200: as_u32(dst) = (u_int32_t)(as_u16c(src) ^ 0x8000) << 16; goto CONV_END;
-conv_xx12_0029: as_u32(dst) = (u_int32_t)(bswap_16(as_u16c(src)) ^ 0x80); goto CONV_END;
+conv_xx12_x920: as_u32(dst) = sx24((uint32_t)(as_u16c(src) ^ 0x8000) << 8); goto CONV_END;
+conv_xx12_029x: as_u32(dst) = sx24s((uint32_t)(bswap_16(as_u16c(src)) ^ 0x80) << 8); goto CONV_END;
+conv_xx12_9200: as_u32(dst) = (uint32_t)(as_u16c(src) ^ 0x8000) << 16; goto CONV_END;
+conv_xx12_0029: as_u32(dst) = (uint32_t)(bswap_16(as_u16c(src)) ^ 0x80); goto CONV_END;
 conv_xx12_xxx2: as_u8(dst) = as_u16c(src) & 0xff; goto CONV_END;
-conv_xx12_x210: as_u32(dst) = sx24((u_int32_t)bswap_16(as_u16c(src)) << 8); goto CONV_END;
-conv_xx12_012x: as_u32(dst) = sx24s((u_int32_t)as_u16c(src) << 8); goto CONV_END;
-conv_xx12_2100: as_u32(dst) = (u_int32_t)bswap_16(as_u16c(src)) << 16; goto CONV_END;
-conv_xx12_0012: as_u32(dst) = (u_int32_t)as_u16c(src); goto CONV_END; 
+conv_xx12_x210: as_u32(dst) = sx24((uint32_t)bswap_16(as_u16c(src)) << 8); goto CONV_END;
+conv_xx12_012x: as_u32(dst) = sx24s((uint32_t)as_u16c(src) << 8); goto CONV_END;
+conv_xx12_2100: as_u32(dst) = (uint32_t)bswap_16(as_u16c(src)) << 16; goto CONV_END;
+conv_xx12_0012: as_u32(dst) = (uint32_t)as_u16c(src); goto CONV_END; 
 conv_xx12_xxxA: as_u8(dst) = (as_u16c(src) ^ 0x80) & 0xff; goto CONV_END;
 conv_xx12_xxA1: as_u16(dst) = bswap_16(as_u16c(src) ^ 0x80); goto CONV_END;
 conv_xx12_xx1A: as_u16(dst) = as_u16c(src) ^ 0x80; goto CONV_END;
-conv_xx12_xA10: as_u32(dst) = sx24((u_int32_t)bswap_16(as_u16c(src) ^ 0x80) << 8); goto CONV_END;
-conv_xx12_01Ax: as_u32(dst) = sx24s((u_int32_t)(as_u16c(src) ^ 0x80) << 8); goto CONV_END;
-conv_xx12_A100: as_u32(dst) = (u_int32_t)bswap_16(as_u16c(src) ^ 0x80) << 16; goto CONV_END;
-conv_xx12_001A: as_u32(dst) = (u_int32_t)(as_u16c(src) ^ 0x80); goto CONV_END;
+conv_xx12_xA10: as_u32(dst) = sx24((uint32_t)bswap_16(as_u16c(src) ^ 0x80) << 8); goto CONV_END;
+conv_xx12_01Ax: as_u32(dst) = sx24s((uint32_t)(as_u16c(src) ^ 0x80) << 8); goto CONV_END;
+conv_xx12_A100: as_u32(dst) = (uint32_t)bswap_16(as_u16c(src) ^ 0x80) << 16; goto CONV_END;
+conv_xx12_001A: as_u32(dst) = (uint32_t)(as_u16c(src) ^ 0x80); goto CONV_END;
 conv_x123_xxx1: as_u8(dst) = as_u32c(src) >> 16; goto CONV_END;
 conv_x123_xx12: as_u16(dst) = as_u32c(src) >> 8; goto CONV_END;
 conv_x123_xx21: as_u16(dst) = bswap_16(as_u32c(src) >> 8); goto CONV_END;
@@ -376,8 +376,8 @@ static void *const get16_labels[4 * 2 * 2 + 4 * 3] = {
 
 #ifdef GET16_END
 while(0) {
-get16_1_10: sample = (u_int16_t)as_u8c(src) << 8; goto GET16_END;
-get16_1_90: sample = (u_int16_t)(as_u8c(src) ^ 0x80) << 8; goto GET16_END;
+get16_1_10: sample = (uint16_t)as_u8c(src) << 8; goto GET16_END;
+get16_1_90: sample = (uint16_t)(as_u8c(src) ^ 0x80) << 8; goto GET16_END;
 get16_12_12: sample = as_u16c(src); goto GET16_END;
 get16_12_92: sample = as_u16c(src) ^ 0x8000; goto GET16_END;
 get16_12_21: sample = bswap_16(as_u16c(src)); goto GET16_END;
@@ -448,26 +448,26 @@ put16_12_12: as_u16(dst) = sample; goto PUT16_END;
 put16_12_92: as_u16(dst) = sample ^ 0x8000; goto PUT16_END;
 put16_12_21: as_u16(dst) = bswap_16(sample); goto PUT16_END;
 put16_12_29: as_u16(dst) = bswap_16(sample) ^ 0x80; goto PUT16_END;
-put16_12_0120: as_u32(dst) = sx24((u_int32_t)sample << 8); goto PUT16_END;
-put16_12_0920: as_u32(dst) = sx24((u_int32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
-put16_12_0210: as_u32(dst) = sx24s((u_int32_t)bswap_16(sample) << 8); goto PUT16_END;
-put16_12_0290: as_u32(dst) = sx24s((u_int32_t)(bswap_16(sample) ^ 0x80) << 8); goto PUT16_END;
-put16_12_1200: as_u32(dst) = (u_int32_t)sample << 16; goto PUT16_END;
-put16_12_9200: as_u32(dst) = (u_int32_t)(sample ^ 0x8000) << 16; goto PUT16_END;
-put16_12_0021: as_u32(dst) = (u_int32_t)bswap_16(sample); goto PUT16_END;
-put16_12_0029: as_u32(dst) = (u_int32_t)bswap_16(sample) ^ 0x80; goto PUT16_END;
-put16_12_120: _put_triple(dst, (u_int32_t)sample << 8); goto PUT16_END;
-put16_12_920: _put_triple(dst, (u_int32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
-put16_12_021: _put_triple_s(dst, (u_int32_t)sample << 8); goto PUT16_END;
-put16_12_029: _put_triple_s(dst, (u_int32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
-put16_12_120_20: _put_triple(dst, (u_int32_t)sample << 4); goto PUT16_END;
-put16_12_920_20: _put_triple(dst, (u_int32_t)(sample ^ 0x8000) << 4); goto PUT16_END;
-put16_12_021_20: _put_triple_s(dst, (u_int32_t)sample << 4); goto PUT16_END;
-put16_12_029_20: _put_triple_s(dst, (u_int32_t)(sample ^ 0x8000) << 4); goto PUT16_END;
-put16_12_120_18: _put_triple(dst, (u_int32_t)sample << 2); goto PUT16_END;
-put16_12_920_18: _put_triple(dst, (u_int32_t)(sample ^ 0x8000) << 2); goto PUT16_END;
-put16_12_021_18: _put_triple_s(dst, (u_int32_t)sample << 2); goto PUT16_END;
-put16_12_029_18: _put_triple_s(dst, (u_int32_t)(sample ^ 0x8000) << 2); goto PUT16_END;
+put16_12_0120: as_u32(dst) = sx24((uint32_t)sample << 8); goto PUT16_END;
+put16_12_0920: as_u32(dst) = sx24((uint32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
+put16_12_0210: as_u32(dst) = sx24s((uint32_t)bswap_16(sample) << 8); goto PUT16_END;
+put16_12_0290: as_u32(dst) = sx24s((uint32_t)(bswap_16(sample) ^ 0x80) << 8); goto PUT16_END;
+put16_12_1200: as_u32(dst) = (uint32_t)sample << 16; goto PUT16_END;
+put16_12_9200: as_u32(dst) = (uint32_t)(sample ^ 0x8000) << 16; goto PUT16_END;
+put16_12_0021: as_u32(dst) = (uint32_t)bswap_16(sample); goto PUT16_END;
+put16_12_0029: as_u32(dst) = (uint32_t)bswap_16(sample) ^ 0x80; goto PUT16_END;
+put16_12_120: _put_triple(dst, (uint32_t)sample << 8); goto PUT16_END;
+put16_12_920: _put_triple(dst, (uint32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
+put16_12_021: _put_triple_s(dst, (uint32_t)sample << 8); goto PUT16_END;
+put16_12_029: _put_triple_s(dst, (uint32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
+put16_12_120_20: _put_triple(dst, (uint32_t)sample << 4); goto PUT16_END;
+put16_12_920_20: _put_triple(dst, (uint32_t)(sample ^ 0x8000) << 4); goto PUT16_END;
+put16_12_021_20: _put_triple_s(dst, (uint32_t)sample << 4); goto PUT16_END;
+put16_12_029_20: _put_triple_s(dst, (uint32_t)(sample ^ 0x8000) << 4); goto PUT16_END;
+put16_12_120_18: _put_triple(dst, (uint32_t)sample << 2); goto PUT16_END;
+put16_12_920_18: _put_triple(dst, (uint32_t)(sample ^ 0x8000) << 2); goto PUT16_END;
+put16_12_021_18: _put_triple_s(dst, (uint32_t)sample << 2); goto PUT16_END;
+put16_12_029_18: _put_triple_s(dst, (uint32_t)(sample ^ 0x8000) << 2); goto PUT16_END;
 }
 #endif
 
@@ -517,12 +517,12 @@ static void *const get32_labels[4 * 2 * 2 + 4 * 3] = {
 
 #ifdef GET32_END
 while (0) {
-get32_1_1000: sample = (u_int32_t)as_u8c(src) << 24; goto GET32_END;
-get32_1_9000: sample = (u_int32_t)(as_u8c(src) ^ 0x80) << 24; goto GET32_END;
-get32_12_1200: sample = (u_int32_t)as_u16c(src) << 16; goto GET32_END;
-get32_12_9200: sample = (u_int32_t)(as_u16c(src) ^ 0x8000) << 16; goto GET32_END;
-get32_12_2100: sample = (u_int32_t)bswap_16(as_u16c(src)) << 16; goto GET32_END;
-get32_12_A100: sample = (u_int32_t)bswap_16(as_u16c(src) ^ 0x80) << 16; goto GET32_END;
+get32_1_1000: sample = (uint32_t)as_u8c(src) << 24; goto GET32_END;
+get32_1_9000: sample = (uint32_t)(as_u8c(src) ^ 0x80) << 24; goto GET32_END;
+get32_12_1200: sample = (uint32_t)as_u16c(src) << 16; goto GET32_END;
+get32_12_9200: sample = (uint32_t)(as_u16c(src) ^ 0x8000) << 16; goto GET32_END;
+get32_12_2100: sample = (uint32_t)bswap_16(as_u16c(src)) << 16; goto GET32_END;
+get32_12_A100: sample = (uint32_t)bswap_16(as_u16c(src) ^ 0x80) << 16; goto GET32_END;
 get32_0123_1230: sample = as_u32c(src) << 8; goto GET32_END;
 get32_0123_9230: sample = (as_u32c(src) << 8) ^ 0x80000000; goto GET32_END;
 get32_1230_3210: sample = bswap_32(as_u32c(src) >> 8); goto GET32_END;
@@ -786,18 +786,18 @@ static inline void _norms(const void *src, void *dst,
 		s += (1U << (dst_wid - 1));
 	switch (dst_wid) {
 	case 8:
-		*(u_int8_t*)dst = s;
+		*(uint8_t*)dst = s;
 		break;
 	case 16:
 		if (dst_end)
 			s = bswap_16(s);
-		*(u_int16_t*)dst = s;
+		*(uint16_t*)dst = s;
 		break;
 	case 24:
 	case 32:
 		if (dst_end)
 			s = bswap_32(s);
-		*(u_int32_t*)dst = s;
+		*(uint32_t*)dst = s;
 		break;
 	}
 	return;
@@ -806,27 +806,27 @@ static inline void _norms(const void *src, void *dst,
 	switch (dst_wid) {
 	case 8:
 		if (dst_sign)
-			*(u_int8_t*)dst = 0x80;
+			*(uint8_t*)dst = 0x80;
 		else
-			*(u_int8_t*)dst = 0;
+			*(uint8_t*)dst = 0;
 		break;
 	case 16:
 		if (dst_sign)
-			*(u_int16_t*)dst = dst_end ? 0x0080 : 0x8000;
+			*(uint16_t*)dst = dst_end ? 0x0080 : 0x8000;
 		else
-			*(u_int16_t*)dst = 0;
+			*(uint16_t*)dst = 0;
 		break;
 	case 24:
 		if (dst_sign)
-			*(u_int32_t*)dst = dst_end ? 0x00008000 : 0x00800000;
+			*(uint32_t*)dst = dst_end ? 0x00008000 : 0x00800000;
 		else
-			*(u_int32_t*)dst = 0;
+			*(uint32_t*)dst = 0;
 		break;
 	case 32:
 		if (dst_sign)
-			*(u_int32_t*)dst = dst_end ? 0x00000080 : 0x80000000;
+			*(uint32_t*)dst = dst_end ? 0x00000080 : 0x80000000;
 		else
-			*(u_int32_t*)dst = 0;
+			*(uint32_t*)dst = 0;
 		break;
 	default:
 		assert(0);
@@ -838,27 +838,27 @@ static inline void _norms(const void *src, void *dst,
 	switch (dst_wid) {
 	case 8:
 		if (dst_sign)
-			*(u_int8_t*)dst = 0x7f;
+			*(uint8_t*)dst = 0x7f;
 		else
-			*(u_int8_t*)dst = 0xff;
+			*(uint8_t*)dst = 0xff;
 		break;
 	case 16:
 		if (dst_sign)
-			*(u_int16_t*)dst = dst_end ? 0xff7f : 0x7fff;
+			*(uint16_t*)dst = dst_end ? 0xff7f : 0x7fff;
 		else
-			*(u_int16_t*)dst = 0;
+			*(uint16_t*)dst = 0;
 		break;
 	case 24:
 		if (dst_sign)
-			*(u_int32_t*)dst = dst_end ? 0xffff7f00 : 0x007fffff;
+			*(uint32_t*)dst = dst_end ? 0xffff7f00 : 0x007fffff;
 		else
-			*(u_int32_t*)dst = 0;
+			*(uint32_t*)dst = 0;
 		break;
 	case 32:
 		if (dst_sign)
-			*(u_int32_t*)dst = dst_end ? 0xffffff7f : 0x7fffffff;
+			*(uint32_t*)dst = dst_end ? 0xffffff7f : 0x7fffffff;
 		else
-			*(u_int32_t*)dst = 0;
+			*(uint32_t*)dst = 0;
 		break;
 	default:
 		assert(0);
-- 
2.13.2
