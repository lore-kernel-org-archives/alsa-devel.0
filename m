From: sutar.mounesh@gmail.com
Subject: [PATCH 3/6] pcm:file: Enable file writing for capture
	path
Date: Fri, 17 Feb 2017 12:47:17 +0530
Message-ID: <1487315837-9034-1-git-send-email-sutar.mounesh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Mounesh Sutar <sutar.mounesh@gmail.com>, Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

This commit reverts parts of commit 4081be0b87ab9fa53a8906e66bc240f18a7a9a54,
because it is realy useful to use the file plugin in a capture path for
debugging. Also it fixes the truncate issue mentioned in above commit.

Additionally following MMAP access issue is considered:
$ arecord -D teeraw -M -d5 arecord.wav
Recording WAVE 'arecord.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
ALSA lib pcm/pcm_file.c:358:(snd_pcm_file_write_bytes)
write failed: Bad file descriptor
ALSA lib pcm/pcm_file.c:358:(snd_pcm_file_write_bytes)
write failed: Bad file descriptor
arecord: pcm/pcm_file.c:397: snd_pcm_file_add_frames:
Assertion `file->wbuf_used_bytes < file->wbuf_size_bytes' failed.
Aborted by signal Aborted...

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 6d119d6..0363f84 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -544,6 +544,7 @@ static snd_pcm_sframes_t snd_pcm_file_writen(snd_pcm_t *pcm, void **bufs, snd_pc
 static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
 	snd_pcm_file_t *file = pcm->private_data;
+	snd_pcm_channel_area_t areas[pcm->channels];
 	snd_pcm_sframes_t n;
 
 	n = _snd_pcm_readi(file->gen.slave, buffer, size);
@@ -555,8 +556,10 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 		__snd_pcm_unlock(pcm);
 		if (n < 0)
 			return n;
-		return n * 8 / pcm->frame_bits;
+		n = n * 8 / pcm->frame_bits;
 	}
+	snd_pcm_areas_from_buf(pcm, areas, buffer);
+	snd_pcm_file_add_frames(pcm, areas, 0, n);
 	return n;
 }
 
@@ -564,6 +567,7 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	snd_pcm_file_t *file = pcm->private_data;
+	snd_pcm_channel_area_t areas[pcm->channels];
 	snd_pcm_sframes_t n;
 
 	if (file->ifd >= 0) {
@@ -572,6 +576,10 @@ static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm
 	}
 
 	n = _snd_pcm_readn(file->gen.slave, bufs, size);
+	if (n > 0) {
+		snd_pcm_areas_from_bufs(pcm, areas, bufs);
+		snd_pcm_file_add_frames(pcm, areas, 0, n);
+	}
 	return n;
 }
 
@@ -635,7 +643,7 @@ static int snd_pcm_file_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 		a->first = slave->sample_bits * channel;
 		a->step = slave->frame_bits;
 	}
-	if ((file->fd < 0) && (pcm->stream == SND_PCM_STREAM_PLAYBACK)) {
+	if (file->fd < 0) {
 		err = snd_pcm_file_open_output_file(file);
 		if (err < 0) {
 			SYSERR("failed opening output file %s", file->fname);
-- 
2.7.4
