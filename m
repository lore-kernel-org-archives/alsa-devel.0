From: Julian Scheel <julian@jusst.de>
Subject: [PATCH] speaker-test: Add option to specify signal
	scale
Date: Tue, 30 Jun 2015 08:57:49 +0200
Message-ID: <1435647469-30754-1-git-send-email-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 750A326041D
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 08:58:01 +0200 (CEST)
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
Cc: Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

Allow generated signals (sine and noise) to have a specified signal scale
instead of using hardcoded limits of 80%. This can be handy for debugging, ie
when analysing clipping issues with audio drivers.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
 speaker-test/speaker-test.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index ccf2671..25970af 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -100,6 +100,7 @@ static unsigned int       period_time = 0;	            /* period time in us */
 static unsigned int       nperiods    = 4;                  /* number of periods */
 static double             freq        = 440.0;              /* sinusoidal wave frequency in Hz */
 static int                test_type   = TEST_PINK_NOISE;    /* Test type. 1 = noise, 2 = sine wave */
+static float              generator_scale  = 0.8;           /* Scale to use for sine volume */
 static pink_noise_t pink;
 static snd_pcm_uframes_t  buffer_size;
 static snd_pcm_uframes_t  period_size;
@@ -306,7 +307,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
       switch (format) {
       case SND_PCM_FORMAT_S8:
         if (chn==channel) {
-          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * generator_scale * 0x7fffffff;
           ires = res;
           *samp8++ = ires >> 24;
         } else {
@@ -315,7 +316,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         break;
       case SND_PCM_FORMAT_S16_LE:
         if (chn==channel) {
-          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * generator_scale * 0x7fffffff;
           ires = res;
           *samp16++ = LE_SHORT(ires >> 16);
         } else {
@@ -324,7 +325,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         break;
       case SND_PCM_FORMAT_S16_BE:
         if (chn==channel) {
-          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * generator_scale * 0x7fffffff;
           ires = res;
           *samp16++ = BE_SHORT(ires >> 16);
         } else {
@@ -333,7 +334,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         break;
       case SND_PCM_FORMAT_FLOAT_LE:
         if (chn==channel) {
-          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0.75 ; /* Don't use MAX volume */
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * generator_scale;
           fres = res;
 	  *samp_f++ = fres;
         } else {
@@ -342,7 +343,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         break;
       case SND_PCM_FORMAT_S32_LE:
         if (chn==channel) {
-          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * generator_scale * 0x7fffffff;
           ires = res;
           *samp32++ = LE_INT(ires);
         } else {
@@ -351,7 +352,7 @@ static void generate_sine(uint8_t *frames, int channel, int count, double *_phas
         break;
       case SND_PCM_FORMAT_S32_BE:
         if (chn==channel) {
-          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * 0x03fffffff; /* Don't use MAX volume */
+          res = (sin((phase * 2 * M_PI) / max_phase - M_PI)) * generator_scale * 0x7fffffff;
           ires = res;
           *samp32++ = BE_INT(ires);
         } else {
@@ -389,7 +390,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
       switch (format) {
       case SND_PCM_FORMAT_S8:
         if (chn==channel) {
-	  res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
+	  res = generate_pink_noise_sample(&pink) * generator_scale * 0x07fffffff;
 	  ires = res;
 	  *samp8++ = ires >> 24;
         } else {
@@ -398,7 +399,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
         break;
       case SND_PCM_FORMAT_S16_LE:
         if (chn==channel) {
-	  res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
+	  res = generate_pink_noise_sample(&pink) * generator_scale * 0x07fffffff;
 	  ires = res;
           *samp16++ = LE_SHORT(ires >> 16);
         } else {
@@ -407,7 +408,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
         break;
       case SND_PCM_FORMAT_S16_BE:
         if (chn==channel) {
-          res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
+          res = generate_pink_noise_sample(&pink) * generator_scale * 0x07fffffff;
           ires = res;
           *samp16++ = BE_SHORT(ires >> 16);
         } else {
@@ -416,7 +417,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
         break;
       case SND_PCM_FORMAT_S32_LE:
         if (chn==channel) {
-          res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
+          res = generate_pink_noise_sample(&pink) * generator_scale * 0x07fffffff;
           ires = res;
           *samp32++ = LE_INT(ires);
         } else {
@@ -425,7 +426,7 @@ static void generate_pink_noise( uint8_t *frames, int channel, int count) {
         break;
       case SND_PCM_FORMAT_S32_BE:
         if (chn==channel) {
-	  res = generate_pink_noise_sample(&pink) * 0x03fffffff; /* Don't use MAX volume */
+	  res = generate_pink_noise_sample(&pink) * generator_scale * 0x07fffffff;
 	  ires = res;
 	  *samp32++ = BE_INT(ires);
         } else {
@@ -1017,6 +1018,7 @@ static void help(void)
 	   "-W,--wavdir	Specify the directory containing WAV files\n"
 	   "-m,--chmap	Specify the channel map to override\n"
 	   "-X,--force-frequency	force frequencies outside the 30-8000hz range\n"
+	   "-S,--scale	Scale of generated test tones in percent (default=80)\n"
 	   "\n"));
   printf(_("Recognized sample formats are:"));
   for (fmt = supported_formats; *fmt >= 0; fmt++) {
@@ -1060,6 +1062,7 @@ int main(int argc, char *argv[]) {
     {"wavdir",    1, NULL, 'W'},
     {"debug",	  0, NULL, 'd'},
     {"force-frequency",	  0, NULL, 'X'},
+    {"scale",	  1, NULL, 'S'},
 #ifdef CONFIG_SUPPORT_CHMAP
     {"chmap",	  1, NULL, 'm'},
 #endif
@@ -1081,7 +1084,7 @@ int main(int argc, char *argv[]) {
   while (1) {
     int c;
     
-    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d:X"
+    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d:XS:"
 #ifdef CONFIG_SUPPORT_CHMAP
 			 "m:"
 #endif
@@ -1182,6 +1185,9 @@ int main(int argc, char *argv[]) {
       chmap = optarg;
       break;
 #endif
+    case 'S':
+      generator_scale = atoi(optarg) / 100.0;
+      break;
     default:
       fprintf(stderr, _("Unknown option '%c'\n"), c);
       exit(EXIT_FAILURE);
-- 
2.4.3
