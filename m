From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/2] speaker-test: only check byte order once
Date: Sat,  9 May 2009 19:47:40 -0500
Message-ID: <1241916460-13648-2-git-send-email-dpmcgee@gmail.com>
References: <1241916460-13648-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F74324534
	for <alsa-devel@alsa-project.org>;
	Sun, 10 May 2009 02:47:47 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1662724ywq.2
	for <alsa-devel@alsa-project.org>; Sat, 09 May 2009 17:47:46 -0700 (PDT)
In-Reply-To: <1241916460-13648-1-git-send-email-dpmcgee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dan McGee <dpmcgee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Rather than having numerous preprocessor directives scattered in the code
checking __BYTE_ORDER, only check it once and define a set of macros
accordingly that can be used in the rest of the code. This makes things
simpler to read and less error-prone.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 speaker-test/speaker-test.c |   54 ++++++++++--------------------------------
 1 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index c1d53b6..e22c937 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -72,10 +72,14 @@ enum {
 #define COMPOSE_ID(a,b,c,d)	((a) | ((b)<<8) | ((c)<<16) | ((d)<<24))
 #define LE_SHORT(v)		(v)
 #define LE_INT(v)		(v)
-#else
+#define BE_SHORT(v)		bswap_16(v)
+#define BE_INT(v)		bswap_32(v)
+#else /* __BIG_ENDIAN */
 #define COMPOSE_ID(a,b,c,d)	((d) | ((c)<<8) | ((b)<<16) | ((a)<<24))
 #define LE_SHORT(v)		bswap_16(v)
 #define LE_INT(v)		bswap_32(v)
+#define BE_SHORT(v)		(v)
+#define BE_INT(v)		(v)
 #endif
 
 static char              *device      = "default";       /* playback device */
@@ -167,11 +171,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-          *samp16++ = ires >> 16;
-#elif __BYTE_ORDER == __BIG_ENDIAN
-          *samp16++ = bswap_16(ires >> 16);
-#endif
+          *samp16++ = LE_SHORT(ires >> 16);
         } else {
           *samp16++ = 0;
         }
@@ -180,11 +180,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-#if __BYTE_ORDER == __BIG_ENDIAN
-          *samp16++ = ires >> 16;
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-          *samp16++ = bswap_16(ires >> 16);
-#endif
+          *samp16++ = BE_SHORT(ires >> 16);
         } else {
           *samp16++ = 0;
         }
@@ -202,11 +198,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-          *samp32++ = ires;
-#elif __BYTE_ORDER == __BIG_ENDIAN
-          *samp32++ = bswap_32(ires);
-#endif
+          *samp32++ = LE_INT(ires);
         } else {
           *samp32++ = 0;
         }
@@ -215,11 +207,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-#if __BYTE_ORDER == __BIG_ENDIAN
-          *samp32++ = ires;
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-          *samp32++ = bswap_32(ires);
-#endif
+          *samp32++ = BE_INT(ires);
         } else {
           *samp32++ = 0;
         }
@@ -266,11 +254,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
         if (chn==channel) {
 	  res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
 	  ires = res;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-          *samp16++ = ires >> 16;
-#elif __BYTE_ORDER == __BIG_ENDIAN
-          *samp16++ = bswap_16(ires >> 16);
-#endif
+          *samp16++ = LE_SHORT(ires >> 16);
         } else {
 	  *samp16++ = 0;
         }
@@ -279,11 +263,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
         if (chn==channel) {
           res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-#if __BYTE_ORDER == __BIG_ENDIAN
-          *samp16++ = ires >> 16;
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-          *samp16++ = bswap_16(ires >> 16);
-#endif
+          *samp16++ = BE_SHORT(ires >> 16);
         } else {
           *samp16++ = 0;
         }
@@ -292,11 +272,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
         if (chn==channel) {
           res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-          *samp32++ = ires;
-#elif __BYTE_ORDER == __BIG_ENDIAN
-          *samp32++ = bswap_32(ires);
-#endif
+          *samp32++ = LE_INT(ires);
         } else {
           *samp32++ = 0;
         }
@@ -305,11 +281,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
         if (chn==channel) {
 	  res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
 	  ires = res;
-#if __BYTE_ORDER == __BIG_ENDIAN
-	  *samp32++ = ires;
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-          *samp32++ = bswap_32(ires);
-#endif
+	  *samp32++ = BE_INT(ires);
         } else {
 	  *samp32++ = 0;
         }
-- 
1.6.2.4
