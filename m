From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 15/26] ALSA: nm256: Convert to copy_silence
	ops
Date: Thu, 11 May 2017 23:09:14 +0200
Message-ID: <20170511210925.18208-16-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EAC3A266FEC
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:31 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 92275AECF
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
 sound/pci/nm256/nm256.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 103fe311e5a9..d8e765f7e758 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -694,31 +694,22 @@ snd_nm256_capture_pointer(struct snd_pcm_substream *substream)
  * silence / copy for playback
  */
 static int
-snd_nm256_playback_silence(struct snd_pcm_substream *substream,
-			   int channel, /* not used (interleaved data) */
-			   snd_pcm_uframes_t pos,
-			   snd_pcm_uframes_t count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct nm256_stream *s = runtime->private_data;
-	count = frames_to_bytes(runtime, count);
-	pos = frames_to_bytes(runtime, pos);
-	memset_io(s->bufptr + pos, 0, count);
-	return 0;
-}
-
-static int
 snd_nm256_playback_copy(struct snd_pcm_substream *substream,
 			int channel, /* not used (interleaved data) */
 			snd_pcm_uframes_t pos,
 			void __user *src,
-			snd_pcm_uframes_t count)
+			snd_pcm_uframes_t count,
+			bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct nm256_stream *s = runtime->private_data;
 	count = frames_to_bytes(runtime, count);
 	pos = frames_to_bytes(runtime, pos);
-	if (copy_from_user_toio(s->bufptr + pos, src, count))
+	if (!src)
+		memset_io(s->bufptr + pos, 0, count);
+	else if (in_kernel)
+		memcpy_toio(s->bufptr + pos, (void *)src, count);
+	else if (copy_from_user_toio(s->bufptr + pos, src, count))
 		return -EFAULT;
 	return 0;
 }
@@ -731,13 +722,16 @@ snd_nm256_capture_copy(struct snd_pcm_substream *substream,
 		       int channel, /* not used (interleaved data) */
 		       snd_pcm_uframes_t pos,
 		       void __user *dst,
-		       snd_pcm_uframes_t count)
+		       snd_pcm_uframes_t count,
+		       bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct nm256_stream *s = runtime->private_data;
 	count = frames_to_bytes(runtime, count);
 	pos = frames_to_bytes(runtime, pos);
-	if (copy_to_user_fromio(dst, s->bufptr + pos, count))
+	if (in_kernel)
+		memcpy_fromio((void *)dst, s->bufptr + pos, count);
+	else if (copy_to_user_fromio(dst, s->bufptr + pos, count))
 		return -EFAULT;
 	return 0;
 }
@@ -911,8 +905,7 @@ static const struct snd_pcm_ops snd_nm256_playback_ops = {
 	.trigger =	snd_nm256_playback_trigger,
 	.pointer =	snd_nm256_playback_pointer,
 #ifndef __i386__
-	.copy =		snd_nm256_playback_copy,
-	.silence =	snd_nm256_playback_silence,
+	.copy_silence =	snd_nm256_playback_copy,
 #endif
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
@@ -926,7 +919,7 @@ static const struct snd_pcm_ops snd_nm256_capture_ops = {
 	.trigger =	snd_nm256_capture_trigger,
 	.pointer =	snd_nm256_capture_pointer,
 #ifndef __i386__
-	.copy =		snd_nm256_capture_copy,
+	.copy_silence =	snd_nm256_capture_copy,
 #endif
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
-- 
2.12.2
