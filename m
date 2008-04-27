From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] speaker-test.c - fix pink noise generator on
 big-endian archs
Date: Sun, 27 Apr 2008 22:53:04 +0200
Message-ID: <20080427225304.ba000bcb.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out114.alice.it (smtp-out114.alice.it [85.37.17.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 034632441B
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Apr 2008 22:53:03 +0200 (CEST)
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


This patch makes speaker-test fill the buffers with properly coded data on
both big- and little-endian processors.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- speaker-test/speaker-test.c__orig	2008-04-27 22:22:14.000000000 +0200
+++ speaker-test/speaker-test.c	2008-04-27 22:38:09.000000000 +0200
@@ -259,7 +259,8 @@ static void generate_pink_noise( uint8_t
 
   while (count-- > 0) {
     for(chn=0;chn<channels;chn++) {
-      if (sample_size_bits == 8) {
+      switch (format) {
+      case SND_PCM_FORMAT_S8:
         if (chn==channel) {
 	  res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
 	  ires = res;
@@ -267,35 +268,64 @@ static void generate_pink_noise( uint8_t
         } else {
 	  *samp8++ = 0;
         }
-      } else if (sample_size_bits == 16) {
+        break;
+      case SND_PCM_FORMAT_S16_LE:
         if (chn==channel) {
 	  res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
 	  ires = res;
-	  *samp16++ = ires >>16;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+          *samp16++ = ires >> 16;
+#elif __BYTE_ORDER == __BIG_ENDIAN
+          *samp16++ = bswap_16(ires >> 16);
+#endif
         } else {
 	  *samp16++ = 0;
         }
-      } else if ((sample_size_bits == 32) && (format == SND_PCM_FORMAT_FLOAT_LE)) {
+        break;
+      case SND_PCM_FORMAT_S16_BE:
         if (chn==channel) {
-	  res = generate_pink_noise_sample(&pink) * 0.75; /* Don't use MAX volume */
-          fres = res;
-	  *samp_f++ = fres;
+          res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
+          ires = res;
+#if __BYTE_ORDER == __BIG_ENDIAN
+          *samp16++ = ires >> 16;
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+          *samp16++ = bswap_16(ires >> 16);
+#endif
         } else {
-	  *samp_f++ = 0.0;
+          *samp16++ = 0;
         }
-      } else if ((sample_size_bits == 32) && (format != SND_PCM_FORMAT_FLOAT_LE)) {
+        break;
+      case SND_PCM_FORMAT_S32_LE:
+        if (chn==channel) {
+          res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
+          ires = res;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+          *samp32++ = ires;
+#elif __BYTE_ORDER == __BIG_ENDIAN
+          *samp32++ = bswap_32(ires);
+#endif
+        } else {
+          *samp32++ = 0;
+        }
+        break;
+      case SND_PCM_FORMAT_S32_BE:
         if (chn==channel) {
 	  res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
 	  ires = res;
+#if __BYTE_ORDER == __BIG_ENDIAN
 	  *samp32++ = ires;
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+          *samp32++ = bswap_32(ires);
+#endif
         } else {
 	  *samp32++ = 0;
         }
+        break;
+      default:
+        ;
       }
     }
-
   }
-     
 }
 
 static int set_hwparams(snd_pcm_t *handle, snd_pcm_hw_params_t *params, snd_pcm_access_t access) {



--
Giuliano.
