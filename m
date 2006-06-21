From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] azt3328 fatal deadlock fix (very rare, though)
Date: Wed, 21 Jun 2006 10:32:34 +0200
Message-ID: <20060621083234.GA25022@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

while listening to my 315th MP3 file played on this soundcard I had the
extreme mispleasure of experiencing a complete lockup of my box right
during shutdown of this file's playback, not even Magic SysRq worked
(characteristic sign of spinlock conflicts).

I determined that it must have been the combination of not doing the _irqsave()
variant in the playback trigger function and then having another IRQ occur
(which tried to spinlock again, against the active lock in the playback trigger
function). By always doing _irqsave() everywhere we also don't need separate
locking in the IRQ handler any more (managed to reduce CPU load, too).

ChangeLog:
- fix spinlocks to avoid entering spinlocking IRQ with lock held in non-IRQ part

Note that at least als4000.c has the same issue in the trigger functions,
so this deadlock has the potential of happening there, too.
I have an ALS4000, so I could do further work if needed.

Also, with this change switching from console to X11 will cause playback
to click, most likely due to interrupting the app during spinlock held in
non-IRQ part, so no IRQ possible during that time to handle buffer updating
(I don't think it clicked before, and this is most likely due to weird interrupt
fiddling of X11 during a console switch).

Changes extensively tested on 2.6.17-rc6-mm2 (but not nearly enough to have
at least the same amount of testing as in the time range before this
*very rare* lockup, to be able to determine whether this truly fixed it!!).

Diff against current rsynced version (had some unexpected rejects,
but should be fine).

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- alsa-kernel/pci/azt3328.c.orig	2006-04-24 12:32:48.000000000 +0200
+++ alsa-kernel/pci/azt3328.c	2006-06-21 10:11:33.000000000 +0200
@@ -899,6 +899,7 @@
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int result = 0;
 	unsigned int status1;
+	unsigned long flags;
 
 	snd_azf3328_dbgcalls("snd_azf3328_playback_trigger cmd %d\n", cmd);
 
@@ -914,7 +915,7 @@
 			snd_pcm_format_width(runtime->format),
 			runtime->channels);
 
-		spin_lock(&chip->reg_lock);
+		spin_lock_irqsave(&chip->reg_lock, flags);
 		/* stop playback */
 		status1 = snd_azf3328_codec_inw(chip, IDX_IO_PLAY_FLAGS);
 		status1 &= ~DMA_RESUME;
@@ -922,14 +923,14 @@
 	    
 		/* FIXME: clear interrupts or what??? */
 		snd_azf3328_codec_outw(chip, IDX_IO_PLAY_IRQTYPE, 0xffff);
-		spin_unlock(&chip->reg_lock);
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 		snd_azf3328_setdmaa(chip, runtime->dma_addr,
 			snd_pcm_lib_period_bytes(substream),
 			snd_pcm_lib_buffer_bytes(substream),
 			0);
 
-		spin_lock(&chip->reg_lock);
+		spin_lock_irqsave(&chip->reg_lock, flags);
 #ifdef WIN9X
 		/* FIXME: enable playback/recording??? */
 		status1 |= DMA_PLAY_SOMETHING1 | DMA_PLAY_SOMETHING2;
@@ -953,7 +954,7 @@
 			DMA_EPILOGUE_SOMETHING |
 			DMA_SOMETHING_ELSE);
 #endif
-		spin_unlock(&chip->reg_lock);
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 		/* now unmute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 0);
@@ -967,7 +968,7 @@
 		/* mute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 1);
 
-		spin_lock(&chip->reg_lock);
+		spin_lock_irqsave(&chip->reg_lock, flags);
 		/* stop playback */
 		status1 = snd_azf3328_codec_inw(chip, IDX_IO_PLAY_FLAGS);
 
@@ -981,7 +982,7 @@
 
 		status1 &= ~DMA_PLAY_SOMETHING1;
 		snd_azf3328_codec_outw(chip, IDX_IO_PLAY_FLAGS, status1);
