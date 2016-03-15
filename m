From: han.lu@intel.com
Subject: [PATCH 1/3] alsabat: add default device name for
	playback and capture
Date: Tue, 15 Mar 2016 11:18:52 +0800
Message-ID: <b76276db854bdcf15562f897eeb1d0cbad7921ec.1458011641.git.han.lu@intel.com>
References: <cover.1458011641.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BBE5A2605E1
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 04:17:09 +0100 (CET)
In-Reply-To: <cover.1458011641.git.han.lu@intel.com>
In-Reply-To: <cover.1458011641.git.han.lu@intel.com>
References: <cover.1458011641.git.han.lu@intel.com>
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

Add default name for the playback and capture devices, in case
they were not set by user through '-D', '-P' or '-C' options.
Previously, if no device be specified, the alsabat will start
a playback thread and a capture thread, and then exit the
threads with error log.
If only one of playback and capture is specified, the alsabat
will work on single line mode as before, where only one thread
(playback or capture) will be started.
The patch was tested on Ubuntu and Chrome OS.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 5eaa25b..5775748 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -377,12 +377,6 @@ void *playback_alsa(struct bat *bat)
 	retval_play = 0;
 	memset(&sndpcm, 0, sizeof(sndpcm));
 
-	if (bat->playback.device == NULL) {
-		fprintf(bat->err, _("No PCM device for playback: exit\n"));
-		retval_play = 1;
-		goto exit1;
-	}
-
 	err = snd_pcm_open(&sndpcm.handle, bat->playback.device,
 			SND_PCM_STREAM_PLAYBACK, 0);
 	if (err != 0) {
@@ -533,12 +527,6 @@ void *record_alsa(struct bat *bat)
 	retval_record = 0;
 	memset(&sndpcm, 0, sizeof(sndpcm));
 
-	if (bat->capture.device == NULL) {
-		fprintf(bat->err, _("No PCM device for capture: exit\n"));
-		retval_record = 1;
-		goto exit1;
-	}
-
 	err = snd_pcm_open(&sndpcm.handle, bat->capture.device,
 			SND_PCM_STREAM_CAPTURE, 0);
 	if (err != 0) {
diff --git a/bat/bat.c b/bat/bat.c
index ddb60b7..9c637f2 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -473,6 +473,10 @@ static int bat_init(struct bat *bat)
 			return err;
 	}
 
+	/* Set default playback and capture devices */
+	if (bat->playback.device == NULL && bat->capture.device == NULL)
+		bat->playback.device = bat->capture.device = DEFAULT_DEV_NAME;
+
 	/* Determine capture file */
 	if (bat->local) {
 		bat->capture.file = bat->playback.file;
diff --git a/bat/common.h b/bat/common.h
index 7346d9f..5417c0e 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -16,6 +16,7 @@
 #include <alsa/asoundlib.h>
 
 #define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav.XXXXXX"
+#define DEFAULT_DEV_NAME		"default"
 
 #define OPT_BASE			300
 #define OPT_LOG				(OPT_BASE + 1)
-- 
2.5.0
