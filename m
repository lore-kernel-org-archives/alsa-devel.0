From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 2/4] snd-usb-caiaq: Missing lock around use of
	buffer positions
Date: Fri, 25 Sep 2009 16:22:16 +0100
Message-ID: <1253892138-10827-2-git-send-email-mark@pogo.org.uk>
References: <alpine.BSO.2.01.0909220805420.25926@zrgural.vwaro.pbz>
	<1253892138-10827-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 15A4510390C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 17:22:19 +0200 (CEST)
In-Reply-To: <1253892138-10827-1-git-send-email-mark@pogo.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix a race which causes snd_pcm_update_hw_ptr_pos() to report a bug.
---
 sound/usb/caiaq/audio.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index ce193a5..9856c00 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -268,16 +268,22 @@ snd_usb_caiaq_pcm_pointer(struct snd_pcm_substream *sub)
 {
 	int index = sub->number;
 	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(sub);
+	snd_pcm_uframes_t ptr;
+
+	spin_lock(&dev->spinlock);
 
 	if (dev->input_panic || dev->output_panic)
-		return SNDRV_PCM_POS_XRUN;
+		ptr = SNDRV_PCM_POS_XRUN;
 
 	if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		return bytes_to_frames(sub->runtime,
+		ptr = bytes_to_frames(sub->runtime,
 					dev->audio_out_buf_pos[index]);
 	else
-		return bytes_to_frames(sub->runtime,
+		ptr = bytes_to_frames(sub->runtime,
 					dev->audio_in_buf_pos[index]);
+
+	spin_unlock(&dev->spinlock);
+	return ptr;
 }
 
 /* operators for both playback and capture */
-- 
1.6.4.4
