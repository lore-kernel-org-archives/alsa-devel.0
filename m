From: John Spencer <maillist-alsa@barfooze.de>
Subject: [PATCH] pcm: use the same set of uint_XX types
	everywhere
Date: Wed,  2 Oct 2013 17:36:49 +0200
Message-ID: <1380728209-24440-1-git-send-email-maillist-alsa@barfooze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id EB12A2654D7
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 17:40:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: John Spencer <maillist-alsa@barfooze.de>
List-Id: alsa-devel@alsa-project.org

previously, pcm.h prototyped the functions
snd_pcm_format_silence* with u_int_XX types
(legacy BSD types from sys/types.h),
while the implementation in pcm_misc.c used the C99
stdint.h types uint_XX.

this caused compilation errors on systems where the
typedef for u_int_XX and uint_XX is not exactly the same.

we fix it by using the C99 stdint.h types everywhere.

Signed-off-by: John Spencer <maillist-alsa@barfooze.de>
---
 include/pcm.h      |    9 +++++----
 src/pcm/pcm_misc.c |   42 +++++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index 95b8aed..cd847e4 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -33,6 +33,7 @@
 extern "C" {
 #endif
 
+#include <stdint.h>
 /**
  *  \defgroup PCM PCM Interface
  *  See the \ref pcm page for more details.
@@ -1048,10 +1049,10 @@ int snd_pcm_format_width(snd_pcm_format_t format);			/* in bits */
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
diff --git a/src/pcm/pcm_misc.c b/src/pcm/pcm_misc.c
index d52160c..2a8be21 100644
--- a/src/pcm/pcm_misc.c
+++ b/src/pcm/pcm_misc.c
@@ -363,7 +363,7 @@ ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples)
  * \param format Sample format
  * \return silence 64 bit word
  */
-u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
+uint64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 {
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S8:
@@ -437,7 +437,7 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	{
 		union {
 			float f[2];
-			u_int64_t i;
+			uint64_t i;
 		} u;
 		u.f[0] = u.f[1] = 0.0;
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -450,7 +450,7 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	{
 		union {
 			double f;
-			u_int64_t i;
+			uint64_t i;
 		} u;
 		u.f = 0.0;
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -463,7 +463,7 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	{
 		union {
 			float f[2];
-			u_int64_t i;
+			uint64_t i;
 		} u;
 		u.f[0] = u.f[1] = 0.0;
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -476,7 +476,7 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
 	{
 		union {
 			double f;
-			u_int64_t i;
+			uint64_t i;
 		} u;
 		u.f = 0.0;
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -509,10 +509,10 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
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
@@ -520,10 +520,10 @@ u_int32_t snd_pcm_format_silence_32(snd_pcm_format_t format)
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
@@ -531,10 +531,10 @@ u_int16_t snd_pcm_format_silence_16(snd_pcm_format_t format)
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
@@ -550,7 +550,7 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		return 0;
 	switch (snd_pcm_format_physical_width(format)) {
 	case 4: {
-		u_int8_t silence = snd_pcm_format_silence_64(format);
+		uint8_t silence = snd_pcm_format_silence_64(format);
 		unsigned int samples1;
 		if (samples % 2 != 0)
 			return -EINVAL;
@@ -559,13 +559,13 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
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
@@ -575,8 +575,8 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
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
@@ -595,8 +595,8 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
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
@@ -606,8 +606,8 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
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
-- 
1.7.3.4
