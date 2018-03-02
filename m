From: Julian Scheel <julian@jusst.de>
Subject: [PATCH] speaker-test: Support S24_3LE sample format
Date: Fri,  2 Mar 2018 15:31:04 +0100
Message-ID: <20180302143104.22859-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web01.jusst.de (jusst.de [188.40.114.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 46C3A2673F4
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 15:31:13 +0100 (CET)
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
Cc: tiwai@suse.de, Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

Implement support signed 24 bit samples, packed in 3 bytes.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 speaker-test/speaker-test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 46b0589..dbee63f 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -284,6 +284,7 @@ static const int	supported_formats[] = {
   SND_PCM_FORMAT_S16_LE,
   SND_PCM_FORMAT_S16_BE,
   SND_PCM_FORMAT_FLOAT_LE,
+  SND_PCM_FORMAT_S24_3LE,
   SND_PCM_FORMAT_S32_LE,
   SND_PCM_FORMAT_S32_BE,
   -1
@@ -341,6 +342,19 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
 	  *samp_f++ = 0.0;
         }
         break;
+      case SND_PCM_FORMAT_S24_3LE:
+        if (chn==channel) {
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * generator_scale * 0x7fffff;
+          ires = res;
+          *samp8++ = LE_INT(ires);
+          *samp8++ = LE_INT(ires) >> 8;
+          *samp8++ = LE_INT(ires) >> 16;
+        } else {
+          *samp8++ = 0;
+          *samp8++ = 0;
+          *samp8++ = 0;
+        }
+        break;
       case SND_PCM_FORMAT_S32_LE:
         if (chn==channel) {
           res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * generator_scale * 0x7fffffff;
@@ -415,6 +429,19 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
           *samp16++ = 0;
         }
         break;
+      case SND_PCM_FORMAT_S24_3LE:
+        if (chn==channel) {
+          res = generate_pink_noise_sample(&pink) * generator_scale * 0x07fffff;
+          ires = res;
+          *samp8++ = LE_INT(ires);
+          *samp8++ = LE_INT(ires) >> 8;
+          *samp8++ = LE_INT(ires) >> 16;
+        } else {
+          *samp8++ = 0;
+          *samp8++ = 0;
+          *samp8++ = 0;
+        }
+        break;
       case SND_PCM_FORMAT_S32_LE:
         if (chn==channel) {
           res = generate_pink_noise_sample(&pink) * generator_scale * 0x07fffffff;
@@ -482,6 +509,17 @@ static void generate_pattern(uint8_t *frames, int channel, int count, int *_patt
 	  *samp_f++ = 0.0;
         }
         break;
+      case SND_PCM_FORMAT_S24_3LE:
+        if (chn==channel) {
+          *samp8++ = LE_INT(pattern);
+          *samp8++ = LE_INT(pattern) >> 8;
+          *samp8++ = LE_INT(pattern) >> 16;
+        } else {
+          *samp8++ = 0;
+          *samp8++ = 0;
+          *samp8++ = 0;
+        }
+        break;
       case SND_PCM_FORMAT_S32_LE:
         if (chn==channel) {
           *samp32++ = LE_INT(pattern);
-- 
2.16.1
