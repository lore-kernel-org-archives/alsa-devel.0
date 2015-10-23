From: Caleb Crome <caleb@crome.org>
Subject: [PATCH 2/2] BAT: Change maximum number of channels
	from 2 to 64
Date: Fri, 23 Oct 2015 17:11:42 +0000
Message-ID: <1445620302-18408-2-git-send-email-caleb@crome.org>
References: <1445620302-18408-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C7D182625D7
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 19:11:49 +0200 (CEST)
Received: by pasz6 with SMTP id z6so123197107pas.2
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:11:48 -0700 (PDT)
In-Reply-To: <1445620302-18408-1-git-send-email-caleb@crome.org>
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
Cc: Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

Changed maximum number of channels to 64.

Added a round-robbin frequency assignment from the command line so
that every frequency need not be specified on the command line.
For example,
      -c 6 -F 100:200:250
will result frequencies for the 6 channels to be set identically
as if the command was
       -c 6 -F 100:200:250:100:200:250
---
 bat/bat.c    | 37 ++++++++++++++++++++++++++-----------
 bat/common.h |  2 +-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/bat/bat.c b/bat/bat.c
index 086b9fa..9c046e6 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -73,16 +73,30 @@ err_exit:
 
 static void get_sine_frequencies(struct bat *bat, char *freq)
 {
-	char *tmp1;
-
-	tmp1 = strchr(freq, ':');
-	if (tmp1 == NULL) {
-		bat->target_freq[1] = bat->target_freq[0] = atof(optarg);
-	} else {
-		*tmp1 = '\0';
-		bat->target_freq[0] = atof(optarg);
-		bat->target_freq[1] = atof(tmp1 + 1);
+	char *tmp0, *tmp1;
+	int ncolons;
+	int nfreqs;
+	int i;
+	ncolons = 0;
+	tmp1 = freq;
+	while ((tmp1 = strchr(tmp1, ':'))) {
+		tmp1++;
+		ncolons ++;
+	}
+	nfreqs = ncolons+1;
+
+	tmp0 = freq;
+	tmp1 = strchr(tmp0, ':');
+	for (i = 0; i < MAX_CHANNELS && i < nfreqs; i++) {
+		if (i+1 < nfreqs)
+			*tmp1 = '\0';
+		bat->target_freq[i] = atof(tmp0);
+		tmp0 = tmp1+1;
+		if (i+1 < nfreqs)
+			tmp1 = strchr(tmp0, ':');
 	}
+	for (i = nfreqs; i < MAX_CHANNELS; i++)
+		bat->target_freq[i] = bat->target_freq[i % nfreqs];
 }
 
 static void get_format(struct bat *bat, char *optarg)
@@ -302,6 +316,7 @@ _("Usage: bat [-options]...\n"
 
 static void set_defaults(struct bat *bat)
 {
+	int i;
 	memset(bat, 0, sizeof(struct bat));
 
 	/* Set default values */
@@ -313,8 +328,8 @@ static void set_defaults(struct bat *bat)
 	bat->convert_float_to_sample = convert_float_to_int16;
 	bat->convert_sample_to_double = convert_int16_to_double;
 	bat->frames = bat->rate * 2;
-	bat->target_freq[0] = 997.0;
-	bat->target_freq[1] = 997.0;
+	for (i = 0; i < MAX_CHANNELS; i++)
+		bat->target_freq[i] = 997.0;
 	bat->sigma_k = 3.0;
 	bat->playback.device = NULL;
 	bat->capture.device = NULL;
diff --git a/bat/common.h b/bat/common.h
index c04452d..6d5e46e 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -30,7 +30,7 @@
 #define WAV_DATA			COMPOSE('d', 'a', 't', 'a')
 #define WAV_FORMAT_PCM			1	/* PCM WAVE file encoding */
 
-#define MAX_CHANNELS			2
+#define MAX_CHANNELS			64
 #define MIN_CHANNELS			1
 #define MAX_PEAKS			10
 #define MAX_FRAMES			(10 * 1024 * 1024)
-- 
2.6.1
