From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] speaker-test.c - fix sine generator on
	big-endian archs
Date: Sat, 19 Apr 2008 23:50:08 +0200
Message-ID: <20080419235008.83593d03.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out25.alice.it (smtp-out25.alice.it [85.33.2.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EAAD243BB
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Apr 2008 23:49:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

speaker-test doesn't work well when you choose a little-endian format on a
big-endian processor, or the opposite. Yes, I know about plughw:, but for
debugging purposes it may not be an option. The following patch add proper
support for S32 and S16 support for but LE and BE processors:

- The "if (bits-per-sample)" construct was replaced by case (format).
- Support for S16_BE, S32_BE formats was added.
- S16_LE and S32_LE were made compatible with big-endian processors.
- NB: The pink noise generator wasn't changed (I'll do if this patch is OK).


--- speaker-test/speaker-test.c__orig	2008-04-19 23:01:22.000000000 +0200
+++ speaker-test/speaker-test.c	2008-04-19 23:29:45.000000000 +0200
@@ -139,7 +139,6 @@ static void generate_sine(uint8_t *frame
   int16_t *samp16 = (int16_t*) frames;
   int32_t *samp32 = (int32_t*) frames;
   float   *samp_f = (float*) frames;
-  int sample_size_bits = snd_pcm_format_width(format); 
 
   while (count-- > 0) {
     //res = sin((phase * 2 * M_PI) / max_phase - M_PI) * 32767;
@@ -154,26 +153,43 @@ static void generate_sine(uint8_t *frame
     //ires = 0;
 
     for(chn=0;chn<channels;chn++) {
-      if (sample_size_bits == 8) {
+      switch (format) {
+      case SND_PCM_FORMAT_S8:
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-	  *samp8++ = ires >> 24;
-	  //*samp8++ = 0x12;
+          *samp8++ = ires >> 24;
         } else {
-	  *samp8++ = 0;
+          *samp8++ = 0;
         }
-      } else if (sample_size_bits == 16) {
+        break;
+      case SND_PCM_FORMAT_S16_LE:
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-	  *samp16++ = ires >>16;
-	  //*samp16++ = 0x1234;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+          *samp16++ = ires >> 16;
+#elif __BYTE_ORDER == __BIG_ENDIAN
+          *samp16++ = bswap_16(ires >> 16);
+#endif
         } else {
-	  //*samp16++ = (ires >>16)+1;
-	  *samp16++ = 0;
+          *samp16++ = 0;
         }
-      } else if ((sample_size_bits == 32) && (format == SND_PCM_FORMAT_FLOAT_LE)) {
+        break;
+      case SND_PCM_FORMAT_S16_BE:
+        if (chn==channel) {
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
+          ires = res;
+#if __BYTE_ORDER == __BIG_ENDIAN
+          *samp16++ = ires >> 16;
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+          *samp16++ = bswap_16(ires >> 16);
+#endif
+        } else {
+          *samp16++ = 0;
+        }
+        break;
+      case SND_PCM_FORMAT_FLOAT_LE:
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0.75 ; /* Don't use MAX volume */
           fres = res;
@@ -185,18 +201,35 @@ static void generate_sine(uint8_t *frame
 	  //*samp32++ = ires;
 	  *samp_f++ = 0.0;
         }
-      } else if ((sample_size_bits == 32) && (format != SND_PCM_FORMAT_FLOAT_LE)) {
+        break;
+      case SND_PCM_FORMAT_S32_LE:
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
           ires = res;
-	  *samp32++ = ires;
-	  //*samp32++ = 0xF2345678;
-	//printf("res=%lf, ires=%d 0x%x, samp32=0x%x\n",res,ires, ires, samp32[-1]);
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+          *samp32++ = ires;
+#elif __BYTE_ORDER == __BIG_ENDIAN
+          *samp32++ = bswap_32(ires);
+#endif
         } else {
-	  //*samp32++ = ires+0x10000;
-	  //*samp32++ = ires;
-	  *samp32++ = 0;
+          *samp32++ = 0;
         }
+        break;
+      case SND_PCM_FORMAT_S32_BE:
+        if (chn==channel) {
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
+          ires = res;
+#if __BYTE_ORDER == __BIG_ENDIAN
+          *samp32++ = ires;
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+          *samp32++ = bswap_32(ires);
+#endif
+        } else {
+          *samp32++ = 0;
+        }
+        break;
+      default:
+        ;
       }
     }
 

--
Giuliano.
