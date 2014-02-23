Return-Path: <alsa-devel-bounces@alsa-project.org>
From: erik@caspar.alsa-project.org
Date: Sat, 22 Feb 2014 16:09:57 -0800
Message-Id: <1393114197-4581-1-git-send-email-erik>
Subject: [alsa-devel] [PATCH - speaker-test 1/1] speaker-test: add
	--force-frequency option to allow hz outside range
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Erik Ackermann <domohawk@gmail.com>
List-ID: <alsa-devel@alsa-project.org>

From: Erik Ackermann <domohawk@gmail.com>

Signed-off-by: Erik Ackermann <domohawk@gmail.com>

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 261f399..22927f2 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -106,6 +106,7 @@ static snd_pcm_uframes_t  period_size;
 static const char *given_test_wav_file = NULL;
 static char *wav_file_dir = SOUNDSDIR;
 static int debug = 0;
+static int force_frequency = 0;
 static int in_aborting = 0;
 static snd_pcm_t *pcm_handle = NULL;
 
@@ -1015,6 +1016,7 @@ static void help(void)
 	   "-w,--wavfile	Use the given WAV file as a test sound\n"
 	   "-W,--wavdir	Specify the directory containing WAV files\n"
 	   "-m,--chmap	Specify the channel map to override\n"
+	   "-X,--force-frequency	force frequencies outside the 30-5000hz range\n"
 	   "\n"));
   printf(_("Recognized sample formats are:"));
   for (fmt = supported_formats; *fmt >= 0; fmt++) {
@@ -1057,6 +1059,7 @@ int main(int argc, char *argv[]) {
     {"wavfile",   1, NULL, 'w'},
     {"wavdir",    1, NULL, 'W'},
     {"debug",	  0, NULL, 'd'},
+    {"force-frequncy",	  1, NULL, 'X'},
 #ifdef CONFIG_SUPPORT_CHMAP
     {"chmap",	  1, NULL, 'm'},
 #endif
@@ -1078,7 +1081,7 @@ int main(int argc, char *argv[]) {
   while (1) {
     int c;
     
-    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d"
+    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d:X"
 #ifdef CONFIG_SUPPORT_CHMAP
 			 "m:"
 #endif
@@ -1114,8 +1117,6 @@ int main(int argc, char *argv[]) {
       break;
     case 'f':
       freq = atof(optarg);
-      freq = freq < 30.0 ? 30.0 : freq;
-      freq = freq > 5000.0 ? 5000.0 : freq;
       break;
     case 'b':
       buffer_time = atoi(optarg);
@@ -1173,6 +1174,9 @@ int main(int argc, char *argv[]) {
     case 'd':
       debug = 1;
       break;
+    case 'X':
+      force_frequency = 1;
+      break;
 #ifdef CONFIG_SUPPORT_CHMAP
     case 'm':
       chmap = optarg;
@@ -1190,6 +1194,11 @@ int main(int argc, char *argv[]) {
     exit(EXIT_SUCCESS);
   }
 
+  if (!force_frequency) {
+    freq = freq < 30.0 ? 30.0 : freq;
+    freq = freq > 5000.0 ? 5000.0 : freq;
+  }
+
   if (test_type == TEST_WAV)
     format = SND_PCM_FORMAT_S16_LE; /* fixed format */
 
-- 
1.8.3.2

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
