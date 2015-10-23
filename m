From: Caleb Crome <caleb@crome.org>
Subject: [PATCH 2/2] BAT: convert from getopt_long to argp
Date: Fri, 23 Oct 2015 22:29:16 +0000
Message-ID: <1445639356-20343-2-git-send-email-caleb@crome.org>
References: <1445639356-20343-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BC14265112
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 00:29:22 +0200 (CEST)
Received: by padhk11 with SMTP id hk11so129327231pad.1
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 15:29:21 -0700 (PDT)
In-Reply-To: <1445639356-20343-1-git-send-email-caleb@crome.org>
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

Convert from getopt_long to argp in preparation for converting to
modular test framework.  This is to allow each module type to have
its own set of options.

argp allows multiple argument sets to be used, whereas
getopt_long is limited in that regard.

Signed-off-by: Caleb Crome <caleb@crome.org>
---
 bat/bat.c | 233 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 129 insertions(+), 104 deletions(-)

diff --git a/bat/bat.c b/bat/bat.c
index 9c046e6..36705c1 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -20,7 +20,8 @@
 #include <string.h>
 #include <errno.h>
 #include <pthread.h>
-#include <getopt.h>
+#include <argp.h>
+#include <error.h>
 #include <math.h>
 #include <limits.h>
 #include <locale.h>
@@ -283,37 +284,6 @@ static void test_capture(struct bat *bat)
 	}
 }
 
-static void usage(struct bat *bat)
-{
-	fprintf(bat->log,
-_("Usage: bat [-options]...\n"
-"\n"
-"  -h, --help             this help\n"
-"  -D                     pcm device for both playback and capture\n"
-"  -P                     pcm device for playback\n"
-"  -C                     pcm device for capture\n"
-"  -f                     sample format\n"
-"  -c                     number of channels\n"
-"  -r                     sampling rate\n"
-"  -n                     frames to playback or capture\n"
-"  -k                     parameter for frequency detecting threshold\n"
-"  -F                     target frequency\n"
-"  -p                     total number of periods to play/capture\n"
-"      --log=#            file that both stdout and strerr redirecting to\n"
-"      --file=#           file for playback\n"
-"      --saveplay=#       file that storing playback content, for debug\n"
-"      --local            internal loop, set to bypass pcm hardware devices\n"
-));
-	fprintf(bat->log, _("Recognized sample formats are: %s %s %s %s\n"),
-			snd_pcm_format_name(SND_PCM_FORMAT_U8),
-			snd_pcm_format_name(SND_PCM_FORMAT_S16_LE),
-			snd_pcm_format_name(SND_PCM_FORMAT_S24_3LE),
-			snd_pcm_format_name(SND_PCM_FORMAT_S32_LE));
-	fprintf(bat->log, _("The available format shotcuts are:\n"));
-	fprintf(bat->log, _("-f cd (16 bit little endian, 44100, stereo)\n"));
-	fprintf(bat->log, _("-f dat (16 bit little endian, 48000, stereo)\n"));
-}
-
 static void set_defaults(struct bat *bat)
 {
 	int i;
@@ -344,82 +314,136 @@ static void set_defaults(struct bat *bat)
 	bat->err = stderr;
 }
 
