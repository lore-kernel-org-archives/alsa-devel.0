From: han.lu@intel.com
Subject: [PATCH 09/10] alsabat: use variable for thread return
	value
Date: Wed,  2 Mar 2016 16:53:19 +0800
Message-ID: <3788d26a68d34132a918b0eb19f7f0a7eb552641.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 89EDC265232
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 09:51:18 +0100 (CET)
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

Replace fixed "1" to variable for thread return value.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 0a5f899..189b0e9 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -309,13 +309,13 @@ void *playback_alsa(struct bat *bat)
 	if (err != 0) {
 		fprintf(bat->err, _("Cannot open PCM playback device: "));
 		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
-		retval_play = 1;
+		retval_play = err;
 		goto exit1;
 	}
 
 	err = set_snd_pcm_params(bat, &sndpcm);
 	if (err != 0) {
-		retval_play = 1;
+		retval_play = err;
 		goto exit2;
 	}
 
@@ -332,13 +332,13 @@ void *playback_alsa(struct bat *bat)
 			fprintf(bat->err, _("Cannot open file for playback: "));
 			fprintf(bat->err, _("%s %d\n"),
 					bat->playback.file, -errno);
-			retval_play = 1;
+			retval_play = -errno;
 			goto exit3;
 		}
 		/* Skip header */
 		err = read_wav_header(bat, bat->playback.file, bat->fp, true);
 		if (err != 0) {
-			retval_play = 1;
+			retval_play = err;
 			goto exit4;
 		}
 	}
@@ -348,7 +348,7 @@ void *playback_alsa(struct bat *bat)
 
 	err = write_to_pcm_loop(&sndpcm, bat);
 	if (err < 0) {
-		retval_play = 1;
+		retval_play = err;
 		goto exit4;
 	}
 
@@ -471,13 +471,13 @@ void *record_alsa(struct bat *bat)
 	if (err != 0) {
 		fprintf(bat->err, _("Cannot open PCM capture device: "));
 		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
-		retval_record = 1;
+		retval_record = err;
 		goto exit1;
 	}
 
 	err = set_snd_pcm_params(bat, &sndpcm);
 	if (err != 0) {
-		retval_record = 1;
+		retval_record = err;
 		goto exit2;
 	}
 
-- 
2.5.0