-		spin_unlock(&chip->reg_lock);
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	    
 		/* now unmute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 0);
@@ -1011,6 +1012,7 @@
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int result = 0;
 	unsigned int status1;
+	unsigned long flags;
 
 	snd_azf3328_dbgcalls("snd_azf3328_capture_trigger cmd %d\n", cmd);
 
@@ -1024,7 +1026,7 @@
 			snd_pcm_format_width(runtime->format),
 			runtime->channels);
 
-		spin_lock(&chip->reg_lock);
+		spin_lock_irqsave(&chip->reg_lock, flags);
 		/* stop recording */
 		status1 = snd_azf3328_codec_inw(chip, IDX_IO_REC_FLAGS);
 		status1 &= ~DMA_RESUME;
@@ -1032,14 +1034,14 @@
 	    
 		/* FIXME: clear interrupts or what??? */
 		snd_azf3328_codec_outw(chip, IDX_IO_REC_IRQTYPE, 0xffff);
-		spin_unlock(&chip->reg_lock);
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 		snd_azf3328_setdmaa(chip, runtime->dma_addr,
 			snd_pcm_lib_period_bytes(substream),
 			snd_pcm_lib_buffer_bytes(substream),
 			1);
 
-		spin_lock(&chip->reg_lock);
+		spin_lock_irqsave(&chip->reg_lock, flags);
 #ifdef WIN9X
 		/* FIXME: enable playback/recording??? */
 		status1 |= DMA_PLAY_SOMETHING1 | DMA_PLAY_SOMETHING2;
@@ -1063,7 +1065,7 @@
 			DMA_EPILOGUE_SOMETHING |
 			DMA_SOMETHING_ELSE);
 #endif
-		spin_unlock(&chip->reg_lock);
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 		chip->is_recording = 1;
 		snd_azf3328_dbgplay("STARTED CAPTURE\n");
@@ -1071,7 +1073,7 @@
         case SNDRV_PCM_TRIGGER_STOP:
 		snd_azf3328_dbgplay("STOP CAPTURE\n");
 
-		spin_lock(&chip->reg_lock);
+		spin_lock_irqsave(&chip->reg_lock, flags);
 		/* stop recording */
 		status1 = snd_azf3328_codec_inw(chip, IDX_IO_REC_FLAGS);
 
@@ -1083,7 +1085,7 @@
 
 		status1 &= ~DMA_PLAY_SOMETHING1;
 		snd_azf3328_codec_outw(chip, IDX_IO_REC_FLAGS, status1);
-		spin_unlock(&chip->reg_lock);
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	    
 		chip->is_recording = 0;
 		snd_azf3328_dbgplay("STOPPED CAPTURE\n");
@@ -1151,6 +1153,10 @@
 	u8 status, which;
 	static unsigned long irq_count;
 
+	/* no need to lock I/O accesses here, since we're in IRQ section.
+	 * However this means that all non-IRQ users must lock via _irqsave()
+	 * to prevent our IRQ I/O here while they're doing their I/O. */
+
 	status = snd_azf3328_codec_inb(chip, IDX_IO_IRQSTATUS);
 
         /* fast path out, to ease interrupt sharing */
@@ -1169,18 +1175,14 @@
 		if (chip->timer)
 			snd_timer_interrupt(chip->timer, chip->timer->sticks);
 		/* ACK timer */
-                spin_lock(&chip->reg_lock);
 		snd_azf3328_codec_outb(chip, IDX_IO_TIMER_VALUE + 3, 0x07);
-		spin_unlock(&chip->reg_lock);
 		snd_azf3328_dbgplay("azt3328: timer IRQ\n");
 	}
 	if (status & IRQ_PLAYBACK)
 	{
-		spin_lock(&chip->reg_lock);
 		which = snd_azf3328_codec_inb(chip, IDX_IO_PLAY_IRQTYPE);
 		/* ack all IRQ types immediately */
 		snd_azf3328_codec_outb(chip, IDX_IO_PLAY_IRQTYPE, which);
-               	spin_unlock(&chip->reg_lock);
 
 		if (chip->pcm && chip->playback_substream)
 		{
@@ -1196,11 +1198,9 @@
 	}
 	if (status & IRQ_RECORDING)
 	{
-                spin_lock(&chip->reg_lock);
 		which = snd_azf3328_codec_inb(chip, IDX_IO_REC_IRQTYPE);
 		/* ack all IRQ types immediately */
 		snd_azf3328_codec_outb(chip, IDX_IO_REC_IRQTYPE, which);
-		spin_unlock(&chip->reg_lock);
 
 		if (chip->pcm && chip->capture_substream)
 		{
