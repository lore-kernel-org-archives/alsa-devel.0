From: Ion-Horia Petrisor <ion-horia.petrisor@nxp.com>
Subject: [RFC PATCH] aplay: Add samples argument for
	playing/recording a given number of samples
Date: Wed, 5 Jul 2017 14:03:51 +0300
Message-ID: <1499252631-11287-1-git-send-email-ion-horia.petrisor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0046.outbound.protection.outlook.com [104.47.34.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B901226698E
 for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2017 13:04:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, o-takashi@sakamocchi.jp
Cc: Ion-Horia Petrisor <ion-horia.petrisor@nxp.com>, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

-s --samples allows aplay to be used for playback/capture a given numbeer of samplese by channel

Signed-off-by: Ion-Horia Petrisor <ion-horia.petrisor@nxp.com>
---
This is just an RFC, we need to clarify the aplay raw format bug from:
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-July/122509.html

 aplay/aplay.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 00af662..6ee0866 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -100,6 +100,7 @@ static struct {
 	unsigned int rate;
 } hwparams, rhwparams;
 static int timelimit = 0;
+static int sampleslimit = 0;
 static int quiet_mode = 0;
 static int file_type = FORMAT_DEFAULT;
 static int open_mode = 0;
@@ -212,6 +213,7 @@ _("Usage: %s [OPTION]... [FILE]...\n"
 "-f, --format=FORMAT     sample format (case insensitive)\n"
 "-r, --rate=#            sample rate\n"
 "-d, --duration=#        interrupt after # seconds\n"
+"-s, --samples=#         interrupt after # samples per channel\n"
 "-M, --mmap              mmap stream\n"
 "-N, --nonblock          nonblocking mode\n"
 "-F, --period-time=#     distance between interrupts is # microseconds\n"
@@ -466,8 +468,9 @@ static long parse_long(const char *str, int *err)
 
 int main(int argc, char *argv[])
 {
+	int duration_or_sample = 0;
 	int option_index;
-	static const char short_options[] = "hnlLD:qt:c:f:r:d:MNF:A:R:T:B:vV:IPCi"
+	static const char short_options[] = "hnlLD:qt:c:f:r:d:s:MNF:A:R:T:B:vV:IPCi"
 #ifdef CONFIG_SUPPORT_CHMAP
 		"m:"
 #endif
@@ -485,6 +488,7 @@ int main(int argc, char *argv[])
 		{"format", 1, 0, 'f'},
 		{"rate", 1, 0, 'r'},
 		{"duration", 1, 0 ,'d'},
+		{"samples", 1, 0, 's'},
 		{"mmap", 0, 0, 'M'},
 		{"nonblock", 0, 0, 'N'},
 		{"period-time", 1, 0, 'F'},
@@ -640,11 +644,28 @@ int main(int argc, char *argv[])
 			}
 			break;
 		case 'd':
+			if (duration_or_sample) {
+				error(_("duration argument '%s' and samples argument cannot be used together"), optarg);
+				return 1;
+			}
 			timelimit = parse_long(optarg, &err);
 			if (err < 0) {
 				error(_("invalid duration argument '%s'"), optarg);
 				return 1;
 			}
+			duration_or_sample = 1;
+			break;
+		case 's':
+			if (duration_or_sample) {
+				error(_("samples argument '%s' and duration argument cannot be used together"), optarg);
+				return 1;
+			}
+			sampleslimit = parse_long(optarg, &err);
+			if (err < 0) {
+				error(_("invalid samples argument '%s'"), optarg);
+				return 1;
+			}
+			duration_or_sample = 1;
 			break;
 		case 'N':
 			nonblock = 1;
@@ -2477,9 +2498,12 @@ static off64_t calc_count(void)
 {
 	off64_t count;
 
-	if (timelimit == 0) {
-		count = pbrec_count;
-	} else {
+	if (timelimit == 0)
+		if (sampleslimit == 0)
+			count = pbrec_count;
+		else
+			count = snd_pcm_format_size(hwparams.format, sampleslimit * hwparams.channels);
+	else {
 		count = snd_pcm_format_size(hwparams.format, hwparams.rate * hwparams.channels);
 		count *= (off64_t)timelimit;
 	}
@@ -3125,7 +3149,7 @@ static void capture(char *orig_name)
 		/* repeat the loop when format is raw without timelimit or
 		 * requested counts of data are recorded
 		 */
-	} while ((file_type == FORMAT_RAW && !timelimit) || count > 0);
+	} while (((file_type == FORMAT_RAW && !timelimit) && !sampleslimit) || count > 0);
 }
 
 static void playbackv_go(int* fds, unsigned int channels, size_t loaded, off64_t count, int rtype, char **names)
-- 
2.7.4
