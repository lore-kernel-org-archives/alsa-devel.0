From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [alsa-lib][PATCH] pcm: add SNDRV_PCM_FORMAT_{S,U}20
Date: Wed, 29 Nov 2017 14:43:51 +0100
Message-ID: <58bd7b03-66c3-1fdb-b810-c8604d2d4ef2@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 9764F266B67
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 14:43:55 +0100 (CET)
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

This format is similar to an existing 20-bit PCM format
SNDRV_PCM_FORMAT_{S,U}20_3, however it occupies 4 bytes instead of 3.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 include/pcm.h          | 20 ++++++++++++++++++--
 include/sound/asound.h |  9 +++++++++
 src/pcm/pcm.c          | 10 ++++++++++
 src/pcm/pcm_linear.c   | 16 +++++++++++++---
 src/pcm/pcm_local.h    |  4 ++++
 src/pcm/pcm_misc.c     | 41 ++++++++++++++++++++++++++++++++++++++---
 src/pcm/pcm_plug.c     | 11 +++++++++++
 src/pcm/pcm_route.c    |  6 ++++--
 src/pcm/plugin_ops.h   | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 9 files changed, 153 insertions(+), 14 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index e05777a7c221..5939c1dab37d 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -175,6 +175,14 @@ typedef enum _snd_pcm_format {
 	SND_PCM_FORMAT_MPEG,
 	/** GSM */
 	SND_PCM_FORMAT_GSM,
+	/** Signed 20bit Little Endian in 4bytes format, LSB justified */
+	SND_PCM_FORMAT_S20_LE,
+	/** Signed 20bit Big Endian in 4bytes format, LSB justified */
+	SND_PCM_FORMAT_S20_BE,
+	/** Unsigned 20bit Little Endian in 4bytes format, LSB justified */
+	SND_PCM_FORMAT_U20_LE,
+	/** Unsigned 20bit Big Endian in 4bytes format, LSB justified */
+	SND_PCM_FORMAT_U20_BE,
 	/** Special */
 	SND_PCM_FORMAT_SPECIAL = 31,
 	/** Signed 24bit Little Endian in 3bytes format */
@@ -239,7 +247,11 @@ typedef enum _snd_pcm_format {
 	/** Float 64 bit CPU endian */
 	SND_PCM_FORMAT_FLOAT64 = SND_PCM_FORMAT_FLOAT64_LE,
 	/** IEC-958 CPU Endian */
-	SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_LE
+	SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_LE,
+	/** Signed 20bit in 4bytes format, LSB justified, CPU Endian */
+	SND_PCM_FORMAT_S20 = SND_PCM_FORMAT_S20_LE,
+	/** Unsigned 20bit in 4bytes format, LSB justified, CPU Endian */
+	SND_PCM_FORMAT_U20 = SND_PCM_FORMAT_U20_LE
 #elif __BYTE_ORDER == __BIG_ENDIAN
 	/** Signed 16 bit CPU endian */
 	SND_PCM_FORMAT_S16 = SND_PCM_FORMAT_S16_BE,
@@ -258,7 +270,11 @@ typedef enum _snd_pcm_format {
 	/** Float 64 bit CPU endian */
 	SND_PCM_FORMAT_FLOAT64 = SND_PCM_FORMAT_FLOAT64_BE,
 	/** IEC-958 CPU Endian */
-	SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_BE
+	SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_BE,
+	/** Signed 20bit in 4bytes format, LSB justified, CPU Endian */
+	SND_PCM_FORMAT_S20 = SND_PCM_FORMAT_S20_BE,
+	/** Unsigned 20bit in 4bytes format, LSB justified, CPU Endian */
+	SND_PCM_FORMAT_U20 = SND_PCM_FORMAT_U20_BE
 #else
 #error "Unknown endian"
 #endif
diff --git a/include/sound/asound.h b/include/sound/asound.h
index 5f659126f066..6041cab27a23 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -213,6 +213,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
 #define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
 #define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
+#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* in four bytes, LSB justified */
+/* gap in the numbering for a future standard linear format */
 #define	SNDRV_PCM_FORMAT_SPECIAL	((__force snd_pcm_format_t) 31)
 #define	SNDRV_PCM_FORMAT_S24_3LE	((__force snd_pcm_format_t) 32)	/* in three bytes */
 #define	SNDRV_PCM_FORMAT_S24_3BE	((__force snd_pcm_format_t) 33)	/* in three bytes */
@@ -247,6 +252,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_LE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_LE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_LE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
@@ -258,6 +265,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_BE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_BE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_BE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_BE
 #endif
 
 typedef int __bitwise snd_pcm_subformat_t;
diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 1efb8b9d4e8c..e9ebf383c31b 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1780,6 +1780,10 @@ static const char *const snd_pcm_format_names[] = {
 	FORMAT(IMA_ADPCM),
 	FORMAT(MPEG),
 	FORMAT(GSM),
+	FORMAT(S20_LE),
+	FORMAT(S20_BE),
+	FORMAT(U20_LE),
+	FORMAT(U20_BE),
 	FORMAT(SPECIAL),
 	FORMAT(S24_3LE),
 	FORMAT(S24_3BE),
@@ -1814,6 +1818,8 @@ static const char *const snd_pcm_format_aliases[SND_PCM_FORMAT_LAST+1] = {
 	FORMAT(FLOAT),
 	FORMAT(FLOAT64),
 	FORMAT(IEC958_SUBFRAME),
+	FORMAT(S20),
+	FORMAT(U20),
 };
 
 static const char *const snd_pcm_format_descriptions[] = {
@@ -1842,6 +1848,10 @@ static const char *const snd_pcm_format_descriptions[] = {
 	FORMATD(IMA_ADPCM, "Ima-ADPCM"),
 	FORMATD(MPEG, "MPEG"),
 	FORMATD(GSM, "GSM"),
+	FORMATD(S20_LE, "Signed 20 bit Little Endian in 4 bytes, LSB justified"),
+	FORMATD(S20_BE, "Signed 20 bit Big Endian in 4 bytes, LSB justified"),
+	FORMATD(U20_LE, "Unsigned 20 bit Little Endian in 4 bytes, LSB justified"),
+	FORMATD(U20_BE, "Unsigned 20 bit Big Endian in 4 bytes, LSB justified"),
 	FORMATD(SPECIAL, "Special"),
 	FORMATD(S24_3LE, "Signed 24 bit Little Endian in 3bytes"),
 	FORMATD(S24_3BE, "Signed 24 bit Big Endian in 3bytes"),
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
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 776f8cd3e302..3d95e1749169 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -984,6 +984,10 @@ const snd_config_t *snd_pcm_rate_get_default_converter(snd_config_t *root);
 	 (1U << SND_PCM_FORMAT_S16_BE) | \
 	 (1U << SND_PCM_FORMAT_U16_LE) | \
 	 (1U << SND_PCM_FORMAT_U16_BE) | \
+	 (1U << SND_PCM_FORMAT_S20_LE) | \
+	 (1U << SND_PCM_FORMAT_S20_BE) | \
+	 (1U << SND_PCM_FORMAT_U20_LE) | \
+	 (1U << SND_PCM_FORMAT_U20_BE) | \
 	 (1U << SND_PCM_FORMAT_S24_LE) | \
 	 (1U << SND_PCM_FORMAT_S24_BE) | \
 	 (1U << SND_PCM_FORMAT_U24_LE) | \
diff --git a/src/pcm/pcm_misc.c b/src/pcm/pcm_misc.c
index 5420b1895713..7ee0dac771af 100644
--- a/src/pcm/pcm_misc.c
+++ b/src/pcm/pcm_misc.c
@@ -38,6 +38,8 @@ int snd_pcm_format_signed(snd_pcm_format_t format)
 	case SNDRV_PCM_FORMAT_S8:
 	case SNDRV_PCM_FORMAT_S16_LE:
 	case SNDRV_PCM_FORMAT_S16_BE:
+	case SNDRV_PCM_FORMAT_S20_LE:
+	case SNDRV_PCM_FORMAT_S20_BE:
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_S32_LE:
@@ -52,6 +54,8 @@ int snd_pcm_format_signed(snd_pcm_format_t format)
 	case SNDRV_PCM_FORMAT_U8:
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_U16_BE:
+	case SNDRV_PCM_FORMAT_U20_LE:
+	case SNDRV_PCM_FORMAT_U20_BE:
 	case SNDRV_PCM_FORMAT_U24_LE:
 	case SNDRV_PCM_FORMAT_U24_BE:
 	case SNDRV_PCM_FORMAT_U32_LE:
@@ -126,6 +130,8 @@ int snd_pcm_format_little_endian(snd_pcm_format_t format)
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 	case SNDRV_PCM_FORMAT_U16_LE:
+	case SNDRV_PCM_FORMAT_S20_LE:
+	case SNDRV_PCM_FORMAT_U20_LE:
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_U24_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
@@ -144,6 +150,8 @@ int snd_pcm_format_little_endian(snd_pcm_format_t format)
 		return 1;
 	case SNDRV_PCM_FORMAT_S16_BE:
 	case SNDRV_PCM_FORMAT_U16_BE:
+	case SNDRV_PCM_FORMAT_S20_BE:
+	case SNDRV_PCM_FORMAT_U20_BE:
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_U24_BE:
 	case SNDRV_PCM_FORMAT_S32_BE:
@@ -218,6 +226,10 @@ int snd_pcm_format_width(snd_pcm_format_t format)
 	case SNDRV_PCM_FORMAT_U18_3LE:
 	case SNDRV_PCM_FORMAT_U18_3BE:
 		return 18;
+	case SNDRV_PCM_FORMAT_S20_LE:
+	case SNDRV_PCM_FORMAT_S20_BE:
+	case SNDRV_PCM_FORMAT_U20_LE:
+	case SNDRV_PCM_FORMAT_U20_BE:
 	case SNDRV_PCM_FORMAT_S20_3LE:
 	case SNDRV_PCM_FORMAT_S20_3BE:
 	case SNDRV_PCM_FORMAT_U20_3LE:
@@ -289,6 +301,10 @@ int snd_pcm_format_physical_width(snd_pcm_format_t format)
 	case SNDRV_PCM_FORMAT_U24_3LE:
 	case SNDRV_PCM_FORMAT_U24_3BE:
 		return 24;
+	case SNDRV_PCM_FORMAT_S20_LE:
+	case SNDRV_PCM_FORMAT_S20_BE:
+	case SNDRV_PCM_FORMAT_U20_LE:
+	case SNDRV_PCM_FORMAT_U20_BE:
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_U24_LE:
@@ -350,6 +366,10 @@ ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples)
 	case SNDRV_PCM_FORMAT_U24_3LE:
 	case SNDRV_PCM_FORMAT_U24_3BE:
 		return samples * 3;
+	case SNDRV_PCM_FORMAT_S20_LE:
+	case SNDRV_PCM_FORMAT_S20_BE:
+	case SNDRV_PCM_FORMAT_U20_LE:
+	case SNDRV_PCM_FORMAT_U20_BE:
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_U24_LE:
@@ -393,6 +413,8 @@ uint64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	case SNDRV_PCM_FORMAT_S8:
 	case SNDRV_PCM_FORMAT_S16_LE:
 	case SNDRV_PCM_FORMAT_S16_BE:
+	case SNDRV_PCM_FORMAT_S20_LE:
+	case SNDRV_PCM_FORMAT_S20_BE:
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_S32_LE:
@@ -415,12 +437,16 @@ uint64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 #ifdef SNDRV_LITTLE_ENDIAN
 	case SNDRV_PCM_FORMAT_U16_LE:
 		return 0x8000800080008000ULL;
+	case SNDRV_PCM_FORMAT_U20_LE:
+		return 0x0008000000080000ULL;
 	case SNDRV_PCM_FORMAT_U24_LE:
 		return 0x0080000000800000ULL;
 	case SNDRV_PCM_FORMAT_U32_LE:
 		return 0x8000000080000000ULL;
 	case SNDRV_PCM_FORMAT_U16_BE:
 		return 0x0080008000800080ULL;
+	case SNDRV_PCM_FORMAT_U20_BE:
+		return 0x0000080000000800ULL;
 	case SNDRV_PCM_FORMAT_U24_BE:
 		return 0x0000800000008000ULL;
 	case SNDRV_PCM_FORMAT_U32_BE:
@@ -440,12 +466,16 @@ uint64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 #else
 	case SNDRV_PCM_FORMAT_U16_LE:
 		return 0x0080008000800080ULL;
+	case SNDRV_PCM_FORMAT_U20_LE:
+		return 0x0000080000000800ULL;
 	case SNDRV_PCM_FORMAT_U24_LE:
 		return 0x0000800000008000ULL;
 	case SNDRV_PCM_FORMAT_U32_LE:
 		return 0x0000008000000080ULL;
 	case SNDRV_PCM_FORMAT_U16_BE:
 		return 0x8000800080008000ULL;
+	case SNDRV_PCM_FORMAT_U20_BE:
+		return 0x0008000000080000ULL;
 	case SNDRV_PCM_FORMAT_U24_BE:
 		return 0x0080000000800000ULL;
 	case SNDRV_PCM_FORMAT_U32_BE:
@@ -653,11 +683,13 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 	return 0;
 }
 
-static const int linear_formats[4][2][2] = {
+static const int linear_formats[5][2][2] = {
 	{ { SNDRV_PCM_FORMAT_S8, SNDRV_PCM_FORMAT_S8 },
 	  { SNDRV_PCM_FORMAT_U8, SNDRV_PCM_FORMAT_U8 } },
 	{ { SNDRV_PCM_FORMAT_S16_LE, SNDRV_PCM_FORMAT_S16_BE },
 	  { SNDRV_PCM_FORMAT_U16_LE, SNDRV_PCM_FORMAT_U16_BE } },
+	{ { SNDRV_PCM_FORMAT_S20_LE, SNDRV_PCM_FORMAT_S20_BE },
+	  { SNDRV_PCM_FORMAT_U20_LE, SNDRV_PCM_FORMAT_U20_BE } },
 	{ { SNDRV_PCM_FORMAT_S24_LE, SNDRV_PCM_FORMAT_S24_BE },
 	  { SNDRV_PCM_FORMAT_U24_LE, SNDRV_PCM_FORMAT_U24_BE } },
 	{ { SNDRV_PCM_FORMAT_S32_LE, SNDRV_PCM_FORMAT_S32_BE },
@@ -706,12 +738,15 @@ snd_pcm_format_t snd_pcm_build_linear_format(int width, int pwidth, int unsignd,
 		case 16:
 			width = 1;
 			break;
-		case 24:
+		case 20:
 			width = 2;
 			break;
-		case 32:
+		case 24:
 			width = 3;
 			break;
+		case 32:
+			width = 4;
+			break;
 		default:
 			return SND_PCM_FORMAT_UNKNOWN;
 		}
diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index f1d7792db709..abf6f1ab9751 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -138,6 +138,17 @@ static const snd_pcm_format_t linear_preferred_formats[] = {
 	SND_PCM_FORMAT_S24_LE,
 	SND_PCM_FORMAT_U24_LE,
 #endif
+#ifdef SND_LITTLE_ENDIAN
+	SND_PCM_FORMAT_S20_LE,
+	SND_PCM_FORMAT_U20_LE,
+	SND_PCM_FORMAT_S20_BE,
+	SND_PCM_FORMAT_U20_BE,
+#else
+	SND_PCM_FORMAT_S20_BE,
+	SND_PCM_FORMAT_U20_BE,
+	SND_PCM_FORMAT_S20_LE,
+	SND_PCM_FORMAT_U20_LE,
+#endif
 #ifdef SND_LITTLE_ENDIAN
 	SND_PCM_FORMAT_S24_3LE,
 	SND_PCM_FORMAT_U24_3LE,
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
