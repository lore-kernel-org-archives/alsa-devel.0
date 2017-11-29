From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [alsa-lib][PATCH 2/4] pcm: add and describe
	SND_PCM_FORMAT_{S, U}20
Date: Wed, 29 Nov 2017 23:16:18 +0100
Message-ID: <0f990d18-d21b-d5c6-b7e2-2e353223c2ef@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 834A6267960
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 23:16:21 +0100 (CET)
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

This patch adds and describes in various functions that query format
properties SND_PCM_FORMAT_{S,U}20 formats that were recently added to the
kernel as SNDRV_PCM_FORMAT_{S,U}20.

These formats are similar to existing 20-bit PCM formats
SND_PCM_FORMAT_{S,U}20_3, however they occupy 4 bytes instead of 3.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 include/pcm.h       | 20 ++++++++++++++++++--
 src/pcm/pcm.c       | 10 ++++++++++
 src/pcm/pcm_local.h |  4 ++++
 src/pcm/pcm_misc.c  | 41 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 70 insertions(+), 5 deletions(-)

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
