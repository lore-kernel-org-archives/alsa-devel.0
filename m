From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 5/5] test: audio_time: show report validity
	and accuracy
Date: Wed,  1 Jul 2015 15:40:58 -0500
Message-ID: <1435783258-23730-6-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1435783258-23730-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E916265068
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 22:41:33 +0200 (CEST)
In-Reply-To: <1435783258-23730-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add checks to show if driver reports valid report and resolution
information. disabled by default

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 test/audio_time.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/test/audio_time.c b/test/audio_time.c
index e369e59..a54c10d 100644
--- a/test/audio_time.c
+++ b/test/audio_time.c
@@ -33,6 +33,7 @@ static void usage(char *command)
 		"-D, --device=NAME       select PCM by name \n"
 		"-p, --playback          playback tstamps \n"
 		"-t, --ts_type=TYPE      Default(0),link(1),link_estimated(2),synchronized(3) \n"
+		"-r, --report            show audio timestamp and accuracy validity\n"
 		, command);
 }
 
@@ -128,7 +129,7 @@ int main(int argc, char *argv[])
 	snd_pcm_audio_tstamp_report_t audio_tstamp_report_c;
 
 	int option_index;
-	static const char short_options[] = "hcpdD:t:";
+	static const char short_options[] = "hcpdrD:t:";
 
 	static const struct option long_options[] = {
 		{"capture", 0, 0, 'c'},
@@ -137,6 +138,7 @@ int main(int argc, char *argv[])
 		{"help", no_argument, 0, 'h'},
 		{"playback", 0, 0, 'p'},
 		{"ts_type", required_argument, 0, 't'},
+		{"report", 0, 0, 'r'},
 		{0, 0, 0, 0}
 	};
 
@@ -144,6 +146,7 @@ int main(int argc, char *argv[])
 	int do_playback = 0;
 	int do_capture = 0;
 	int type = 0;
+	int do_report = 0;
 
 	while ((c = getopt_long(argc, argv, short_options, long_options, &option_index)) != -1) {
 		switch (c) {
@@ -165,6 +168,8 @@ int main(int argc, char *argv[])
 		case 't':
 			type = atoi(optarg);
 			break;
+		case 'r':
+			do_report = 1;
 		}
 	}
 
@@ -376,11 +381,19 @@ int main(int argc, char *argv[])
 				(long long)curr_count_c * 1000000000LL / SAMPLE_FREQ - timestamp2ns(audio_tstamp_c)
 				);
 #endif
+			if (do_report) {
+				if (audio_tstamp_report_c.valid == 0)
+					printf("Audio capture timestamp report invalid - ");
+				if (audio_tstamp_report_c.accuracy_report == 0)
+					printf("Audio capture timestamp accuracy report invalid");
+				printf("\n");
+			}
+
 
-			printf("\t capture: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli\n",
+			printf("\t capture: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli \t resolution %d ns \n", 
 				timediff(tstamp_c, trigger_tstamp_c),
 				timestamp2ns(audio_tstamp_c),
-				timediff(tstamp_c, trigger_tstamp_c) - timestamp2ns(audio_tstamp_c)
+				timediff(tstamp_c, trigger_tstamp_c) - timestamp2ns(audio_tstamp_c), audio_tstamp_report_c.accuracy
 				);
 #endif
 		}
@@ -411,11 +424,18 @@ int main(int argc, char *argv[])
 				(long long)curr_count_p * 1000000000LL / SAMPLE_FREQ - timestamp2ns(audio_tstamp_p)
 				);
 #endif
+			if (do_report) {
+				if (audio_tstamp_report_p.valid == 0)
+					printf("Audio playback timestamp report invalid - ");
+				if (audio_tstamp_report_p.accuracy_report == 0)
+					printf("Audio playback timestamp accuracy report invalid");
+				printf("\n");
+			}
 
-			printf("playback: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli\n",
+			printf("playback: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli resolution %d ns\n",
 				timediff(tstamp_p, trigger_tstamp_p),
 				timestamp2ns(audio_tstamp_p),
-				timediff(tstamp_p, trigger_tstamp_p) - timestamp2ns(audio_tstamp_p)
+				timediff(tstamp_p, trigger_tstamp_p) - timestamp2ns(audio_tstamp_p), audio_tstamp_report_p.accuracy
 				);
 #endif
 		}
-- 
1.9.1
