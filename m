From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH - alsa-lib 4/4] pcm_file: add infile read
	support for mmap mode
Date: Tue, 21 May 2019 15:33:50 +0200
Message-ID: <1558445630-11610-1-git-send-email-amiartus@de.adit-jv.com>
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

mmap_begin callback is used to copy data from input file to mmaped
buffer

guard for corner use of api (multiple mmap_begin calls by user) is
introduced to check if next continuous buffer was already overwritten

buffer is overwritten with input file data only in case of stream capture

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 10d227b..7d3439a 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -88,6 +88,7 @@ typedef struct {
 	size_t buffer_bytes;
 	struct wav_fmt wav_header;
 	size_t filelen;
+	char ifmmap_overwritten;
 } snd_pcm_file_t;
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -626,6 +627,8 @@ static snd_pcm_sframes_t snd_pcm_file_mmap_commit(snd_pcm_t *pcm,
 	const snd_pcm_channel_area_t *areas;
 	snd_pcm_sframes_t result;
 
+	file->ifmmap_overwritten = 0;
+
 	result = snd_pcm_mmap_begin(file->gen.slave, &areas, &ofs, &siz);
 	if (result >= 0) {
 		assert(ofs == offset && siz == size);
@@ -636,6 +639,32 @@ static snd_pcm_sframes_t snd_pcm_file_mmap_commit(snd_pcm_t *pcm,
 	return result;
 }
 
+static int snd_pcm_file_mmap_begin(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas,
+	snd_pcm_uframes_t *offset, snd_pcm_uframes_t *frames)
+{
+	snd_pcm_file_t *file = pcm->private_data;
+	snd_pcm_channel_area_t areas_if[pcm->channels];
+	snd_pcm_uframes_t frames_if;
+	void *buffer = NULL;
+	int result;
+
+	result = snd_pcm_mmap_begin(file->gen.slave, areas, offset, frames);
+	if (result < 0)
+		return result;
+
+	if (pcm->stream != SND_PCM_STREAM_CAPTURE)
+		return result;
+
+	/* user may run mmap_begin without mmap_commit multiple times in row */
+	if (file->ifmmap_overwritten)
+		return result;
+	file->ifmmap_overwritten = 1;
+
+	snd_pcm_file_areas_read_infile(pcm, *areas, *offset, *frames);
+
+	return result;
+}
+
 static int snd_pcm_file_hw_free(snd_pcm_t *pcm)
 {
 	snd_pcm_file_t *file = pcm->private_data;
@@ -662,6 +691,7 @@ static int snd_pcm_file_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	file->wbuf_size = slave->buffer_size * 2;
 	file->wbuf_size_bytes = snd_pcm_frames_to_bytes(slave, file->wbuf_size);
 	file->wbuf_used_bytes = 0;
+	file->ifmmap_overwritten = 0;
 	assert(!file->wbuf);
 	file->wbuf = malloc(file->wbuf_size_bytes);
 	if (file->wbuf == NULL) {
@@ -773,7 +803,7 @@ static const snd_pcm_fast_ops_t snd_pcm_file_fast_ops = {
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_generic_poll_revents,
 	.htimestamp = snd_pcm_generic_htimestamp,
-	.mmap_begin = NULL,
+	.mmap_begin = snd_pcm_file_mmap_begin,
 };
 
 /**
-- 
2.7.4
