From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [alsa-lib][PATCH 3/4] pcm: linear,
 route: handle linear formats with 20-bit sample on 4 bytes
Date: Wed, 29 Nov 2017 23:17:11 +0100
Message-ID: <06db78be-2d91-c996-5a5b-d408ff4a84fa@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 15737267960
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 23:17:12 +0100 (CET)
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
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

The previous patch has added 20-bit PCM formats SND_PCM_FORMAT_{S,U}20 to
alsa-lib.
We need to extend the linear format conversion code with handling of these
sample formats so they can also be utilized by applications that only
recognize the more typical ones like SND_PCM_FORMAT_S16.

Since the conversion arrays are indexed by a format bit width divided by 8
the easiest way to handle these formats is to treat them like they were
40-bit wide (the next free integer multiple of 8 bits).
This doesn't create a collision risk with a future format since there can't
really be a 40-bit sample format that occupies 4 bytes.

Make sure we use the getput conversion method for these formats since a
direct conversion from / to them is not supported.

While we are at it let's also add asserts on a format bit width value
in snd_pcm_linear_get_index() and snd_pcm_linear_put_index() received from
snd_pcm_format_width() so we won't try to access memory outside a
conversion array if for some reason this function had returned a value that
is not in the expected range.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 src/pcm/pcm_linear.c | 16 +++++++++++++---
 src/pcm/pcm_route.c  |  6 ++++--
 src/pcm/plugin_ops.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/src/pcm/pcm_linear.c b/src/pcm/pcm_linear.c
index 0d61e927323f..e4973a308004 100644
--- a/src/pcm/pcm_linear.c
+++ b/src/pcm/pcm_linear.c
@@ -90,6 +90,7 @@ int snd_pcm_linear_get_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
 		endian = 0;
 	pwidth = snd_pcm_format_physical_width(src_format);
 	width = snd_pcm_format_width(src_format);
+	assert(width >= 8 && width <= 32);
 	if (pwidth == 24) {
 		switch (width) {
 		case 24:
@@ -100,8 +101,11 @@ int snd_pcm_linear_get_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
 		default:
 			width = 2; break;
 		}
-		return width * 4 + endian * 2 + sign + 16;
+		return width * 4 + endian * 2 + sign + 20;
 	} else {
+		if (width == 20)
+			width = 40;
+
 		width = width / 8 - 1;
 		return width * 4 + endian * 2 + sign;
 	}
@@ -121,6 +125,7 @@ int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
 		endian = 0;
 	pwidth = snd_pcm_format_physical_width(dst_format);
 	width = snd_pcm_format_width(dst_format);
+	assert(width >= 8 && width <= 32);
 	if (pwidth == 24) {
 		switch (width) {
 		case 24:
@@ -131,8 +136,11 @@ int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
 		default:
 			width = 2; break;
 		}
-		return width * 4 + endian * 2 + sign + 16;
+		return width * 4 + endian * 2 + sign + 20;
 	} else {
+		if (width == 20)
+			width = 40;
+
 		width = width / 8 - 1;
 		return width * 4 + endian * 2 + sign;
 	}
@@ -303,7 +311,9 @@ static int snd_pcm_linear_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 	if (err < 0)
 		return err;
 	linear->use_getput = (snd_pcm_format_physical_width(format) == 24 ||
-			      snd_pcm_format_physical_width(linear->sformat) == 24);
+			      snd_pcm_format_physical_width(linear->sformat) == 24 ||
+			      snd_pcm_format_width(format) == 20 ||
+			      snd_pcm_format_width(linear->sformat) == 20);
 	if (linear->use_getput) {
 		if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
 			linear->get_idx = snd_pcm_linear_get_index(format, SND_PCM_FORMAT_S32);
diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 1f485a8e79f9..bbcc6118b593 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -565,10 +565,12 @@ static int snd_pcm_route_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	}
 	if (err < 0)
 		return err;
-	/* 3 bytes formats? */
+	/* 3 bytes or 20-bit formats? */
 	route->params.use_getput =
 		(snd_pcm_format_physical_width(src_format) + 7) / 8 == 3 ||
-		(snd_pcm_format_physical_width(dst_format) + 7) / 8 == 3;
+		(snd_pcm_format_physical_width(dst_format) + 7) / 8 == 3 ||
+		snd_pcm_format_width(src_format) == 20 ||
+		snd_pcm_format_width(dst_format) == 20;
 	route->params.get_idx = snd_pcm_linear_get_index(src_format, SND_PCM_FORMAT_S32);
 	route->params.put_idx = snd_pcm_linear_put_index(SND_PCM_FORMAT_S32, dst_format);
 	route->params.conv_idx = snd_pcm_linear_convert_index(src_format, dst_format);
diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
index 5a6016adb13a..a784d9c2b320 100644
--- a/src/pcm/plugin_ops.h
+++ b/src/pcm/plugin_ops.h
@@ -21,6 +21,12 @@
 
 #ifndef SX_INLINES
 #define SX_INLINES
+static inline uint32_t sx20(uint32_t x)
+{
+	if(x&0x00080000)
+		return x|0xFFF00000;
+	return x&0x000FFFFF;
+}
 static inline uint32_t sx24(uint32_t x)
 {
 	if(x&0x00800000)
@@ -341,7 +347,7 @@ conv_1234_123C: as_u32(dst) = as_u32c(src) ^ 0x80; goto CONV_END;
 
 #ifdef GET16_LABELS
 /* src_wid src_endswap sign_toggle */
-static void *const get16_labels[4 * 2 * 2 + 4 * 3] = {
+static void *const get16_labels[5 * 2 * 2 + 4 * 3] = {
 	&&get16_1_10,	 /*  8h -> 16h */
 	&&get16_1_90,	 /*  8h ^> 16h */
 	&&get16_1_10,	 /*  8s -> 16h */
@@ -350,6 +356,7 @@ static void *const get16_labels[4 * 2 * 2 + 4 * 3] = {
 	&&get16_12_92,	 /* 16h ^> 16h */
 	&&get16_12_21,	 /* 16s -> 16h */
 	&&get16_12_A1,	 /* 16s ^> 16h */
+	/* 4 byte formats */
 	&&get16_0123_12, /* 24h -> 16h */
 	&&get16_0123_92, /* 24h ^> 16h */
 	&&get16_1230_32, /* 24s -> 16h */
@@ -358,6 +365,10 @@ static void *const get16_labels[4 * 2 * 2 + 4 * 3] = {
 	&&get16_1234_92, /* 32h ^> 16h */
 	&&get16_1234_43, /* 32s -> 16h */
 	&&get16_1234_C3, /* 32s ^> 16h */
+	&&get16_0123_12_20, /* 20h -> 16h */
+	&&get16_0123_92_20, /* 20h ^> 16h */
+	&&get16_1230_32_20, /* 20s -> 16h */
+	&&get16_1230_B2_20, /* 20s ^> 16h */
 	/* 3bytes format */
 	&&get16_123_12,	 /* 24h -> 16h */
 	&&get16_123_92,	 /* 24h ^> 16h */
@@ -390,6 +401,10 @@ get16_1234_12: sample = as_u32c(src) >> 16; goto GET16_END;
 get16_1234_92: sample = (as_u32c(src) >> 16) ^ 0x8000; goto GET16_END;
 get16_1234_43: sample = bswap_16(as_u32c(src)); goto GET16_END;
 get16_1234_C3: sample = bswap_16(as_u32c(src) ^ 0x80); goto GET16_END;
+get16_0123_12_20: sample = as_u32c(src) >> 4; goto GET16_END;
+get16_0123_92_20: sample = (as_u32c(src) >> 4) ^ 0x8000; goto GET16_END;
+get16_1230_32_20: sample = bswap_32(as_u32c(src)) >> 4; goto GET16_END;
+get16_1230_B2_20: sample = (bswap_32(as_u32c(src)) >> 4) ^ 0x8000; goto GET16_END;
 get16_123_12: sample = _get_triple(src) >> 8; goto GET16_END;
 get16_123_92: sample = (_get_triple(src) >> 8) ^ 0x8000; goto GET16_END;
 get16_123_32: sample = _get_triple_s(src) >> 8; goto GET16_END;
@@ -407,7 +422,7 @@ get16_123_B2_18: sample = (_get_triple_s(src) >> 2) ^ 0x8000; goto GET16_END;
 
 #ifdef PUT16_LABELS
 /* dst_wid dst_endswap sign_toggle */
-static void *const put16_labels[4 * 2 * 2 + 4 * 3] = {
+static void *const put16_labels[5 * 2 * 2 + 4 * 3] = {
 	&&put16_12_1,		 /* 16h ->  8h */
 	&&put16_12_9,		 /* 16h ^>  8h */
 	&&put16_12_1,		 /* 16h ->  8s */
@@ -416,6 +431,7 @@ static void *const put16_labels[4 * 2 * 2 + 4 * 3] = {
 	&&put16_12_92,		 /* 16h ^> 16h */
 	&&put16_12_21,		 /* 16h -> 16s */
 	&&put16_12_29,		 /* 16h ^> 16s */
+	/* 4 byte formats */
 	&&put16_12_0120,	 /* 16h -> 24h */
 	&&put16_12_0920,	 /* 16h ^> 24h */
 	&&put16_12_0210,	 /* 16h -> 24s */
@@ -424,6 +440,10 @@ static void *const put16_labels[4 * 2 * 2 + 4 * 3] = {
 	&&put16_12_9200,	 /* 16h ^> 32h */
 	&&put16_12_0021,	 /* 16h -> 32s */
 	&&put16_12_0029,	 /* 16h ^> 32s */
+	&&put16_12_0120_20,	 /* 16h -> 20h */
+	&&put16_12_0920_20,	 /* 16h ^> 20h */
+	&&put16_12_0210_20,	 /* 16h -> 20s */
+	&&put16_12_0290_20,	 /* 16h ^> 20s */
 	/* 3bytes format */
 	&&put16_12_120,		 /* 16h -> 24h */
 	&&put16_12_920,		 /* 16h ^> 24h */
@@ -456,6 +476,10 @@ put16_12_1200: as_u32(dst) = (uint32_t)sample << 16; goto PUT16_END;
 put16_12_9200: as_u32(dst) = (uint32_t)(sample ^ 0x8000) << 16; goto PUT16_END;
 put16_12_0021: as_u32(dst) = (uint32_t)bswap_16(sample); goto PUT16_END;
 put16_12_0029: as_u32(dst) = (uint32_t)bswap_16(sample) ^ 0x80; goto PUT16_END;
+put16_12_0120_20: as_u32(dst) = sx20((uint32_t)sample << 4); goto PUT16_END;
+put16_12_0920_20: as_u32(dst) = sx20((uint32_t)(sample ^ 0x8000) << 4); goto PUT16_END;
+put16_12_0210_20: as_u32(dst) = bswap_32(sx20((uint32_t)sample << 4)); goto PUT16_END;
+put16_12_0290_20: as_u32(dst) = bswap_32(sx20((uint32_t)(sample ^ 0x8000) << 4)); goto PUT16_END;
 put16_12_120: _put_triple(dst, (uint32_t)sample << 8); goto PUT16_END;
 put16_12_920: _put_triple(dst, (uint32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
 put16_12_021: _put_triple_s(dst, (uint32_t)sample << 8); goto PUT16_END;
@@ -478,7 +502,7 @@ put16_12_029_18: _put_triple_s(dst, (uint32_t)(sample ^ 0x8000) << 2); goto PUT1
 
 #ifdef GET32_LABELS
 /* src_wid src_endswap sign_toggle */
-static void *const get32_labels[4 * 2 * 2 + 4 * 3] = {
+static void *const get32_labels[5 * 2 * 2 + 4 * 3] = {
 	&&get32_1_1000,	 	 /*  8h -> 32h */
 	&&get32_1_9000,	 	 /*  8h ^> 32h */
 	&&get32_1_1000,		 /*  8s -> 32h */
@@ -487,6 +511,7 @@ static void *const get32_labels[4 * 2 * 2 + 4 * 3] = {
 	&&get32_12_9200,	 /* 16h ^> 32h */
 	&&get32_12_2100,	 /* 16s -> 32h */
 	&&get32_12_A100,	 /* 16s ^> 32h */
+	/* 4 byte formats */
 	&&get32_0123_1230,	 /* 24h -> 32h */
 	&&get32_0123_9230,	 /* 24h ^> 32h */
 	&&get32_1230_3210,	 /* 24s -> 32h */
@@ -495,6 +520,10 @@ static void *const get32_labels[4 * 2 * 2 + 4 * 3] = {
 	&&get32_1234_9234,	 /* 32h ^> 32h */
 	&&get32_1234_4321,	 /* 32s -> 32h */
 	&&get32_1234_C321,	 /* 32s ^> 32h */
+	&&get32_0123_1230_20,	 /* 20h -> 32h */
+	&&get32_0123_9230_20,	 /* 20h ^> 32h */
+	&&get32_1230_3210_20,	 /* 20s -> 32h */
+	&&get32_1230_B210_20,	 /* 20s ^> 32h */
 	/* 3bytes format */
 	&&get32_123_1230,	 /* 24h -> 32h */
 	&&get32_123_9230,	 /* 24h ^> 32h */
@@ -531,6 +560,10 @@ get32_1234_1234: sample = as_u32c(src); goto GET32_END;
 get32_1234_9234: sample = as_u32c(src) ^ 0x80000000; goto GET32_END;
 get32_1234_4321: sample = bswap_32(as_u32c(src)); goto GET32_END;
 get32_1234_C321: sample = bswap_32(as_u32c(src) ^ 0x80); goto GET32_END;
+get32_0123_1230_20: sample = as_u32c(src) << 12; goto GET32_END;
+get32_0123_9230_20: sample = (as_u32c(src) << 12) ^ 0x80000000; goto GET32_END;
+get32_1230_3210_20: sample = bswap_32(as_u32c(src)) << 12; goto GET32_END;
+get32_1230_B210_20: sample = (bswap_32(as_u32c(src)) << 12) ^ 0x80000000; goto GET32_END;
 get32_123_1230: sample = _get_triple(src) << 8; goto GET32_END;
 get32_123_9230: sample = (_get_triple(src) << 8) ^ 0x80000000; goto GET32_END;
 get32_123_3210: sample = _get_triple_s(src) << 8; goto GET32_END;
@@ -553,7 +586,7 @@ __conv24_get: goto *put;
 
 #ifdef PUT32_LABELS
 /* dst_wid dst_endswap sign_toggle */
-static void *const put32_labels[4 * 2 * 2 + 4 * 3] = {
+static void *const put32_labels[5 * 2 * 2 + 4 * 3] = {
 	&&put32_1234_1,	 	 /* 32h ->  8h */
 	&&put32_1234_9,	 	 /* 32h ^>  8h */
 	&&put32_1234_1,	 	 /* 32h ->  8s */
@@ -562,6 +595,7 @@ static void *const put32_labels[4 * 2 * 2 + 4 * 3] = {
 	&&put32_1234_92,	 /* 32h ^> 16h */
 	&&put32_1234_21,	 /* 32h -> 16s */
 	&&put32_1234_29,	 /* 32h ^> 16s */
+	/* 4 byte formats */
 	&&put32_1234_0123,	 /* 32h -> 24h */
 	&&put32_1234_0923,	 /* 32h ^> 24h */
 	&&put32_1234_3210,	 /* 32h -> 24s */
@@ -570,6 +604,10 @@ static void *const put32_labels[4 * 2 * 2 + 4 * 3] = {
 	&&put32_1234_9234,	 /* 32h ^> 32h */
 	&&put32_1234_4321,	 /* 32h -> 32s */
 	&&put32_1234_4329,	 /* 32h ^> 32s */
+	&&put32_1234_0123_20,	 /* 32h -> 20h */
+	&&put32_1234_0923_20,	 /* 32h ^> 20h */
+	&&put32_1234_3210_20,	 /* 32h -> 20s */
+	&&put32_1234_3290_20,	 /* 32h ^> 20s */
 	/* 3bytes format */
 	&&put32_1234_123,	 /* 32h -> 24h */
 	&&put32_1234_923,	 /* 32h ^> 24h */
@@ -607,6 +645,10 @@ put32_1234_1234: as_u32(dst) = sample; goto PUT32_END;
 put32_1234_9234: as_u32(dst) = sample ^ 0x80000000; goto PUT32_END;
 put32_1234_4321: as_u32(dst) = bswap_32(sample); goto PUT32_END;
 put32_1234_4329: as_u32(dst) = bswap_32(sample) ^ 0x80; goto PUT32_END;
+put32_1234_0123_20: as_u32(dst) = sx20(sample >> 12); goto PUT32_END;
+put32_1234_0923_20: as_u32(dst) = sx20((sample ^ 0x80000000) >> 12); goto PUT32_END;
+put32_1234_3210_20: as_u32(dst) = bswap_32(sx20(sample >> 12)); goto PUT32_END;
+put32_1234_3290_20: as_u32(dst) = bswap_32(sx20((sample ^ 0x80000000) >> 12)); goto PUT32_END;
 put32_1234_123: _put_triple(dst, sample >> 8); goto PUT32_END;
 put32_1234_923: _put_triple(dst, (sample ^ 0x80000000) >> 8); goto PUT32_END;
 put32_1234_321: _put_triple_s(dst, sample >> 8); goto PUT32_END;
