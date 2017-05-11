From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 17/26] ALSA: rme96: Convert to copy_silence
	ops
Date: Thu, 11 May 2017 23:09:16 +0200
Message-ID: <20170511210925.18208-18-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D2F2E266FF6
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 96CB8AED3
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
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

Replace the copy and the silence ops with the new merged ops.
The conversion is straightforward with standard helper functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme96.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 05b9da30990d..2161f6aad532 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -326,31 +326,25 @@ snd_rme96_capture_ptr(struct rme96 *rme96)
 }
 
 static int
-snd_rme96_playback_silence(struct snd_pcm_substream *substream,
-			   int channel, /* not used (interleaved data) */
-			   snd_pcm_uframes_t pos,
-			   snd_pcm_uframes_t count)
-{
-	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-	count <<= rme96->playback_frlog;
-	pos <<= rme96->playback_frlog;
-	memset_io(rme96->iobase + RME96_IO_PLAY_BUFFER + pos,
-		  0, count);
-	return 0;
-}
-
-static int
 snd_rme96_playback_copy(struct snd_pcm_substream *substream,
 			int channel, /* not used (interleaved data) */
 			snd_pcm_uframes_t pos,
 			void __user *src,
-			snd_pcm_uframes_t count)
+			snd_pcm_uframes_t count,
+			bool in_kernel)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	count <<= rme96->playback_frlog;
 	pos <<= rme96->playback_frlog;
-	return copy_from_user_toio(rme96->iobase + RME96_IO_PLAY_BUFFER + pos, src,
-				   count);
+	if (!src)
+		memset_io(rme96->iobase + RME96_IO_PLAY_BUFFER + pos, 0, count);
+	else if (in_kernel)
+		memcpy_toio(rme96->iobase + RME96_IO_PLAY_BUFFER + pos,
+			    (void *)src, count);
+	else if (copy_from_user_toio(rme96->iobase + RME96_IO_PLAY_BUFFER + pos,
+				     src, count))
+		return -EFAULT;
+	return 0;
 }
 
 static int
@@ -358,13 +352,21 @@ snd_rme96_capture_copy(struct snd_pcm_substream *substream,
 		       int channel, /* not used (interleaved data) */
 		       snd_pcm_uframes_t pos,
 		       void __user *dst,
-		       snd_pcm_uframes_t count)
+		       snd_pcm_uframes_t count,
+		       bool in_kernel)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	count <<= rme96->capture_frlog;
 	pos <<= rme96->capture_frlog;
-	return copy_to_user_fromio(dst, rme96->iobase + RME96_IO_REC_BUFFER + pos,
-				   count);
+	if (in_kernel)
+		memcpy_fromio((void *)dst,
+			      rme96->iobase + RME96_IO_REC_BUFFER + pos,
+			      count);
+	else if (copy_to_user_fromio(dst,
+				     rme96->iobase + RME96_IO_REC_BUFFER + pos,
+				     count))
+		return -EFAULT;
+	return 0;
 }
 
 /*
@@ -1513,8 +1515,7 @@ static const struct snd_pcm_ops snd_rme96_playback_spdif_ops = {
 	.prepare =	snd_rme96_playback_prepare,
 	.trigger =	snd_rme96_playback_trigger,
 	.pointer =	snd_rme96_playback_pointer,
-	.copy =		snd_rme96_playback_copy,
-	.silence =	snd_rme96_playback_silence,
+	.copy_silence =	snd_rme96_playback_copy,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
@@ -1526,7 +1527,7 @@ static const struct snd_pcm_ops snd_rme96_capture_spdif_ops = {
 	.prepare =	snd_rme96_capture_prepare,
 	.trigger =	snd_rme96_capture_trigger,
 	.pointer =	snd_rme96_capture_pointer,
-	.copy =		snd_rme96_capture_copy,
+	.copy_silence =	snd_rme96_capture_copy,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
@@ -1538,8 +1539,7 @@ static const struct snd_pcm_ops snd_rme96_playback_adat_ops = {
 	.prepare =	snd_rme96_playback_prepare,
 	.trigger =	snd_rme96_playback_trigger,
 	.pointer =	snd_rme96_playback_pointer,
-	.copy =		snd_rme96_playback_copy,
-	.silence =	snd_rme96_playback_silence,
+	.copy_silence =	snd_rme96_playback_copy,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
@@ -1551,7 +1551,7 @@ static const struct snd_pcm_ops snd_rme96_capture_adat_ops = {
 	.prepare =	snd_rme96_capture_prepare,
 	.trigger =	snd_rme96_capture_trigger,
 	.pointer =	snd_rme96_capture_pointer,
-	.copy =		snd_rme96_capture_copy,
+	.copy_silence =	snd_rme96_capture_copy,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-- 
2.12.2
