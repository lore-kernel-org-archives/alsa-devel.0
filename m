From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] speaker-test - update to add -s option for single shot single
 speaker test.
Date: Sun, 16 May 2004 01:47:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A6BA10.7020105@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090303070908080107040001"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090303070908080107040001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I attach a patch that updates the speaker-test program.
It corrects a few minor bugs as well as add a new -s option.

Diff is with the alsa-utils cvs.

Cheers
James

--------------090303070908080107040001
Content-Type: text/plain;
 name="speaker-test-diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="speaker-test-diff.txt"

Index: alsa-utils/speaker-test/readme.txt
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/speaker-test/readme.txt,v
retrieving revision 1.1
diff -u -r1.1 readme.txt
--- alsa-utils/speaker-test/readme.txt	10 May 2004 14:28:03 -0000	1.1
+++ alsa-utils/speaker-test/readme.txt	16 May 2004 00:20:23 -0000
@@ -4,9 +4,11 @@
 
 To test: -
 1) Just stereo sound from one stereo jack: -
-./speaker-test -Dfront -c 2
+./speaker-test -Dfront -c2
 2) A 4 speaker setup from two stereo jacks: -
-./speaker-test -Dsurround40 -c 4
+./speaker-test -Dsurround40 -c4
 3) A 5.1 speaker setup from three stereo jacks: -
-./speaker-test -Dsurround51 -c 6
+./speaker-test -Dsurround51 -c6
+4) To send a nice low 75Hz tone to the Woofer and then exit without touching any other speakers: -
+./speaker-test -Dplug:surround51 -c6 -s1 -f75
 
Index: alsa-utils/speaker-test/speaker-test.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/speaker-test/speaker-test.c,v
retrieving revision 1.1
diff -u -r1.1 speaker-test.c
--- alsa-utils/speaker-test/speaker-test.c	10 May 2004 14:28:03 -0000	1.1
+++ alsa-utils/speaker-test/speaker-test.c	16 May 2004 00:20:23 -0000
@@ -10,7 +10,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * xine is distributed in the hope that it will be useful,
+ * speaker-test is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
@@ -40,8 +40,9 @@
 
 static char              *device      = "plughw:0,0";       /* playback device */
 static snd_pcm_format_t   format      = SND_PCM_FORMAT_S16; /* sample format */
-static unsigned int       rate        = 44100;	            /* stream rate */
+static unsigned int       rate        = 48000;	            /* stream rate */
 static unsigned int       channels    = 1;	            /* count of channels */
+static unsigned int       speaker     = 0;	            /* count of channels */
 static unsigned int       buffer_time = 500000;	            /* ring buffer length in us */
 static unsigned int       period_time = 100000;	            /* period time in us */
 static double             freq        = 440;                /* sinusoidal wave frequency in Hz */
@@ -307,10 +308,9 @@
 }
 
 static void help(void) {
-  int k;
 
   printf(
-      "Usage: latency [OPTION]... [FILE]...\n"
+      "Usage: speaker-test [OPTION]... \n"
       "-h,--help	help\n"
       "-D,--device	playback device\n"
       "-r,--rate	stream rate in Hz\n"
@@ -318,8 +318,9 @@
       "-f,--frequency	sine wave frequency in Hz\n"
       "-b,--buffer	ring buffer size in us\n"
       "-p,--period	period size in us\n"
+      "-s,--speaker	single speaker test. Values 1=Left or 2=right\n"
       "\n");
-
+#if 0
   printf("Recognized sample formats are:");
   for (k = 0; k < SND_PCM_FORMAT_LAST; ++k) {
     const char *s = snd_pcm_format_name(k);
@@ -328,6 +329,8 @@
   }
 
   printf("\n\n");
+#endif
+
 }
 
 int main(int argc, char *argv[]) {
@@ -345,6 +348,7 @@
     {"frequency", 1, NULL, 'f'},
     {"buffer",    1, NULL, 'b'},
     {"period",    1, NULL, 'p'},
+    {"speaker",    1, NULL, 's'},
     {NULL,        0, NULL, 0  },
   };
 
@@ -357,7 +361,7 @@
   while (1) {
     int c;
     
-    if ((c = getopt_long(argc, argv, "hD:r:c:f:b:p:m:", long_option, NULL)) < 0)
+    if ((c = getopt_long(argc, argv, "hD:r:c:f:b:p:s:", long_option, NULL)) < 0)
       break;
     
     switch (c) {
@@ -392,6 +396,15 @@
       period_time = period_time < 1000 ? 1000 : period_time;
       period_time = period_time > 1000000 ? 1000000 : period_time;
       break;
+    case 's':
+      speaker = atoi(optarg);
+      speaker = speaker < 1 ? 0 : speaker;
+      speaker = speaker > channels ? 0 : speaker;
+      if (speaker==0) {
+        printf("Invalid parameter for -s option.\n");
+        exit(EXIT_FAILURE);
+      }  
+      break;
     default:
       printf("Unknown option '%c'\n", c);
       exit(EXIT_FAILURE);
@@ -433,21 +446,30 @@
     printf("No enough memory\n");
     exit(EXIT_FAILURE);
   }
+  if (speaker==0) {
+    while (1) {
 
-  while (1) {
-
-    for(chn = 0; chn < channels; chn++) {
-      printf("  - %s\n", channel_name[chn]);
+      for(chn = 0; chn < channels; chn++) {
+        printf("  - %s\n", channel_name[chn]);
 
-      err = write_loop(handle, chn, ((rate*5)/period_size), samples);
+        err = write_loop(handle, chn, ((rate*5)/period_size), samples);
 
-      if (err < 0) {
-        printf("Transfer failed: %s\n", snd_strerror(err));
-	exit(EXIT_FAILURE);
+        if (err < 0) {
+          printf("Transfer failed: %s\n", snd_strerror(err));
+	  exit(EXIT_FAILURE);
+        }
       }
     }
+  } else {
+    printf("  - %s\n", channel_name[speaker-1]);
+    err = write_loop(handle, speaker-1, ((rate*5)/period_size), samples);
+
+    if (err < 0) {
+      printf("Transfer failed: %s\n", snd_strerror(err));
+    }
   }
 
+
   free(samples);
   snd_pcm_close(handle);
 

--------------090303070908080107040001--


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
