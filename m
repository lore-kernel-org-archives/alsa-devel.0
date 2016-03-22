From: han.lu@intel.com
Subject: [PATCH 3/6] alsabat: clean return value of playback
	and capture loops
Date: Tue, 22 Mar 2016 13:10:26 +0800
Message-ID: <8d813747d2a9abf0c725aa6744e1a6cb5e82d980.1458623090.git.han.lu@intel.com>
References: <cover.1458623090.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C532652EE
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 06:09:03 +0100 (CET)
In-Reply-To: <cover.1458623090.git.han.lu@intel.com>
In-Reply-To: <cover.1458623090.git.han.lu@intel.com>
References: <cover.1458623090.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Remove unneccessary prints, and return error code instead of 0.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 5acc2bc..aae2eb0 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -316,18 +316,13 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 
 	while (1) {
 		err = generate_input_data(sndpcm, bytes, bat);
-		if (err < 0)
-			return err;
-		else if (err > 0)
+		if (err != 0)
 			break;
 
 		if (bat->debugplay) {
-			err = fwrite(sndpcm->buffer, 1, bytes, fp);
-			if (err != bytes) {
-				fprintf(bat->err, _("Write file error: "));
-				fprintf(bat->err, _("%s(%d)\n"),
-						snd_strerror(err), err);
-				return -EIO;
+			if (fwrite(sndpcm->buffer, 1, bytes, fp) != bytes) {
+				err = -EIO;
+				break;
 			}
 			bytes_total += bytes;
 		}
@@ -339,7 +334,7 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 
 		err = write_to_pcm(sndpcm, frames, bat);
 		if (err != 0)
-			return err;
+			break;
 	}
 
 	if (bat->debugplay) {
@@ -349,7 +344,7 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 
 	snd_pcm_drain(sndpcm->handle);
 
-	return 0;
+	return err;
 }
 
 /**
@@ -405,7 +400,7 @@ void *playback_alsa(struct bat *bat)
 	}
 
 	err = write_to_pcm_loop(&sndpcm, bat);
-	if (err != 0) {
+	if (err < 0) {
 		retval_play = err;
 		goto exit4;
 	}
@@ -484,14 +479,12 @@ static int read_from_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 		/* read a chunk from pcm device */
 		err = read_from_pcm(sndpcm, frames, bat);
 		if (err != 0)
-			return err;
+			break;
 
 		/* write the chunk to file */
-		err = fwrite(sndpcm->buffer, 1, size, fp);
-		if (err != size) {
-			fprintf(bat->err, _("Write file error: %s(%d)\n"),
-					snd_strerror(err), err);
-			return -EIO;
+		if (fwrite(sndpcm->buffer, 1, size, fp) != size) {
+			err = -EIO;
+			break;
 		}
 
 		bytes_read += size;
@@ -506,7 +499,7 @@ static int read_from_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 	update_wav_header(bat, fp, bytes_read);
 
 	fclose(fp);
-	return 0;
+	return err;
 }
 
 static void pcm_cleanup(void *p)
-- 
2.5.0
