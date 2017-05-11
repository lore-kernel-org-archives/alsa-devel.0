From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 19/26] ALSA: hdsp: Convert to copy_silence
	ops
Date: Thu, 11 May 2017 23:09:18 +0200
Message-ID: <20170511210925.18208-20-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D17F2266FCD
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:32 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9EFEDAED4
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
 sound/pci/rme9652/hdsp.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index fc0face6cdc6..5325e91fc3a8 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3913,8 +3913,10 @@ static char *hdsp_channel_buffer_location(struct hdsp *hdsp,
 		return hdsp->playback_buffer + (mapped_channel * HDSP_CHANNEL_BUFFER_BYTES);
 }
 
-static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream, int channel,
-				  snd_pcm_uframes_t pos, void __user *src, snd_pcm_uframes_t count)
+static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream,
+				  int channel, snd_pcm_uframes_t pos,
+				  void __user *src, snd_pcm_uframes_t count,
+				  bool in_kernel)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	char *channel_buf;
@@ -3925,13 +3927,19 @@ static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream, int chann
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
 		return -EIO;
-	if (copy_from_user(channel_buf + pos * 4, src, count * 4))
+	if (!src)
+		memset(channel_buf + pos * 4, 0, count * 4);
+	else if (in_kernel)
+		memcpy(channel_buf + pos * 4, (void *)src, count * 4);
+	else if (copy_from_user(channel_buf + pos * 4, src, count * 4))
 		return -EFAULT;
-	return count;
+	return 0;
 }
 
-static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream, int channel,
-				 snd_pcm_uframes_t pos, void __user *dst, snd_pcm_uframes_t count)
+static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream,
+				 int channel, snd_pcm_uframes_t pos,
+				 void __user *dst, snd_pcm_uframes_t count,
+				 bool in_kernel)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	char *channel_buf;
@@ -3942,22 +3950,11 @@ static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream, int channe
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
 		return -EIO;
-	if (copy_to_user(dst, channel_buf + pos * 4, count * 4))
+	if (in_kernel)
+		memcpy((void *)dst, channel_buf + pos * 4, count * 4);
+	else if (copy_to_user(dst, channel_buf + pos * 4, count * 4))
 		return -EFAULT;
-	return count;
-}
-
-static int snd_hdsp_hw_silence(struct snd_pcm_substream *substream, int channel,
-				  snd_pcm_uframes_t pos, snd_pcm_uframes_t count)
-{
-	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
-
-	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	memset(channel_buf + pos * 4, 0, count * 4);
-	return count;
+	return 0;
 }
 
 static int snd_hdsp_reset(struct snd_pcm_substream *substream)
@@ -4869,8 +4866,7 @@ static const struct snd_pcm_ops snd_hdsp_playback_ops = {
 	.prepare =	snd_hdsp_prepare,
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
-	.copy =		snd_hdsp_playback_copy,
-	.silence =	snd_hdsp_hw_silence,
+	.copy_silence =	snd_hdsp_playback_copy,
 };
 
 static const struct snd_pcm_ops snd_hdsp_capture_ops = {
@@ -4881,7 +4877,7 @@ static const struct snd_pcm_ops snd_hdsp_capture_ops = {
 	.prepare =	snd_hdsp_prepare,
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
-	.copy =		snd_hdsp_capture_copy,
+	.copy_silence =	snd_hdsp_capture_copy,
 };
 
 static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
-- 
2.12.2
