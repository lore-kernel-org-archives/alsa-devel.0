From: han.lu@intel.com
Subject: [PATCH V4 3/4] BAT: Change comments and interface of
	usage()
Date: Tue, 20 Oct 2015 16:45:47 +0800
Message-ID: <32cd61d012efbf11292d4719fa14a0be30677a91.1445330404.git.han.lu@intel.com>
References: <cover.1445330404.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D553026646C
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 10:48:42 +0200 (CEST)
In-Reply-To: <cover.1445330404.git.han.lu@intel.com>
In-Reply-To: <cover.1445330404.git.han.lu@intel.com>
References: <cover.1445330404.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

1. Change comment strings to make the descriptions more clear;
2. Add indent for option lines that have no indent;
3. Use a const string instead of argv[0] as program name.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat.c b/bat/bat.c
index 2320984..2be3efb 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -268,28 +268,27 @@ static void test_capture(struct bat *bat)
 	}
 }
 
-static void usage(struct bat *bat, char *argv[])
+static void usage(struct bat *bat)
 {
 	fprintf(bat->log,
-_("Usage:%s [Option]...\n"
+_("Usage: bat [-options]...\n"
 "\n"
-"-h, --help             help\n"
-"-D                     sound card\n"
-"-P                     playback pcm\n"
-"-C                     capture pcm\n"
-"-f                     sample size\n"
-"-c                     number of channels\n"
-"-r                     sampling rate\n"
-"-n                     frames to capture\n"
-"-k                     sigma k\n"
-"-F                     target frequency\n"
-"-p                     total number of periods to play/capture\n"
-"    --log=#            path of log file. if not set, logs be put to stdout,\n"
-"                       and errors be put to stderr.\n"
-"    --file=#           input file\n"
-"    --saveplay=#       save playback content to target file, for debug\n"
-"    --local            internal loop, bypass hardware\n"
-), argv[0]);
+"  -h, --help             this help\n"
+"  -D                     pcm device for both playback and capture\n"
+"  -P                     pcm device for playback\n"
+"  -C                     pcm device for capture\n"
+"  -f                     sample format\n"
+"  -c                     number of channels\n"
+"  -r                     sampling rate\n"
+"  -n                     frames to playback or capture\n"
+"  -k                     parameter for frequency detecting threshold\n"
+"  -F                     target frequency\n"
+"  -p                     total number of periods to play/capture\n"
+"      --log=#            file that both stdout and strerr redirecting to\n"
+"      --file=#           file for playback\n"
+"      --saveplay=#       file that storing playback content, for debug\n"
+"      --local            internal loop, set to bypass pcm hardware devices\n"
+));
 	fprintf(bat->log, _("Recognized sample formats are: %s %s %s %s\n"),
 			snd_pcm_format_name(SND_PCM_FORMAT_U8),
 			snd_pcm_format_name(SND_PCM_FORMAT_S16_LE),
@@ -402,7 +401,7 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 			break;
 		case 'h':
 		default:
-			usage(bat, argv);
+			usage(bat);
 			exit(EXIT_SUCCESS);
 		}
 	}
-- 
1.9.1
