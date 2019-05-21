From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH - alsa-lib 2/4] pcm_file: use
	snd_pcm_file_areas_read_infile for readi
Date: Tue, 21 May 2019 15:33:08 +0200
Message-ID: <1558445588-11524-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

use previously introduced helper function, this commit unifies behavior
of readi and readn

corner case behavior of readi is changed by this commit, previously,
in case 0 bytes were red from file (EOF), frames = 0 was returned,
signaling api user as if no data was red from slave, after the patch,
amount of frames red from slave with data red from slave stored in buffer
is returned when EOF is reached

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 3c68265..dcaa41d 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -579,22 +579,21 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 {
 	snd_pcm_file_t *file = pcm->private_data;
 	snd_pcm_channel_area_t areas[pcm->channels];
-	snd_pcm_sframes_t n;
+	snd_pcm_sframes_t frames;
+
+	__snd_pcm_lock(pcm);
+
+	frames = _snd_pcm_readi(file->gen.slave, buffer, size);
+	if (frames <= 0)
+		return frames;
 
-	n = _snd_pcm_readi(file->gen.slave, buffer, size);
-	if (n <= 0)
-		return n;
-	if (file->ifd >= 0) {
-		__snd_pcm_lock(pcm);
-		n = read(file->ifd, buffer, n * pcm->frame_bits / 8);
-		__snd_pcm_unlock(pcm);
-		if (n < 0)
-			return n;
-		n = n * 8 / pcm->frame_bits;
-	}
 	snd_pcm_areas_from_buf(pcm, areas, buffer);
-	snd_pcm_file_add_frames(pcm, areas, 0, n);
-	return n;
+	snd_pcm_file_areas_read_infile(pcm, areas, 0, frames);
+	snd_pcm_file_add_frames(pcm, areas, 0, frames);
+
+	__snd_pcm_unlock(pcm);
+
+	return frames;
 }
 
 /* locking */
-- 
2.7.4
