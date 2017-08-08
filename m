From: Zhang Keqiao <keqiaox.k.zhang@linux.intel.com>
Subject: [PATCH] alsabat: fix the buffer size dependency issue
Date: Tue,  8 Aug 2017 22:31:38 +0800
Message-ID: <20170808143138.18439-1-keqiaox.k.zhang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E668A2664EB
 for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2017 16:34:25 +0200 (CEST)
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
Cc: keqiao.zhang@intel.com, Zhang Keqiao <keqiaox.k.zhang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

In round trip latency test, the latency time is depends on the buffer
size, before the test, it will playing one second 0 data to synchronize
the playback thread and the recording thread, then begin playing a ~1000
HZ sine wave and record it. Stop counting and playing if the input's
loudness is higher than the threshold. The issue here is before catching
the sine wave, the buffer is full with 0 data need to deal with, so this
latency is also counted.

This patch is intends to use flag to do the thread synchronization instead
of playing 0 data, once recording thread is ready, playing the ~1000 HZ
sine wave and start over this process until the final test is over.

Signed-off-by: Zhang Keqiao <keqiaox.k.zhang@linux.intel.com>
---
 bat/alsa.c        | 26 +++++++++++++++++++++++---
 bat/common.h      |  4 +++-
 bat/latencytest.c | 47 +++++++++++++++++++++++++----------------------
 3 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/bat/alsa.c b/bat/alsa.c
