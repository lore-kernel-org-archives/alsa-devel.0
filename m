From: Andrey Mazo <mazo@telum.ru>
Subject: [PATCH 3/3] pcm_file: don't touch infile on playback
	and output file on capture.
Date: Sun, 17 Nov 2013 01:11:56 +0400
Message-ID: <1384636316-26706-4-git-send-email-mazo@telum.ru>
References: <1384636316-26706-1-git-send-email-mazo@telum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.telum.ru (mail.telum.ru [62.141.76.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C4092610A1
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 22:13:23 +0100 (CET)
In-Reply-To: <1384636316-26706-1-git-send-email-mazo@telum.ru>
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
List-Id: alsa-devel@alsa-project.org

Commit 1d80c5b901baf7e1b7998dfa518532fbd64e4283 message describes
behaviour in case of specified infile option as
'No file writes will take place in this case'.
But this is clearly not the case as output file gets truncated while
running `arecord -Dtestin >/dev/null`, where "testin" is defined as
pcm.testin {
	type file
	slave.pcm null
	file "/tmp/qqqq.out"
	infile "/tmp/qqqq.in"
	format "raw"
}

Besides that, the existing behaviour is rather counterintuitive,
requiring both output and input files to exist and making access to them
regardless of playback or capture intention.
Also, it's very confusing to get output file truncated while trying to
just capture from the device.

Current changeset introduces the following behaviour:
 - output file ("file" option) is only (p)open()'ed for writing
   only on playback to the device
 - any data is written to the output file descriptor
   (provided with "file" option) only on playback to the device
 - input file ("infile" option) is only open()'ed for reading only on
   capture from the device
 - any data is read from the input file descriptor
   (provided with the "infile" option) only on capture from the device

Signed-off-by: Andrey Mazo <mazo@telum.ru>
---
 src/pcm/pcm_file.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index c3e67b2..25055d0 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -406,7 +406,9 @@ static int snd_pcm_file_close(snd_pcm_t *pcm)
 		if (file->wav_header.fmt)
 			fixup_wav_header(pcm);
 		free((void *)file->fname);
-		close(file->fd);
+		if (file->fd >= 0) {
+			close(file->fd);
+		}
 	}
 	if (file->ifname) {
 		free((void *)file->ifname);
@@ -533,7 +535,6 @@ static snd_pcm_sframes_t snd_pcm_file_writen(snd_pcm_t *pcm, void **bufs, snd_pc
 static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
 {
 	snd_pcm_file_t *file = pcm->private_data;
-	snd_pcm_channel_area_t areas[pcm->channels];
 	snd_pcm_sframes_t n;
 
 	n = snd_pcm_readi(file->gen.slave, buffer, size);
@@ -545,15 +546,12 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 			return n;
 		return n * 8 / pcm->frame_bits;
 	}
-	snd_pcm_areas_from_buf(pcm, areas, buffer);
-	snd_pcm_file_add_frames(pcm, areas, 0, n);
 	return n;
 }
 
 static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
 {
 	snd_pcm_file_t *file = pcm->private_data;
-	snd_pcm_channel_area_t areas[pcm->channels];
 	snd_pcm_sframes_t n;
 
 	if (file->ifd >= 0) {
@@ -562,10 +560,6 @@ static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm
 	}
 
 	n = snd_pcm_readn(file->gen.slave, bufs, size);
-	if (n > 0) {
-		snd_pcm_areas_from_bufs(pcm, areas, bufs);
-		snd_pcm_file_add_frames(pcm, areas, 0, n);
-	}
 	return n;
 }
 
@@ -629,7 +623,7 @@ static int snd_pcm_file_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 		a->first = slave->sample_bits * channel;
 		a->step = slave->frame_bits;
 	}
-	if (file->fd < 0) {
+	if ((file->fd < 0) && (pcm->stream == SND_PCM_STREAM_PLAYBACK)) {
 		err = snd_pcm_file_open_output_file(file);
 		if (err < 0) {
 			SYSERR("failed opening output file %s", file->fname);
@@ -728,7 +722,8 @@ static const snd_pcm_fast_ops_t snd_pcm_file_fast_ops = {
 int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 		      const char *fname, int fd, const char *ifname, int ifd,
 		      int trunc,
-		      const char *fmt, int perm, snd_pcm_t *slave, int close_slave)
+		      const char *fmt, int perm, snd_pcm_t *slave, int close_slave,
+		      snd_pcm_stream_t stream)
 {
 	snd_pcm_t *pcm;
 	snd_pcm_file_t *file;
@@ -758,7 +753,7 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	file->trunc = trunc;
 	file->perm = perm;
 
-	if (ifname) {
+	if (ifname && (stream == SND_PCM_STREAM_CAPTURE)) {
 		ifd = open(ifname, O_RDONLY);	/* TODO: mind blocking mode */
 		if (ifd < 0) {
 			SYSERR("open %s for reading failed", ifname);
@@ -790,6 +785,7 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 #else
 	pcm->monotonic = 0;
 #endif
+	pcm->stream = stream;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;
@@ -960,7 +956,7 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	if (err < 0)
 		return err;
 	err = snd_pcm_file_open(pcmp, name, fname, fd, ifname, ifd,
-				trunc, format, perm, spcm, 1);
+				trunc, format, perm, spcm, 1, stream);
 	if (err < 0)
 		snd_pcm_close(spcm);
 	return err;
-- 
1.8.4
