From: pavel.hofman@ivitera.com
Subject: [PATCH - aplay 1/1] aplay - option to dump HW
	parameters
Date: Fri,  2 Mar 2012 20:32:58 +0000
Message-ID: <1330720378-24855-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

Dumping HW parameters of the current device with snd_pcm_hw_params_dump,
a new option --dump-hw-params added.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/aplay/aplay.1 b/aplay/aplay.1
index 2acaed5..218d0b5 100644
--- a/aplay/aplay.1
+++ b/aplay/aplay.1
@@ -184,6 +184,9 @@ the month, %H hour, %M minute and %S second.  In addition, %v is
 the file number, starting at 1.  When this option is specified,
 intermediate directories for the output file are created automatically.
 This option has no effect if \-\-separate\-channels is specified.
+.TP
+\fI\-\-dump\-hw\-params\fP
+Dump HW parameters of the given device to stderr.
 
 .SH SIGNALS
 When recording, SIGINT, SIGTERM and SIGABRT will close the output 
diff --git a/aplay/aplay.c b/aplay/aplay.c
index 73a9544..0633cbd 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -129,6 +129,7 @@ static int max_file_time = 0;
 static int use_strftime = 0;
 volatile static int recycle_capture_file = 0;
 static long term_c_lflag = -1;
+static int dump_hw_params = 0;
 
 static int fd = -1;
 static off64_t pbrec_count = LLONG_MAX, fdcount;
@@ -223,7 +224,8 @@ _("Usage: %s [OPTION]... [FILE]...\n"
 "    --max-file-time=#   start another output file when the old file has recorded\n"
 "                        for this many seconds\n"
 "    --process-id-file   write the process ID here\n"
-"    --use-strftime      apply the strftime facility to the output file name\n")
+"    --use-strftime      apply the strftime facility to the output file name\n"
+"    --dump-hw-params    dump hw_params of the device\n")
 		, command);
 	printf(_("Recognized sample formats are:"));
 	for (k = 0; k < SND_PCM_FORMAT_LAST; ++k) {
@@ -416,7 +418,8 @@ enum {
 	OPT_TEST_NOWAIT,
 	OPT_MAX_FILE_TIME,
 	OPT_PROCESS_ID_FILE,
-	OPT_USE_STRFTIME
+	OPT_USE_STRFTIME,
+	OPT_DUMP_HWPARAMS
 };
 
 int main(int argc, char *argv[])
@@ -461,6 +464,7 @@ int main(int argc, char *argv[])
 		{"process-id-file", 1, 0, OPT_PROCESS_ID_FILE},
 		{"use-strftime", 0, 0, OPT_USE_STRFTIME},
 		{"interactive", 0, 0, 'i'},
+		{"dump-hw-params", 0, 0, OPT_DUMP_HWPARAMS},
 		{0, 0, 0, 0}
 	};
 	char *pcm_name = "default";
@@ -662,6 +666,9 @@ int main(int argc, char *argv[])
 		case OPT_USE_STRFTIME:
 			use_strftime = 1;
 			break;
+		case OPT_DUMP_HWPARAMS:
+			dump_hw_params = 1;
+			break;
 		default:
 			fprintf(stderr, _("Try `%s --help' for more information.\n"), command);
 			return 1;
@@ -1059,6 +1066,13 @@ static void set_params(void)
 		error(_("Broken configuration for this PCM: no configurations available"));
 		prg_exit(EXIT_FAILURE);
 	}
+	if (dump_hw_params) {
+		fprintf(stderr, _("HW Params of device \"%s\":\n"),
+			snd_pcm_name(handle));
+		fprintf(stderr, "--------------------\n");
+		snd_pcm_hw_params_dump(params, log);
+		fprintf(stderr, "--------------------\n");
+	}
 	if (mmap_flag) {
 		snd_pcm_access_mask_t *mask = alloca(snd_pcm_access_mask_sizeof());
 		snd_pcm_access_mask_none(mask);
-- 
1.7.0.4
