From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] aplay: Introduce and use xwrite helper
Date: Fri, 7 Apr 2017 18:35:40 +0300
Message-ID: <1491579340-29277-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0077.outbound.protection.outlook.com [104.47.0.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CBD626696B
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 17:35:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, shengjiu.wang@nxp.com, o-takashi@sakamocchi.jp, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com
List-Id: alsa-devel@alsa-project.org

Write can return less then requested bytes, but we treat this as
an error thus ending up with confusing error messages.

Fix this by introducing xwrite helper, which makes sure all bytes
are written or an error is returned.

With this patch an usecase where disk is filled by recording will
print:
$ /mnt/msc/audio.wav: No space left on device

instead of random messages like:

$/mnt/msc/audio.wav: No such file or directory

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
This is a follow up of:

http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119632.html

where I tried to fix the error message instead of write :).

 aplay/aplay.c | 55 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index ee480f2..74d3d37 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -429,6 +429,25 @@ enum {
 	OPT_FATAL_ERRORS,
 };
 
+/*
+ * make sure we write all bytes or return an error
+ */
+static ssize_t xwrite(int fd, const void *buf, size_t count)
+{
+	ssize_t written;
+	size_t offset = 0;
+
+	while (offset < count) {
+		written = write(fd, buf + offset, count - offset);
+		if (written <= 0)
+			return written;
+
+		offset += written;
+	};
+
+	return written;
+}
+
 static long parse_long(const char *str, int *err)
 {
 	long val;
@@ -2428,7 +2447,7 @@ static void voc_play(int fd, int ofs, char *name)
 			l = nextblock;
 		if (l) {
 			if (output && !quiet_mode) {
-				if (write(2, data, l) != l) {	/* to stderr */
+				if (xwrite(2, data, l) != l) {	/* to stderr */
 					error(_("write error"));
 					prg_exit(EXIT_FAILURE);
 				}
@@ -2480,7 +2499,7 @@ static void begin_voc(int fd, size_t cnt)
 	vh.version = LE_SHORT(VOC_ACTUAL_VERSION);
 	vh.coded_ver = LE_SHORT(0x1233 - VOC_ACTUAL_VERSION);
 
-	if (write(fd, &vh, sizeof(VocHeader)) != sizeof(VocHeader)) {
+	if (xwrite(fd, &vh, sizeof(VocHeader)) != sizeof(VocHeader)) {
 		error(_("write error"));
 		prg_exit(EXIT_FAILURE);
 	}
@@ -2489,14 +2508,14 @@ static void begin_voc(int fd, size_t cnt)
 		bt.type = 8;
 		bt.datalen = 4;
 		bt.datalen_m = bt.datalen_h = 0;
-		if (write(fd, &bt, sizeof(VocBlockType)) != sizeof(VocBlockType)) {
+		if (xwrite(fd, &bt, sizeof(VocBlockType)) != sizeof(VocBlockType)) {
 			error(_("write error"));
 			prg_exit(EXIT_FAILURE);
 		}
 		eb.tc = LE_SHORT(65536 - 256000000L / (hwparams.rate << 1));
 		eb.pack = 0;
 		eb.mode = 1;
-		if (write(fd, &eb, sizeof(VocExtBlock)) != sizeof(VocExtBlock)) {
+		if (xwrite(fd, &eb, sizeof(VocExtBlock)) != sizeof(VocExtBlock)) {
 			error(_("write error"));
 			prg_exit(EXIT_FAILURE);
 		}
@@ -2506,13 +2525,13 @@ static void begin_voc(int fd, size_t cnt)
 	bt.datalen = (u_char) (cnt & 0xFF);
 	bt.datalen_m = (u_char) ((cnt & 0xFF00) >> 8);
 	bt.datalen_h = (u_char) ((cnt & 0xFF0000) >> 16);
-	if (write(fd, &bt, sizeof(VocBlockType)) != sizeof(VocBlockType)) {
+	if (xwrite(fd, &bt, sizeof(VocBlockType)) != sizeof(VocBlockType)) {
 		error(_("write error"));
 		prg_exit(EXIT_FAILURE);
 	}
 	vd.tc = (u_char) (256 - (1000000 / hwparams.rate));
 	vd.pack = 0;
-	if (write(fd, &vd, sizeof(VocVoiceData)) != sizeof(VocVoiceData)) {
+	if (xwrite(fd, &vd, sizeof(VocVoiceData)) != sizeof(VocVoiceData)) {
 		error(_("write error"));
 		prg_exit(EXIT_FAILURE);
 	}
@@ -2581,10 +2600,10 @@ static void begin_wave(int fd, size_t cnt)
 	cd.type = WAV_DATA;
 	cd.length = LE_INT(cnt);
 
-	if (write(fd, &h, sizeof(WaveHeader)) != sizeof(WaveHeader) ||
-	    write(fd, &cf, sizeof(WaveChunkHeader)) != sizeof(WaveChunkHeader) ||
-	    write(fd, &f, sizeof(WaveFmtBody)) != sizeof(WaveFmtBody) ||
-	    write(fd, &cd, sizeof(WaveChunkHeader)) != sizeof(WaveChunkHeader)) {
+	if (xwrite(fd, &h, sizeof(WaveHeader)) != sizeof(WaveHeader) ||
+	    xwrite(fd, &cf, sizeof(WaveChunkHeader)) != sizeof(WaveChunkHeader) ||
+	    xwrite(fd, &f, sizeof(WaveFmtBody)) != sizeof(WaveFmtBody) ||
+	    xwrite(fd, &cd, sizeof(WaveChunkHeader)) != sizeof(WaveChunkHeader)) {
 		error(_("write error"));
 		prg_exit(EXIT_FAILURE);
 	}
@@ -2614,7 +2633,7 @@ static void begin_au(int fd, size_t cnt)
 	}
 	ah.sample_rate = BE_INT(hwparams.rate);
 	ah.channels = BE_INT(hwparams.channels);
-	if (write(fd, &ah, sizeof(AuHeader)) != sizeof(AuHeader)) {
+	if (xwrite(fd, &ah, sizeof(AuHeader)) != sizeof(AuHeader)) {
 		error(_("write error"));
 		prg_exit(EXIT_FAILURE);
 	}
@@ -2628,7 +2647,7 @@ static void end_voc(int fd)
 	size_t cnt;
 	char dummy = 0;		/* Write a Terminator */
 
-	if (write(fd, &dummy, 1) != 1) {
+	if (xwrite(fd, &dummy, 1) != 1) {
 		error(_("write error"));
 		prg_exit(EXIT_FAILURE);
 	}
@@ -2644,7 +2663,7 @@ static void end_voc(int fd)
 	bt.datalen_m = (u_char) ((cnt & 0xFF00) >> 8);
 	bt.datalen_h = (u_char) ((cnt & 0xFF0000) >> 16);
 	if (lseek64(fd, length_seek, SEEK_SET) == length_seek)
-		write(fd, &bt, sizeof(VocBlockType));
+		xwrite(fd, &bt, sizeof(VocBlockType));
 	if (fd != 1)
 		close(fd);
 }
@@ -2664,9 +2683,9 @@ static void end_wave(int fd)
 	filelen = fdcount + 2*sizeof(WaveChunkHeader) + sizeof(WaveFmtBody) + 4;
 	rifflen = filelen > 0x7fffffff ? LE_INT(0x7fffffff) : LE_INT(filelen);
 	if (lseek64(fd, 4, SEEK_SET) == 4)
-		write(fd, &rifflen, 4);
+		xwrite(fd, &rifflen, 4);
 	if (lseek64(fd, length_seek, SEEK_SET) == length_seek)
-		write(fd, &cd, sizeof(WaveChunkHeader));
+		xwrite(fd, &cd, sizeof(WaveChunkHeader));
 	if (fd != 1)
 		close(fd);
 }
@@ -2679,7 +2698,7 @@ static void end_au(int fd)
 	length_seek = (char *)&ah.data_size - (char *)&ah;
 	ah.data_size = fdcount > 0xffffffff ? 0xffffffff : BE_INT(fdcount);
 	if (lseek64(fd, length_seek, SEEK_SET) == length_seek)
-		write(fd, &ah.data_size, sizeof(ah.data_size));
+		xwrite(fd, &ah.data_size, sizeof(ah.data_size));
 	if (fd != 1)
 		close(fd);
 }
@@ -3078,7 +3097,7 @@ static void capture(char *orig_name)
 				in_aborting = 1;
 				break;
 			}
-			if (write(fd, audiobuf, c) != c) {
+			if (xwrite(fd, audiobuf, c) != c) {
 				perror(name);
 				in_aborting = 1;
 				break;
@@ -3187,7 +3206,7 @@ static void capturev_go(int* fds, unsigned int channels, off64_t count, int rtyp
 			break;
 		rv = r * bits_per_sample / 8;
 		for (channel = 0; channel < channels; ++channel) {
-			if ((size_t)write(fds[channel], bufs[channel], rv) != rv) {
+			if ((size_t)xwrite(fds[channel], bufs[channel], rv) != rv) {
 				perror(names[channel]);
 				prg_exit(EXIT_FAILURE);
 			}
-- 
2.7.4
