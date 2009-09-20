From: Mark Hills <mark@pogo.org.uk>
Subject: Questions on locking, snd-usb-caiaq
Date: Sun, 20 Sep 2009 13:07:05 +0100 (BST)
Message-ID: <alpine.BSO.2.01.0909201207350.12606@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BCAB2414A
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 14:07:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I fixed some race issues in snd-usb-caiaq, but have some questions on the 
interface between the driver and ALSA.

First fix is a lock in pointer(), which caused snd_pcm_update_hw_ptr_pos() 
to report an out of range buffer position (even though it was sucessfully 
corrected to zero).

Second is a lock as part of trigger(). On testing, this appears to fix an 
issue where white noise could sometimes be transferred by the driver.

According to the documentation, trigger() and pointer() are called with 
local interrupts disabled. This means they should really be non-irqsave 
locks?

(http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s08.html)

Even for callbacks documented as atomic, if read_completed() and 
write_completed() can be called at any time interrupts are enabled (eg. on 
another CPU) it seems that additional locking my be required. Candidates 
are:

   snd_usb_caiaq_substream_open
   snd_usb_caiaq_substream_close
   snd_usb_caiaq_pcm_hw_free
   snd_usb_caiaq_pcm_prepare

Are there any guarantees on these functions which mean the lock is not 
required?

To lock in prepare() would (I think) require demoting a 
spin_lock_irqsave() to a spin_lock() to send initialisation commands. If 
so, what is the best design for this?

Thanks,

-- 
Mark

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 121af06..c659f81 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -62,10 +62,15 @@ static void
  activate_substream(struct snd_usb_caiaqdev *dev,
  	           struct snd_pcm_substream *sub)
  {
+	unsigned long flags;
+	spin_lock_irqsave(&dev->spinlock, flags);
+
  	if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
  		dev->sub_playback[sub->number] = sub;
  	else
  		dev->sub_capture[sub->number] = sub;
+
+	spin_unlock_irqrestore(&dev->spinlock, flags);
  }

  static void
@@ -269,16 +274,23 @@ snd_usb_caiaq_pcm_pointer(struct snd_pcm_substream *sub)
  {
  	int index = sub->number;
  	struct snd_usb_caiaqdev *dev = snd_pcm_substream_chip(sub);
+	unsigned long flags;
+	snd_pcm_uframes_t ptr;
+
+	spin_lock_irqsave(&dev->spinlock, flags);

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
+	spin_unlock_irqrestore(&dev->spinlock, flags);
+	return ptr;
  }

  /* operators for both playback and capture */
