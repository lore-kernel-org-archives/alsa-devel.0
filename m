From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH] aplay: support no period wakeup option in
	argument
Date: Wed, 26 Dec 2018 11:28:11 +0000
Message-ID: <1545823678-15563-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150058.outbound.protection.outlook.com [40.107.15.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 17E272678D4
 for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2018 12:28:12 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

In the case that alsa driver can't support period wakeup,
we need to set the no period wakeup flag

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 aplay/aplay.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index efc1eb4cae3a..4f562bfe2884 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -137,6 +137,7 @@ static int use_strftime = 0;
 volatile static int recycle_capture_file = 0;
 static long term_c_lflag = -1;
 static int dump_hw_params = 0;
+static int no_period_wakeup = 0;
 
 static int fd = -1;
 static off64_t pbrec_count = LLONG_MAX, fdcount;
@@ -243,6 +244,7 @@ _("Usage: %s [OPTION]... [FILE]...\n"
 "    --use-strftime      apply the strftime facility to the output file name\n"
 "    --dump-hw-params    dump hw_params of the device\n"
 "    --fatal-errors      treat all errors as fatal\n"
+"    --no-period-wakeup  set no period wakeup flag if necessary\n"
   )
 		, command);
 	printf(_("Recognized sample formats are:"));
@@ -429,6 +431,7 @@ enum {
 	OPT_USE_STRFTIME,
 	OPT_DUMP_HWPARAMS,
 	OPT_FATAL_ERRORS,
+	OPT_NO_PERIOD_WAKEUP,
 };
 
 /*
@@ -516,6 +519,7 @@ int main(int argc, char *argv[])
 		{"interactive", 0, 0, 'i'},
 		{"dump-hw-params", 0, 0, OPT_DUMP_HWPARAMS},
 		{"fatal-errors", 0, 0, OPT_FATAL_ERRORS},
+		{"no-period-wakeup", 0, 0, OPT_NO_PERIOD_WAKEUP},
 #ifdef CONFIG_SUPPORT_CHMAP
 		{"chmap", 1, 0, 'm'},
 #endif
@@ -799,6 +803,9 @@ int main(int argc, char *argv[])
 		case OPT_FATAL_ERRORS:
 			fatal_errors = 1;
 			break;
+		case OPT_NO_PERIOD_WAKEUP:
+			no_period_wakeup = 1;
+			break;
 #ifdef CONFIG_SUPPORT_CHMAP
 		case 'm':
 			channel_map = snd_pcm_chmap_parse_string(optarg);
@@ -1396,6 +1403,12 @@ static void set_params(void)
 							     &buffer_frames);
 	}
 	assert(err >= 0);
+
+	if (no_period_wakeup) {
+		err = snd_pcm_hw_params_set_period_wakeup(handle, params, 0);
+		assert(err >= 0);
+	}
+
 	monotonic = snd_pcm_hw_params_is_monotonic(params);
 	can_pause = snd_pcm_hw_params_can_pause(params);
 	err = snd_pcm_hw_params(handle, params);
-- 
1.9.1