+
+static error_t parse_opt (int key, char *arg, struct argp_state *state)
+{
+	struct bat *bat = state->input;
+	switch (key) {
+	case OPT_LOG:
+		bat->logarg = arg;
+		break;
+	case OPT_READFILE:
+		bat->playback.file = arg;
+		break;
+	case OPT_SAVEPLAY:
+		bat->debugplay = arg;
+		break;
+	case OPT_LOCAL:
+		bat->local = true;
+		break;
+	case 'D':
+		if (bat->playback.device == NULL)
+			bat->playback.device = arg;
+		if (bat->capture.device == NULL)
+			bat->capture.device = arg;
+		break;
+	case 'P':
+		if (bat->capture.mode == MODE_SINGLE)
+			bat->capture.mode = MODE_LOOPBACK;
+		else
+			bat->playback.mode = MODE_SINGLE;
+		bat->playback.device = arg;
+		break;
+	case 'C':
+		if (bat->playback.mode == MODE_SINGLE)
+			bat->playback.mode = MODE_LOOPBACK;
+		else
+			bat->capture.mode = MODE_SINGLE;
+		bat->capture.device = arg;
+		break;
+	case 'n':
+		bat->narg = arg;
+		break;
+	case 'F':
+		get_sine_frequencies(bat, arg);
+		break;
+	case 'c':
+		bat->channels = atoi(arg);
+		break;
+	case 'r':
+		bat->rate = atoi(arg);
+		break;
+	case 'f':
+		get_format(bat, arg);
+		break;
+	case 'k':
+		bat->sigma_k = atof(arg);
+		break;
+	case 'p':
+		bat->periods_total = atoi(arg);
+		bat->period_is_limited = true;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+		break;
+	}
+	return 0;
+}
 static void parse_arguments(struct bat *bat, int argc, char *argv[])
 {
-	int c, option_index;
-	static const char short_options[] = "D:P:C:f:n:F:c:r:s:k:p:lth";
-	static const struct option long_options[] = {
-		{"help",     0, 0, 'h'},
-		{"log",      1, 0, OPT_LOG},
-		{"file",     1, 0, OPT_READFILE},
-		{"saveplay", 1, 0, OPT_SAVEPLAY},
-		{"local",    0, 0, OPT_LOCAL},
-		{0, 0, 0, 0}
+
+	const char doc[] =
+		"Basic Audio Tester\n"
+		"\n"
+		"Uses a loopback configuration or 2 PC configuration "
+		"(play on one PC and record on the other) to test "
+		"if if audio is flowing smoothly."
+		"\n"
+		"Full documentation in the bat man page and at "
+		"https://github.com/01org/bat/wiki"
+		"\n"
+		"Recognized sample formats are: %s %s %s %s\n"
+		"The available format shotcuts are:\n"
+		"\t-f cd (16 bit little endian, 44100, stereo)\n"
+		"\t-f dat (16 bit little endian, 48000, stereo)\n";
+
+	const char args_doc[] = "";
+
+	struct argp_option options[] = {
+		{"log", OPT_LOG, "FILENAME", 0,
+		 "file that both stdout and strerr redirecting to", 0},
+		{"file", OPT_READFILE, "FILENAME", 0,
+		 "file for playback",0},
+		{"saveplay", OPT_SAVEPLAY, "FILENAME", 0,
+		 "file for storing playback content, for debug", 0},
+		{"local", OPT_LOCAL, 0, 0,
+		 "internal loopback, set to bypass pcm hardware devices",0},
+		{"device-duplex", 'D', "DEVICE", 0,
+		 "pcm device for both playback and capture", 0},
+		{"device-playback", 'P', "DEVICE", 0,
+		 "pcm device for playback", 0},
+		{"device-capture", 'C', "DEVICE", 0,
+		 "pcm device for capture", 0},
+		{"sample_format" , 'f', "FORMAT", 0,
+		 "sample format", 0},
+		{"channels", 'c', "CHANNELS", 0,
+		 "number of channels", 0},
+		{"sample-rate", 'r', "SAMP/SEC", 0,
+		 "sampling rate", 0},
+		{"frames", 'n', "FRAMES", 0,
+		 "The number of frames for playback and/or capture", 0},
+		{"threshold", 'k', "THRESHOLD", 0,
+		 "parameter for frequency detecting threshold", 0},
+		{"target-frequency", 'F', "FREQUENCY", 0,
+		 "target frequency for sin test ", 0},
+		{"periods", 'p', "PERIODS", 0,
+		 "total number of periods to play/capture", 0},
+		{ 0 }
 	};
 
-	while ((c = getopt_long(argc, argv, short_options, long_options,
-					&option_index)) != -1) {
-		switch (c) {
-		case OPT_LOG:
-			bat->logarg = optarg;
-			break;
-		case OPT_READFILE:
-			bat->playback.file = optarg;
-			break;
-		case OPT_SAVEPLAY:
-			bat->debugplay = optarg;
-			break;
-		case OPT_LOCAL:
-			bat->local = true;
-			break;
-		case 'D':
-			if (bat->playback.device == NULL)
-				bat->playback.device = optarg;
-			if (bat->capture.device == NULL)
-				bat->capture.device = optarg;
-			break;
-		case 'P':
-			if (bat->capture.mode == MODE_SINGLE)
-				bat->capture.mode = MODE_LOOPBACK;
-			else
-				bat->playback.mode = MODE_SINGLE;
-			bat->playback.device = optarg;
-			break;
-		case 'C':
-			if (bat->playback.mode == MODE_SINGLE)
-				bat->playback.mode = MODE_LOOPBACK;
-			else
-				bat->capture.mode = MODE_SINGLE;
-			bat->capture.device = optarg;
-			break;
-		case 'n':
-			bat->narg = optarg;
-			break;
-		case 'F':
-			get_sine_frequencies(bat, optarg);
-			break;
-		case 'c':
-			bat->channels = atoi(optarg);
-			break;
-		case 'r':
-			bat->rate = atoi(optarg);
-			break;
-		case 'f':
-			get_format(bat, optarg);
-			break;
-		case 'k':
-			bat->sigma_k = atof(optarg);
-			break;
-		case 'p':
-			bat->periods_total = atoi(optarg);
-			bat->period_is_limited = true;
-			break;
-		case 'h':
-		default:
-			usage(bat);
-			exit(EXIT_SUCCESS);
-		}
-	}
+	char *doc_filled;
+
+	const int doc_size = strlen(doc) + 20*4;
+	doc_filled = malloc(doc_size);
+	snprintf(doc_filled, doc_size, doc,
+		 snd_pcm_format_name(SND_PCM_FORMAT_U8),
+		 snd_pcm_format_name(SND_PCM_FORMAT_S16_LE),
+		 snd_pcm_format_name(SND_PCM_FORMAT_S24_3LE),
+		 snd_pcm_format_name(SND_PCM_FORMAT_S32_LE));
+
+	struct argp  argp = {options, parse_opt, args_doc, doc_filled};
+	argp_parse(&argp, argc, argv, 0, 0, bat);
+	free(doc_filled);
 }
 
 static int validate_options(struct bat *bat)
@@ -498,6 +522,7 @@ static int bat_init(struct bat *bat)
 			fprintf(bat->err, _("Fail to create record file: %d\n"),
 					-errno);
 			return -errno;
+
 		}
 		/* store file name which is dynamically created */
 		bat->capture.file = strdup(name);
-- 
2.6.1
