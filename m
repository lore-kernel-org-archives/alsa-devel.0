From: Caleb Crome <caleb@crome.org>
Subject: [PATCH] BAT: Change maximum number of channels from 2
	to 64
Date: Thu, 22 Oct 2015 15:05:24 -0700
Message-ID: <CAG5mAdx9iZC=JPKdShjqayaU3pEOa67Wb58CNyc-YNdJE2W1SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id C53D32607E8
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 00:05:43 +0200 (CEST)
Received: by wicfv8 with SMTP id fv8so7934660wic.0
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 15:05:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lu,
 Han" <han.lu@intel.com>, "Gautier, Bernard" <bernard.gautier@intel.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

commit 23521f2e04df7ae39ccdbc7b4a9aa59220b56495
Author: Caleb Crome <ccrome@gmail.com>
Date:   Tue Oct 20 20:57:57 2015 +0000

    Change maximum number of channels from 2 to 64.

    Added a round-robbin frequency assignment from the command line so that
    if you specify -F 100:200:250 on the command line, then all subsequent
    channels will get assigned frequencies like this first set.  So by
    specifying

       -c 6 -F 100:200:250

    the resulting frequencies for the 6 channels will be the same as if you
    specified

       -c 6 -F 100:200:250:100:200:250

diff --git a/bat/bat.c b/bat/bat.c
index 56cfaf6..57c9db8 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -72,16 +72,31 @@ err_exit:

 static void get_sine_frequencies(struct bat *bat, char *freq)
 {
-    char *tmp1;
-
-    tmp1 = strchr(freq, ':');
-    if (tmp1 == NULL) {
-        bat->target_freq[1] = bat->target_freq[0] = atof(optarg);
-    } else {
-        *tmp1 = '\0';
-        bat->target_freq[0] = atof(optarg);
-        bat->target_freq[1] = atof(tmp1 + 1);
+    char *tmp0, *tmp1;
+    int ncolons;
+    int nfreqs;
+    int i;
+
+    ncolons = 0;
+    tmp1 = freq;
+    while ((tmp1 = strchr(tmp1, ':'))) {
+        tmp1++;
+        ncolons ++;
     }
+    nfreqs = ncolons+1;
+
+    tmp0 = freq;
+    tmp1 = strchr(tmp0, ':');
+    for (i = 0; i < MAX_CHANNELS && i < nfreqs; i++) {
+        if (i+1 < nfreqs)
+            *tmp1 = '\0';
+        bat->target_freq[i] = atof(tmp0);
+        tmp0 = tmp1+1;
+        if (i+1 < nfreqs)
+            tmp1 = strchr(tmp0, ':');
+    }
+    for (i = nfreqs; i < MAX_CHANNELS; i++)
+        bat->target_freq[i] = bat->target_freq[i % nfreqs];
 }

 static void get_format(struct bat *bat, char *optarg)
@@ -301,6 +316,7 @@ _("Usage: bat [-options]...\n"

 static void set_defaults(struct bat *bat)
 {
+    int i;
     memset(bat, 0, sizeof(struct bat));

     /* Set default values */
@@ -312,8 +328,9 @@ static void set_defaults(struct bat *bat)
     bat->convert_float_to_sample = convert_float_to_int16;
     bat->convert_sample_to_double = convert_int16_to_double;
     bat->frames = bat->rate * 2;
-    bat->target_freq[0] = 997.0;
-    bat->target_freq[1] = 997.0;
+    for (i = 0; i < MAX_CHANNELS; i++) {
+        bat->target_freq[i] = 997.0;
+    }
     bat->sigma_k = 3.0;
     bat->playback.device = NULL;
     bat->capture.device = NULL;
diff --git a/bat/common.h b/bat/common.h
index c04452d..6d5e46e 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -30,7 +30,7 @@
 #define WAV_DATA            COMPOSE('d', 'a', 't', 'a')
 #define WAV_FORMAT_PCM            1    /* PCM WAVE file encoding */

-#define MAX_CHANNELS            2
+#define MAX_CHANNELS            64
 #define MIN_CHANNELS            1
 #define MAX_PEAKS            10
 #define MAX_FRAMES            (10 * 1024 * 1024)