index 7613f44..5af7766 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -351,6 +351,14 @@ static int latencytest_process_output(struct pcm_container *sndpcm,
 
 	bat->latency.is_playing = true;
 
+	/* set playback ready */
+	bat->latency.state = LATENCY_STATE_PLAY_READY;
+
+	/* wait for capture ready */
+	while (bat->latency.state != LATENCY_STATE_RECORD_AND_LISTEN) {
+		usleep(10);
+	}
+
 	while (1) {
 		/* generate output data */
 		err = handleoutput(bat, sndpcm->buffer, bytes, frames);
@@ -365,10 +373,16 @@ static int latencytest_process_output(struct pcm_container *sndpcm,
 		if (bat->latency.xrun_error == true)
 			break;
 
+		/* Final test is over */
 		if (bat->latency.state == LATENCY_STATE_COMPLETE_SUCCESS)
 			break;
 
 		bat->periods_played++;
+
+		/* One time success, start over */
+		if (bat->latency.state == LATENCY_STATE_ONE_TIME_SUCCESS)
+			break;
+
 	}
 
 	bat->latency.is_playing = false;
@@ -441,6 +455,7 @@ void *playback_alsa(struct bat *bat)
 	int err = 0;
 	struct pcm_container sndpcm;
 
+LATENCY_TEST_START:
 	fprintf(bat->log, _("Entering playback thread (ALSA).\n"));
 
 	retval_play = 0;
@@ -501,6 +516,11 @@ exit3:
 	free(sndpcm.buffer);
 exit2:
 	snd_pcm_close(sndpcm.handle);
+
+/* Latency test is not finished, start over */
+	if (bat->latency.is_capturing == true)
+		goto LATENCY_TEST_START;
+
 exit1:
 	pthread_exit(&retval_play);
 }
@@ -641,15 +661,15 @@ static int latencytest_process_input(struct pcm_container *sndpcm,
 		if (err != 0)
 			break;
 
-		if (bat->latency.is_playing == false)
-			break;
-
 		/* write the chunk to file */
 		if (fwrite(sndpcm->buffer, 1, size, fp) != size) {
 			err = -EIO;
 			break;
 		}
 
+		if (bat->latency.state == LATENCY_STATE_COMPLETE_SUCCESS)
+			break;
+
 		bytes_read += size;
 	}
 
diff --git a/bat/common.h b/bat/common.h
index 1b07fbe..2ab3e86 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -158,8 +158,10 @@ enum latency_state {
 	LATENCY_STATE_COMPLETE_FAILURE = -1,
 	LATENCY_STATE_COMPLETE_SUCCESS = 0,
 	LATENCY_STATE_MEASURE_FOR_1_SECOND,
-	LATENCY_STATE_PLAY_AND_LISTEN,
+	LATENCY_STATE_PLAY_READY,
+	LATENCY_STATE_RECORD_AND_LISTEN,
 	LATENCY_STATE_WAITING,
+	LATENCY_STATE_ONE_TIME_SUCCESS,
 };
 
 struct pcm {
diff --git a/bat/latencytest.c b/bat/latencytest.c
index fae191c..e7727e9 100644
--- a/bat/latencytest.c
+++ b/bat/latencytest.c
@@ -55,8 +55,6 @@ static void play_and_listen(struct bat *bat, void *buffer, int frames)
 	int averageinput;
 	int n = 0;
 	float sum = 0;
-	float max = 0;
-	float min = 100000.0f;
 	short int *input;
 	int num = bat->latency.number;
 
@@ -69,17 +67,17 @@ static void play_and_listen(struct bat *bat, void *buffer, int frames)
 
 		/* Check the location when it became loud enough */
 		while (n < frames) {
-			if (*input++ > bat->latency.threshold)
+			if (*input > bat->latency.threshold)
 				break;
-			*input += bat->channels;
+			input += bat->channels;
 			n++;
 		}
 
 		/* Now we get the total round trip latency*/
 		bat->latency.samples += n;
 
-		/* Expect at least 1 buffer of round trip latency. */
-		if (bat->latency.samples > frames) {
+		/* Round trip latency may less than one buffer */
+		if (1) {
 			bat->latency.result[num - 1] =
 				(float) bat->latency.samples * 1000 / bat->rate;
 			fprintf(bat->log,
@@ -88,22 +86,14 @@ static void play_and_listen(struct bat *bat, void *buffer, int frames)
 					(int) bat->latency.result[num - 1]);
 
 			for (n = 0; n < num; n++) {
-				if (bat->latency.result[n] > max)
-					max = bat->latency.result[n];
-				if (bat->latency.result[n] < min)
-					min = bat->latency.result[n];
 				sum += bat->latency.result[n];
 			}
-
-			/* The maximum is higher than the minimum's double */
-			if (max / min > 2.0f) {
-				bat->latency.state =
-					LATENCY_STATE_COMPLETE_FAILURE;
-				bat->latency.is_capturing = false;
-				return;
+			/* This is unnecessary, round trip lantency can be less than one
+			 * period size, so this case is likely happen unless the period
+			 * size is samll enough than the round trip latency. */
 
 			/* Final results */
-			} else if (num == LATENCY_TEST_NUMBER) {
+			if (num == LATENCY_TEST_NUMBER) {
 				bat->latency.final_result =
 					(int) (sum / LATENCY_TEST_NUMBER);
 				fprintf(bat->log,
@@ -113,11 +103,12 @@ static void play_and_listen(struct bat *bat, void *buffer, int frames)
 				bat->latency.state =
 					LATENCY_STATE_COMPLETE_SUCCESS;
 				bat->latency.is_capturing = false;
+				bat->latency.is_playing = false;
 				return;
 
 			/* Next step */
 			} else
-				bat->latency.state = LATENCY_STATE_WAITING;
+				bat->latency.state = LATENCY_STATE_ONE_TIME_SUCCESS;
 
 			bat->latency.number++;
 
@@ -194,17 +185,23 @@ int handleinput(struct bat *bat, void *buffer, int frames)
 		/* 1 second elapsed */
 		if (bat->latency.samples >= bat->rate) {
 			calculate_threshold(bat);
-			bat->latency.state = LATENCY_STATE_PLAY_AND_LISTEN;
+			/* Capture preparation is ready, start the latency test */
+			bat->latency.state = LATENCY_STATE_RECORD_AND_LISTEN;
 			bat->latency.samples = 0;
 			bat->latency.sum = 0;
 		}
 		break;
 
 	/* Playing sine wave and listening if it comes back */
-	case LATENCY_STATE_PLAY_AND_LISTEN:
+	case LATENCY_STATE_RECORD_AND_LISTEN:
 		play_and_listen(bat, buffer, frames);
 		break;
 
+	/* playback is ready, trigger recording */
+	case LATENCY_STATE_PLAY_READY:
+		bat->latency.state = LATENCY_STATE_MEASURE_FOR_1_SECOND;
+		break;
+
 	/* Waiting 1 second */
 	case LATENCY_STATE_WAITING:
 		bat->latency.samples += frames;
@@ -216,6 +213,12 @@ int handleinput(struct bat *bat, void *buffer, int frames)
 		}
 		break;
 
+	/* wait for next round playback ready */
+	case LATENCY_STATE_ONE_TIME_SUCCESS:
+		if (bat->latency.state == LATENCY_STATE_PLAY_READY)
+			bat->latency.state = LATENCY_STATE_WAITING;
+		break;
+
 	default:
 		return 0;
 	}
@@ -232,7 +235,7 @@ int handleoutput(struct bat *bat, void *buffer, int bytes, int frames)
 			&& bat->latency.is_capturing == false)
 		return bat->latency.state;
 
-	if (bat->latency.state == LATENCY_STATE_PLAY_AND_LISTEN)
+	if (bat->latency.state == LATENCY_STATE_RECORD_AND_LISTEN)
 		err = generate_sine_wave(bat, frames, buffer);
 	else
 		/* Output silence */
-- 
2.9.3
