From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 13/26] ALSA: es1938: Convert to
	copy_silence ops
Date: Thu, 11 May 2017 23:09:12 +0200
Message-ID: <20170511210925.18208-14-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D1EDA266FD4
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8FED6AECD
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
It's used only for a capture stream (for some hardware workaround),
thus we need no silence operation but only to add the in_kernel
memcpy() handling.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/es1938.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index e8d943071a8c..d79ac13d6f70 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -842,7 +842,8 @@ static int snd_es1938_capture_copy(struct snd_pcm_substream *substream,
 				   int channel,
 				   snd_pcm_uframes_t pos,
 				   void __user *dst,
-				   snd_pcm_uframes_t count)
+				   snd_pcm_uframes_t count,
+				   bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct es1938 *chip = snd_pcm_substream_chip(substream);
@@ -850,8 +851,10 @@ static int snd_es1938_capture_copy(struct snd_pcm_substream *substream,
 	count <<= chip->dma1_shift;
 	if (snd_BUG_ON(pos + count > chip->dma1_size))
 		return -EINVAL;
-	if (pos + count < chip->dma1_size) {
-		if (copy_to_user(dst, runtime->dma_area + pos + 1, count))
+	if (in_kernel || pos + count < chip->dma1_size) {
+		if (in_kernel)
+			memcpy((void *)dst, runtime->dma_area + pos + 1, count);
+		else if (copy_to_user(dst, runtime->dma_area + pos + 1, count))
 			return -EFAULT;
 	} else {
 		if (copy_to_user(dst, runtime->dma_area + pos + 1, count - 1))
@@ -1012,7 +1015,7 @@ static const struct snd_pcm_ops snd_es1938_capture_ops = {
 	.prepare =	snd_es1938_capture_prepare,
 	.trigger =	snd_es1938_capture_trigger,
 	.pointer =	snd_es1938_capture_pointer,
-	.copy =		snd_es1938_capture_copy,
+	.copy_silence =	snd_es1938_capture_copy,
 };
 
 static int snd_es1938_new_pcm(struct es1938 *chip, int device)
-- 
2.12.2
