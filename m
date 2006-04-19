From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: [PATCH 3/3] azt3328.c: use kernel coding style
Date: Wed, 19 Apr 2006 21:22:46 +0200
Message-ID: <20060419192246.GC5800@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

[patch 3 of 3, to be applied in correct order]

Scope braces were not done the One True Kernel Way.

Patch done and hardware-tested on 2.6.16-ck3, rediffed to ALSA CVS.

Signed-off-by: Andreas Mohr <andi@lisas.de>

Thanks!


--- alsa-kernel/pci/azt3328.c	2006-04-19 20:49:05.000000000 +0200
+++ alsa-kernel/pci/azt3328.c	2006-04-19 20:53:12.000000000 +0200
@@ -33,7 +33,7 @@
  *  in the first place >:-P}),
  *  I was forced to base this driver on reverse engineering
  *  (3 weeks' worth of evenings filled with driver work).
- *  (and no, I did NOT go the easy way: to pick up a PCI128 for 9 Euros)
+ *  (and no, I did NOT go the easy way: to pick up a SB PCI128 for 9 Euros)
  *
  *  The AZF3328 chip (note: AZF3328, *not* AZT3328, that's just the driver name
  *  for compatibility reasons) has the following features:
@@ -338,10 +338,8 @@
 	else
 		dst_vol_left &= ~0x80;
 
-	do
-	{
-		if (!left_done)
-		{
+	do {
+		if (!left_done) {
 			if (curr_vol_left > dst_vol_left)
 				curr_vol_left--;
 			else
@@ -351,8 +349,7 @@
 			    left_done = 1;
 			outb(curr_vol_left, portbase + 1);
 		}
-		if (!right_done)
-		{
+		if (!right_done) {
 			if (curr_vol_right > dst_vol_right)
 				curr_vol_right--;
 			else
@@ -367,8 +364,7 @@
 		}
 		if (delay)
 			mdelay(delay);
-	}
-	while ((!left_done) || (!right_done));
+	} while ((!left_done) || (!right_done));
 	snd_azf3328_dbgcallleave();
 }
 
@@ -555,8 +551,7 @@
         uinfo->value.enumerated.items = reg.enum_c;
         if (uinfo->value.enumerated.item > reg.enum_c - 1U)
                 uinfo->value.enumerated.item = reg.enum_c - 1U;
-	if (reg.reg == IDX_MIXER_ADVCTL2)
-	{
+	if (reg.reg == IDX_MIXER_ADVCTL2) {
 		switch(reg.lchan_shift) {
 		case 8: /* modem out sel */
 			strcpy(uinfo->value.enumerated.name, texts1[uinfo->value.enumerated.item]);
@@ -568,8 +563,7 @@
 			strcpy(uinfo->value.enumerated.name, texts4[uinfo->value.enumerated.item]);
 			break;
 		}
-	}
-	else
+	} else
         	strcpy(uinfo->value.enumerated.name, texts3[uinfo->value.enumerated.item]
 );
         return 0;
@@ -585,12 +579,10 @@
         
 	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
 	val = snd_azf3328_mixer_inw(chip, reg.reg);
-	if (reg.reg == IDX_MIXER_REC_SELECT)
-	{
+	if (reg.reg == IDX_MIXER_REC_SELECT) {
         	ucontrol->value.enumerated.item[0] = (val >> 8) & (reg.enum_c - 1);
         	ucontrol->value.enumerated.item[1] = (val >> 0) & (reg.enum_c - 1);
-	}
-	else
+	} else
         	ucontrol->value.enumerated.item[0] = (val >> reg.lchan_shift) & (reg.enum_c - 1);
 
 	snd_azf3328_dbgmixer("get_enum: %02x is %04x -> %d|%d (shift %02d, enum_c %d)\n",
@@ -610,16 +602,13 @@
 	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
 	oreg = snd_azf3328_mixer_inw(chip, reg.reg);
 	val = oreg;
-	if (reg.reg == IDX_MIXER_REC_SELECT)
-	{
+	if (reg.reg == IDX_MIXER_REC_SELECT) {
         	if (ucontrol->value.enumerated.item[0] > reg.enum_c - 1U ||
             	ucontrol->value.enumerated.item[1] > reg.enum_c - 1U)
                 	return -EINVAL;
         	val = (ucontrol->value.enumerated.item[0] << 8) |
         	      (ucontrol->value.enumerated.item[1] << 0);
-	}
-	else
-	{
+	} else {
         	if (ucontrol->value.enumerated.item[0] > reg.enum_c - 1U)
                 	return -EINVAL;
 		val &= ~((reg.enum_c - 1) << reg.lchan_shift);
@@ -845,22 +834,18 @@
 	unsigned int is_running;
 
 	snd_azf3328_dbgcallenter();
-	if (do_recording)
-	{
+	if (do_recording) {
 		/* access capture registers, i.e. skip playback reg section */
 		portbase = chip->codec_port + 0x20;
 		is_running = chip->is_recording;
-	}
-	else
-	{
+	} else {
 		/* access the playback register section */
 		portbase = chip->codec_port + 0x00;
 		is_running = chip->is_playing;
 	}
 
 	/* AZF3328 uses a two buffer pointer DMA playback approach */
-	if (!is_running)
-	{
+	if (!is_running) {
 		unsigned long addr_area2;
 		unsigned long count_areas, count_tmp; /* width 32bit -- overflow!! */
 		count_areas = size/2;
@@ -1195,8 +1180,7 @@
 		snd_azf3328_codec_inw(chip, IDX_IO_PLAY_IRQTYPE),
 		status);
 		
-	if (status & IRQ_TIMER)
-	{
+	if (status & IRQ_TIMER) {
 		/* snd_azf3328_dbgplay("timer %ld\n", inl(chip->codec_port+IDX_IO_TIMER_VALUE) & TIMER_VALUE_MASK); */
 		if (chip->timer)
 			snd_timer_interrupt(chip->timer, chip->timer->sticks);
@@ -1206,50 +1190,43 @@
 		spin_unlock(&chip->reg_lock);
 		snd_azf3328_dbgplay("azt3328: timer IRQ\n");
 	}
-	if (status & IRQ_PLAYBACK)
-	{
+	if (status & IRQ_PLAYBACK) {
 		spin_lock(&chip->reg_lock);
 		which = snd_azf3328_codec_inb(chip, IDX_IO_PLAY_IRQTYPE);
 		/* ack all IRQ types immediately */
 		snd_azf3328_codec_outb(chip, IDX_IO_PLAY_IRQTYPE, which);
                	spin_unlock(&chip->reg_lock);
 
-		if (chip->pcm && chip->playback_substream)
-		{
+		if (chip->pcm && chip->playback_substream) {
 			snd_pcm_period_elapsed(chip->playback_substream);
 			snd_azf3328_dbgplay("PLAY period done (#%x), @ %x\n",
 				which,
 				inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
-		}
-		else
+		} else
 			snd_azf3328_dbgplay("azt3328: ouch, irq handler problem!\n");
 		if (which & IRQ_PLAY_SOMETHING)
 			snd_azf3328_dbgplay("azt3328: unknown play IRQ type occurred, please report!\n");
 	}
-	if (status & IRQ_RECORDING)
-	{
+	if (status & IRQ_RECORDING) {
                 spin_lock(&chip->reg_lock);
 		which = snd_azf3328_codec_inb(chip, IDX_IO_REC_IRQTYPE);
 		/* ack all IRQ types immediately */
 		snd_azf3328_codec_outb(chip, IDX_IO_REC_IRQTYPE, which);
 		spin_unlock(&chip->reg_lock);
 
-		if (chip->pcm && chip->capture_substream)
-		{
+		if (chip->pcm && chip->capture_substream) {
 			snd_pcm_period_elapsed(chip->capture_substream);
 			snd_azf3328_dbgplay("REC  period done (#%x), @ %x\n",
 				which,
 				inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
-		}
-		else
+		} else
 			snd_azf3328_dbgplay("azt3328: ouch, irq handler problem!\n");
 		if (which & IRQ_REC_SOMETHING)
 			snd_azf3328_dbgplay("azt3328: unknown rec IRQ type occurred, please report!\n");
 	}
 	/* MPU401 has less critical IRQ requirements
 	 * than timer and playback/recording, right? */
-	if (status & IRQ_MPU401)
-	{
+	if (status & IRQ_MPU401) {
 		snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data, regs);
 
 		/* hmm, do we have to ack the IRQ here somehow?
@@ -1543,8 +1520,7 @@
 	snd_azf3328_dbgcallenter();
 	chip = snd_timer_chip(timer);
 	delay = ((timer->sticks * seqtimer_scaling) - 1) & TIMER_VALUE_MASK;
-	if (delay < 49)
-	{
+	if (delay < 49) {
 		/* uhoh, that's not good, since user-space won't know about
 		 * this timing tweak
 		 * (we need to do it to avoid a lockup, though) */


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
