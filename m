From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 5/5] test: fix audio_time with new get/set
	audio_tstamp_config
Date: Fri, 20 Feb 2015 18:28:14 -0600
Message-ID: <1424478494-5135-6-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1424478494-5135-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A22F2614B0
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 01:28:45 +0100 (CET)
In-Reply-To: <1424478494-5135-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 test/audio_time.c | 491 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 313 insertions(+), 178 deletions(-)

diff --git a/test/audio_time.c b/test/audio_time.c
index 7435db6..e369e59 100644
--- a/test/audio_time.c
+++ b/test/audio_time.c
@@ -4,13 +4,39 @@
  * helpful to verify the information reported by drivers.
  */
 
-#include "../include/asoundlib.h"
+#include <stdio.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <time.h>
+#include <locale.h>
 #include <math.h>
+#include "../include/asoundlib.h"
 
-static char *device = "hw:0,0";
-
+static char *command;
+static char *pcm_name = "hw:0";
 snd_output_t *output = NULL;
 
+static void usage(char *command)
+{
+	printf("Usage: %s [OPTION]... \n"
+		"\n"
+		"-h, --help              help\n"
+		"-c, --capture           capture tstamps \n"
+		"-d, --delay             add delay \n"
+		"-D, --device=NAME       select PCM by name \n"
+		"-p, --playback          playback tstamps \n"
+		"-t, --ts_type=TYPE      Default(0),link(1),link_estimated(2),synchronized(3) \n"
+		, command);
+}
+
+
 long long timestamp2ns(snd_htimestamp_t t)
 {
 	long long nsec;
@@ -31,15 +57,20 @@ long long timediff(snd_htimestamp_t t1, snd_htimestamp_t t2)
 	return nsec1 - nsec2;
 }
 
