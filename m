From: nebelbank@posteo.de
Subject: [PATCH v2 1/1] aplay/arecord: handle parsing errors of
	parameter values
Date: Fri, 11 Mar 2016 11:40:30 +0000
Message-ID: <1457696430-3781-1-git-send-email-nebelbank@posteo.de>
References: <s5h4mce9lsa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 059902606AB
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 12:40:46 +0100 (CET)
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
 by mout01.posteo.de (Postfix) with ESMTPS id 2F5A4209C1
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 12:40:46 +0100 (CET)
In-Reply-To: <s5h4mce9lsa.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, erwin <nebelbank@posteo.de>
List-Id: alsa-devel@alsa-project.org

From: erwin <nebelbank@posteo.de>

when a user enters a command, he expects his command to be executed
as specified or aborted if it is impossible to fulfill his request

right now a command like "arecord -d hw:1,0 --max-file-time 1h recording.wav"
will happily record something and exit without error status while the resulting
recording contains definitely not what the user requested

to fix this, the patch handles the number parsing function's error channel
and checks whether the parsed number has any trailing characters

Signed-off-by: erwin <nebelbank@posteo.de>

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 7eacee3..7acaa83 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -427,6 +427,22 @@ enum {
 	OPT_FATAL_ERRORS,
 };
 
+static long parse_long(const char *str, int *err)
+{
+	long val;
+	char *endptr;
+
+	errno = 0;
+	val = strtol(str, &endptr, 0);
+
+	if (errno != 0 || *endptr != '\0')
+		*err = -1;
+	else
+		*err = 0;
+
+	return val;
+}
+
 int main(int argc, char *argv[])
 {
 	int option_index;
@@ -558,7 +574,11 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'c':
-			rhwparams.channels = strtol(optarg, NULL, 0);
+			rhwparams.channels = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid channels argument '%s'"), optarg);
+				return 1;
+			}
 			if (rhwparams.channels < 1 || rhwparams.channels > 256) {
 				error(_("value %i for channels is invalid"), rhwparams.channels);
 				return 1;
@@ -585,7 +605,11 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'r':
-			tmp = strtol(optarg, NULL, 0);
+			tmp = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid rate argument '%s'"), optarg);
+				return 1;
+			}
 			if (tmp < 300)
 				tmp *= 1000;
 			rhwparams.rate = tmp;
@@ -595,32 +619,64 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'd':
-			timelimit = strtol(optarg, NULL, 0);
+			timelimit = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid duration argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case 'N':
 			nonblock = 1;
 			open_mode |= SND_PCM_NONBLOCK;
 			break;
 		case 'F':
-			period_time = strtol(optarg, NULL, 0);
+			period_time = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid period time argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case 'B':
-			buffer_time = strtol(optarg, NULL, 0);
+			buffer_time = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid buffer time argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case OPT_PERIOD_SIZE:
-			period_frames = strtol(optarg, NULL, 0);
+			period_frames = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid period size argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case OPT_BUFFER_SIZE:
-			buffer_frames = strtol(optarg, NULL, 0);
+			buffer_frames = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid buffer size argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case 'A':
-			avail_min = strtol(optarg, NULL, 0);
+			avail_min = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid min available space argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case 'R':
-			start_delay = strtol(optarg, NULL, 0);
+			start_delay = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid start delay argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case 'T':
-			stop_delay = strtol(optarg, NULL, 0);
+			stop_delay = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid stop delay argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case 'v':
 			verbose++;
@@ -671,7 +727,11 @@ int main(int argc, char *argv[])
 			test_position = 1;
 			break;
 		case OPT_TEST_COEF:
-			test_coef = strtol(optarg, NULL, 0);
+			test_coef = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid test coef argument '%s'"), optarg);
+				return 1;
+			}
 			if (test_coef < 1)
 				test_coef = 1;
 			break;
@@ -679,7 +739,11 @@ int main(int argc, char *argv[])
 			test_nowait = 1;
 			break;
 		case OPT_MAX_FILE_TIME:
-			max_file_time = strtol(optarg, NULL, 0);
+			max_file_time = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid max file time argument '%s'"), optarg);
+				return 1;
+			}
 			break;
 		case OPT_PROCESS_ID_FILE:
 			pidfile_name = optarg;
-- 
2.5.0
