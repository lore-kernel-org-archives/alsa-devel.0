From: han.lu@intel.com
Subject: [PATCH V3 3/4] BAT: Adjust parameters and strings
Date: Fri, 16 Oct 2015 16:12:05 +0800
Message-ID: <3a99986b04bfd6a0e845d91c9a22e1d3b85e6653.1444982584.git.han.lu@intel.com>
References: <cover.1444982584.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BBC2B26065A
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 10:14:38 +0200 (CEST)
In-Reply-To: <cover.1444982584.git.han.lu@intel.com>
In-Reply-To: <cover.1444982584.git.han.lu@intel.com>
References: <cover.1444982584.git.han.lu@intel.com>
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

Use rational parameters and clearer comments.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat.c b/bat/bat.c
index 2320984..02b1abd 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -268,16 +268,16 @@ static void test_capture(struct bat *bat)
 	}
 }
 
-static void usage(struct bat *bat, char *argv[])
+static void usage(struct bat *bat, const char *command)
 {
 	fprintf(bat->log,
 _("Usage:%s [Option]...\n"
 "\n"
 "-h, --help             help\n"
-"-D                     sound card\n"
+"-D                     pcm for both playback and capture\n"
 "-P                     playback pcm\n"
 "-C                     capture pcm\n"
-"-f                     sample size\n"
+"-f                     sample format\n"
 "-c                     number of channels\n"
 "-r                     sampling rate\n"
 "-n                     frames to capture\n"
@@ -289,7 +289,7 @@ _("Usage:%s [Option]...\n"
 "    --file=#           input file\n"
 "    --saveplay=#       save playback content to target file, for debug\n"
 "    --local            internal loop, bypass hardware\n"
-), argv[0]);
+), command);
 	fprintf(bat->log, _("Recognized sample formats are: %s %s %s %s\n"),
 			snd_pcm_format_name(SND_PCM_FORMAT_U8),
 			snd_pcm_format_name(SND_PCM_FORMAT_S16_LE),
@@ -402,7 +402,7 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 			break;
 		case 'h':
 		default:
-			usage(bat, argv);
+			usage(bat, argv[0]);
 			exit(EXIT_SUCCESS);
 		}
 	}
-- 
1.9.1