-void gettimestamp(snd_pcm_t *handle, snd_htimestamp_t *timestamp,
-		  snd_htimestamp_t *trigger_timestamp,
-		  snd_htimestamp_t *audio_timestamp,
-		  snd_pcm_uframes_t *avail, snd_pcm_sframes_t *delay)
+void _gettimestamp(snd_pcm_t *handle, snd_htimestamp_t *timestamp,
+		   snd_htimestamp_t *trigger_timestamp,
+		   snd_htimestamp_t *audio_timestamp,
+		   snd_pcm_audio_tstamp_config_t  *audio_tstamp_config,
+		   snd_pcm_audio_tstamp_report_t  *audio_tstamp_report,
+		   snd_pcm_uframes_t *avail, snd_pcm_sframes_t *delay)
 {
 	int err;
 	snd_pcm_status_t *status;
 
 	snd_pcm_status_alloca(&status);
+
+	snd_pcm_status_set_audio_htstamp_config(status, audio_tstamp_config);
+
 	if ((err = snd_pcm_status(handle, status)) < 0) {
 		printf("Stream status error: %s\n", snd_strerror(err));
 		exit(0);
@@ -47,26 +78,30 @@ void gettimestamp(snd_pcm_t *handle, snd_htimestamp_t *timestamp,
 	snd_pcm_status_get_trigger_htstamp(status, trigger_timestamp);
 	snd_pcm_status_get_htstamp(status, timestamp);
 	snd_pcm_status_get_audio_htstamp(status, audio_timestamp);
+	snd_pcm_status_get_audio_htstamp_report(status, audio_tstamp_report);
 	*avail = snd_pcm_status_get_avail(status);
 	*delay = snd_pcm_status_get_delay(status);
 }
 
-#define PERIOD 6000
+#define TIMESTAMP_FREQ 8 /* Hz */
+#define SAMPLE_FREQ 48000
+#define PERIOD (SAMPLE_FREQ/TIMESTAMP_FREQ)
 #define PCM_LINK        /* sync start for playback and capture */
 #define TRACK_CAPTURE   /* dump capture timing info  */
 #define TRACK_PLAYBACK  /* dump playback timing info */
-#define TRACK_SAMPLE_COUNTS /* show difference between sample counters and audiotimestamps returned by driver */
+/*#define TRACK_SAMPLE_COUNTS */ /* show difference between sample counters and audiotimestamps returned by driver */
 #define PLAYBACK_BUFFERS 4
-#define TSTAMP_TYPE	SND_PCM_TSTAMP_TYPE_MONOTONIC
+#define TSTAMP_TYPE	SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW
 
 
-int main(void)
+int main(int argc, char *argv[])
 {
-        int err;
-        unsigned int i;
-        snd_pcm_t *handle_p = NULL;
-        snd_pcm_t *handle_c = NULL;
-        snd_pcm_sframes_t frames;
+	int c;
+	int err;
+	unsigned int i;
+	snd_pcm_t *handle_p = NULL;
+	snd_pcm_t *handle_c = NULL;
+	snd_pcm_sframes_t frames;
 	snd_htimestamp_t tstamp_c, tstamp_p;
 	snd_htimestamp_t trigger_tstamp_c, trigger_tstamp_p;
 	snd_htimestamp_t audio_tstamp_c, audio_tstamp_p;
@@ -87,206 +122,306 @@ int main(void)
 	snd_pcm_sframes_t delay_p, delay_c;
 	snd_pcm_uframes_t avail_p, avail_c;
 
-	if ((err = snd_pcm_open(&handle_p, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
-		printf("Playback open error: %s\n", snd_strerror(err));
-		goto _exit;
-	}
-	if ((err = snd_pcm_set_params(handle_p,
-	                              SND_PCM_FORMAT_S16,
-	                              SND_PCM_ACCESS_RW_INTERLEAVED,
-	                              2,
-	                              48000,
-	                              0,
-	                              500000)) < 0) {	/* 0.5sec */
-		printf("Playback open error: %s\n", snd_strerror(err));
-		goto _exit;
+	snd_pcm_audio_tstamp_config_t audio_tstamp_config_p;
+	snd_pcm_audio_tstamp_config_t audio_tstamp_config_c;
+	snd_pcm_audio_tstamp_report_t audio_tstamp_report_p;
+	snd_pcm_audio_tstamp_report_t audio_tstamp_report_c;
+
+	int option_index;
+	static const char short_options[] = "hcpdD:t:";
+
+	static const struct option long_options[] = {
+		{"capture", 0, 0, 'c'},
+		{"delay", 0, 0, 'd'},
+		{"device", required_argument, 0, 'D'},
+		{"help", no_argument, 0, 'h'},
+		{"playback", 0, 0, 'p'},
+		{"ts_type", required_argument, 0, 't'},
+		{0, 0, 0, 0}
+	};
+
+	int do_delay = 0;
+	int do_playback = 0;
+	int do_capture = 0;
+	int type = 0;
+
+	while ((c = getopt_long(argc, argv, short_options, long_options, &option_index)) != -1) {
+		switch (c) {
+		case 'h':
+			usage(command);
+			return 0;
+		case 'p':
+			do_playback = 1;
+			break;
+		case 'c':
+			do_capture = 1;
+			break;
+		case 'd':
+			do_delay = 1;
+			break;
+		case 'D':
+			pcm_name = optarg;
+			break;
+		case 't':
+			type = atoi(optarg);
+			break;
+		}
 	}
 
-	snd_pcm_hw_params_alloca(&hwparams_p);
-	/* get the current hwparams */
-	err = snd_pcm_hw_params_current(handle_p, hwparams_p);
-	if (err < 0) {
-		printf("Unable to determine current hwparams_p: %s\n", snd_strerror(err));
-		goto _exit;
-	}
-	if (snd_pcm_hw_params_supports_audio_wallclock_ts(hwparams_p))
-		printf("Playback relies on audio wallclock timestamps\n");
-	else
-		printf("Playback relies on audio sample counter timestamps\n");
-
-	snd_pcm_sw_params_alloca(&swparams_p);
-	/* get the current swparams */
-	err = snd_pcm_sw_params_current(handle_p, swparams_p);
-	if (err < 0) {
-		printf("Unable to determine current swparams_p: %s\n", snd_strerror(err));
-		goto _exit;
-	}
+	memset(&audio_tstamp_config_p, 0, sizeof(snd_pcm_audio_tstamp_config_t));
+	memset(&audio_tstamp_config_c, 0, sizeof(snd_pcm_audio_tstamp_config_t));
+	memset(&audio_tstamp_report_p, 0, sizeof(snd_pcm_audio_tstamp_report_t));
+	memset(&audio_tstamp_report_c, 0, sizeof(snd_pcm_audio_tstamp_report_t));
 
-	/* enable tstamp */
-	err = snd_pcm_sw_params_set_tstamp_mode(handle_p, swparams_p, SND_PCM_TSTAMP_ENABLE);
-	if (err < 0) {
-		printf("Unable to set tstamp mode : %s\n", snd_strerror(err));
-		goto _exit;
-	}
+	if (do_playback) {
+		if ((err = snd_pcm_open(&handle_p, pcm_name, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
+			printf("Playback open error: %s\n", snd_strerror(err));
+			goto _exit;
+		}
 
-	err = snd_pcm_sw_params_set_tstamp_type(handle_p, swparams_p, TSTAMP_TYPE);
-	if (err < 0) {
-		printf("Unable to set tstamp type : %s\n", snd_strerror(err));
-		goto _exit;
-	}
+		if ((err = snd_pcm_set_params(handle_p,
+							SND_PCM_FORMAT_S16,
+							SND_PCM_ACCESS_RW_INTERLEAVED,
+							2,
+							SAMPLE_FREQ,
+							0,
+							4*1000000/TIMESTAMP_FREQ)) < 0) {
+			printf("Playback open error: %s\n", snd_strerror(err));
+			goto _exit;
+		}
 
-	/* write the sw parameters */
-	err = snd_pcm_sw_params(handle_p, swparams_p);
-	if (err < 0) {
-		printf("Unable to set swparams_p : %s\n", snd_strerror(err));
-		goto _exit;
-	}
+		snd_pcm_hw_params_alloca(&hwparams_p);
+/* get the current hwparams */
+		err = snd_pcm_hw_params_current(handle_p, hwparams_p);
+		if (err < 0) {
+			printf("Unable to determine current hwparams_p: %s\n", snd_strerror(err));
+			goto _exit;
+		}
 
-	if ((err = snd_pcm_open(&handle_c, device, SND_PCM_STREAM_CAPTURE, SND_PCM_NONBLOCK)) < 0) {
-		printf("Capture open error: %s\n", snd_strerror(err));
-		goto _exit;
-	}
-	if ((err = snd_pcm_set_params(handle_c,
-	                              SND_PCM_FORMAT_S16,
-	                              SND_PCM_ACCESS_RW_INTERLEAVED,
-	                              2,
-	                              48000,
-	                              0,
-	                              500000)) < 0) {	/* 0.5sec */
-		printf("Capture open error: %s\n", snd_strerror(err));
-		goto _exit;
-	}
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 0))
+			printf("Playback supports audio compat timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 1))
+			printf("Playback supports audio default timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 2))
+			printf("Playback supports audio link timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 3))
+			printf("Playback supports audio link absolute timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 4))
+			printf("Playback supports audio link estimated timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_p, 5))
+			printf("Playback supports audio link synchronized timestamps\n");
+
+		snd_pcm_sw_params_alloca(&swparams_p);
+		/* get the current swparams */
+		err = snd_pcm_sw_params_current(handle_p, swparams_p);
+		if (err < 0) {
+			printf("Unable to determine current swparams_p: %s\n", snd_strerror(err));
+			goto _exit;
+		}
 
-	snd_pcm_hw_params_alloca(&hwparams_c);
-	/* get the current hwparams */
-	err = snd_pcm_hw_params_current(handle_c, hwparams_c);
-	if (err < 0) {
-		printf("Unable to determine current hwparams_c: %s\n", snd_strerror(err));
-		goto _exit;
-	}
-	if (snd_pcm_hw_params_supports_audio_wallclock_ts(hwparams_c))
-		printf("Capture relies on audio wallclock timestamps\n");
-	else
-		printf("Capture relies on audio sample counter timestamps\n");
-
-	snd_pcm_sw_params_alloca(&swparams_c);
-	/* get the current swparams */
-	err = snd_pcm_sw_params_current(handle_c, swparams_c);
-	if (err < 0) {
-		printf("Unable to determine current swparams_c: %s\n", snd_strerror(err));
-		goto _exit;
-	}
+		/* enable tstamp */
+		err = snd_pcm_sw_params_set_tstamp_mode(handle_p, swparams_p, SND_PCM_TSTAMP_ENABLE);
+		if (err < 0) {
+			printf("Unable to set tstamp mode : %s\n", snd_strerror(err));
+			goto _exit;
+		}
 
-	/* enable tstamp */
-	err = snd_pcm_sw_params_set_tstamp_mode(handle_c, swparams_c, SND_PCM_TSTAMP_ENABLE);
-	if (err < 0) {
-		printf("Unable to set tstamp mode : %s\n", snd_strerror(err));
-		goto _exit;
-	}
+		err = snd_pcm_sw_params_set_tstamp_type(handle_p, swparams_p, TSTAMP_TYPE);
+		if (err < 0) {
+			printf("Unable to set tstamp type : %s\n", snd_strerror(err));
+			goto _exit;
+		}
+
+		/* write the sw parameters */
+		err = snd_pcm_sw_params(handle_p, swparams_p);
+		if (err < 0) {
+			printf("Unable to set swparams_p : %s\n", snd_strerror(err));
+			goto _exit;
+		}
 
-	err = snd_pcm_sw_params_set_tstamp_type(handle_c, swparams_c, TSTAMP_TYPE);
-	if (err < 0) {
-		printf("Unable to set tstamp type : %s\n", snd_strerror(err));
-		goto _exit;
 	}
 
-	/* write the sw parameters */
-	err = snd_pcm_sw_params(handle_c, swparams_c);
-	if (err < 0) {
-		printf("Unable to set swparams_c : %s\n", snd_strerror(err));
-		goto _exit;
+	if (do_capture) {
+
+		if ((err = snd_pcm_open(&handle_c, pcm_name, SND_PCM_STREAM_CAPTURE, SND_PCM_NONBLOCK)) < 0) {
+			printf("Capture open error: %s\n", snd_strerror(err));
+			goto _exit;
+		}
+		if ((err = snd_pcm_set_params(handle_c,
+							SND_PCM_FORMAT_S16,
+							SND_PCM_ACCESS_RW_INTERLEAVED,
+							2,
+							SAMPLE_FREQ,
+							0,
+							4*1000000/TIMESTAMP_FREQ)) < 0) {
+			printf("Capture open error: %s\n", snd_strerror(err));
+			goto _exit;
+		}
+
+		snd_pcm_hw_params_alloca(&hwparams_c);
+		/* get the current hwparams */
+		err = snd_pcm_hw_params_current(handle_c, hwparams_c);
+		if (err < 0) {
+			printf("Unable to determine current hwparams_c: %s\n", snd_strerror(err));
+			goto _exit;
+		}
+
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 0))
+			printf("Capture supports audio compat timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 1))
+			printf("Capture supports audio default timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 2))
+			printf("Capture supports audio link timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 3))
+			printf("Capture supports audio link absolute timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 4))
+			printf("Capture supports audio link estimated timestamps\n");
+		if (snd_pcm_hw_params_supports_audio_ts_type(hwparams_c, 5))
+			printf("Capture supports audio link synchronized timestamps\n");
+
+		snd_pcm_sw_params_alloca(&swparams_c);
+		/* get the current swparams */
+		err = snd_pcm_sw_params_current(handle_c, swparams_c);
+		if (err < 0) {
+			printf("Unable to determine current swparams_c: %s\n", snd_strerror(err));
+			goto _exit;
+		}
+
+		/* enable tstamp */
+		err = snd_pcm_sw_params_set_tstamp_mode(handle_c, swparams_c, SND_PCM_TSTAMP_ENABLE);
+		if (err < 0) {
+			printf("Unable to set tstamp mode : %s\n", snd_strerror(err));
+			goto _exit;
+		}
+
+		err = snd_pcm_sw_params_set_tstamp_type(handle_c, swparams_c, TSTAMP_TYPE);
+		if (err < 0) {
+			printf("Unable to set tstamp type : %s\n", snd_strerror(err));
+			goto _exit;
+		}
+
+		/* write the sw parameters */
+		err = snd_pcm_sw_params(handle_c, swparams_c);
+		if (err < 0) {
+			printf("Unable to set swparams_c : %s\n", snd_strerror(err));
+			goto _exit;
+		}
 	}
 
+	if (do_playback && do_capture) {
 #ifdef PCM_LINK
-	if ((err = snd_pcm_link(handle_c, handle_p)) < 0) {
-		printf("Streams link error: %s\n", snd_strerror(err));
-		exit(0);
-	}
+		if ((err = snd_pcm_link(handle_c, handle_p)) < 0) {
+			printf("Streams link error: %s\n", snd_strerror(err));
+			exit(0);
+		}
 #endif
-
-	i = PLAYBACK_BUFFERS;
-	while (i--) {
-                frames = snd_pcm_writei(handle_p, buffer_p, PERIOD);
-                if (frames < 0) {
-                        printf("snd_pcm_writei failed: %s\n", snd_strerror(frames));
-                        goto _exit;
-                }
-		frame_count_p += frames;
 	}
 
-	if (PLAYBACK_BUFFERS != 4)
-		snd_pcm_start(handle_p);
+	if (do_playback) {
+		i = PLAYBACK_BUFFERS;
+		while (i--) {
+			frames = snd_pcm_writei(handle_p, buffer_p, PERIOD);
+			if (frames < 0) {
+				printf("snd_pcm_writei failed: %s\n", snd_strerror(frames));
+				goto _exit;
+			}
+			frame_count_p += frames;
+		}
+
+		if (PLAYBACK_BUFFERS != 4)
+			snd_pcm_start(handle_p);
+	}
 
+	if (do_capture) {
 #ifndef PCM_LINK
-	/* need to start capture explicitly */
-	snd_pcm_start(handle_c);
+		/* need to start capture explicitly */
+		snd_pcm_start(handle_c);
+#else
+		if (!do_playback)
+			/* need to start capture explicitly */
+			snd_pcm_start(handle_c);
 #endif
+	}
 
-        while (1) {
-
-		frames = snd_pcm_wait(handle_c, -1);
-		if (frames < 0) {
-			printf("snd_pcm_wait failed: %s\n", snd_strerror(frames));
-                        goto _exit;
-		}
-
-		frames = snd_pcm_readi(handle_c, buffer_c, PERIOD);
-                if (frames < 0) {
-                        printf("snd_pcm_readi failed: %s\n", snd_strerror(frames));
-                        goto _exit;
-                }
-		frame_count_c += frames;
+	while (1) {
 
-                frames = snd_pcm_writei(handle_p, buffer_p, PERIOD);
-                if (frames < 0) {
-                        printf("snd_pcm_writei failed: %s\n", snd_strerror(frames));
-                        goto _exit;
-                }
+		if (do_capture) {
 
-		frame_count_p += frames;
+			frames = snd_pcm_wait(handle_c, -1);
+			if (frames < 0) {
+				printf("snd_pcm_wait failed: %s\n", snd_strerror(frames));
+				goto _exit;
+			}
 
-#if defined(TRACK_PLAYBACK)
-		gettimestamp(handle_p, &tstamp_p, &trigger_tstamp_p, &audio_tstamp_p, &avail_p, &delay_p);
+			frames = snd_pcm_readi(handle_c, buffer_c, PERIOD);
+			if (frames < 0) {
+				printf("snd_pcm_readi failed: %s\n", snd_strerror(frames));
+				goto _exit;
+			}
+			frame_count_c += frames;
 
+#if defined(TRACK_CAPTURE)
+			audio_tstamp_config_c.type_requested = type;
+			audio_tstamp_config_c.report_delay = do_delay;
+			_gettimestamp(handle_c, &tstamp_c, &trigger_tstamp_c,
+				&audio_tstamp_c, &audio_tstamp_config_c, &audio_tstamp_report_c,
+				&avail_c, &delay_c);
 #if defined(TRACK_SAMPLE_COUNTS)
-		curr_count_p = frame_count_p - delay_p; /* written minus queued */
+			curr_count_c = frame_count_c + delay_c; /* read plus queued */
 
-		printf("playback: curr_count %lli driver count %lli, delta %lli\n",
-		       (long long)curr_count_p * 1000000000LL / 48000 ,
-		       timestamp2ns(audio_tstamp_p),
-		       (long long)curr_count_p * 1000000000LL / 48000 - timestamp2ns(audio_tstamp_p)
-		       );
+
+			printf("capture: curr_count %lli driver count %lli, delta %lli\n",
+				(long long)curr_count_c * 1000000000LL / SAMPLE_FREQ ,
+				timestamp2ns(audio_tstamp_c),
+				(long long)curr_count_c * 1000000000LL / SAMPLE_FREQ - timestamp2ns(audio_tstamp_c)
+				);
 #endif
 
-		printf("playback: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli\n",
-		       timediff(tstamp_p, trigger_tstamp_p),
-		       timestamp2ns(audio_tstamp_p),
-		       timediff(tstamp_p, trigger_tstamp_p) - timestamp2ns(audio_tstamp_p)
-		       );
+			printf("\t capture: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli\n",
+				timediff(tstamp_c, trigger_tstamp_c),
+				timestamp2ns(audio_tstamp_c),
+				timediff(tstamp_c, trigger_tstamp_c) - timestamp2ns(audio_tstamp_c)
+				);
 #endif
+		}
 
-#if defined(TRACK_CAPTURE)
-		gettimestamp(handle_c, &tstamp_c, &trigger_tstamp_c, &audio_tstamp_c, &avail_c, &delay_c);
+		if (do_playback) {
+			frames = snd_pcm_writei(handle_p, buffer_p, PERIOD);
+			if (frames < 0) {
+				printf("snd_pcm_writei failed: %s\n", snd_strerror(frames));
+				goto _exit;
+			}
 
-#if defined(TRACK_SAMPLE_COUNTS)
-		curr_count_c = frame_count_c + delay_c; /* read plus queued */
+			frame_count_p += frames;
+
+#if defined(TRACK_PLAYBACK)
 
+			audio_tstamp_config_p.type_requested = type;
+			audio_tstamp_config_p.report_delay = do_delay;
+			_gettimestamp(handle_p, &tstamp_p, &trigger_tstamp_p,
+				&audio_tstamp_p, &audio_tstamp_config_p, &audio_tstamp_report_p,
+				&avail_p, &delay_p);
 
-		printf("capture: curr_count %lli driver count %lli, delta %lli\n",
-		       (long long)curr_count_c * 1000000000LL / 48000 ,
-		       timestamp2ns(audio_tstamp_c),
-		       (long long)curr_count_c * 1000000000LL / 48000 - timestamp2ns(audio_tstamp_c)
-		       );
+#if defined(TRACK_SAMPLE_COUNTS)
+			curr_count_p = frame_count_p - delay_p; /* written minus queued */
+
+			printf("playback: curr_count %lli driver count %lli, delta %lli\n",
+				(long long)curr_count_p * 1000000000LL / SAMPLE_FREQ ,
+				timestamp2ns(audio_tstamp_p),
+				(long long)curr_count_p * 1000000000LL / SAMPLE_FREQ - timestamp2ns(audio_tstamp_p)
+				);
 #endif
 
-		printf("\t capture: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli\n",
-		       timediff(tstamp_c, trigger_tstamp_c),
-		       timestamp2ns(audio_tstamp_c),
-		       timediff(tstamp_c, trigger_tstamp_c) - timestamp2ns(audio_tstamp_c)
-		       );
+			printf("playback: systime: %lli nsec, audio time %lli nsec, \tsystime delta %lli\n",
+				timediff(tstamp_p, trigger_tstamp_p),
+				timestamp2ns(audio_tstamp_p),
+				timediff(tstamp_p, trigger_tstamp_p) - timestamp2ns(audio_tstamp_p)
+				);
 #endif
+		}
+
 
-        }
+	} /* while(1) */
 
 _exit:
 	if (handle_p)
-- 
1.9.1
