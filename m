From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH] aplay/arecord: option to treat any xrun as
	fatal
Date: Thu, 15 Mar 2012 23:51:02 -0400
Message-ID: <1331869862-10227-1-git-send-email-bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog138.obsmtp.com [74.125.149.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 425C310467E
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 04:51:30 +0100 (CET)
Received: by mail-iy0-f175.google.com with SMTP id g37so5842017iaa.34
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 20:51:27 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 aplay/aplay.1 |    4 ++++
 aplay/aplay.c |   17 +++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/aplay/aplay.1 b/aplay/aplay.1
index 0195322..bf9b53e 100644
--- a/aplay/aplay.1
+++ b/aplay/aplay.1
@@ -191,6 +191,10 @@ lists capabilities of the selected device such as supported formats,
 sampling rates, numbers of channels, period and buffer bytes/sizes/times.
 For raw device hw:X this option basically lists hardware capabilities of
 the soundcard.
+.TP
+\fI\-\-fatal\-errors\fP
+Disables recovery attempts when errors (e.g. xrun) are encountered; the
+aplay process instead aborts immediately.
 
 .SH SIGNALS
 When recording, SIGINT, SIGTERM and SIGABRT will close the output 
diff --git a/aplay/aplay.c b/aplay/aplay.c
index 0633cbd..1ce34c4 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -115,6 +115,7 @@ static int stop_delay = 0;
 static int monotonic = 0;
 static int interactive = 0;
 static int can_pause = 0;
+static int fatal_errors = 0;
 static int verbose = 0;
 static int vumeter = VUMETER_NONE;
 static int buffer_pos = 0;
@@ -225,7 +226,8 @@ _("Usage: %s [OPTION]... [FILE]...\n"
 "                        for this many seconds\n"
 "    --process-id-file   write the process ID here\n"
 "    --use-strftime      apply the strftime facility to the output file name\n"
-"    --dump-hw-params    dump hw_params of the device\n")
+"    --dump-hw-params    dump hw_params of the device\n"
+"    --fatal-errors      treat all errors as fatal\n")
 		, command);
 	printf(_("Recognized sample formats are:"));
 	for (k = 0; k < SND_PCM_FORMAT_LAST; ++k) {
@@ -419,7 +421,8 @@ enum {
 	OPT_MAX_FILE_TIME,
 	OPT_PROCESS_ID_FILE,
 	OPT_USE_STRFTIME,
-	OPT_DUMP_HWPARAMS
+	OPT_DUMP_HWPARAMS,
+	OPT_FATAL_ERRORS,
 };
 
 int main(int argc, char *argv[])
@@ -465,6 +468,7 @@ int main(int argc, char *argv[])
 		{"use-strftime", 0, 0, OPT_USE_STRFTIME},
 		{"interactive", 0, 0, 'i'},
 		{"dump-hw-params", 0, 0, OPT_DUMP_HWPARAMS},
+		{"fatal-errors", 0, 0, OPT_FATAL_ERRORS},
 		{0, 0, 0, 0}
 	};
 	char *pcm_name = "default";
@@ -669,6 +673,9 @@ int main(int argc, char *argv[])
 		case OPT_DUMP_HWPARAMS:
 			dump_hw_params = 1;
 			break;
+		case OPT_FATAL_ERRORS:
+			fatal_errors = 1;
+			break;
 		default:
 			fprintf(stderr, _("Try `%s --help' for more information.\n"), command);
 			return 1;
@@ -1350,6 +1357,12 @@ static void xrun(void)
 		prg_exit(EXIT_FAILURE);
 	}
 	if (snd_pcm_status_get_state(status) == SND_PCM_STATE_XRUN) {
+		if (fatal_errors) {
+			error(_("fatal %s: %s"),
+					stream == SND_PCM_STREAM_PLAYBACK ? _("underrun") : _("overrun"),
+					snd_strerror(res));
+			prg_exit(EXIT_FAILURE);
+		}
 		if (monotonic) {
 #ifdef HAVE_CLOCK_GETTIME
 			struct timespec now, diff, tstamp;
-- 
1.7.4.1
