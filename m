From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: [PATCH] AZT3328 driver update
Date: Wed, 14 Sep 2005 00:59:58 +0200
Message-ID: <20050913225958.GA28548@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

call me crazy, call me weird, but I decided to finally spend another evening
on my oldish undocumented PCI168 card since it's sooo much fun!

The result is this patch to current CVS which:
- improves/fixes some fatal playback/recording interaction
- improves IRQ handler performance (and actually fixes some weird code)
- coalesces some I/O accesses
- slightly improves I/O interface documentation
- improves/fixes logging
- defines out some less important debug code
- constifies some data

Thanks,

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="azt3328_cvs.diff"

Index: azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/azt3328.c,v
retrieving revision 1.29
diff -u -r1.29 azt3328.c
--- azt3328.c	12 Sep 2005 07:20:54 -0000	1.29
+++ azt3328.c	13 Sep 2005 22:50:10 -0000
@@ -445,9 +445,9 @@
 static int snd_azf3328_info_mixer_enum(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	azf3328_mixer_reg_t reg;
-	static char *texts1[2] = { "ModemOut1", "ModemOut2" };
-	static char *texts2[2] = { "MonoSelectSource1", "MonoSelectSource2" };
-        static char *texts3[8] = {
+	static const char * const texts1[2] = { "ModemOut1", "ModemOut2" };
+	static const char * const texts2[2] = { "MonoSelectSource1", "MonoSelectSource2" };
+	static const char * const texts3[8] = {
                 "Mic", "CD", "Video", "Aux", "Line",
                 "Mix", "Mix Mono", "Phone"
         };
@@ -578,7 +578,7 @@
 
 #define AZF3328_INIT_VALUES (sizeof(snd_azf3328_init_values)/sizeof(unsigned int)/2)
 
-static unsigned int snd_azf3328_init_values[][2] = {
+static const unsigned int snd_azf3328_init_values[][2] = {
         { IDX_MIXER_PLAY_MASTER,	MIXER_MUTE_MASK|0x1f1f },
         { IDX_MIXER_MODEMOUT,		MIXER_MUTE_MASK|0x1f1f },
 	{ IDX_MIXER_BASSTREBLE,		0x0000 },
@@ -718,12 +718,25 @@
 	unsigned int count1;
 	unsigned int count2;
 	unsigned long flags;
-	int reg_offs = do_recording ? 0x20 : 0x00;
-
+	int reg_offs;
+	unsigned int is_running;
+	
 	snd_azf3328_dbgcallenter();
+	if (do_recording)
+	{
+		reg_offs = 0x20; /* access the capture register section */
+		is_running = chip->is_recording;
+	}
+	else
+	{
+		reg_offs = 0x00; /* access the playback register section */
+		is_running = chip->is_playing;
+	}
+
 	/* AZF3328 uses a two buffer pointer DMA playback approach */
-	if (!chip->is_playing)
+	if (!is_running)
 	{
+		unsigned long count_combo;
 		addr1 = addr;
 		addr2 = addr+(size/2);
 		count1 = (size/2)-1;
@@ -731,11 +744,11 @@
 #if DEBUG_PLAY_REC
 		snd_azf3328_dbgplay("setting dma: buf1 %08lx[%d], buf2 %08lx[%d]\n", addr1, count1, addr2, count2);
 #endif
+		count_combo = count1 | (count2 << 16);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 		outl(addr1, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_START_1);
 		outl(addr2, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_START_2);
-		outw(count1, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_LEN_1);
-		outw(count2, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_LEN_2);
+		outl(count_combo, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_LEN_1);
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	}
 	snd_azf3328_dbgcallleave();
@@ -787,8 +800,7 @@
 	snd_azf3328_dbgcalls("snd_azf3328_playback_trigger cmd %d\n", cmd);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-
-		snd_azf3328_dbgio(chip, "trigger1");
+		snd_azf3328_dbgplay("START PLAYBACK\n");
 
 		/* mute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 1);
@@ -818,7 +830,7 @@
 		status1 |= DMA_RESUME | DMA_EPILOGUE_SOMETHING;
 		outw(status1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 #else /* NT4 */
-		outw(0x00, chip->codec_port+IDX_IO_PLAY_FLAGS);
+		outw(0x0000, chip->codec_port+IDX_IO_PLAY_FLAGS);
 		outw(DMA_PLAY_SOMETHING1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 		outw(DMA_PLAY_SOMETHING1|DMA_PLAY_SOMETHING2, chip->codec_port+IDX_IO_PLAY_FLAGS);
 		outw(DMA_RESUME|SOMETHING_ALMOST_ALWAYS_SET|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port+IDX_IO_PLAY_FLAGS);
@@ -828,10 +840,12 @@
 		/* now unmute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 0);
 
-		snd_azf3328_dbgio(chip, "trigger2");
 		chip->is_playing = 1;
+		snd_azf3328_dbgplay("STARTED PLAYBACK\n");
 		break;
-        case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_azf3328_dbgplay("STOP PLAYBACK\n");
+
 		/* mute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 1);
 
@@ -842,6 +856,8 @@
 		status1 &= ~DMA_RESUME;
 		outw(status1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 
+		/* hmm, is this really required? we're resetting the same bit
+		 * immediately thereafter... */
 		status1 |= DMA_PLAY_SOMETHING1;
 		outw(status1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 
@@ -852,6 +868,7 @@
 		/* now unmute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 0);
 		chip->is_playing = 0;
+		snd_azf3328_dbgplay("STOPPED PLAYBACK\n");
 		break;
         case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_printk("FIXME: SNDRV_PCM_TRIGGER_PAUSE_PUSH NIY!\n");
@@ -880,7 +897,7 @@
         switch (cmd) {
         case SNDRV_PCM_TRIGGER_START:
 
-		snd_azf3328_dbgio(chip, "trigger1");
+		snd_azf3328_dbgplay("START CAPTURE\n");
 
 		snd_azf3328_setfmt(chip, IDX_IO_REC_SOUNDFORMAT, runtime->rate, snd_pcm_format_width(runtime->format), runtime->channels);
 
@@ -902,7 +919,7 @@
 		status1 |= DMA_PLAY_SOMETHING1 | DMA_PLAY_SOMETHING2;
 		outw(status1, chip->codec_port+IDX_IO_REC_FLAGS);
 
-		/* start playback again */
+		/* start capture again */
 		/* FIXME: what is this value (0x0010)??? */
 		status1 |= DMA_RESUME | DMA_EPILOGUE_SOMETHING;
 		outw(status1, chip->codec_port+IDX_IO_REC_FLAGS);
@@ -914,10 +931,12 @@
 #endif
 		spin_unlock(&chip->reg_lock);
 
-		snd_azf3328_dbgio(chip, "trigger2");
-		chip->is_playing = 1;
+		chip->is_recording = 1;
+		snd_azf3328_dbgplay("STARTED CAPTURE\n");
 		break;
         case SNDRV_PCM_TRIGGER_STOP:
+		snd_azf3328_dbgplay("STOP CAPTURE\n");
+
 		spin_lock(&chip->reg_lock);
 		/* stop recording */
 		status1 = inw(chip->codec_port+IDX_IO_REC_FLAGS);
@@ -932,7 +951,8 @@
 		outw(status1, chip->codec_port+IDX_IO_REC_FLAGS);
 		spin_unlock(&chip->reg_lock);
 	    
-		chip->is_playing = 0;
+		chip->is_recording = 0;
+		snd_azf3328_dbgplay("STOPPED CAPTURE\n");
 		break;
         case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_printk("FIXME: SNDRV_PCM_TRIGGER_PAUSE_PUSH NIY!\n");
@@ -964,7 +984,7 @@
 
 	result = playptr - bufptr;
 	frmres = bytes_to_frames( substream->runtime, result );
-	snd_azf3328_dbgplay("result %lx, playptr %lx (base %x), frames %ld\n", result, playptr, substream->runtime->dma_addr, frmres);
+	snd_azf3328_dbgplay("PLAY @ 0x%8lx, frames %8ld\n", result, frmres);
 	return frmres;
 }
 
@@ -984,7 +1004,7 @@
 
 	result = recptr - bufptr;
 	frmres = bytes_to_frames( substream->runtime, result );
-	snd_azf3328_dbgplay("result %lx, rec ptr %lx (base %x), frames %ld\n", result, recptr, substream->runtime->dma_addr, frmres);
+	snd_azf3328_dbgplay("REC  @ 0x%8lx, frames %8ld\n", result, frmres);
 	return frmres;
 }
 
@@ -1000,55 +1020,45 @@
 	if (!(status & (IRQ_PLAYBACK|IRQ_RECORDING|IRQ_MPU401|IRQ_SOMEIRQ)))
 		return IRQ_NONE; /* must be interrupt for another device */
 
-	snd_azf3328_dbgplay("Interrupt %ld!\nIDX_IO_PLAY_FLAGS %04x, IDX_IO_PLAY_IRQMASK %04x, IDX_IO_IRQSTATUS %04x\n", count, inw(chip->codec_port+IDX_IO_PLAY_FLAGS), inw(chip->codec_port+IDX_IO_PLAY_IRQMASK), inw(chip->codec_port+IDX_IO_IRQSTATUS));
+	snd_azf3328_dbgplay("Interrupt %ld!\nIDX_IO_PLAY_FLAGS %04x, IDX_IO_PLAY_IRQMASK %04x, IDX_IO_IRQSTATUS %04x\n", count, inw(chip->codec_port+IDX_IO_PLAY_FLAGS), inw(chip->codec_port+IDX_IO_PLAY_IRQMASK), status);
 		
 	if (status & IRQ_PLAYBACK)
 	{
 		spin_lock(&chip->reg_lock);
 		which = inw(chip->codec_port+IDX_IO_PLAY_IRQMASK);
-		if (which & IRQ_FINISHED_PLAYBUF_1)
-			/* ack IRQ */
-			outw(which | IRQ_FINISHED_PLAYBUF_1, chip->codec_port+IDX_IO_PLAY_IRQMASK);
-		if (which & IRQ_FINISHED_PLAYBUF_2)
-			/* ack IRQ */
-			outw(which | IRQ_FINISHED_PLAYBUF_2, chip->codec_port+IDX_IO_PLAY_IRQMASK);
+		/* ack all IRQ types immediately */
+		outw(which, chip->codec_port+IDX_IO_PLAY_IRQMASK);
+               	spin_unlock(&chip->reg_lock);
 		if (which & IRQ_PLAY_SOMETHING)
 		{
 			snd_azf3328_dbgplay("azt3328: unknown play IRQ type occurred, please report!\n");
 		}
 		if (chip->pcm && chip->playback_substream)
 		{
-			snd_azf3328_dbgplay("which %x, playptr %lx\n", which, inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
+			snd_azf3328_dbgplay("which %x, playptr %x\n", which, inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
 			snd_pcm_period_elapsed(chip->playback_substream);
-			snd_azf3328_dbgplay("period done, playptr %lx.\n", inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
+			snd_azf3328_dbgplay("period done, playptr %x\n", inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
 		}
 		else
 			snd_azf3328_dbgplay("azt3328: ouch, irq handler problem!\n");
-               	spin_unlock(&chip->reg_lock);
 	}
 	if (status & IRQ_RECORDING)
 	{
                 spin_lock(&chip->reg_lock);
 		which = inw(chip->codec_port+IDX_IO_REC_IRQMASK);
-		if (which & IRQ_FINISHED_RECBUF_1)
-			/* ack interrupt */
-			outw(which | IRQ_FINISHED_RECBUF_1, chip->codec_port+IDX_IO_REC_IRQMASK);
-		if (which & IRQ_FINISHED_RECBUF_2)
-			/* ack interrupt */
-			outw(which | IRQ_FINISHED_RECBUF_2, chip->codec_port+IDX_IO_REC_IRQMASK);
+		/* ack all IRQ types immediately */
+		outw(which, chip->codec_port+IDX_IO_REC_IRQMASK);
+               	spin_unlock(&chip->reg_lock);
 		if (which & IRQ_REC_SOMETHING)
 		{
 			snd_azf3328_dbgplay("azt3328: unknown rec IRQ type occurred, please report!\n");
 		}
 		if (chip->pcm && chip->capture_substream)
 		{
-			snd_azf3328_dbgplay("which %x, recptr %lx\n", which, inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
-			spin_unlock(&chip->reg_lock);
+			snd_azf3328_dbgplay("which %x, recptr %x\n", which, inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
 			snd_pcm_period_elapsed(chip->capture_substream);
-			spin_lock(&chip->reg_lock);
-			snd_azf3328_dbgplay("period done, recptr %lx.\n", inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
+			snd_azf3328_dbgplay("period done, recptr %x\n", inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
 		}
-               	spin_unlock(&chip->reg_lock);
 	}
 	if (status & IRQ_MPU401)
 		snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data, regs);
@@ -1291,7 +1301,7 @@
 	/* FIXME */
 
         synchronize_irq(chip->irq);
-      __end_hw:
+__end_hw:
 	snd_azf3328_free_joystick(chip);
         if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
@@ -1338,7 +1348,9 @@
 	static snd_device_ops_t ops = {
 		.dev_free =     snd_azf3328_dev_free,
 	};
+#if DEBUG_MISC
 	u16 tmp;
+#endif
 
 	*rchip = NULL;
 
@@ -1384,6 +1396,7 @@
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);
 
+#if DEBUG_MISC
 	snd_azf3328_dbgmisc("codec_port 0x%lx, io2_port 0x%lx, mpu_port 0x%lx, synth_port 0x%lx, mixer_port 0x%lx, irq %d\n", chip->codec_port, chip->io2_port, chip->mpu_port, chip->synth_port, chip->mixer_port, chip->irq);
 
 	snd_azf3328_dbgmisc("io2 %02x %02x %02x %02x %02x %02x\n", snd_azf3328_io2_read(chip, 0), snd_azf3328_io2_read(chip, 1), snd_azf3328_io2_read(chip, 2), snd_azf3328_io2_read(chip, 3), snd_azf3328_io2_read(chip, 4), snd_azf3328_io2_read(chip, 5));
@@ -1391,6 +1404,10 @@
 	for (tmp=0; tmp <= 0x01; tmp += 1)
 		snd_azf3328_dbgmisc("0x%02x: opl 0x%04x, mpu300 0x%04x, mpu310 0x%04x, mpu320 0x%04x, mpu330 0x%04x\n", tmp, inb(0x388 + tmp), inb(0x300 + tmp), inb(0x310 + tmp), inb(0x320 + tmp), inb(0x330 + tmp));
 
+	for (tmp = 0; tmp <= 0x6E; tmp += 2)
+		snd_azf3328_dbgmisc("0x%02x: 0x%04x\n", tmp, inb(chip->codec_port + tmp));
+#endif
+
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_azf3328_free(chip);
 		return err;
@@ -1408,10 +1425,9 @@
 	/* standard chip init stuff */
 	spin_lock_irq(&chip->reg_lock);
 	outb(DMA_PLAY_SOMETHING2|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_PLAY_FLAGS);
-	outb(DMA_PLAY_SOMETHING2|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_SOMETHING_FLAGS);
 	outb(DMA_PLAY_SOMETHING2|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_REC_FLAGS);
+	outb(DMA_PLAY_SOMETHING2|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_SOMETHING_FLAGS);
 	outb(0x0, chip->codec_port + IDX_IO_IRQ63H);
-
 	spin_unlock_irq(&chip->reg_lock);
 
 	snd_card_set_dev(card, &pci->dev);
@@ -1473,7 +1489,7 @@
 		}
 	}
 
-	snd_azf3328_dbgio(chip, "create");
+	snd_azf3328_dbgio(chip, "create\n");
 
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->codec_port, chip->irq);
Index: azt3328.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/azt3328.h,v
retrieving revision 1.1
diff -u -r1.1 azt3328.h
--- azt3328.h	2 Jun 2003 12:59:41 -0000	1.1
+++ azt3328.h	13 Sep 2005 22:50:10 -0000
@@ -1,19 +1,21 @@
-#ifndef __SOUND_AZF3328_H
-#define __SOUND_AZF3328_H
+#ifndef __SOUND_AZT3328_H
+#define __SOUND_AZT3328_H
 
 /* type argument to use for the I/O functions */
 #define WORD_VALUE      0x1000
 #define DWORD_VALUE     0x2000
 #define BYTE_VALUE      0x4000
 
+/* "PU" == "power-up value", as tested on PCI168 PCI rev. 10 */
+
 /*** main I/O area port indices ***/
 /* (only 0x70 of 0x80 bytes saved/restored by Windows driver) */
 /* the driver initialisation suggests a layout of 3 main areas:
  * from 0x00 (playback), from 0x20 (recording) and from 0x40 (maybe DirectX
- * timer ???). and probably another area from 0x60 to 0x6f
- * (IRQ management, power management etc. ???). */
+ * timer???). and probably another area from 0x60 to 0x6f
+ * (IRQ management, power management etc.???). */
 /* playback area */
-#define IDX_IO_PLAY_FLAGS       0x00
+#define IDX_IO_PLAY_FLAGS       0x00 /* PU:0x0000 */
      /* able to reactivate output after output muting due to 8/16bit
       * output change, just like 0x0002.
       * 0x0001 is the only bit that's able to start the DMA counter */
@@ -29,7 +31,7 @@
   #define DMA_EPILOGUE_SOMETHING	0x0010
   #define DMA_SOMETHING_ELSE		0x0020 /* ??? */
   #define SOMETHING_UNMODIFIABLE	0xffc0 /* unused ? not modifiable */
-#define IDX_IO_PLAY_IRQMASK     0x02
+#define IDX_IO_PLAY_IRQMASK     0x02 /* PU:0x0001 */
   /* write back to flags in case flags are set, in order to ACK IRQ in handler
    * (bit 1 of port 0x64 indicates interrupt for one of these three types)
    * sometimes in this case it just writes 0xffff to globally ACK all IRQs
@@ -41,13 +43,13 @@
   #define IRQMASK_SOME_STATUS_1		0x0008 /* \ related bits */
   #define IRQMASK_SOME_STATUS_2		0x0010 /* / (checked together in loop) */
   #define IRQMASK_UNMODIFIABLE		0xffe0 /* unused ? not modifiable */
-#define IDX_IO_PLAY_DMA_START_1 0x04 /* start address of 1st DMA play area */
-#define IDX_IO_PLAY_DMA_START_2 0x08 /* start address of 2nd DMA play area */
-#define IDX_IO_PLAY_DMA_LEN_1   0x0c /* length of 1st DMA play area */
-#define IDX_IO_PLAY_DMA_LEN_2   0x0e /* length of 2nd DMA play area */
-#define IDX_IO_PLAY_DMA_CURRPOS 0x10 /* current DMA position  */
-#define IDX_IO_PLAY_DMA_CURROFS	0x14 /* offset within current DMA play area */
-#define IDX_IO_PLAY_SOUNDFORMAT 0x16
+#define IDX_IO_PLAY_DMA_START_1 0x04 /* start address of 1st DMA play area, PU:0x00000000 */
+#define IDX_IO_PLAY_DMA_START_2 0x08 /* start address of 2nd DMA play area, PU:0x00000000 */
+#define IDX_IO_PLAY_DMA_LEN_1   0x0c /* length of 1st DMA play area, PU:0x0000 */
+#define IDX_IO_PLAY_DMA_LEN_2   0x0e /* length of 2nd DMA play area, PU:0x0000 */
+#define IDX_IO_PLAY_DMA_CURRPOS 0x10 /* current DMA position, PU:0x00000000 */
+#define IDX_IO_PLAY_DMA_CURROFS	0x14 /* offset within current DMA play area, PU:0x0000 */
+#define IDX_IO_PLAY_SOUNDFORMAT 0x16 /* PU:0x0010 */
   /* all unspecified bits can't be modified */
   #define SOUNDFORMAT_FREQUENCY_MASK	0x000f
     /* all _SUSPECTED_ values are not used by Windows drivers, so we don't
@@ -69,8 +71,8 @@
   #define SOUNDFORMAT_FLAG_16BIT	0x0010
   #define SOUNDFORMAT_FLAG_2CHANNELS	0x0020
 /* recording area (see also: playback bit flag definitions) */
-#define IDX_IO_REC_FLAGS	0x20 /* ?? */
-#define IDX_IO_REC_IRQMASK	0x22 /* ?? */
+#define IDX_IO_REC_FLAGS	0x20 /* ??, PU:0x0000 */
+#define IDX_IO_REC_IRQMASK	0x22 /* ??, PU:0x0000 */
   #define IRQ_REC_SOMETHING		0x0001 /* something & ACK */
   #define IRQ_FINISHED_RECBUF_1		0x0002 /* 1st dmabuf finished & ACK */
   #define IRQ_FINISHED_RECBUF_2		0x0004 /* 2nd dmabuf finished & ACK */
@@ -78,16 +80,17 @@
    * but OTOH they are most likely at port 0x22 instead */
   #define IRQMASK_SOME_STATUS_1		0x0008 /* \ related bits */
   #define IRQMASK_SOME_STATUS_2		0x0010 /* / (checked together in loop) */
-#define IDX_IO_REC_DMA_START_1  0x24
-#define IDX_IO_REC_DMA_START_2  0x28
-#define IDX_IO_REC_DMA_LEN_1    0x2c
-#define IDX_IO_REC_DMA_LEN_2    0x2e
-#define IDX_IO_REC_DMA_CURRPOS  0x30
-#define IDX_IO_REC_DMA_CURROFS  0x34
-#define IDX_IO_REC_SOUNDFORMAT  0x36
+#define IDX_IO_REC_DMA_START_1  0x24 /* PU:0x00000000 */
+#define IDX_IO_REC_DMA_START_2  0x28 /* PU:0x00000000 */
+#define IDX_IO_REC_DMA_LEN_1    0x2c /* PU:0x0000 */
+#define IDX_IO_REC_DMA_LEN_2    0x2e /* PU:0x0000 */
+#define IDX_IO_REC_DMA_CURRPOS  0x30 /* PU:0x00000000 */
+#define IDX_IO_REC_DMA_CURROFS  0x34 /* PU:0x00000000 */
+#define IDX_IO_REC_SOUNDFORMAT  0x36 /* PU:0x0000 */
 /* some third area ? (after playback and recording) */
-#define IDX_IO_SOMETHING_FLAGS	0x40 /* gets set to 0x34 just like port 0x0 and 0x20 on card init */
+#define IDX_IO_SOMETHING_FLAGS	0x40 /* gets set to 0x34 just like port 0x0 and 0x20 on card init, PU:0x0000 */
 /* general */
+#define IDX_IO_42H		0x42 /* PU:0x0001 */
 #define IDX_IO_60H		0x60 /* writing 0xffff returns 0xffff */
 #define IDX_IO_62H		0x62 /* writing to WORD 0x0062 can hang the box ! --> responsible for IRQ management as a whole ?? */
 #define IDX_IO_IRQ63H		0x63 /* FIXME !! */
@@ -96,10 +99,10 @@
   #define IRQ_PLAYBACK			0x0001
   #define IRQ_RECORDING			0x0002
   #define IRQ_MPU401			0x0010
-  #define IRQ_SOMEIRQ			0x0020 /* ???? */
+  #define IRQ_SOMEIRQ			0x0020 /* DirectX timer???? */
   #define IRQ_WHO_KNOWS_UNUSED		0x00e0 /* probably unused */
 #define IDX_IO_66H		0x66    /* writing 0xffff returns 0x0000 */
-#define IDX_IO_SOME_VALUE	0x68	/* this is always set to 0x3ff, and writable; maybe some buffer limit, but I couldn't find out more */
+#define IDX_IO_SOME_VALUE	0x68	/* this is always set to 0x3ff(?), and writable; maybe some buffer limit, but I couldn't find out more, PU:0x00ff(!!!) */
 #define IDX_IO_6AH		0x6A	/* this WORD can be set to have bits 0x0028 activated; actually inhibits PCM playback !!! maybe power management ?? */
 #define IDX_IO_6CH		0x6C	/* this WORD can have all its bits activated ? */
 #define IDX_IO_6EH		0x6E	/* writing 0xffff returns 0x83fe */
@@ -108,7 +111,7 @@
 /*** I/O 2 area port indices ***/
 /* (only 0x06 of 0x08 bytes saved/restored by Windows driver) */ 
 #define IDX_IO2_LEGACY_ADDR	0x04
-  #define LEGACY_SOMETHING		0x01 /* OPL3 ?? */
+  #define LEGACY_SOMETHING		0x01 /* OPL3?? */
   #define LEGACY_JOY			0x08
 
 /*** mixer I/O area port indices ***/
@@ -148,18 +151,18 @@
   /* unlisted bits are unmodifiable */
   #define MIXER_ADVCTL1_3DWIDTH_MASK	0x000e
   #define MIXER_ADVCTL1_HIFI3D_MASK	0x0300
-#define IDX_MIXER_ADVCTL2       0x20 /* resembles AC97_GENERAL_PURPOSE reg ! */
+#define IDX_MIXER_ADVCTL2       0x20 /* resembles AC97_GENERAL_PURPOSE reg! */
   /* unlisted bits are unmodifiable */
-  #define MIXER_ADVCTL2_BIT7		0x0080 /* WaveOut 3D Bypass ? mutes WaveOut at LineOut */
-  #define MIXER_ADVCTL2_BIT8		0x0100 /* is this Modem Out Select ? */
-  #define MIXER_ADVCTL2_BIT9		0x0200 /* Mono Select Source ? */
-  #define MIXER_ADVCTL2_BIT13		0x2000 /* 3D enable ? */
+  #define MIXER_ADVCTL2_BIT7		0x0080 /* WaveOut 3D Bypass? mutes WaveOut at LineOut */
+  #define MIXER_ADVCTL2_BIT8		0x0100 /* is this Modem Out Select? */
+  #define MIXER_ADVCTL2_BIT9		0x0200 /* Mono Select Source? */
+  #define MIXER_ADVCTL2_BIT13		0x2000 /* 3D enable? */
   #define MIXER_ADVCTL2_BIT15		0x8000 /* unknown */
   
-#define IDX_MIXER_SOMETHING30H	0x30 /* used, but unknown ??? */
+#define IDX_MIXER_SOMETHING30H	0x30 /* used, but unknown??? */
 
 /* driver internal flags */
 #define SET_CHAN_LEFT	1
 #define SET_CHAN_RIGHT	2
 
-#endif /* __SOUND_AZF3328_H  */
+#endif /* __SOUND_AZT3328_H  */

--LQksG6bCIzRHxTLp--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
