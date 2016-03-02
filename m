From: han.lu@intel.com
Subject: [PATCH 07/10] alsabat: add interrupt handler for
	shutdown
Date: Wed,  2 Mar 2016 16:53:17 +0800
Message-ID: <8584931850982f157bbf6fbadd016392fed86654.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 27101261515
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 09:51:15 +0100 (CET)
In-Reply-To: <cover.1456907242.git.han.lu@intel.com>
In-Reply-To: <cover.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, bernard.gautier@intel.com, edward.c.popescu@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add ctrl-c capturing for playback thread and capture thread to
shutdown cleanly.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 905be6e..443ede8 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <pthread.h>
+#include <signal.h>
 
 #include <alsa/asoundlib.h>
 
@@ -256,7 +257,7 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 		}
 	}
 
-	while (1) {
+	do {
 		err = generate_input_data(bat, sndpcm->buffer, bytes, frames);
 		if (err != 0)
 			break;
@@ -278,7 +279,7 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 		err = write_to_pcm(sndpcm, frames, bat);
 		if (err != 0)
 			return err;
-	}
+	} while (is_playing);
 
 	if (bat->debugplay) {
 		err = update_wav_header(bat, fp, bytes_total);
@@ -342,6 +343,9 @@ void *playback_alsa(struct bat *bat)
 		}
 	}
 
+	/* catch ctrl-c to shutdown cleanly */
+	signal(SIGINT, stream_close);
+
 	err = write_to_pcm_loop(&sndpcm, bat);
 	if (err < 0) {
 		retval_play = 1;
@@ -412,7 +416,7 @@ static int read_from_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 		return -errno;
 	}
 
-	while (remain > 0) {
+	while (remain > 0 && is_capturing) {
 		size = (remain <= sndpcm->period_bytes) ?
 			remain : sndpcm->period_bytes;
 		frames = size * 8 / sndpcm->frame_bits;
@@ -477,6 +481,9 @@ void *record_alsa(struct bat *bat)
 		goto exit2;
 	}
 
+	/* install signal handler and begin capturing Ctrl-C */
+	signal(SIGINT, sigint_handler);
+
 	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
 	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
 	pthread_cleanup_push(pcm_cleanup, sndpcm.handle);
diff --git a/bat/alsa.h b/bat/alsa.h
index d5c9972..19945ed 100644
--- a/bat/alsa.h
+++ b/bat/alsa.h
@@ -16,5 +16,8 @@
 extern int retval_play;
 extern int retval_record;
 
+extern int is_capturing;
+extern int is_playing;
+
 void *playback_alsa(struct bat *);
 void *record_alsa(struct bat *);
-- 
2.5.0
