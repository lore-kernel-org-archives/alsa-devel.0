From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 07/11] ALSA: rme9652: an exsample changes
	for drivers which support interleaved buffer
Date: Wed, 24 May 2017 09:52:51 +0900
Message-ID: <20170524005255.31223-8-o-takashi@sakamocchi.jp>
References: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id CC5602671AB
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 02:53:04 +0200 (CEST)
In-Reply-To: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an example of new operation for copy_frames callback, in a case
of drivers for interleaved frame alignment.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/rme9652/hdsp.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index fc0face6cdc6..430c6cbcb5f6 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3930,6 +3930,31 @@ static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream, int chann
 	return count;
 }
 
+static int playback_copy_frames(struct snd_pcm_substream *substream,
+				unsigned int hwoff, unsigned long data,
+				unsigned int off, snd_pcm_uframes_t count)
+{
+	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char __user *src = (char __user *)data;
+	char *channel_buf;
+
+	channel_buf = hdsp_channel_buffer_location(hdsp,
+				substream->pstr->stream, runtime->channels);
+	if (snd_BUG_ON(!channel_buf))
+		return -EIO;
+	channel_buf += hwoff * 4;
+
+	if (src == NULL) {
+		memset(channel_buf, 0, count * 4);
+	} else {
+		if (copy_from_user(channel_buf, src, count * 4))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream, int channel,
 				 snd_pcm_uframes_t pos, void __user *dst, snd_pcm_uframes_t count)
 {
@@ -3947,6 +3972,26 @@ static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream, int channe
 	return count;
 }
 
+static int capture_copy_frames(struct snd_pcm_substream *substream,
+			       unsigned int hwoff, unsigned long data,
+			       unsigned int off, snd_pcm_uframes_t count)
+{
+	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	char __user *dst = (char __user *)data;
+	char *channel_buf;
+
+	channel_buf = hdsp_channel_buffer_location(hdsp,
+				substream->pstr->stream, runtime->channels);
+	if (snd_BUG_ON(!channel_buf))
+		return -EIO;
+	channel_buf += hwoff * 4;
+
+	if (copy_to_user(dst, channel_buf + hwoff * 4, count * 4))
+		return -EFAULT;
+	return count;
+}
+
 static int snd_hdsp_hw_silence(struct snd_pcm_substream *substream, int channel,
 				  snd_pcm_uframes_t pos, snd_pcm_uframes_t count)
 {
@@ -4871,6 +4916,7 @@ static const struct snd_pcm_ops snd_hdsp_playback_ops = {
 	.pointer =	snd_hdsp_hw_pointer,
 	.copy =		snd_hdsp_playback_copy,
 	.silence =	snd_hdsp_hw_silence,
+	.copy_frames =	playback_copy_frames,
 };
 
 static const struct snd_pcm_ops snd_hdsp_capture_ops = {
@@ -4882,6 +4928,7 @@ static const struct snd_pcm_ops snd_hdsp_capture_ops = {
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
 	.copy =		snd_hdsp_capture_copy,
+	.copy_frames =	capture_copy_frames,
 };
 
 static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
-- 
2.11.0
