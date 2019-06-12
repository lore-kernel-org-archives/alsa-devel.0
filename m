From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 1/2] pcm_file: do not disrupt playback on
	output file write fail
Date: Wed, 12 Jun 2019 08:48:27 +0200
Message-ID: <1560322108-17074-2-git-send-email-amiartus@de.adit-jv.com>
References: <1560322108-17074-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1560322108-17074-1-git-send-email-amiartus@de.adit-jv.com>
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

previously playback could be interrupted by snd_pcm_file_add_frames:
    assert(file->wbuf_used_bytes < file->wbuf_size_bytes)

in case snd_pcm_file_write_bytes fails to write full amount of bytes
to file, variable wbuf_used_bytes would not be fully decremented by
requested amount of bytes function was called with

for the assert to trigger, multiple write fails need to happen, so
that wbuf_used_bytes overflows wbuf_size_bytes,

this patch will allow application to report error code to api user
who might have an idea how to recover, before assert is triggered,
also reporting error along with the print out message might give user
a better idea of what is going on, where previously reason for
mentioned assert was not immediately clear

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>
---
 src/pcm/pcm_file.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 1ef80b5..0a8d98d 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -346,7 +346,7 @@ static int write_wav_header(snd_pcm_t *pcm)
 	    sizeof(file->wav_header) ||
 	    write(file->fd, header2, sizeof(header2)) != sizeof(header2)) {
 		int err = errno;
-		SYSERR("Write error.\n");
+		SYSERR("%s write header failed, file data may be corrupt", file->fname);
 		return -err;
 	}
 	return 0;
@@ -381,27 +381,29 @@ static void fixup_wav_header(snd_pcm_t *pcm)
 
 
 
-static void snd_pcm_file_write_bytes(snd_pcm_t *pcm, size_t bytes)
+/* return error code in case write failed */
+static int snd_pcm_file_write_bytes(snd_pcm_t *pcm, size_t bytes)
 {
 	snd_pcm_file_t *file = pcm->private_data;
+	snd_pcm_sframes_t err = 0;
 	assert(bytes <= file->wbuf_used_bytes);
 
 	if (file->format == SND_PCM_FILE_FORMAT_WAV &&
 	    !file->wav_header.fmt) {
-		if (write_wav_header(pcm) < 0)
-			return;
+		err = write_wav_header(pcm);
+		if (err < 0)
+			return err;
 	}
 
 	while (bytes > 0) {
-		snd_pcm_sframes_t err;
 		size_t n = bytes;
 		size_t cont = file->wbuf_size_bytes - file->file_ptr_bytes;
 		if (n > cont)
 			n = cont;
 		err = write(file->fd, file->wbuf + file->file_ptr_bytes, n);
 		if (err < 0) {
-			SYSERR("write failed");
-			break;
+			SYSERR("%s write failed, file data may be corrupt", file->fname);
+			return err;
 		}
 		bytes -= err;
 		file->wbuf_used_bytes -= err;
@@ -412,15 +414,17 @@ static void snd_pcm_file_write_bytes(snd_pcm_t *pcm, size_t bytes)
 		if ((snd_pcm_uframes_t)err != n)
 			break;
 	}
+	return 0;
 }
 
-static void snd_pcm_file_add_frames(snd_pcm_t *pcm, 
-				    const snd_pcm_channel_area_t *areas,
-				    snd_pcm_uframes_t offset,
-				    snd_pcm_uframes_t frames)
+static int snd_pcm_file_add_frames(snd_pcm_t *pcm,
+				   const snd_pcm_channel_area_t *areas,
+				   snd_pcm_uframes_t offset,
+				   snd_pcm_uframes_t frames)
 {
 	snd_pcm_file_t *file = pcm->private_data;
 	while (frames > 0) {
+		int err = 0;
 		snd_pcm_uframes_t n = frames;
 		snd_pcm_uframes_t cont = file->wbuf_size - file->appl_ptr;
 		snd_pcm_uframes_t avail = file->wbuf_size - snd_pcm_bytes_to_frames(pcm, file->wbuf_used_bytes);
@@ -437,10 +441,14 @@ static void snd_pcm_file_add_frames(snd_pcm_t *pcm,
 		if (file->appl_ptr == file->wbuf_size)
 			file->appl_ptr = 0;
 		file->wbuf_used_bytes += snd_pcm_frames_to_bytes(pcm, n);
-		if (file->wbuf_used_bytes > file->buffer_bytes)
-			snd_pcm_file_write_bytes(pcm, file->wbuf_used_bytes - file->buffer_bytes);
+		if (file->wbuf_used_bytes > file->buffer_bytes) {
+			err = snd_pcm_file_write_bytes(pcm, file->wbuf_used_bytes - file->buffer_bytes);
+			if (err < 0)
+				return err;
+		}
 		assert(file->wbuf_used_bytes < file->wbuf_size_bytes);
 	}
+	return 0;
 }
 
 static int snd_pcm_file_close(snd_pcm_t *pcm)
-- 
2.7.4
