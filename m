From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH 2/3] aplay: Refactor playback code
Date: Wed,  9 Aug 2017 01:05:59 +0300
Message-ID: <1502229960-8516-3-git-send-email-daniel.baluta@gmail.com>
References: <1502229960-8516-1-git-send-email-daniel.baluta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id D2C3C266E26
 for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2017 00:06:18 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id y67so3324069wrb.3
 for <alsa-devel@alsa-project.org>; Tue, 08 Aug 2017 15:06:18 -0700 (PDT)
In-Reply-To: <1502229960-8516-1-git-send-email-daniel.baluta@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, alsa-devel@alsa-project.org
Cc: mihai.serban@nxp.com, shengjiu.wang@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This introduces read_header function which tries
to read the header of an audio file in order to determine
its type.

This has the following effects:
	(1) makes code easier to read
	(2) don't abort if file size is less than expected header

(2), allows us to play small files with size smaller than any
supported audio file headers.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 aplay/aplay.c | 144 +++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 107 insertions(+), 37 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index fb2909f..28da6c5 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -2801,6 +2801,89 @@ static void playback_go(int fd, size_t loaded, off64_t count, int rtype, char *n
 	snd_pcm_nonblock(handle, nonblock);
 }
 
+static int read_header(int *loaded, int header_size)
+{
+	int ret;
+	struct stat buf;
+
+	ret = fstat(fd, &buf);
+	if (ret < 0) {
+		perror("fstat");
+		prg_exit(EXIT_FAILURE);
+	}
+
+	/* don't be adventurous, get out if file size is smaller than
+	 * requested header size */
+	if (buf.st_size < header_size)
+		return -1;
+
+	if (*loaded < header_size) {
+		header_size -= *loaded;
+		ret = safe_read(fd, audiobuf + *loaded, header_size);
+		if (ret != header_size) {
+			error(_("read error"));
+			prg_exit(EXIT_FAILURE);
+		}
+		*loaded += header_size;
+	}
+	return 0;
+}
+
+static int playback_au(char *name, int *loaded)
+{
+	if (read_header(loaded, sizeof(AuHeader)) < 0)
+		return -1;
+
+	if (test_au(fd, audiobuf) < 0)
+		return -1;
+
+	rhwparams.format = hwparams.format;
+	pbrec_count = calc_count();
+	playback_go(fd, *loaded - sizeof(AuHeader), pbrec_count, FORMAT_AU, name);
+
+	return 0;
+}
+
+static int playback_voc(char *name, int *loaded)
+{
+	int ofs;
+
+	if (read_header(loaded, sizeof(VocHeader)) < 0)
+		return -1;
+
+	if ((ofs = test_vocfile(audiobuf)) < 0)
+		return -1;
+
+	pbrec_count = calc_count();
+	voc_play(fd, ofs, name);
+
+	return 0;
+}
+
+static int playback_wave(char *name, int *loaded)
+{
+	ssize_t dtawave;
+
+	if (read_header(loaded, sizeof(WaveHeader)) < 0)
+		return -1;
+
+	if ((dtawave = test_wavefile(fd, audiobuf, *loaded)) < 0)
+		return -1;
+
+	pbrec_count = calc_count();
+	playback_go(fd, dtawave, pbrec_count, FORMAT_WAVE, name);
+
+	return 0;
+}
+
+static int playback_raw(char *name, int *loaded)
+{
+	init_raw_data();
+	pbrec_count = calc_count();
+	playback_go(fd, *loaded, pbrec_count, FORMAT_RAW, name);
+
+	return 0;
+}
 
 /*
  *  let's play or capture it (capture_type says VOC/WAVE/raw)
@@ -2808,9 +2891,7 @@ static void playback_go(int fd, size_t loaded, off64_t count, int rtype, char *n
 
 static void playback(char *name)
 {
-	int ofs;
-	size_t dta;
-	ssize_t dtawave;
+	int loaded = 0;
 
 	pbrec_count = LLONG_MAX;
 	fdcount = 0;
@@ -2824,40 +2905,29 @@ static void playback(char *name)
 			prg_exit(EXIT_FAILURE);
 		}
 	}
-	/* read the file header */
-	dta = sizeof(AuHeader);
-	if ((size_t)safe_read(fd, audiobuf, dta) != dta) {
-		error(_("read error"));
-		prg_exit(EXIT_FAILURE);
-	}
-	if (test_au(fd, audiobuf) >= 0) {
-		rhwparams.format = hwparams.format;
-		pbrec_count = calc_count();
-		playback_go(fd, 0, pbrec_count, FORMAT_AU, name);
-		goto __end;
-	}
-	dta = sizeof(VocHeader);
-	if ((size_t)safe_read(fd, audiobuf + sizeof(AuHeader),
-		 dta - sizeof(AuHeader)) != dta - sizeof(AuHeader)) {
-		error(_("read error"));
-		prg_exit(EXIT_FAILURE);;
-	}
-	if ((ofs = test_vocfile(audiobuf)) >= 0) {
-		pbrec_count = calc_count();
-		voc_play(fd, ofs, name);
-		goto __end;
-	}
-	/* read bytes for WAVE-header */
-	if ((dtawave = test_wavefile(fd, audiobuf, dta)) >= 0) {
-		pbrec_count = calc_count();
-		playback_go(fd, dtawave, pbrec_count, FORMAT_WAVE, name);
-	} else {
-		/* should be raw data */
-		init_raw_data();
-		pbrec_count = calc_count();
-		playback_go(fd, dta, pbrec_count, FORMAT_RAW, name);
-	}
-      __end:
+
+	switch(file_type) {
+	case FORMAT_AU:
+		playback_au(name, &loaded);
+		break;
+	case FORMAT_VOC:
+		playback_voc(name, &loaded);
+		break;
+	case FORMAT_WAVE:
+		playback_wave(name, &loaded);
+		break;
+	case FORMAT_RAW:
+		playback_raw(name, &loaded);
+		break;
+	default:
+		/* parse the file header */
+		if (playback_au(name, &loaded) < 0 &&
+		    playback_voc(name, &loaded) < 0 &&
+		    playback_wave(name, &loaded) < 0)
+			playback_raw(name, &loaded); /* should be raw data */
+		break;
+        }
+
 	if (fd != 0)
 		close(fd);
 }
-- 
2.7.4
