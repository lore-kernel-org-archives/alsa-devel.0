From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 08/24] sound/pci: coding style fixes: emu10k1
Date: Tue, 9 Sep 2008 05:51:38 +0400
Message-ID: <20080909015138.GL6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F0EB103800
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:52:11 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1535544fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:52:11 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/emu10k1/emu10k1.c          |    8 +-
 sound/pci/emu10k1/emu10k1_callback.c |   28 ++--
 sound/pci/emu10k1/emu10k1_main.c     |  266 +++++++++++++++++-----------------
 sound/pci/emu10k1/emu10k1_patch.c    |   14 +-
 sound/pci/emu10k1/emu10k1_synth.c    |    2 +-
 sound/pci/emu10k1/emu10k1x.c         |  156 ++++++++++----------
 sound/pci/emu10k1/emufx.c            |  148 ++++++++++----------
 sound/pci/emu10k1/emumixer.c         |  130 ++++++++--------
 sound/pci/emu10k1/emumpu401.c        |    2 +-
 sound/pci/emu10k1/emupcm.c           |   56 ++++----
 sound/pci/emu10k1/emuproc.c          |   80 +++++-----
 sound/pci/emu10k1/io.c               |   32 ++--
 sound/pci/emu10k1/irq.c              |   18 +-
 sound/pci/emu10k1/memory.c           |    8 +-
 sound/pci/emu10k1/p16v.c             |  132 +++++++++---------
 sound/pci/emu10k1/p16v.h             |   14 +-
 sound/pci/emu10k1/p17v.h             |    6 +-
 sound/pci/emu10k1/voice.c            |   32 ++--
 18 files changed, 566 insertions(+), 566 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 8354c1a..094a874 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -20,7 +20,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- * 
+ *
  */
 
 #include <linux/init.h>
@@ -134,7 +134,7 @@ static int __devinit snd_card_emu10k1_probe(struct pci_dev *pci,
 	if ((err = snd_emu10k1_pcm_efx(emu, 2, NULL)) < 0)
 		goto error;
 	/* This stores the periods table. */
-	if (emu->card_capabilities->ca0151_chip) { /* P16V */	
+	if (emu->card_capabilities->ca0151_chip) { /* P16V */
 		if ((err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 					       1024, &emu->p16v_buffer)) < 0)
 			goto error;
@@ -142,7 +142,7 @@ static int __devinit snd_card_emu10k1_probe(struct pci_dev *pci,
 
 	if ((err = snd_emu10k1_mixer(emu, 0, 3)) < 0)
 		goto error;
-	
+
 	if ((err = snd_emu10k1_timer(emu, 0)) < 0)
 		goto error;
 
@@ -176,7 +176,7 @@ static int __devinit snd_card_emu10k1_probe(struct pci_dev *pci,
 		arg->max_voices = max_synth_voices[dev];
 	}
 #endif
- 
+
 	strcpy(card->driver, emu->card_capabilities->driver);
 	strcpy(card->shortname, emu->card_capabilities->name);
 	snprintf(card->longname, sizeof(card->longname),
diff --git a/sound/pci/emu10k1/emu10k1_callback.c b/sound/pci/emu10k1/emu10k1_callback.c
index 0e649dc..7bc7fce 100644
--- a/sound/pci/emu10k1/emu10k1_callback.c
+++ b/sound/pci/emu10k1/emu10k1_callback.c
@@ -103,7 +103,7 @@ snd_emu10k1_synth_get_voice(struct snd_emu10k1 *hw)
 			int ch;
 			vp = &emu->voices[best[i].voice];
 			if ((ch = vp->ch) < 0) {
-				//printk("synth_get_voice: ch < 0 (%d) ??", i);
+				/* printk("synth_get_voice: ch < 0 (%d) ??", i); */
 				continue;
 			}
 			vp->emu->num_voices--;
@@ -128,7 +128,7 @@ release_voice(struct snd_emux_voice *vp)
 {
 	int dcysusv;
 	struct snd_emu10k1 *hw;
-	
+
 	hw = vp->hw;
 	dcysusv = 0x8000 | (unsigned char)vp->reg.parm.modrelease;
 	snd_emu10k1_ptr_write(hw, DCYSUSM, vp->ch, dcysusv);
@@ -144,7 +144,7 @@ static void
 terminate_voice(struct snd_emux_voice *vp)
 {
 	struct snd_emu10k1 *hw;
-	
+
 	if (snd_BUG_ON(!vp))
 		return;
 	hw = vp->hw;
@@ -164,7 +164,7 @@ static void
 free_voice(struct snd_emux_voice *vp)
 {
 	struct snd_emu10k1 *hw;
-	
+
 	hw = vp->hw;
 	/* FIXME: emu10k1_synth is broken. */
 	/* This can get called with hw == 0 */
@@ -173,7 +173,7 @@ free_voice(struct snd_emux_voice *vp)
 	if (hw && (vp->ch >= 0)) {
 		snd_emu10k1_ptr_write(hw, IFATN, vp->ch, 0xff00);
 		snd_emu10k1_ptr_write(hw, DCYSUSV, vp->ch, 0x807f | DCYSUSV_CHANNELENABLE_MASK);
-		// snd_emu10k1_ptr_write(hw, DCYSUSV, vp->ch, 0);
+		/* snd_emu10k1_ptr_write(hw, DCYSUSV, vp->ch, 0); */
 		snd_emu10k1_ptr_write(hw, VTFT, vp->ch, 0xffff);
 		snd_emu10k1_ptr_write(hw, CVCF, vp->ch, 0xffff);
 		snd_emu10k1_voice_free(hw, &hw->voices[vp->ch]);
@@ -190,7 +190,7 @@ static void
 update_voice(struct snd_emux_voice *vp, int update)
 {
 	struct snd_emu10k1 *hw;
-	
+
 	hw = vp->hw;
 	if (update & SNDRV_EMUX_UPDATE_VOLUME)
 		snd_emu10k1_ptr_write(hw, IFATN_ATTENUATION, vp->ch, vp->avol);
@@ -250,7 +250,7 @@ lookup_voices(struct snd_emux *emu, struct snd_emu10k1 *hw,
 			bp = best + V_RELEASED;
 #if 1
 			val = snd_emu10k1_ptr_read(hw, CVCF_CURRENTVOL, vp->ch);
-			if (! val)
+			if (!val)
 				bp = best + V_OFF;
 #endif
 		}
@@ -323,7 +323,7 @@ start_voice(struct snd_emux_voice *vp)
 	struct snd_midi_channel *chan;
 	struct snd_emu10k1 *hw;
 	struct snd_emu10k1_memblk *emem;
-	
+
 	hw = vp->hw;
 	ch = vp->ch;
 	if (snd_BUG_ON(ch < 0))
@@ -335,7 +335,7 @@ start_voice(struct snd_emux_voice *vp)
 		return -EINVAL;
 	emem->map_locked++;
 	if (snd_emu10k1_memblk_map(hw, emem) < 0) {
-		// printk("emu: cannot map!\n");
+		/* printk("emu: cannot map!\n"); */
 		return -ENOMEM;
 	}
 	mapped_offset = snd_emu10k1_memblk_offset(emem) >> 1;
@@ -347,11 +347,11 @@ start_voice(struct snd_emux_voice *vp)
 	/* set channel routing */
 	/* A = left(0), B = right(1), C = reverb(c), D = chorus(d) */
 	if (hw->audigy) {
-		temp = FXBUS_MIDI_LEFT | (FXBUS_MIDI_RIGHT << 8) | 
+		temp = FXBUS_MIDI_LEFT | (FXBUS_MIDI_RIGHT << 8) |
 			(FXBUS_MIDI_REVERB << 16) | (FXBUS_MIDI_CHORUS << 24);
 		snd_emu10k1_ptr_write(hw, A_FXRT1, ch, temp);
 	} else {
-		temp = (FXBUS_MIDI_LEFT << 16) | (FXBUS_MIDI_RIGHT << 20) | 
+		temp = (FXBUS_MIDI_LEFT << 16) | (FXBUS_MIDI_RIGHT << 20) |
 			(FXBUS_MIDI_REVERB << 24) | (FXBUS_MIDI_CHORUS << 28);
 		snd_emu10k1_ptr_write(hw, FXRT, ch, temp);
 	}
@@ -437,7 +437,7 @@ start_voice(struct snd_emux_voice *vp)
 		temp = ((unsigned int)hw->silent_page.addr << 1) | MAP_PTI_MASK;
 		snd_emu10k1_ptr_write(hw, MAPA, ch, temp);
 		snd_emu10k1_ptr_write(hw, MAPB, ch, temp);
-		
+
 		/* fill cache */
 		val -= 4;
 		val <<= 25;
@@ -476,11 +476,11 @@ trigger_voice(struct snd_emux_voice *vp)
 	unsigned int temp, ptarget;
 	struct snd_emu10k1 *hw;
 	struct snd_emu10k1_memblk *emem;
-	
+
 	hw = vp->hw;
 
 	emem = (struct snd_emu10k1_memblk *)vp->block;
-	if (! emem || emem->mapped_page < 0)
+	if (!emem || emem->mapped_page < 0)
 		return; /* not mapped */
 
 #if 0
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 2f283ea..ab57586 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -153,7 +153,7 @@ static unsigned int i2c_adc_init[][2] = {
 	{ 0x14, 0xa6 },  /* Limiter control */
 	{ 0x15, ADC_MUX_2 },  /* ADC Mixer control. Mic for Audigy 2 ZS Notebook */
 };
-	
+
 static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
 {
 	unsigned int silent_page;
@@ -197,12 +197,12 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
 
 	if (emu->card_capabilities->ca0151_chip) { /* audigy2 */
 		/* Hacks for Alice3 to work independent of haP16V driver */
-		//Setup SRCMulti_I2S SamplingRate
+		/* Setup SRCMulti_I2S SamplingRate */
 		tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
 		tmp &= 0xfffff1ff;
 		tmp |= (0x2<<9);
 		snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, 0, tmp);
-		
+
 		/* Setup SRCSel (Enable Spdif,I2S SRCMulti) */
 		snd_emu10k1_ptr20_write(emu, SRCSel, 0, 0x14);
 		/* Setup SRCMulti Input Audio Enable */
@@ -217,7 +217,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
 	if (emu->card_capabilities->ca0108_chip) { /* audigy2 Value */
 		/* Hacks for Alice3 to work independent of haP16V driver */
 		snd_printk(KERN_INFO "Audigy2 value: Special config.\n");
-		//Setup SRCMulti_I2S SamplingRate
+		/* Setup SRCMulti_I2S SamplingRate */
 		tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
 		tmp &= 0xfffff1ff;
 		tmp |= (0x2<<9);
@@ -276,7 +276,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
 		}
 	}
 
-	
+
 	snd_emu10k1_ptr_write(emu, PTB, 0, emu->ptb_pages.addr);
 	snd_emu10k1_ptr_write(emu, TCB, 0, 0);	/* taken from original driver */
 	snd_emu10k1_ptr_write(emu, TCBS, 0, 4);	/* taken from original driver */
@@ -313,7 +313,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
 	    (emu->model == 0x21 && emu->revision < 6))
 		outl(HCFG_LOCKTANKCACHE_MASK | HCFG_AUTOMUTE, emu->port + HCFG);
 	else
-		// With on-chip joystick
+		/* With on-chip joystick */
 		outl(HCFG_LOCKTANKCACHE_MASK | HCFG_AUTOMUTE | HCFG_JOYENABLE, emu->port + HCFG);
 
 	if (enable_ir) {	/* enable IR for SB Live */
@@ -337,7 +337,7 @@ static int snd_emu10k1_init(struct snd_emu10k1 *emu, int enable_ir, int resume)
 			outl(reg, emu->port + HCFG);
  		}
 	}
-	
+
 	if (emu->card_capabilities->emu_model) {
 		;  /* Disable all access to A_IOCFG for the emu1010 */
 	} else if (emu->card_capabilities->i2c_adc) {
@@ -364,7 +364,7 @@ static void snd_emu10k1_audio_enable(struct snd_emu10k1 *emu)
 		;  /* Disable A_IOCFG for Audigy 2 ZS Notebook */
 	} else if (emu->audigy) {
 		outl(inl(emu->port + A_IOCFG) & ~0x44, emu->port + A_IOCFG);
- 
+
 		if (emu->card_capabilities->ca0151_chip) { /* audigy2 */
 			/* Unmute Analog now.  Set GPO6 to 1 for Apollo.
 			 * This has to be done after init ALice3 I2SOut beyond 48KHz.
@@ -378,12 +378,12 @@ static void snd_emu10k1_audio_enable(struct snd_emu10k1 *emu)
 			outl(inl(emu->port + A_IOCFG) | 0x0080, emu->port + A_IOCFG);
 		}
 	}
-	
+
 #if 0
 	{
 	unsigned int tmp;
 	/* FIXME: the following routine disables LiveDrive-II !! */
-	// TOSLink detection
+	/* TOSLink detection */
 	emu->tos_link = 0;
 	tmp = inl(emu->port + HCFG);
 	if (tmp & (HCFG_GPINPUT0 | HCFG_GPINPUT1)) {
@@ -495,7 +495,7 @@ int snd_emu10k1_done(struct snd_emu10k1 * emu)
 
 #define EC_LAST_PROMFILE_ADDR	0x2f
 
-#define EC_SERIALNUM_ADDR	0x30	/* First word of serial number.  The 
+#define EC_SERIALNUM_ADDR	0x30	/* First word of serial number.  The
 					 * can be up to 30 characters in length
 					 * and is stored as a NULL-terminated
 					 * ASCII string.  Any unused bytes must be
@@ -503,8 +503,8 @@ int snd_emu10k1_done(struct snd_emu10k1 * emu)
 #define EC_CHECKSUM_ADDR	0x3f	/* Location at which checksum is stored */
 
 
-/* Most of this stuff is pretty self-evident.  According to the hardware 
- * dudes, we need to leave the ADCCAL bit low in order to avoid a DC 
+/* Most of this stuff is pretty self-evident.  According to the hardware
+ * dudes, we need to leave the ADCCAL bit low in order to avoid a DC
  * offset problem.  Weird.
  */
 #define EC_RAW_RUN_MODE		(EC_DACMUTEN | EC_ADCRSTN | EC_TRIM_MUTEN | \
@@ -574,7 +574,7 @@ static void snd_emu10k1_ecard_setadcgain(struct snd_emu10k1 * emu,
 
 	for (bit = (1 << 15); bit; bit >>= 1) {
 		unsigned int value;
-		
+
 		value = emu->ecard_ctrl & ~(EC_TRIM_CSN | EC_TRIM_SDATA);
 
 		if (gain & bit)
@@ -598,7 +598,7 @@ static int snd_emu10k1_ecard_init(struct snd_emu10k1 * emu)
 			  EC_SPDIF0_SELECT(EC_DEFAULT_SPDIF0_SEL) |
 			  EC_SPDIF1_SELECT(EC_DEFAULT_SPDIF1_SEL);
 
-	/* Step 0: Set the codec type in the hardware control register 
+	/* Step 0: Set the codec type in the hardware control register
 	 * and enable audio output */
 	hc_value = inl(emu->port + HCFG);
 	outl(hc_value | HCFG_AUDIOENABLE | HCFG_CODECFORMAT_I2S, emu->port + HCFG);
@@ -685,13 +685,13 @@ static int snd_emu1010_load_firmware(struct snd_emu10k1 * emu, const char * file
 	outl(0x80, emu->port + A_IOCFG); /* Leave bit 7 set during netlist setup. */
 	write_post = inl(emu->port + A_IOCFG);
 	udelay(100); /* Allow FPGA memory to clean */
-	for(n = 0; n < fw_entry->size; n++) {
-		value=fw_entry->data[n];	
-		for(i = 0; i < 8; i++) {
+	for (n = 0; n < fw_entry->size; n++) {
+		value=fw_entry->data[n];
+		for (i = 0; i < 8; i++) {
 			reg = 0x80;
 			if (value & 0x1)
 				reg = reg | 0x20;
-			value = value >> 1;   
+			value = value >> 1;
 			outl(reg, emu->port + A_IOCFG);
 			write_post = inl(emu->port + A_IOCFG);
 			outl(reg | 0x40, emu->port + A_IOCFG);
@@ -719,13 +719,13 @@ static int emu1010_firmware_thread(void *data)
 		msleep_interruptible(1000);
 		if (kthread_should_stop())
 			break;
-		snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp ); /* IRQ Status */
-		snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg ); /* OPTIONS: Which cards are attached to the EMU */
+		snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp); /* IRQ Status */
+		snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
 		if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
 			/* Audio Dock attached */
 			/* Return to Audio Dock programming mode */
 			snd_printk(KERN_INFO "emu1010: Loading Audio Dock Firmware\n");
-			snd_emu1010_fpga_write(emu,  EMU_HANA_FPGA_CONFIG, EMU_HANA_FPGA_CONFIG_AUDIODOCK );
+			snd_emu1010_fpga_write(emu,  EMU_HANA_FPGA_CONFIG, EMU_HANA_FPGA_CONFIG_AUDIODOCK);
 			if (emu->card_capabilities->emu_model ==
 			    EMU_MODEL_EMU1010) {
 				if ((err = snd_emu1010_load_firmware(emu, DOCK_FILENAME)) != 0) {
@@ -743,11 +743,11 @@ static int emu1010_firmware_thread(void *data)
 				}
 			}
 
-			snd_emu1010_fpga_write(emu,  EMU_HANA_FPGA_CONFIG, 0 );
-			snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &reg );
+			snd_emu1010_fpga_write(emu,  EMU_HANA_FPGA_CONFIG, 0);
+			snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &reg);
 			snd_printk(KERN_INFO "emu1010: EMU_HANA+DOCK_IRQ_STATUS=0x%x\n",reg);
 			/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
-			snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg );
+			snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
 			snd_printk(KERN_INFO "emu1010: EMU_HANA+DOCK_ID=0x%x\n",reg);
 			if ((reg & 0x1f) != 0x15) {
 				/* FPGA failed to be programmed */
@@ -755,14 +755,14 @@ static int emu1010_firmware_thread(void *data)
 				continue;
 			}
 			snd_printk(KERN_INFO "emu1010: Audio Dock Firmware loaded\n");
-			snd_emu1010_fpga_read(emu, EMU_DOCK_MAJOR_REV, &tmp );
-			snd_emu1010_fpga_read(emu, EMU_DOCK_MINOR_REV, &tmp2 );
+			snd_emu1010_fpga_read(emu, EMU_DOCK_MAJOR_REV, &tmp);
+			snd_emu1010_fpga_read(emu, EMU_DOCK_MINOR_REV, &tmp2);
 			snd_printk("Audio Dock ver:%d.%d\n",tmp ,tmp2);
 			/* Sync clocking between 1010 and Dock */
 			/* Allow DLL to settle */
 			msleep(10);
 			/* Unmute all. Default is muted after a firmware load */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE );
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
 		}
 	}
 	snd_printk(KERN_INFO "emu1010: firmware thread stopping\n");
@@ -818,7 +818,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 	 * Lock Tank Memory Cache,
 	 * Mute all codecs.
 	 */
-	outl(0x0005a004, emu->port + HCFG); 
+	outl(0x0005a004, emu->port + HCFG);
 	/* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
 	 * Mute all codecs.
 	 */
@@ -829,18 +829,18 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 	outl(0x0005a000, emu->port + HCFG);
 
 	/* Disable 48Volt power to Audio Dock */
-	snd_emu1010_fpga_write(emu,  EMU_HANA_DOCK_PWR,  0 );
+	snd_emu1010_fpga_write(emu,  EMU_HANA_DOCK_PWR,  0);
 
 	/* ID, should read & 0x7f = 0x55. (Bit 7 is the IRQ bit) */
-	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg );
+	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
 	snd_printdd("reg1=0x%x\n",reg);
 	if ((reg & 0x3f) == 0x15) {
 		/* FPGA netlist already present so clear it */
 		/* Return to programming mode */
 
-		snd_emu1010_fpga_write(emu,  EMU_HANA_FPGA_CONFIG, 0x02 );
+		snd_emu1010_fpga_write(emu,  EMU_HANA_FPGA_CONFIG, 0x02);
 	}
-	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg );
+	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
 	snd_printdd("reg2=0x%x\n",reg);
 	if ((reg & 0x3f) == 0x15) {
 		/* FPGA failed to return to programming mode */
@@ -876,7 +876,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 	}
 
 	/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
-	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg );
+	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
 	if ((reg & 0x3f) != 0x15) {
 		/* FPGA failed to be programmed */
 		snd_printk(KERN_INFO "emu1010: Loading Hana Firmware file failed, reg=0x%x\n", reg);
@@ -884,17 +884,17 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 	}
 
 	snd_printk(KERN_INFO "emu1010: Hana Firmware loaded\n");
-	snd_emu1010_fpga_read(emu, EMU_HANA_MAJOR_REV, &tmp );
-	snd_emu1010_fpga_read(emu, EMU_HANA_MINOR_REV, &tmp2 );
+	snd_emu1010_fpga_read(emu, EMU_HANA_MAJOR_REV, &tmp);
+	snd_emu1010_fpga_read(emu, EMU_HANA_MINOR_REV, &tmp2);
 	snd_printk("Hana ver:%d.%d\n",tmp ,tmp2);
 	/* Enable 48Volt power to Audio Dock */
-	snd_emu1010_fpga_write(emu,  EMU_HANA_DOCK_PWR,  EMU_HANA_DOCK_PWR_ON );
+	snd_emu1010_fpga_write(emu,  EMU_HANA_DOCK_PWR,  EMU_HANA_DOCK_PWR_ON);
 
-	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg );
+	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
 	snd_printk(KERN_INFO "emu1010: Card options=0x%x\n",reg);
-	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg );
+	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
 	snd_printk(KERN_INFO "emu1010: Card options=0x%x\n",reg);
-	snd_emu1010_fpga_read(emu, EMU_HANA_OPTICAL_TYPE, &tmp ); 
+	snd_emu1010_fpga_read(emu, EMU_HANA_OPTICAL_TYPE, &tmp);
 	/* Optical -> ADAT I/O  */
 	/* 0 : SPDIF
 	 * 1 : ADAT
@@ -904,41 +904,41 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 	tmp = 0;
 	tmp = (emu->emu1010.optical_in ? EMU_HANA_OPTICAL_IN_ADAT : 0) |
 		(emu->emu1010.optical_out ? EMU_HANA_OPTICAL_OUT_ADAT : 0);
-	snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, tmp );
-	snd_emu1010_fpga_read(emu, EMU_HANA_ADC_PADS, &tmp );
+	snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, tmp);
+	snd_emu1010_fpga_read(emu, EMU_HANA_ADC_PADS, &tmp);
 	/* Set no attenuation on Audio Dock pads. */
-	snd_emu1010_fpga_write(emu, EMU_HANA_ADC_PADS, 0x00 );
+	snd_emu1010_fpga_write(emu, EMU_HANA_ADC_PADS, 0x00);
 	emu->emu1010.adc_pads = 0x00;
-	snd_emu1010_fpga_read(emu, EMU_HANA_DOCK_MISC, &tmp );
+	snd_emu1010_fpga_read(emu, EMU_HANA_DOCK_MISC, &tmp);
 	/* Unmute Audio dock DACs, Headphone source DAC-4. */
-	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_MISC, 0x30 );
-	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12 );
-	snd_emu1010_fpga_read(emu, EMU_HANA_DAC_PADS, &tmp );
+	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_MISC, 0x30);
+	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12);
+	snd_emu1010_fpga_read(emu, EMU_HANA_DAC_PADS, &tmp);
 	/* DAC PADs. */
-	snd_emu1010_fpga_write(emu, EMU_HANA_DAC_PADS, 0x0f );
+	snd_emu1010_fpga_write(emu, EMU_HANA_DAC_PADS, 0x0f);
 	emu->emu1010.dac_pads = 0x0f;
-	snd_emu1010_fpga_read(emu, EMU_HANA_DOCK_MISC, &tmp );
-	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_MISC, 0x30 );
-	snd_emu1010_fpga_read(emu, EMU_HANA_SPDIF_MODE, &tmp );
+	snd_emu1010_fpga_read(emu, EMU_HANA_DOCK_MISC, &tmp);
+	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_MISC, 0x30);
+	snd_emu1010_fpga_read(emu, EMU_HANA_SPDIF_MODE, &tmp);
 	/* SPDIF Format. Set Consumer mode, 24bit, copy enable */
-	snd_emu1010_fpga_write(emu, EMU_HANA_SPDIF_MODE, 0x10 );
+	snd_emu1010_fpga_write(emu, EMU_HANA_SPDIF_MODE, 0x10);
 	/* MIDI routing */
-	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_IN, 0x19 );
+	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_IN, 0x19);
 	/* Unknown. */
-	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_OUT, 0x0c );
-	/* snd_emu1010_fpga_write(emu, 0x09, 0x0f ); // IRQ Enable: All on */
+	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_OUT, 0x0c);
+	/* snd_emu1010_fpga_write(emu, 0x09, 0x0f);  IRQ Enable: All on */
 	/* IRQ Enable: All off */
-	snd_emu1010_fpga_write(emu, EMU_HANA_IRQ_ENABLE, 0x00 );
+	snd_emu1010_fpga_write(emu, EMU_HANA_IRQ_ENABLE, 0x00);
 
-	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg );
+	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
 	snd_printk(KERN_INFO "emu1010: Card options3=0x%x\n",reg);
 	/* Default WCLK set to 48kHz. */
-	snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, 0x00 );
+	snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, 0x00);
 	/* Word Clock source, Internal 48kHz x1 */
-	snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K );
-	//snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_4X );
+	snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K);
+	/* snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_4X); */
 	/* Audio Dock LEDs. */
-	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12 );
+	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12);
 
 #if 0
 	/* For 96kHz */
@@ -992,7 +992,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 	 * Defaults only, users will set their own values anyways, let's
 	 * just copy/paste.
 	 */
-	
+
 	snd_emu1010_fpga_link_dst_src_write(emu,
 		EMU_DST_ALICE2_EMU32_8, EMU_SRC_DOCK_MIC_A1);
 	snd_emu1010_fpga_link_dst_src_write(emu,
@@ -1037,19 +1037,19 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 	snd_emu1010_fpga_link_dst_src_write(emu,
 		EMU_DST_ALICE2_EMU32_F, EMU_SRC_HAMOA_ADC_LEFT2);
 #endif
-	for (i = 0;i < 0x20; i++ ) {
+	for (i = 0; i < 0x20; i++) {
 		/* AudioDock Elink <-  Silence */
 		snd_emu1010_fpga_link_dst_src_write(emu, 0x0100+i, EMU_SRC_SILENCE);
 	}
-	for (i = 0;i < 4; i++) {
+	for (i = 0; i < 4; i++) {
 		/* Hana SPDIF Out <- Silence */
 		snd_emu1010_fpga_link_dst_src_write(emu, 0x0200+i, EMU_SRC_SILENCE);
 	}
-	for (i = 0;i < 7; i++) {
+	for (i = 0; i < 7; i++) {
 		/* Hamoa DAC <- Silence */
 		snd_emu1010_fpga_link_dst_src_write(emu, 0x0300+i, EMU_SRC_SILENCE);
 	}
-	for (i = 0;i < 7; i++) {
+	for (i = 0; i < 7; i++) {
 		/* Hana ADAT Out <- Silence */
 		snd_emu1010_fpga_link_dst_src_write(emu, EMU_DST_HANA_ADAT + i, EMU_SRC_SILENCE);
 	}
@@ -1065,30 +1065,30 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 		EMU_DST_ALICE_I2S2_LEFT, EMU_SRC_DOCK_ADC3_LEFT1);
 	snd_emu1010_fpga_link_dst_src_write(emu,
 		EMU_DST_ALICE_I2S2_RIGHT, EMU_SRC_DOCK_ADC3_RIGHT1);
-	snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x01 ); // Unmute all
+	snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x01); /* Unmute all */
+
+	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &tmp);
 
-	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &tmp );
-	
 	/* AC97 1.03, Any 32Meg of 2Gig address, Auto-Mute, EMU32 Slave,
 	 * Lock Sound Memory Cache, Lock Tank Memory Cache,
 	 * Mute all codecs.
 	 */
-	outl(0x0000a000, emu->port + HCFG); 
+	outl(0x0000a000, emu->port + HCFG);
 	/* AC97 1.03, Any 32Meg of 2Gig address, Auto-Mute, EMU32 Slave,
 	 * Lock Sound Memory Cache, Lock Tank Memory Cache,
 	 * Un-Mute all codecs.
 	 */
 	outl(0x0000a001, emu->port + HCFG);
- 
+
 	/* Initial boot complete. Now patches */
 
-	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &tmp );
-	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_IN, 0x19 ); /* MIDI Route */
-	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_OUT, 0x0c ); /* Unknown */
-	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_IN, 0x19 ); /* MIDI Route */
-	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_OUT, 0x0c ); /* Unknown */
-	snd_emu1010_fpga_read(emu, EMU_HANA_SPDIF_MODE, &tmp ); 
-	snd_emu1010_fpga_write(emu, EMU_HANA_SPDIF_MODE, 0x10 ); /* SPDIF Format spdif  (or 0x11 for aes/ebu) */
+	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &tmp);
+	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_IN, 0x19); /* MIDI Route */
+	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_OUT, 0x0c); /* Unknown */
+	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_IN, 0x19); /* MIDI Route */
+	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_OUT, 0x0c); /* Unknown */
+	snd_emu1010_fpga_read(emu, EMU_HANA_SPDIF_MODE, &tmp);
+	snd_emu1010_fpga_write(emu, EMU_HANA_SPDIF_MODE, 0x10); /* SPDIF Format spdif  (or 0x11 for aes/ebu) */
 
 	/* Start Micro/Audio Dock firmware loader thread */
 	if (!emu->emu1010.firmware_thread) {
@@ -1218,20 +1218,20 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 * emu)
 		emu->emu1010.output_source[23] = 28;
 	}
 	/* TEMP: Select SPDIF in/out */
-	//snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, 0x0); /* Output spdif */
+	/* snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, 0x0);  Output spdif */
 
 	/* TEMP: Select 48kHz SPDIF out */
 	snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x0); /* Mute all */
 	snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, 0x0); /* Default fallback clock 48kHz */
 	/* Word Clock source, Internal 48kHz x1 */
-	snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K );
-	//snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_4X );
+	snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K);
+	/* snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK, EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_4X); */
 	emu->emu1010.internal_clock = 1; /* 48000 */
 	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, 0x12);/* Set LEDs on Audio Dock */
 	snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, 0x1); /* Unmute all */
-	//snd_emu1010_fpga_write(emu, 0x7, 0x0); /* Mute all */
-	//snd_emu1010_fpga_write(emu, 0x7, 0x1); /* Unmute all */
-	//snd_emu1010_fpga_write(emu, 0xe, 0x12); /* Set LEDs on Audio Dock */
+	/* snd_emu1010_fpga_write(emu, 0x7, 0x0);  Mute all */
+	/* snd_emu1010_fpga_write(emu, 0x7, 0x1);  Unmute all */
+	/* snd_emu1010_fpga_write(emu, 0xe, 0x12);  Set LEDs on Audio Dock */
 
 	return 0;
 }
@@ -1253,7 +1253,7 @@ static int snd_emu10k1_free(struct snd_emu10k1 *emu)
        	}
 	if (emu->card_capabilities->emu_model == EMU_MODEL_EMU1010) {
 		/* Disable 48Volt power to Audio Dock */
-		snd_emu1010_fpga_write(emu,  EMU_HANA_DOCK_PWR,  0 );
+		snd_emu1010_fpga_write(emu,  EMU_HANA_DOCK_PWR,  0);
 	}
 	if (emu->emu1010.firmware_thread)
 		kthread_stop(emu->emu1010.firmware_thread);
@@ -1278,7 +1278,7 @@ static int snd_emu10k1_free(struct snd_emu10k1 *emu)
 #endif
 	if (emu->port)
 		pci_release_regions(emu->pci);
-	if (emu->card_capabilities->ca0151_chip) /* P16V */	
+	if (emu->card_capabilities->ca0151_chip) /* P16V */
 		snd_p16v_free(emu);
 	pci_disable_device(emu->pci);
 	kfree(emu);
@@ -1301,7 +1301,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 * CA0151: None
 	 */
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10011102,
-	 .driver = "Audigy2", .name = "Audigy 2 Value [SB0400]", 
+	 .driver = "Audigy2", .name = "Audigy 2 Value [SB0400]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
@@ -1346,7 +1346,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 * CA0151: None
 	 */
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10211102,
-	 .driver = "Audigy2", .name = "Audigy 4 [SB0610]", 
+	 .driver = "Audigy2", .name = "Audigy 4 [SB0610]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
@@ -1359,7 +1359,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 * Digital output working. (AC3 not checked, only PCM)
 	 * Audio Mic/Line inputs working.
 	 * Digital input not tested.
-	 */ 
+	 */
 	/* DSP: Tina2
 	 * DAC: Wolfson WM8768/WM8568
 	 * ADC: Wolfson WM8775
@@ -1386,7 +1386,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 *
 	 */
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x20011102,
-	 .driver = "Audigy2", .name = "Audigy 2 ZS Notebook [SB0530]", 
+	 .driver = "Audigy2", .name = "Audigy 2 ZS Notebook [SB0530]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
@@ -1396,7 +1396,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .spk71 = 1} ,
 	/* Tested by James@superbug.co.uk 4th Nov 2007. */
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x42011102,
-	 .driver = "Audigy2", .name = "E-mu 1010 Notebook [MAEM8950]", 
+	 .driver = "Audigy2", .name = "E-mu 1010 Notebook [MAEM8950]",
 	 .id = "EMU1010",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
@@ -1405,7 +1405,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .emu_model = EMU_MODEL_EMU1616},
 	/* Tested by James@superbug.co.uk 4th Nov 2007. */
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x40041102,
-	 .driver = "Audigy2", .name = "E-mu 1010b PCI [MAEM????]", 
+	 .driver = "Audigy2", .name = "E-mu 1010b PCI [MAEM????]",
 	 .id = "EMU1010",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
@@ -1436,15 +1436,15 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .spk71 = 1,
 	 .emu_model = EMU_MODEL_EMU0404}, /* EMU 0404 */
 	/* Audigy4 (Not PRO) SB0610 */
-	{.vendor = 0x1102, .device = 0x0008, 
-	 .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]", 
+	{.vendor = 0x1102, .device = 0x0008,
+	 .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
 	 .ac97_chip = 1} ,
 	/* Tested by James@superbug.co.uk 3rd July 2005 */
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20071102,
-	 .driver = "Audigy2", .name = "Audigy 4 PRO [SB0380]", 
+	 .driver = "Audigy2", .name = "Audigy 4 PRO [SB0380]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
@@ -1457,7 +1457,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 * Just like 0x20021102
 	 */
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20061102,
-	 .driver = "Audigy2", .name = "Audigy 2 [SB0350b]", 
+	 .driver = "Audigy2", .name = "Audigy 2 [SB0350b]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
@@ -1466,7 +1466,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20021102,
-	 .driver = "Audigy2", .name = "Audigy 2 ZS [SB0350]", 
+	 .driver = "Audigy2", .name = "Audigy 2 ZS [SB0350]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
@@ -1475,7 +1475,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20011102,
-	 .driver = "Audigy2", .name = "Audigy 2 ZS [2001]", 
+	 .driver = "Audigy2", .name = "Audigy 2 ZS [2001]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
@@ -1492,7 +1492,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 * CA0151: Yes
 	 */
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10071102,
-	 .driver = "Audigy2", .name = "Audigy 2 [SB0240]", 
+	 .driver = "Audigy2", .name = "Audigy 2 [SB0240]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
@@ -1502,7 +1502,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .adc_1361t = 1,  /* 24 bit capture instead of 16bit */
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10051102,
-	 .driver = "Audigy2", .name = "Audigy 2 EX [1005]", 
+	 .driver = "Audigy2", .name = "Audigy 2 EX [1005]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
@@ -1521,7 +1521,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10021102,
-	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]", 
+	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
@@ -1540,44 +1540,44 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00531102,
-	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]",
 	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00521102,
-	 .driver = "Audigy", .name = "Audigy 1 ES [SB0160]", 
+	 .driver = "Audigy", .name = "Audigy 1 ES [SB0160]",
 	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00511102,
-	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]",
 	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004,
-	 .driver = "Audigy", .name = "Audigy 1 [Unknown]", 
+	 .driver = "Audigy", .name = "Audigy 1 [Unknown]",
 	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806B1102,
-	 .driver = "EMU10K1", .name = "SBLive! [SB0105]", 
+	 .driver = "EMU10K1", .name = "SBLive! [SB0105]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806A1102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [SB0103]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0103]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80691102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [SB0101]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0101]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
@@ -1585,26 +1585,26 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	/* Tested by ALSA bug#1680 26th December 2005 */
 	/* note: It really has SB0220 written on the card. */
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80661102,
-	 .driver = "EMU10K1", .name = "SB Live 5.1 Dell OEM [SB0220]", 
+	 .driver = "EMU10K1", .name = "SB Live 5.1 Dell OEM [SB0220]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	/* Tested by Thomas Zehetbauer 27th Aug 2005 */
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80651102,
-	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x100a1102,
-	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
-	 .driver = "EMU10K1", .name = "SB Live 5.1", 
+	 .driver = "EMU10K1", .name = "SB Live 5.1",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
@@ -1619,78 +1619,78 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 			  */
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80401102,
-	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
+	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80321102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4871]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4871]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80311102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4831]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4831]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80281102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4870]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4870]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	/* Tested by James@superbug.co.uk 3rd July 2005 */
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80261102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4830]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4830]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80231102,
-	 .driver = "EMU10K1", .name = "SB PCI512 [CT4790]", 
+	 .driver = "EMU10K1", .name = "SB PCI512 [CT4790]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80221102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4780]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4780]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
-	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
+	 .driver = "EMU10K1", .name = "E-mu APS [4001]",
 	 .id = "APS",
 	 .emu10k1_chip = 1,
 	 .ecard = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00211102,
-	 .driver = "EMU10K1", .name = "SBLive! [CT4620]", 
+	 .driver = "EMU10K1", .name = "SBLive! [CT4620]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00201102,
-	 .driver = "EMU10K1", .name = "SBLive! Value [CT4670]", 
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4670]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002,
-	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
+	 .driver = "EMU10K1", .name = "SB Live [Unknown]",
 	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
@@ -1715,7 +1715,7 @@ int __devinit snd_emu10k1_create(struct snd_card *card,
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_emu10k1_dev_free,
 	};
-	
+
 	*remu = NULL;
 
 	/* enable PCI device */
@@ -1751,11 +1751,11 @@ int __devinit snd_emu10k1_create(struct snd_card *card,
 	for (c = emu_chip_details; c->vendor; c++) {
 		if (c->vendor == pci->vendor && c->device == pci->device) {
 			if (subsystem) {
-				if (c->subsystem && (c->subsystem == subsystem) ) {
+				if (c->subsystem && (c->subsystem == subsystem)) {
 					break;
 				} else continue;
 			} else {
-				if (c->subsystem && (c->subsystem != emu->serial) )
+				if (c->subsystem && (c->subsystem != emu->serial))
 					continue;
 				if (c->revision && c->revision != emu->revision)
 					continue;
@@ -1772,13 +1772,13 @@ int __devinit snd_emu10k1_create(struct snd_card *card,
 	emu->card_capabilities = c;
 	if (c->subsystem && !subsystem)
 		snd_printdd("Sound card name=%s\n", c->name);
-	else if (subsystem) 
+	else if (subsystem)
 		snd_printdd("Sound card name=%s, vendor=0x%x, device=0x%x, subsystem=0x%x. Forced to subsytem=0x%x\n",
 		       	c->name, pci->vendor, pci->device, emu->serial, c->subsystem);
-	else 
+	else
 		snd_printdd("Sound card name=%s, vendor=0x%x, device=0x%x, subsystem=0x%x.\n",
 		      	c->name, pci->vendor, pci->device, emu->serial);
-	
+
 	if (!*card->id && c->id) {
 		int i, n = 0;
 		strlcpy(card->id, c->id, sizeof(card->id));
@@ -1913,7 +1913,7 @@ int __devinit snd_emu10k1_create(struct snd_card *card,
 		snd_emu10k1_synth_alloc(emu, 4096);
 	if (emu->reserved_page)
 		emu->reserved_page->map_locked = 1;
-	
+
 	/* Clear silent pages and set up pointers */
 	memset(emu->silent_page.area, 0, PAGE_SIZE);
 	silent_page = emu->silent_page.addr << 1;
@@ -1978,7 +1978,7 @@ static int __devinit alloc_pm_buffer(struct snd_emu10k1 *emu)
 	if (emu->audigy)
 		size += ARRAY_SIZE(saved_regs_audigy);
 	emu->saved_ptr = vmalloc(4 * NUM_G * size);
-	if (! emu->saved_ptr)
+	if (!emu->saved_ptr)
 		return -ENOMEM;
 	if (snd_emu10k1_efx_alloc_pm_buffer(emu) < 0)
 		return -ENOMEM;
diff --git a/sound/pci/emu10k1/emu10k1_patch.c b/sound/pci/emu10k1/emu10k1_patch.c
index e10f027..8e59bba 100644
--- a/sound/pci/emu10k1/emu10k1_patch.c
+++ b/sound/pci/emu10k1/emu10k1_patch.c
@@ -88,7 +88,7 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 
 	/* try to allocate a memory block */
 	blocksize = truesize;
-	if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
+	if (!(sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
 		blocksize *= 2;
 	sp->block = snd_emu10k1_synth_alloc(emu, blocksize);
 	if (sp->block == NULL) {
@@ -102,7 +102,7 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 	/* write blank samples at head */
 	offset = 0;
 	size = BLANK_HEAD_SIZE;
-	if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
+	if (!(sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
 		size *= 2;
 	if (offset + size > blocksize)
 		return -EINVAL;
@@ -111,7 +111,7 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 
 	/* copy start->loopend */
 	size = loopend;
-	if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
+	if (!(sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
 		size *= 2;
 	if (offset + size > blocksize)
 		return -EINVAL;
@@ -127,7 +127,7 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 	/* handle reverse (or bidirectional) loop */
 	if (sp->v.mode_flags & (SNDRV_SFNT_SAMPLE_BIDIR_LOOP|SNDRV_SFNT_SAMPLE_REVERSE_LOOP)) {
 		/* copy loop in reverse */
-		if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS)) {
+		if (!(sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS)) {
 			int woffset;
 			unsigned short *wblock = (unsigned short*)block;
 			woffset = offset / 2;
@@ -160,7 +160,7 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 	size = sp->v.size - loopend;
 	if (size < 0)
 		return -EINVAL;
-	if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
+	if (!(sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
 		size *= 2;
 	if (snd_emu10k1_synth_copy_from_user(emu, sp->block, offset, data, size)) {
 		snd_emu10k1_synth_free(emu, sp->block);
@@ -184,7 +184,7 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 #if 0 /* not supported yet */
 	if (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_UNSIGNED) {
 		/* unsigned -> signed */
-		if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS)) {
+		if (!(sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS)) {
 			unsigned short *wblock = (unsigned short*)block;
 			for (i = 0; i < truesize; i++)
 				wblock[i] ^= 0x8000;
@@ -197,7 +197,7 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 
 	/* recalculate offset */
 	start_addr = BLANK_HEAD_SIZE * 2;
-	if (! (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
+	if (!(sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS))
 		start_addr >>= 1;
 	sp->v.start += start_addr;
 	sp->v.end += start_addr;
diff --git a/sound/pci/emu10k1/emu10k1_synth.c b/sound/pci/emu10k1/emu10k1_synth.c
index ad7b714..bedb7dd 100644
--- a/sound/pci/emu10k1/emu10k1_synth.c
+++ b/sound/pci/emu10k1/emu10k1_synth.c
@@ -105,7 +105,7 @@ static int snd_emu10k1_synth_delete_device(struct snd_seq_device *dev)
 
 static int __init alsa_emu10k1_synth_init(void)
 {
-	
+
 	static struct snd_seq_dev_ops ops = {
 		snd_emu10k1_synth_new_device,
 		snd_emu10k1_synth_delete_device,
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 5ff4dbb..0c02d87 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -107,7 +107,7 @@ MODULE_PARM_DESC(enable, "Enable the EMU10K1X soundcard.");
 /* Emu10k1x pointer-offset register set, accessed through the PTR and DATA registers			*/
 /********************************************************************************************************/
 #define PLAYBACK_LIST_ADDR	0x00		/* Base DMA address of a list of pointers to each period/size */
-						/* One list entry: 4 bytes for DMA address, 
+						/* One list entry: 4 bytes for DMA address,
 						 * 4 bytes for period_size << 16.
 						 * One list entry is 8 bytes long.
 						 * One list entry for each period in the buffer.
@@ -186,7 +186,7 @@ MODULE_PARM_DESC(enable, "Enable the EMU10K1X soundcard.");
  *  - channel 1 is the rear channel
  *  - channel 2 is the center/lfe chanel
  * Volume is controlled by the AC97 for the front and rear channels by
- * the PCM Playback Volume, Sigmatel Surround Playback Volume and 
+ * the PCM Playback Volume, Sigmatel Surround Playback Volume and
  * Surround Playback Volume. The Sigmatel 4-Speaker Stereo switch affects
  * the front/rear channel mixing in the REAR OUT jack. When using the
  * 4-Speaker Stereo, both front and rear channels will be mixed in the
@@ -199,7 +199,7 @@ struct emu10k1x_voice {
 	struct emu10k1x *emu;
 	int number;
 	int use;
-  
+
 	struct emu10k1x_pcm *epcm;
 };
 
@@ -246,7 +246,7 @@ struct emu10k1x {
 
 	struct emu10k1x_voice voices[3];
 	struct emu10k1x_voice capture_voice;
-	u32 spdif_bits[3]; // SPDIF out setup
+	u32 spdif_bits[3]; /* SPDIF out setup */
 
 	struct snd_dma_buffer dma_buffer;
 
@@ -255,7 +255,7 @@ struct emu10k1x {
 
 /* hardware definition */
 static struct snd_pcm_hardware snd_emu10k1x_playback_hw = {
-	.info =			(SNDRV_PCM_INFO_MMAP | 
+	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
@@ -274,7 +274,7 @@ static struct snd_pcm_hardware snd_emu10k1x_playback_hw = {
 };
 
 static struct snd_pcm_hardware snd_emu10k1x_capture_hw = {
-	.info =			(SNDRV_PCM_INFO_MMAP | 
+	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
@@ -292,13 +292,13 @@ static struct snd_pcm_hardware snd_emu10k1x_capture_hw = {
 	.fifo_size =		0,
 };
 
-static unsigned int snd_emu10k1x_ptr_read(struct emu10k1x * emu, 
-					  unsigned int reg, 
+static unsigned int snd_emu10k1x_ptr_read(struct emu10k1x * emu,
+					  unsigned int reg,
 					  unsigned int chn)
 {
 	unsigned long flags;
 	unsigned int regptr, val;
-  
+
 	regptr = (reg << 16) | chn;
 
 	spin_lock_irqsave(&emu->emu_lock, flags);
@@ -308,9 +308,9 @@ static unsigned int snd_emu10k1x_ptr_read(struct emu10k1x * emu,
 	return val;
 }
 
-static void snd_emu10k1x_ptr_write(struct emu10k1x *emu, 
-				   unsigned int reg, 
-				   unsigned int chn, 
+static void snd_emu10k1x_ptr_write(struct emu10k1x *emu,
+				   unsigned int reg,
+				   unsigned int chn,
 				   unsigned int data)
 {
 	unsigned int regptr;
@@ -396,10 +396,10 @@ static int snd_emu10k1x_playback_open(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 	epcm->emu = chip;
 	epcm->substream = substream;
-  
+
 	runtime->private_data = epcm;
 	runtime->private_free = snd_emu10k1x_pcm_free_substream;
-  
+
 	runtime->hw = snd_emu10k1x_playback_hw;
 
 	return 0;
@@ -418,7 +418,7 @@ static int snd_emu10k1x_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct emu10k1x_pcm *epcm = runtime->private_data;
 
-	if (! epcm->voice) {
+	if (!epcm->voice) {
 		epcm->voice = &epcm->emu->voices[substream->pcm->device];
 		epcm->voice->use = 1;
 		epcm->voice->epcm = epcm;
@@ -436,7 +436,7 @@ static int snd_emu10k1x_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	if (runtime->private_data == NULL)
 		return 0;
-	
+
 	epcm = runtime->private_data;
 
 	if (epcm->voice) {
@@ -458,8 +458,8 @@ static int snd_emu10k1x_pcm_prepare(struct snd_pcm_substream *substream)
 	u32 *table_base = (u32 *)(emu->dma_buffer.area+1024*voice);
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
 	int i;
-	
-	for(i = 0; i < runtime->periods; i++) {
+
+	for (i = 0; i < runtime->periods; i++) {
 		*table_base++=runtime->dma_addr+(i*period_size_bytes);
 		*table_base++=period_size_bytes<<16;
 	}
@@ -491,7 +491,7 @@ static int snd_emu10k1x_pcm_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		if(runtime->periods == 2)
+		if (runtime->periods == 2)
 			snd_emu10k1x_intr_enable(emu, (INTE_CH_0_LOOP | INTE_CH_0_HALF_LOOP) << channel);
 		else
 			snd_emu10k1x_intr_enable(emu, INTE_CH_0_LOOP << channel);
@@ -527,10 +527,10 @@ snd_emu10k1x_pcm_pointer(struct snd_pcm_substream *substream)
 	ptr1 = snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel);
 	ptr4 = snd_emu10k1x_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
 
-	if(ptr4 == 0 && ptr1 == frames_to_bytes(runtime, runtime->buffer_size))
+	if (ptr4 == 0 && ptr1 == frames_to_bytes(runtime, runtime->buffer_size))
 		return 0;
-	
-	if (ptr3 != ptr4) 
+
+	if (ptr3 != ptr4)
 		ptr1 = snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel);
 	ptr2 = bytes_to_frames(runtime, ptr1);
 	ptr2 += (ptr4 >> 3) * runtime->period_size;
@@ -595,7 +595,7 @@ static int snd_emu10k1x_pcm_hw_params_capture(struct snd_pcm_substream *substrea
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct emu10k1x_pcm *epcm = runtime->private_data;
 
-	if (! epcm->voice) {
+	if (!epcm->voice) {
 		if (epcm->emu->capture_voice.use)
 			return -EBUSY;
 		epcm->voice = &epcm->emu->capture_voice;
@@ -634,7 +634,7 @@ static int snd_emu10k1x_pcm_prepare_capture(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	snd_emu10k1x_ptr_write(emu, CAPTURE_DMA_ADDR, 0, runtime->dma_addr);
-	snd_emu10k1x_ptr_write(emu, CAPTURE_BUFFER_SIZE, 0, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
+	snd_emu10k1x_ptr_write(emu, CAPTURE_BUFFER_SIZE, 0, frames_to_bytes(runtime, runtime->buffer_size)<<16); /* buffer size in bytes */
 	snd_emu10k1x_ptr_write(emu, CAPTURE_POINTER, 0, 0);
 	snd_emu10k1x_ptr_write(emu, CAPTURE_UNKNOWN, 0, 0);
 
@@ -652,14 +652,14 @@ static int snd_emu10k1x_pcm_trigger_capture(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_emu10k1x_intr_enable(emu, INTE_CAP_0_LOOP | 
+		snd_emu10k1x_intr_enable(emu, INTE_CAP_0_LOOP |
 					 INTE_CAP_0_HALF_LOOP);
 		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0)|TRIGGER_CAPTURE);
 		epcm->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		epcm->running = 0;
-		snd_emu10k1x_intr_disable(emu, INTE_CAP_0_LOOP | 
+		snd_emu10k1x_intr_disable(emu, INTE_CAP_0_LOOP |
 					  INTE_CAP_0_HALF_LOOP);
 		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0) & ~(TRIGGER_CAPTURE));
 		break;
@@ -706,7 +706,7 @@ static unsigned short snd_emu10k1x_ac97_read(struct snd_ac97 *ac97,
 	struct emu10k1x *emu = ac97->private_data;
 	unsigned long flags;
 	unsigned short val;
-  
+
 	spin_lock_irqsave(&emu->emu_lock, flags);
 	outb(reg, emu->port + AC97ADDRESS);
 	val = inw(emu->port + AC97DATA);
@@ -719,7 +719,7 @@ static void snd_emu10k1x_ac97_write(struct snd_ac97 *ac97,
 {
 	struct emu10k1x *emu = ac97->private_data;
 	unsigned long flags;
-  
+
 	spin_lock_irqsave(&emu->emu_lock, flags);
 	outb(reg, emu->port + AC97ADDRESS);
 	outw(val, emu->port + AC97DATA);
@@ -735,7 +735,7 @@ static int snd_emu10k1x_ac97(struct emu10k1x *chip)
 		.write = snd_emu10k1x_ac97_write,
 		.read = snd_emu10k1x_ac97_read,
 	};
-  
+
 	if ((err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus)) < 0)
 		return err;
 	pbus->no_vra = 1; /* we don't need VRA */
@@ -749,26 +749,26 @@ static int snd_emu10k1x_ac97(struct emu10k1x *chip)
 static int snd_emu10k1x_free(struct emu10k1x *chip)
 {
 	snd_emu10k1x_ptr_write(chip, TRIGGER_CHANNEL, 0, 0);
-	// disable interrupts
+	/* disable interrupts */
 	outl(0, chip->port + INTE);
-	// disable audio
+	/* disable audio */
 	outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
 
 	/* release the irq */
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
 
-	// release the i/o port
+	/* release the i/o port */
 	release_and_free_resource(chip->res_port);
 
-	// release the DMA
+	/* release the DMA */
 	if (chip->dma_buffer.area) {
 		snd_dma_free_pages(&chip->dma_buffer);
 	}
 
 	pci_disable_device(chip->pci);
 
-	// release the data
+	/* release the data */
 	kfree(chip);
 	return 0;
 }
@@ -790,43 +790,43 @@ static irqreturn_t snd_emu10k1x_interrupt(int irq, void *dev_id)
 
 	status = inl(chip->port + IPR);
 
-	if (! status)
+	if (!status)
 		return IRQ_NONE;
 
-	// capture interrupt
+	/* capture interrupt */
 	if (status & (IPR_CAP_0_LOOP | IPR_CAP_0_HALF_LOOP)) {
 		struct emu10k1x_voice *cap_voice = &chip->capture_voice;
 		if (cap_voice->use)
 			snd_emu10k1x_pcm_interrupt(chip, cap_voice);
 		else
-			snd_emu10k1x_intr_disable(chip, 
+			snd_emu10k1x_intr_disable(chip,
 						  INTE_CAP_0_LOOP |
 						  INTE_CAP_0_HALF_LOOP);
 	}
-		
+
 	mask = IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP;
 	for (i = 0; i < 3; i++) {
 		if (status & mask) {
 			if (pvoice->use)
 				snd_emu10k1x_pcm_interrupt(chip, pvoice);
-			else 
+			else
 				snd_emu10k1x_intr_disable(chip, mask);
 		}
 		pvoice++;
 		mask <<= 1;
 	}
-		
+
 	if (status & (IPR_MIDITRANSBUFEMPTY|IPR_MIDIRECVBUFEMPTY)) {
 		if (chip->midi.interrupt)
 			chip->midi.interrupt(chip, status);
 		else
 			snd_emu10k1x_intr_disable(chip, INTE_MIDITXENABLE|INTE_MIDIRXENABLE);
 	}
-		
-	// acknowledge the interrupt if necessary
+
+	/* acknowledge the interrupt if necessary */
 	outl(status, chip->port + IPR);
 
-	// snd_printk(KERN_INFO "interrupt %08x\n", status);
+	/* snd_printk(KERN_INFO "interrupt %08x\n", status); */
 	return IRQ_HANDLED;
 }
 
@@ -835,17 +835,17 @@ static int __devinit snd_emu10k1x_pcm(struct emu10k1x *emu, int device, struct s
 	struct snd_pcm *pcm;
 	int err;
 	int capture = 0;
-  
+
 	if (rpcm)
 		*rpcm = NULL;
 	if (device == 0)
 		capture = 1;
-	
+
 	if ((err = snd_pcm_new(emu->card, "emu10k1x", device, 1, capture, &pcm)) < 0)
 		return err;
-  
+
 	pcm->private_data = emu;
-	
+
 	switch(device) {
 	case 0:
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1x_playback_ops);
@@ -873,12 +873,12 @@ static int __devinit snd_emu10k1x_pcm(struct emu10k1x *emu, int device, struct s
 	emu->pcm = pcm;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      snd_dma_pci_data(emu->pci), 
+					      snd_dma_pci_data(emu->pci),
 					      32*1024, 32*1024);
-  
+
 	if (rpcm)
 		*rpcm = pcm;
-  
+
 	return 0;
 }
 
@@ -916,10 +916,10 @@ static int __devinit snd_emu10k1x_create(struct snd_card *card,
 
 	spin_lock_init(&chip->emu_lock);
 	spin_lock_init(&chip->voice_lock);
-  
+
 	chip->port = pci_resource_start(pci, 0);
 	if ((chip->res_port = request_region(chip->port, 8,
-					     "EMU10K1X")) == NULL) { 
+					     "EMU10K1X")) == NULL) {
 		snd_printk(KERN_ERR "emu10k1x: cannot allocate the port 0x%lx\n", chip->port);
 		snd_emu10k1x_free(chip);
 		return -EBUSY;
@@ -932,8 +932,8 @@ static int __devinit snd_emu10k1x_create(struct snd_card *card,
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-  
-	if(snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
+
+	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 			       4 * 1024, &chip->dma_buffer) < 0) {
 		snd_emu10k1x_free(chip);
 		return -ENOMEM;
@@ -947,9 +947,9 @@ static int __devinit snd_emu10k1x_create(struct snd_card *card,
 	snd_printk(KERN_INFO "Model %04x Rev %08x Serial %08x\n", chip->model,
 		   chip->revision, chip->serial);
 
-	outl(0, chip->port + INTE);	
+	outl(0, chip->port + INTE);
 
-	for(ch = 0; ch < 3; ch++) {
+	for (ch = 0; ch < 3; ch++) {
 		chip->voices[ch].emu = chip;
 		chip->voices[ch].number = ch;
 	}
@@ -969,27 +969,27 @@ static int __devinit snd_emu10k1x_create(struct snd_card *card,
 	 *  P                 = 0     (Consumer)
 	 */
 	snd_emu10k1x_ptr_write(chip, SPCS0, 0,
-			       chip->spdif_bits[0] = 
+			       chip->spdif_bits[0] =
 			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
 			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
 			       SPCS_GENERATIONSTATUS | 0x00001200 |
 			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 	snd_emu10k1x_ptr_write(chip, SPCS1, 0,
-			       chip->spdif_bits[1] = 
+			       chip->spdif_bits[1] =
 			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
 			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
 			       SPCS_GENERATIONSTATUS | 0x00001200 |
 			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 	snd_emu10k1x_ptr_write(chip, SPCS2, 0,
-			       chip->spdif_bits[2] = 
+			       chip->spdif_bits[2] =
 			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
 			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
 			       SPCS_GENERATIONSTATUS | 0x00001200 |
 			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 
-	snd_emu10k1x_ptr_write(chip, SPDIF_SELECT, 0, 0x700); // disable SPDIF
-	snd_emu10k1x_ptr_write(chip, ROUTING, 0, 0x1003F); // routing
-	snd_emu10k1x_gpio_write(chip, 0x1080); // analog mode
+	snd_emu10k1x_ptr_write(chip, SPDIF_SELECT, 0, 0x700); /* disable SPDIF */
+	snd_emu10k1x_ptr_write(chip, ROUTING, 0, 0x1003F); /* routing */
+	snd_emu10k1x_gpio_write(chip, 0x1080); /* analog mode */
 
 	outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
 
@@ -1002,7 +1002,7 @@ static int __devinit snd_emu10k1x_create(struct snd_card *card,
 	return 0;
 }
 
-static void snd_emu10k1x_proc_reg_read(struct snd_info_entry *entry, 
+static void snd_emu10k1x_proc_reg_read(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct emu10k1x *emu = entry->private_data;
@@ -1011,16 +1011,16 @@ static void snd_emu10k1x_proc_reg_read(struct snd_info_entry *entry,
 	int i;
 
 	snd_iprintf(buffer, "Registers:\n\n");
-	for(i = 0; i < 0x20; i+=4) {
+	for (i = 0; i < 0x20; i += 4) {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		value = inl(emu->port + i);
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
 		snd_iprintf(buffer, "Register %02X: %08lX\n", i, value);
 	}
 	snd_iprintf(buffer, "\nRegisters\n\n");
-	for(i = 0; i <= 0x48; i++) {
+	for (i = 0; i <= 0x48; i++) {
 		value = snd_emu10k1x_ptr_read(emu, i, 0);
-		if(i < 0x10 || (i >= 0x20 && i < 0x40)) {
+		if (i < 0x10 || (i >= 0x20 && i < 0x40)) {
 			value1 = snd_emu10k1x_ptr_read(emu, i, 1);
 			value2 = snd_emu10k1x_ptr_read(emu, i, 2);
 			snd_iprintf(buffer, "%02X: %08lX %08lX %08lX\n", i, value, value1, value2);
@@ -1030,7 +1030,7 @@ static void snd_emu10k1x_proc_reg_read(struct snd_info_entry *entry,
 	}
 }
 
-static void snd_emu10k1x_proc_reg_write(struct snd_info_entry *entry, 
+static void snd_emu10k1x_proc_reg_write(struct snd_info_entry *entry,
 					struct snd_info_buffer *buffer)
 {
 	struct emu10k1x *emu = entry->private_data;
@@ -1041,8 +1041,8 @@ static void snd_emu10k1x_proc_reg_write(struct snd_info_entry *entry,
 		if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
 			continue;
 
-		if ((reg < 0x49) && (reg >= 0) && (val <= 0xffffffff) 
-		    && (channel_id >= 0) && (channel_id <= 2) )
+		if ((reg < 0x49) && (reg >= 0) && (val <= 0xffffffff)
+		    && (channel_id >= 0) && (channel_id <= 2))
 			snd_emu10k1x_ptr_write(emu, reg, channel_id, val);
 	}
 }
@@ -1050,14 +1050,14 @@ static void snd_emu10k1x_proc_reg_write(struct snd_info_entry *entry,
 static int __devinit snd_emu10k1x_proc_init(struct emu10k1x * emu)
 {
 	struct snd_info_entry *entry;
-	
-	if(! snd_card_proc_new(emu->card, "emu10k1x_regs", &entry)) {
+
+	if (!snd_card_proc_new(emu->card, "emu10k1x_regs", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu10k1x_proc_reg_read);
 		entry->c.text.write = snd_emu10k1x_proc_reg_write;
 		entry->mode |= S_IWUSR;
 		entry->private_data = emu;
 	}
-	
+
 	return 0;
 }
 
@@ -1080,15 +1080,15 @@ static int snd_emu10k1x_shared_spdif_put(struct snd_kcontrol *kcontrol,
 	unsigned int val;
 	int change = 0;
 
-	val = ucontrol->value.integer.value[0] ;
+	val = ucontrol->value.integer.value[0];
 
 	if (val) {
-		// enable spdif output
+		/* enable spdif output */
 		snd_emu10k1x_ptr_write(emu, SPDIF_SELECT, 0, 0x000);
 		snd_emu10k1x_ptr_write(emu, ROUTING, 0, 0x700);
 		snd_emu10k1x_gpio_write(emu, 0x1000);
 	} else {
-		// disable spdif output
+		/* disable spdif output */
 		snd_emu10k1x_ptr_write(emu, SPDIF_SELECT, 0, 0x700);
 		snd_emu10k1x_ptr_write(emu, ROUTING, 0, 0x1003F);
 		snd_emu10k1x_gpio_write(emu, 0x1080);
@@ -1317,7 +1317,7 @@ static int snd_emu10k1x_midi_input_open(struct snd_rawmidi_substream *substream)
 	struct emu10k1x *emu;
 	struct emu10k1x_midi *midi = substream->rmidi->private_data;
 	unsigned long flags;
-	
+
 	emu = midi->emu;
 	if (snd_BUG_ON(!emu))
 		return -ENXIO;
@@ -1439,7 +1439,7 @@ static void snd_emu10k1x_midi_output_trigger(struct snd_rawmidi_substream *subst
 	if (up) {
 		int max = 4;
 		unsigned char byte;
-	
+
 		/* try to send some amount of bytes here before interrupts */
 		spin_lock_irqsave(&midi->output_lock, flags);
 		while (max > 0) {
@@ -1575,7 +1575,7 @@ static int __devinit snd_emu10k1x_probe(struct pci_dev *pci,
 		snd_card_free(card);
 		return err;
 	}
-	
+
 	if ((err = snd_emu10k1x_midi(chip)) < 0) {
 		snd_card_free(card);
 		return err;
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 7dba08f..f8ce97b 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -52,7 +52,7 @@
 
 /*
  *  Tables
- */ 
+ */
 
 static char *fxbuses[16] = {
 	/* 0x00 */ "PCM Left",
@@ -303,7 +303,7 @@ static const u32 onoff_table[2] = {
 
 /*
  */
- 
+
 static inline mm_segment_t snd_enter_user(void)
 {
 	mm_segment_t fs = get_fs();
@@ -342,7 +342,7 @@ static int snd_emu10k1_gpr_ctl_get(struct snd_kcontrol *kcontrol, struct snd_ctl
 		(struct snd_emu10k1_fx8010_ctl *) kcontrol->private_value;
 	unsigned long flags;
 	unsigned int i;
-	
+
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (i = 0; i < ctl->vcount; i++)
 		ucontrol->value.integer.value[i] = ctl->value[i];
@@ -359,7 +359,7 @@ static int snd_emu10k1_gpr_ctl_put(struct snd_kcontrol *kcontrol, struct snd_ctl
 	unsigned int nval, val;
 	unsigned int i, j;
 	int change = 0;
-	
+
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (i = 0; i < ctl->vcount; i++) {
 		nval = ucontrol->value.integer.value[i];
@@ -398,7 +398,7 @@ static int snd_emu10k1_gpr_ctl_put(struct snd_kcontrol *kcontrol, struct snd_ctl
 			break;
 		}
 	}
-      __error:
+__error:
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return change;
 }
@@ -431,7 +431,7 @@ int snd_emu10k1_fx8010_register_irq_handler(struct snd_emu10k1 *emu,
 {
 	struct snd_emu10k1_fx8010_irq *irq;
 	unsigned long flags;
-	
+
 	irq = kmalloc(sizeof(*irq), GFP_ATOMIC);
 	if (irq == NULL)
 		return -ENOMEM;
@@ -459,7 +459,7 @@ int snd_emu10k1_fx8010_unregister_irq_handler(struct snd_emu10k1 *emu,
 {
 	struct snd_emu10k1_fx8010_irq *tmp;
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&emu->fx8010.irq_lock, flags);
 	if ((tmp = emu->fx8010.irq_handlers) == irq) {
 		emu->fx8010.irq_handlers = tmp->next;
@@ -703,7 +703,7 @@ static int copy_gctl_to_user(struct snd_emu10k1 *emu,
 
 	if (emu->support_tlv)
 		return copy_to_user(&_gctl[idx], gctl, sizeof(*gctl));
-	
+
 	octl = (struct snd_emu10k1_fx8010_control_old_gpr __user *)_gctl;
 	return copy_to_user(&octl[idx], gctl, sizeof(*octl));
 }
@@ -716,7 +716,7 @@ static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
 	struct snd_ctl_elem_id id;
 	struct snd_emu10k1_fx8010_control_gpr *gctl;
 	int err;
-	
+
 	for (i = 0, _id = icode->gpr_del_controls;
 	     i < icode->gpr_del_control_count; i++, _id++) {
 	     	if (copy_from_user(&id, _id, sizeof(id)))
@@ -725,7 +725,7 @@ static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
 			return -ENOENT;
 	}
 	gctl = kmalloc(sizeof(*gctl), GFP_KERNEL);
-	if (! gctl)
+	if (!gctl)
 		return -ENOMEM;
 	err = 0;
 	for (i = 0; i < icode->gpr_add_control_count; i++) {
@@ -755,7 +755,7 @@ static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
 			goto __error;
 		}
 	}
- __error:
+__error:
 	kfree(gctl);
 	return err;
 }
@@ -763,7 +763,7 @@ static int snd_emu10k1_verify_controls(struct snd_emu10k1 *emu,
 static void snd_emu10k1_ctl_private_free(struct snd_kcontrol *kctl)
 {
 	struct snd_emu10k1_fx8010_ctl *ctl;
-	
+
 	ctl = (struct snd_emu10k1_fx8010_ctl *) kctl->private_value;
 	kctl->private_value = 0;
 	list_del(&ctl->list);
@@ -801,7 +801,7 @@ static int snd_emu10k1_add_controls(struct snd_emu10k1 *emu,
 			err = -EINVAL;
 			goto __error;
 		}
-		if (! gctl->id.name[0]) {
+		if (!gctl->id.name[0]) {
 			err = -EINVAL;
 			goto __error;
 		}
@@ -857,7 +857,7 @@ static int snd_emu10k1_add_controls(struct snd_emu10k1 *emu,
 		}
 		snd_emu10k1_gpr_ctl_put(ctl->kcontrol, val);
 	}
-      __error:
+__error:
 	kfree(nctl);
 	kfree(gctl);
 	kfree(val);
@@ -872,7 +872,7 @@ static int snd_emu10k1_del_controls(struct snd_emu10k1 *emu,
 	struct snd_ctl_elem_id __user *_id;
 	struct snd_emu10k1_fx8010_ctl *ctl;
 	struct snd_card *card = emu->card;
-	
+
 	for (i = 0, _id = icode->gpr_del_controls;
 	     i < icode->gpr_del_control_count; i++, _id++) {
 	     	if (copy_from_user(&id, _id, sizeof(id)))
@@ -896,7 +896,7 @@ static int snd_emu10k1_list_controls(struct snd_emu10k1 *emu,
 	struct snd_ctl_elem_id *id;
 
 	gctl = kmalloc(sizeof(*gctl), GFP_KERNEL);
-	if (! gctl)
+	if (!gctl)
 		return -ENOMEM;
 
 	list_for_each_entry(ctl, &emu->fx8010.gpr_ctl, list) {
@@ -959,7 +959,7 @@ static int snd_emu10k1_icode_poke(struct snd_emu10k1 *emu,
 		snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg);
 	else
 		snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg);
-      __error:
+__error:
 	mutex_unlock(&emu->fx8010.lock);
 	return err;
 }
@@ -1023,7 +1023,7 @@ static int snd_emu10k1_ipcm_poke(struct snd_emu10k1 *emu,
 		for (i = 0; i < pcm->channels; i++)
 			pcm->etram[i] = ipcm->etram[i];
 	}
-      __error:
+__error:
 	spin_unlock_irq(&emu->reg_lock);
 	mutex_unlock(&emu->fx8010.lock);
 	return err;
@@ -1075,7 +1075,7 @@ snd_emu10k1_init_mono_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 	ctl->min = 0;
 	ctl->max = 100;
 	ctl->tlv = snd_emu10k1_db_scale1;
-	ctl->translation = EMU10K1_GPR_TRANSLATION_TABLE100;	
+	ctl->translation = EMU10K1_GPR_TRANSLATION_TABLE100;
 }
 
 static void __devinit
@@ -1177,7 +1177,7 @@ static int __devinit _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
 	/* clear free GPRs */
 	for (i = 0; i < 512; i++)
 		set_bit(i, icode->gpr_valid);
-		
+
 	/* clear TRAM data & address lines */
 	for (i = 0; i < 256; i++)
 		set_bit(i, icode->tram_valid);
@@ -1210,7 +1210,7 @@ static int __devinit _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback+3), A_C_00000000, A_GPR(gpr+1), A_FXBUS(FXBUS_PCM_RIGHT_REAR));
 	snd_emu10k1_init_stereo_control(&controls[nctl++], "PCM Surround Playback Volume", gpr, 100);
 	gpr += 2;
-	
+
 	/* PCM Side Playback (independent from stereo mix) */
 	if (emu->card_capabilities->spk71) {
 		A_OP(icode, &ptr, iMAC0, A_GPR(playback+6), A_C_00000000, A_GPR(gpr), A_FXBUS(FXBUS_PCM_LEFT_SIDE));
@@ -1228,7 +1228,7 @@ static int __devinit _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback+5), A_C_00000000, A_GPR(gpr), A_FXBUS(FXBUS_PCM_LFE));
 	snd_emu10k1_init_mono_control(&controls[nctl++], "PCM LFE Playback Volume", gpr, 100);
 	gpr++;
-	
+
 	/*
 	 * Stereo Mix
 	 */
@@ -1255,7 +1255,7 @@ static int __devinit _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
 	A_OP(icode, &ptr, iMAC0, A_GPR(capture+1), A_GPR(capture+1), A_GPR(gpr+1), A_FXBUS(FXBUS_MIDI_RIGHT));
 	snd_emu10k1_init_stereo_control(&controls[nctl++], "Synth Capture Volume", gpr, 0);
 	gpr += 2;
-      
+
 	/*
 	 * inputs
 	 */
@@ -1288,7 +1288,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	snd_emu10k1_init_stereo_control(&controls[nctl++], "Mic Capture Volume", gpr, 0);
 	gpr += 2;
 
-	/* mic capture buffer */	
+	/* mic capture buffer */
 	A_OP(icode, &ptr, iINTERP, A_EXTOUT(A_EXTOUT_MIC_CAP), A_EXTIN(A_EXTIN_AC97_L), 0xcd, A_EXTIN(A_EXTIN_AC97_R));
 
 	/* Audigy CD Playback Volume */
@@ -1331,7 +1331,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 					emu->card_capabilities->ac97_chip ? "Line2 Capture Volume" : "Line Capture Volume",
 					gpr, 0);
 	gpr += 2;
-        
+
 	/* Philips ADC Playback Volume */
 	A_ADD_VOLUME_IN(stereo_mix, gpr, A_EXTIN_ADC_L);
 	A_ADD_VOLUME_IN(stereo_mix+1, gpr+1, A_EXTIN_ADC_R);
@@ -1357,13 +1357,13 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 					emu->card_capabilities->ac97_chip ? "Aux2 Capture Volume" : "Aux Capture Volume",
 					gpr, 0);
 	gpr += 2;
-	
+
 	/* Stereo Mix Front Playback Volume */
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback), A_GPR(playback), A_GPR(gpr), A_GPR(stereo_mix));
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback+1), A_GPR(playback+1), A_GPR(gpr+1), A_GPR(stereo_mix+1));
 	snd_emu10k1_init_stereo_control(&controls[nctl++], "Front Playback Volume", gpr, 100);
 	gpr += 2;
-	
+
 	/* Stereo Mix Surround Playback */
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback+2), A_GPR(playback+2), A_GPR(gpr), A_GPR(stereo_mix));
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback+3), A_GPR(playback+3), A_GPR(gpr+1), A_GPR(stereo_mix+1));
@@ -1381,7 +1381,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	A_OP(icode, &ptr, iMAC0, A_GPR(playback+5), A_GPR(playback+5), A_GPR(gpr), A_GPR(tmp));
 	snd_emu10k1_init_mono_control(&controls[nctl++], "LFE Playback Volume", gpr, 0);
 	gpr++;
-	
+
 	if (emu->card_capabilities->spk71) {
 		/* Stereo Mix Side Playback */
 		A_OP(icode, &ptr, iMAC0, A_GPR(playback+6), A_GPR(playback+6), A_GPR(gpr), A_GPR(stereo_mix));
@@ -1420,7 +1420,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 		A_OP(icode, &ptr, iACC3, A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 6), A_GPR(playback + 6), A_C_00000000, A_C_00000000); /* side left */
 		A_OP(icode, &ptr, iACC3, A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 7), A_GPR(playback + 7), A_C_00000000, A_C_00000000); /* side right */
 	}
-	
+
 
 	ctl = &controls[nctl + 0];
 	ctl->id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
@@ -1529,7 +1529,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 		}
 	}
 
-	/* IEC958 Optical Raw Playback Switch */ 
+	/* IEC958 Optical Raw Playback Switch */
 	gpr_map[gpr++] = 0;
 	gpr_map[gpr++] = 0x1008;
 	gpr_map[gpr++] = 0xffff0000;
@@ -1552,7 +1552,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	}
 	snd_emu10k1_init_stereo_onoff_control(controls + nctl++, SNDRV_CTL_NAME_IEC958("Optical Raw ",PLAYBACK,SWITCH), gpr, 0);
 	gpr += 2;
-	
+
 	A_PUT_STEREO_OUTPUT(A_EXTOUT_REAR_L, A_EXTOUT_REAR_R, playback+2 + SND_EMU10K1_PLAYBACK_CHANNELS);
 	A_PUT_OUTPUT(A_EXTOUT_CENTER, playback+4 + SND_EMU10K1_PLAYBACK_CHANNELS);
 	A_PUT_OUTPUT(A_EXTOUT_LFE, playback+5 + SND_EMU10K1_PLAYBACK_CHANNELS);
@@ -1569,10 +1569,10 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 		if (emu->card_capabilities->ca0108_chip) {
 			snd_printk("EMU2 inputs on\n");
 			for (z = 0; z < 0x10; z++) {
-				snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, 
+				snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp,
 									bit_shifter16,
 									A3_EMU32IN(z),
-									A_FXBUS2(z*2) );
+									A_FXBUS2(z*2));
 			}
 		} else {
 			snd_printk("EMU inputs on\n");
@@ -1584,7 +1584,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 			 * so all other A_P16VIN channels will need to also be delayed
 			 */
 			/* Left ADC in. 1 of 2 */
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_P16VIN(0x0), A_FXBUS2(0) );
+			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_P16VIN(0x0), A_FXBUS2(0));
 			/* Right ADC in 1 of 2 */
 			gpr_map[gpr++] = 0x00000000;
 			/* Delaying by one sample: instead of copying the input
@@ -1592,28 +1592,28 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 			 * we use an auxiliary register, delaying the value by one
 			 * sample
 			 */
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(2) );
+			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(2));
 			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x1), A_C_00000000, A_C_00000000);
 			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(4) );
+			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(4));
 			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x2), A_C_00000000, A_C_00000000);
 			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(6) );
+			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(6));
 			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x3), A_C_00000000, A_C_00000000);
 			/* For 96kHz mode */
 			/* Left ADC in. 2 of 2 */
 			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0x8) );
+			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0x8));
 			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x4), A_C_00000000, A_C_00000000);
 			/* Right ADC in 2 of 2 */
 			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xa) );
+			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xa));
 			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x5), A_C_00000000, A_C_00000000);
 			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xc) );
+			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xc));
 			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x6), A_C_00000000, A_C_00000000);
 			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xe) );
+			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xe));
 			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x7), A_C_00000000, A_C_00000000);
 			/* Pavel Hofman - we still have voices, A_FXBUS2s, and
 			 * A_P16VINs available -
@@ -1692,7 +1692,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 			A_OP(icode, &ptr, iACC3, A_FXBUS2(z), A_C_00000000, A_C_00000000, A_EXTIN(z));
 		}
 	}
-	
+
 #endif /* JCD test */
 	/*
 	 * ok, set up done..
@@ -1715,7 +1715,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	emu->support_tlv = 0; /* clear again */
 	snd_leave_user(seg);
 
- __err:
+__err:
 	kfree(controls);
 	if (icode != NULL) {
 		kfree((void __force *)icode->gpr_map);
@@ -1804,7 +1804,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 	icode->tram_data_map = icode->gpr_map + 256;
 	icode->tram_addr_map = icode->tram_data_map + 160;
 	icode->code = icode->tram_addr_map + 160;
-	
+
 	/* clear free GPRs */
 	for (i = 0; i < 256; i++)
 		set_bit(i, icode->gpr_valid);
@@ -1904,7 +1904,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 	/* 18: */ OP(icode, &ptr, iSKIP, GPR_COND, GPR_COND, CC_REG_MINUS, C_00000001);
 	/* 19: */ OP(icode, &ptr, iACC3, GPR(tmp + 0), C_00000000, C_00000000, C_00000000);
 	/* 1a: */ OP(icode, &ptr, iACC3, GPR(ipcm->gpr_ptr), GPR(tmp + 0), C_00000000, C_00000000);
-	
+
 	/* 1b: */ OP(icode, &ptr, iACC3, GPR(ipcm->gpr_tmpcount), GPR(ipcm->gpr_tmpcount), C_ffffffff, C_00000000);
 	/* 1c: */ OP(icode, &ptr, iSKIP, GPR_COND, GPR_COND, CC_REG_NONZERO, C_00000002);
 	/* 1d: */ OP(icode, &ptr, iACC3, GPR(ipcm->gpr_tmpcount), GPR(ipcm->gpr_count), C_00000000, C_00000000);
@@ -1931,7 +1931,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		VOLUME(icode, &ptr, playback + 2 + z, z, gpr + z);
 	snd_emu10k1_init_stereo_control(controls + i++, "Wave Surround Playback Volume", gpr, 0);
 	gpr += 2;
-	
+
 	/* Wave Center/LFE Playback Volume */
 	OP(icode, &ptr, iACC3, GPR(tmp + 0), FXBUS(FXBUS_PCM_LEFT), FXBUS(FXBUS_PCM_RIGHT), C_00000000);
 	OP(icode, &ptr, iMACINT0, GPR(tmp + 0), C_00000000, GPR(tmp + 0), C_00000002);
@@ -2016,14 +2016,14 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		VOLUME_ADDIN(icode, &ptr, capture + 1, EXTIN_AC97_R, gpr); gpr++;
 		snd_emu10k1_init_stereo_control(controls + i++, "AC97 Capture Volume", gpr-2, 100);
 	}
-	
+
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_SPDIF_CD_L)|(1<<EXTIN_SPDIF_CD_R))) {
 		/* IEC958 TTL Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_SPDIF_CD_L + z, gpr + z);
 		snd_emu10k1_init_stereo_control(controls + i++, SNDRV_CTL_NAME_IEC958("TTL ",PLAYBACK,VOLUME), gpr, 0);
 		gpr += 2;
-	
+
 		/* IEC958 TTL Capture Volume + Switch */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_SPDIF_CD_L + z, gpr + 2 + z);
@@ -2033,14 +2033,14 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		snd_emu10k1_init_stereo_onoff_control(controls + i++, SNDRV_CTL_NAME_IEC958("TTL ",CAPTURE,SWITCH), gpr + 2, 0);
 		gpr += 4;
 	}
-	
+
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_ZOOM_L)|(1<<EXTIN_ZOOM_R))) {
 		/* Zoom Video Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_ZOOM_L + z, gpr + z);
 		snd_emu10k1_init_stereo_control(controls + i++, "Zoom Video Playback Volume", gpr, 0);
 		gpr += 2;
-	
+
 		/* Zoom Video Capture Volume + Switch */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_ZOOM_L + z, gpr + 2 + z);
@@ -2050,14 +2050,14 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Zoom Video Capture Switch", gpr + 2, 0);
 		gpr += 4;
 	}
-	
+
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_TOSLINK_L)|(1<<EXTIN_TOSLINK_R))) {
 		/* IEC958 Optical Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_TOSLINK_L + z, gpr + z);
 		snd_emu10k1_init_stereo_control(controls + i++, SNDRV_CTL_NAME_IEC958("LiveDrive ",PLAYBACK,VOLUME), gpr, 0);
 		gpr += 2;
-	
+
 		/* IEC958 Optical Capture Volume */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_TOSLINK_L + z, gpr + 2 + z);
@@ -2067,14 +2067,14 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		snd_emu10k1_init_stereo_onoff_control(controls + i++, SNDRV_CTL_NAME_IEC958("LiveDrive ",CAPTURE,SWITCH), gpr + 2, 0);
 		gpr += 4;
 	}
-	
+
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_LINE1_L)|(1<<EXTIN_LINE1_R))) {
 		/* Line LiveDrive Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_LINE1_L + z, gpr + z);
 		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Playback Volume", gpr, 0);
 		gpr += 2;
-	
+
 		/* Line LiveDrive Capture Volume + Switch */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_LINE1_L + z, gpr + 2 + z);
@@ -2084,14 +2084,14 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line LiveDrive Capture Switch", gpr + 2, 0);
 		gpr += 4;
 	}
-	
+
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_COAX_SPDIF_L)|(1<<EXTIN_COAX_SPDIF_R))) {
 		/* IEC958 Coax Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_COAX_SPDIF_L + z, gpr + z);
 		snd_emu10k1_init_stereo_control(controls + i++, SNDRV_CTL_NAME_IEC958("Coaxial ",PLAYBACK,VOLUME), gpr, 0);
 		gpr += 2;
-	
+
 		/* IEC958 Coax Capture Volume + Switch */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_COAX_SPDIF_L + z, gpr + 2 + z);
@@ -2101,7 +2101,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		snd_emu10k1_init_stereo_onoff_control(controls + i++, SNDRV_CTL_NAME_IEC958("Coaxial ",CAPTURE,SWITCH), gpr + 2, 0);
 		gpr += 4;
 	}
-	
+
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_LINE2_L)|(1<<EXTIN_LINE2_R))) {
 		/* Line LiveDrive Playback Volume */
 		for (z = 0; z < 2; z++)
@@ -2109,7 +2109,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		snd_emu10k1_init_stereo_control(controls + i++, "Line2 LiveDrive Playback Volume", gpr, 0);
 		controls[i-1].id.index = 1;
 		gpr += 2;
-	
+
 		/* Line LiveDrive Capture Volume */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_LINE2_L + z, gpr + 2 + z);
@@ -2249,7 +2249,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 
 		gpr += 4;
 	}
-	
+
 	if (emu->fx8010.extout_mask & ((1<<EXTOUT_REAR_L)|(1<<EXTOUT_REAR_R)))
 		for (z = 0; z < 2; z++)
 			OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_REAR_L + z), GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000, C_00000000);
@@ -2277,12 +2277,12 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_ALFE), GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 1), C_00000000, C_00000000);
 #endif
 	}
-	
+
 #ifndef EMU10K1_CAPTURE_DIGITAL_OUT
 	for (z = 0; z < 2; z++)
  		OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_ADC_CAP_L + z), GPR(capture + z), C_00000000, C_00000000);
 #endif
-	
+
 	if (emu->fx8010.extout_mask & (1<<EXTOUT_MIC_CAP))
 		OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_MIC_CAP), GPR(capture + 2), C_00000000, C_00000000);
 
@@ -2291,10 +2291,10 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		/* On the Live! 5.1, FXBUS2(1) and FXBUS(2) are shared with EXTOUT_ACENTER
 		 * and EXTOUT_ALFE, so we can't connect inputs to them for multitrack recording.
 		 *
-		 * Since only 14 of the 16 EXTINs are used, this is not a big problem.  
-		 * We route AC97L and R to FX capture 14 and 15, SPDIF CD in to FX capture 
-		 * 0 and 3, then the rest of the EXTINs to the corresponding FX capture 
-		 * channel.  Multitrack recorders will still see the center/lfe output signal 
+		 * Since only 14 of the 16 EXTINs are used, this is not a big problem.
+		 * We route AC97L and R to FX capture 14 and 15, SPDIF CD in to FX capture
+		 * 0 and 3, then the rest of the EXTINs to the corresponding FX capture
+		 * channel.  Multitrack recorders will still see the center/lfe output signal
 		 * on the second and third channels.
 		 */
 		OP(icode, &ptr, iACC3, FXBUS2(14), C_00000000, C_00000000, EXTIN(0));
@@ -2307,7 +2307,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		for (z = 0; z < 16; z++)
 			OP(icode, &ptr, iACC3, FXBUS2(z), C_00000000, C_00000000, EXTIN(z));
 	}
-	    
+
 
 	if (gpr > tmp) {
 		snd_BUG();
@@ -2319,7 +2319,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 		err = -EIO;
 		goto __err;
 	}
-	
+
 	/* clear remaining instruction memory */
 	while (ptr < 0x200)
 		OP(icode, &ptr, iACC3, C_00000000, C_00000000, C_00000000, C_00000000);
@@ -2335,7 +2335,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 	snd_leave_user(seg);
 	if (err >= 0)
 		err = snd_emu10k1_ipcm_poke(emu, ipcm);
-      __err:
+__err:
 	kfree(ipcm);
 	kfree(controls);
 	if (icode != NULL) {
@@ -2471,7 +2471,7 @@ static int snd_emu10k1_fx8010_ioctl(struct snd_hwdep * hw, struct file *file, un
 	unsigned int addr;
 	void __user *argp = (void __user *)arg;
 	int res;
-	
+
 	switch (cmd) {
 	case SNDRV_EMU10K1_IOCTL_PVERSION:
 		emu->support_tlv = 1;
@@ -2617,7 +2617,7 @@ int __devinit snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device, struct
 {
 	struct snd_hwdep *hw;
 	int err;
-	
+
 	if (rhwdep)
 		*rhwdep = NULL;
 	if ((err = snd_hwdep_new(emu->card, "FX8010", device, &hw)) < 0)
@@ -2640,16 +2640,16 @@ int __devinit snd_emu10k1_efx_alloc_pm_buffer(struct snd_emu10k1 *emu)
 
 	len = emu->audigy ? 0x200 : 0x100;
 	emu->saved_gpr = kmalloc(len * 4, GFP_KERNEL);
-	if (! emu->saved_gpr)
+	if (!emu->saved_gpr)
 		return -ENOMEM;
 	len = emu->audigy ? 0x100 : 0xa0;
 	emu->tram_val_saved = kmalloc(len * 4, GFP_KERNEL);
 	emu->tram_addr_saved = kmalloc(len * 4, GFP_KERNEL);
-	if (! emu->tram_val_saved || ! emu->tram_addr_saved)
+	if (!emu->tram_val_saved || ! emu->tram_addr_saved)
 		return -ENOMEM;
 	len = emu->audigy ? 2 * 1024 : 2 * 512;
 	emu->saved_icode = vmalloc(len * 4);
-	if (! emu->saved_icode)
+	if (!emu->saved_icode)
 		return -ENOMEM;
 	return 0;
 }
@@ -2721,7 +2721,7 @@ void snd_emu10k1_efx_resume(struct snd_emu10k1 *emu)
 	for (i = 0; i < len; i++) {
 		snd_emu10k1_ptr_write(emu, TANKMEMDATAREGBASE + i, 0,
 				      emu->tram_val_saved[i]);
-		if (! emu->audigy)
+		if (!emu->audigy)
 			snd_emu10k1_ptr_write(emu, TANKMEMADDRREGBASE + i, 0,
 					      emu->tram_addr_saved[i]);
 		else {
diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index f34bbfb..a1366e0 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -83,7 +83,7 @@ static int snd_emu10k1_spdif_get_mask(struct snd_kcontrol *kcontrol,
  * Items labels in enum mixer controls assigning source data to
  * each destination
  */
-static char *emu1010_src_texts[] = { 
+static char *emu1010_src_texts[] = {
 	"Silence",
 	"Dock Mic A",
 	"Dock Mic B",
@@ -615,12 +615,12 @@ static int snd_emu1010_adc_pads_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	unsigned int val, cache;
 	val = ucontrol->value.integer.value[0];
 	cache = emu->emu1010.adc_pads;
-	if (val == 1) 
+	if (val == 1)
 		cache = cache | mask;
 	else
 		cache = cache & ~mask;
 	if (cache != emu->emu1010.adc_pads) {
-		snd_emu1010_fpga_write(emu, EMU_HANA_ADC_PADS, cache );
+		snd_emu1010_fpga_write(emu, EMU_HANA_ADC_PADS, cache);
 	        emu->emu1010.adc_pads = cache;
 	}
 
@@ -663,12 +663,12 @@ static int snd_emu1010_dac_pads_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	unsigned int val, cache;
 	val = ucontrol->value.integer.value[0];
 	cache = emu->emu1010.dac_pads;
-	if (val == 1) 
+	if (val == 1)
 		cache = cache | mask;
 	else
 		cache = cache & ~mask;
 	if (cache != emu->emu1010.dac_pads) {
-		snd_emu1010_fpga_write(emu, EMU_HANA_DAC_PADS, cache );
+		snd_emu1010_fpga_write(emu, EMU_HANA_DAC_PADS, cache);
 	        emu->emu1010.dac_pads = cache;
 	}
 
@@ -702,7 +702,7 @@ static int snd_emu1010_internal_clock_info(struct snd_kcontrol *kcontrol,
 	static char *texts[4] = {
 		"44100", "48000", "SPDIF", "ADAT"
 	};
-		
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 4;
@@ -710,8 +710,8 @@ static int snd_emu1010_internal_clock_info(struct snd_kcontrol *kcontrol,
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
 	return 0;
-	
-	
+
+
 }
 
 static int snd_emu1010_internal_clock_get(struct snd_kcontrol *kcontrol,
@@ -730,7 +730,7 @@ static int snd_emu1010_internal_clock_put(struct snd_kcontrol *kcontrol,
 	unsigned int val;
 	int change = 0;
 
-	val = ucontrol->value.enumerated.item[0] ;
+	val = ucontrol->value.enumerated.item[0];
 	/* Limit: uinfo->value.enumerated.items = 4; */
 	if (val >= 4)
 		return -EINVAL;
@@ -741,75 +741,75 @@ static int snd_emu1010_internal_clock_put(struct snd_kcontrol *kcontrol,
 		case 0:
 			/* 44100 */
 			/* Mute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE );
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE);
 			/* Default fallback clock 48kHz */
-			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_44_1K );
+			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_44_1K);
 			/* Word Clock source, Internal 44.1kHz x1 */
 			snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK,
-			EMU_HANA_WCLOCK_INT_44_1K | EMU_HANA_WCLOCK_1X );
+			EMU_HANA_WCLOCK_INT_44_1K | EMU_HANA_WCLOCK_1X);
 			/* Set LEDs on Audio Dock */
 			snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2,
-				EMU_HANA_DOCK_LEDS_2_44K | EMU_HANA_DOCK_LEDS_2_LOCK );
+				EMU_HANA_DOCK_LEDS_2_44K | EMU_HANA_DOCK_LEDS_2_LOCK);
 			/* Allow DLL to settle */
 			msleep(10);
 			/* Unmute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE );
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
 			break;
 		case 1:
 			/* 48000 */
 			/* Mute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE );
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE);
 			/* Default fallback clock 48kHz */
-			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_48K );
+			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_48K);
 			/* Word Clock source, Internal 48kHz x1 */
 			snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK,
-				EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_1X );
+				EMU_HANA_WCLOCK_INT_48K | EMU_HANA_WCLOCK_1X);
 			/* Set LEDs on Audio Dock */
 			snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2,
-				EMU_HANA_DOCK_LEDS_2_48K | EMU_HANA_DOCK_LEDS_2_LOCK );
+				EMU_HANA_DOCK_LEDS_2_48K | EMU_HANA_DOCK_LEDS_2_LOCK);
 			/* Allow DLL to settle */
 			msleep(10);
 			/* Unmute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE );
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
 			break;
-			
+
 		case 2: /* Take clock from S/PDIF IN */
 			/* Mute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE );
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE);
 			/* Default fallback clock 48kHz */
-			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_48K );
+			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_48K);
 			/* Word Clock source, sync to S/PDIF input */
 			snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK,
-				EMU_HANA_WCLOCK_HANA_SPDIF_IN | EMU_HANA_WCLOCK_1X );
+				EMU_HANA_WCLOCK_HANA_SPDIF_IN | EMU_HANA_WCLOCK_1X);
 			/* Set LEDs on Audio Dock */
 			snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2,
-				EMU_HANA_DOCK_LEDS_2_EXT | EMU_HANA_DOCK_LEDS_2_LOCK );
-			/* FIXME: We should set EMU_HANA_DOCK_LEDS_2_LOCK only when clock signal is present and valid */	
+				EMU_HANA_DOCK_LEDS_2_EXT | EMU_HANA_DOCK_LEDS_2_LOCK);
+			/* FIXME: We should set EMU_HANA_DOCK_LEDS_2_LOCK only when clock signal is present and valid */
 			/* Allow DLL to settle */
 			msleep(10);
 			/* Unmute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE );
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
 			break;
-		
-		case 3: 			
+
+		case 3:
 			/* Take clock from ADAT IN */
 			/* Mute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE );
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_MUTE);
 			/* Default fallback clock 48kHz */
-			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_48K );
+			snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, EMU_HANA_DEFCLOCK_48K);
 			/* Word Clock source, sync to ADAT input */
 			snd_emu1010_fpga_write(emu, EMU_HANA_WCLOCK,
-				EMU_HANA_WCLOCK_HANA_ADAT_IN | EMU_HANA_WCLOCK_1X );
+				EMU_HANA_WCLOCK_HANA_ADAT_IN | EMU_HANA_WCLOCK_1X);
 			/* Set LEDs on Audio Dock */
-			snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, EMU_HANA_DOCK_LEDS_2_EXT | EMU_HANA_DOCK_LEDS_2_LOCK );
-			/* FIXME: We should set EMU_HANA_DOCK_LEDS_2_LOCK only when clock signal is present and valid */	
+			snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_LEDS_2, EMU_HANA_DOCK_LEDS_2_EXT | EMU_HANA_DOCK_LEDS_2_LOCK);
+			/* FIXME: We should set EMU_HANA_DOCK_LEDS_2_LOCK only when clock signal is present and valid */
 			/* Allow DLL to settle */
 			msleep(10);
 			/*   Unmute all */
-			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE );
-			 
-			
-			break;		
+			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
+
+
+			break;
 		}
 	}
         return change;
@@ -958,7 +958,7 @@ static int snd_audigy_i2c_volume_put(struct snd_kcontrol *kcontrol,
 		return 0;
 	if (ogain != ngain) {
 		if (emu->i2c_capture_source == source_id)
-			snd_emu10k1_i2c_write(emu, ADC_ATTEN_ADCL, ((ngain) & 0xff) );
+			snd_emu10k1_i2c_write(emu, ADC_ATTEN_ADCL, ((ngain) & 0xff));
 		emu->i2c_capture_volume[source_id][0] = ngain;
 		change = 1;
 	}
@@ -1014,7 +1014,7 @@ static int snd_audigy_spdif_output_rate_get(struct snd_kcontrol *kcontrol,
 	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int tmp;
 	unsigned long flags;
-	
+
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
@@ -1058,7 +1058,7 @@ static int snd_audigy_spdif_output_rate_put(struct snd_kcontrol *kcontrol,
 		break;
 	}
 
-	
+
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	reg = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
 	tmp = reg & ~A_SPDIF_RATE_MASK;
@@ -1182,7 +1182,7 @@ static int snd_emu10k1_send_routing_get(struct snd_kcontrol *kcontrol,
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (voice = 0; voice < 3; voice++)
 		for (idx = 0; idx < num_efx; idx++)
-			ucontrol->value.integer.value[(voice * num_efx) + idx] = 
+			ucontrol->value.integer.value[(voice * num_efx) + idx] =
 				mix->send_routing[voice][idx] & mask;
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return 0;
@@ -1207,7 +1207,7 @@ static int snd_emu10k1_send_routing_put(struct snd_kcontrol *kcontrol,
 				mix->send_routing[voice][idx] = val;
 				change = 1;
 			}
-		}	
+		}
 	if (change && mix->epcm) {
 		if (mix->epcm->voices[0] && mix->epcm->voices[1]) {
 			update_emu10k1_fxrt(emu, mix->epcm->voices[0]->number,
@@ -1395,7 +1395,7 @@ static int snd_emu10k1_efx_send_routing_get(struct snd_kcontrol *kcontrol,
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (idx = 0; idx < num_efx; idx++)
-		ucontrol->value.integer.value[idx] = 
+		ucontrol->value.integer.value[idx] =
 			mix->send_routing[0][idx] & mask;
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return 0;
@@ -1419,7 +1419,7 @@ static int snd_emu10k1_efx_send_routing_put(struct snd_kcontrol *kcontrol,
 			mix->send_routing[0][idx] = val;
 			change = 1;
 		}
-	}	
+	}
 
 	if (change && mix->epcm) {
 		if (mix->epcm->voices[ch]) {
@@ -1581,7 +1581,7 @@ static int snd_emu10k1_shared_spdif_get(struct snd_kcontrol *kcontrol,
 	if (emu->card_capabilities->invert_shared_spdif)
 		ucontrol->value.integer.value[0] =
 			!ucontrol->value.integer.value[0];
-		
+
 	return 0;
 }
 
@@ -1597,7 +1597,7 @@ static int snd_emu10k1_shared_spdif_put(struct snd_kcontrol *kcontrol,
 	if (emu->card_capabilities->invert_shared_spdif)
 		sw = !sw;
 	spin_lock_irqsave(&emu->reg_lock, flags);
-	if ( emu->card_capabilities->i2c_adc) {
+	if (emu->card_capabilities->i2c_adc) {
 		/* Do nothing for Audigy 2 ZS Notebook */
 	} else if (emu->audigy) {
 		reg = inl(emu->port + A_IOCFG);
@@ -1738,7 +1738,7 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		NULL
 	};
 	static char *audigy_rename_ctls_i2c_adc[] = {
-		//"Analog Mix Capture Volume","OLD Analog Mix Capture Volume",
+		/*"Analog Mix Capture Volume","OLD Analog Mix Capture Volume", */
 		"Line Capture Volume", "Analog Mix Capture Volume",
 		"Wave Playback Volume", "OLD PCM Playback Volume",
 		"Wave Master Playback Volume", "Master Playback Volume",
@@ -1808,7 +1808,7 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		if ((err = snd_ac97_bus(emu->card, 0, &ops, NULL, &pbus)) < 0)
 			return err;
 		pbus->no_vra = 1; /* we don't need VRA */
-		
+
 		memset(&ac97, 0, sizeof(ac97));
 		ac97.private_data = emu;
 		ac97.private_free = snd_emu10k1_mixer_free_ac97;
@@ -1828,7 +1828,7 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 			snd_ac97_write_cache(emu->ac97, AC97_REC_SEL, 0x0000);
 			if (emu->card_capabilities->adc_1361t)
 				c = audigy_remove_ctls_1361t_adc;
-			else 
+			else
 				c = audigy_remove_ctls;
 		} else {
 			/*
@@ -1906,13 +1906,13 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 	kctl->id.device = multi_device;
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
-	
+
 	if ((kctl = emu->ctl_efx_send_volume = snd_ctl_new1(&snd_emu10k1_efx_send_volume_control, emu)) == NULL)
 		return -ENOMEM;
 	kctl->id.device = multi_device;
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
-	
+
 	if ((kctl = emu->ctl_efx_attn = snd_ctl_new1(&snd_emu10k1_efx_attn_control, emu)) == NULL)
 		return -ENOMEM;
 	kctl->id.device = multi_device;
@@ -1923,27 +1923,27 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 	for (pcm = 0; pcm < 32; pcm++) {
 		struct snd_emu10k1_pcm_mixer *mix;
 		int v;
-		
+
 		mix = &emu->pcm_mixer[pcm];
 		mix->epcm = NULL;
 
 		for (v = 0; v < 4; v++)
-			mix->send_routing[0][v] = 
-				mix->send_routing[1][v] = 
+			mix->send_routing[0][v] =
+				mix->send_routing[1][v] =
 				mix->send_routing[2][v] = v;
-		
+
 		memset(&mix->send_volume, 0, sizeof(mix->send_volume));
 		mix->send_volume[0][0] = mix->send_volume[0][1] =
 		mix->send_volume[1][0] = mix->send_volume[2][1] = 255;
-		
+
 		mix->attn[0] = mix->attn[1] = mix->attn[2] = 0xffff;
 	}
-	
+
 	/* initialize the routing and volume table for the multichannel playback stream */
 	for (pcm = 0; pcm < NUM_EFX_PLAYBACK; pcm++) {
 		struct snd_emu10k1_pcm_mixer *mix;
 		int v;
-		
+
 		mix = &emu->efx_pcm_mixer[pcm];
 		mix->epcm = NULL;
 
@@ -1954,14 +1954,14 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		if (emu->audigy)
 			for (v = 0; v < 4; v++)
 				mix->send_routing[0][4+v] = 60+v;
-		
+
 		memset(&mix->send_volume, 0, sizeof(mix->send_volume));
 		mix->send_volume[0][0]  = 255;
-		
+
 		mix->attn[0] = 0xffff;
 	}
-	
-	if (! emu->card_capabilities->ecard) { /* FIXME: APS has these controls? */
+
+	if (!emu->card_capabilities->ecard) { /* FIXME: APS has these controls? */
 		/* sb live! and audigy */
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_mask_control, emu)) == NULL)
 			return -ENOMEM;
@@ -1990,7 +1990,7 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		if ((err = snd_ctl_add(card, kctl)))
 			return err;
 #endif
-	} else if (! emu->card_capabilities->ecard) {
+	} else if (!emu->card_capabilities->ecard) {
 		/* sb live! */
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_shared_spdif, emu)) == NULL)
 			return -ENOMEM;
@@ -2073,7 +2073,7 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 			return err;
 	}
 
-	if ( emu->card_capabilities->i2c_adc) {
+	if (emu->card_capabilities->i2c_adc) {
 		int i;
 
 		err = snd_ctl_add(card, snd_ctl_new1(&snd_audigy_i2c_capture_source, emu));
@@ -2086,6 +2086,6 @@ int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 				return err;
 		}
 	}
-		
+
 	return 0;
 }
diff --git a/sound/pci/emu10k1/emumpu401.c b/sound/pci/emu10k1/emumpu401.c
index 8578c70..18495b4 100644
--- a/sound/pci/emu10k1/emumpu401.c
+++ b/sound/pci/emu10k1/emumpu401.c
@@ -277,7 +277,7 @@ static void snd_emu10k1_midi_output_trigger(struct snd_rawmidi_substream *substr
 	if (up) {
 		int max = 4;
 		unsigned char byte;
-	
+
 		/* try to send some amount of bytes here before interrupts */
 		spin_lock_irqsave(&midi->output_lock, flags);
 		while (max > 0) {
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index cf9276d..f9144dc 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -86,7 +86,7 @@ static void snd_emu10k1_pcm_efx_interrupt(struct snd_emu10k1 *emu,
 	}
 #endif
 	snd_pcm_period_elapsed(emu->pcm_capture_efx_substream);
-}	 
+}
 
 static snd_pcm_uframes_t snd_emu10k1_efx_playback_pointer(struct snd_pcm_substream *substream)
 {
@@ -130,7 +130,7 @@ static int snd_emu10k1_pcm_channel_alloc(struct snd_emu10k1_pcm * epcm, int voic
 				      epcm->type == PLAYBACK_EMUVOICE ? EMU10K1_PCM : EMU10K1_EFX,
 				      voices,
 				      &epcm->voices[0]);
-	
+
 	if (err < 0)
 		return err;
 	epcm->voices[0]->epcm = epcm;
@@ -253,12 +253,12 @@ static unsigned int emu10k1_select_interprom(unsigned int pitch_target)
 		return CCCA_INTERPROM_4;
 	else if (pitch_target >= PITCH_57081)
 		return CCCA_INTERPROM_3;
-	else  
+	else
 		return CCCA_INTERPROM_2;
 }
 
 /*
- * calculate cache invalidate size 
+ * calculate cache invalidate size
  *
  * stereo: channel is stereo
  * w_16: using 16bit samples
@@ -323,7 +323,7 @@ static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1 *emu,
 	}
 
 	ccis = emu10k1_ccis(stereo, w_16);
-	
+
 	if (master) {
 		evoice->epcm->ccca_start_addr = start_addr + ccis;
 		if (extra) {
@@ -359,7 +359,7 @@ static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1 *emu,
 	snd_emu10k1_ptr_write(emu, PSST, voice, start_addr | (send_amount[2] << 24));
 	if (emu->card_capabilities->emu_model)
 		pitch_target = PITCH_48000; /* Disable interpolators on emu1010 card */
-	else 
+	else
 		pitch_target = emu10k1_calc_pitch_target(runtime->rate);
 	if (extra)
 		snd_emu10k1_ptr_write(emu, CCCA, voice, start_addr |
@@ -416,7 +416,7 @@ static int snd_emu10k1_playback_hw_params(struct snd_pcm_substream *substream,
 			snd_emu10k1_free_pages(emu, epcm->memblk);
 		epcm->memblk = snd_emu10k1_alloc_pages(emu, substream);
 		epcm->start_addr = 0;
-		if (! epcm->memblk)
+		if (!epcm->memblk)
 			return -ENOMEM;
 		mapped = ((struct snd_emu10k1_memblk *)epcm->memblk)->mapped_page;
 		if (mapped < 0)
@@ -602,7 +602,7 @@ static int snd_emu10k1_capture_prepare(struct snd_pcm_substream *substream)
 		break;
 	default:
 		break;
-	}	
+	}
 	snd_emu10k1_ptr_write(emu, epcm->capture_ba_reg, 0, runtime->dma_addr);
 	epcm->capture_bufsize = snd_pcm_lib_buffer_bytes(substream);
 	epcm->capture_bs_val = 0;
@@ -685,7 +685,7 @@ static void snd_emu10k1_playback_prepare_voice(struct snd_emu10k1 *emu, struct s
 	snd_emu10k1_ptr_write(emu, CVCF, voice, vattn | 0xffff);
 	snd_emu10k1_ptr_write(emu, DCYSUSV, voice, 0x7f7f);
 	snd_emu10k1_voice_clear_loop_stop(emu, voice);
-}	
+}
 
 static void snd_emu10k1_playback_trigger_voice(struct snd_emu10k1 *emu, struct snd_emu10k1_voice *evoice, int master, int extra)
 {
@@ -702,7 +702,7 @@ static void snd_emu10k1_playback_trigger_voice(struct snd_emu10k1 *emu, struct s
 	pitch = snd_emu10k1_rate_to_pitch(runtime->rate) >> 8;
 	if (emu->card_capabilities->emu_model)
 		pitch_target = PITCH_48000; /* Disable interpolators on emu1010 card */
-	else 
+	else
 		pitch_target = emu10k1_calc_pitch_target(runtime->rate);
 	snd_emu10k1_ptr_write(emu, PTRX_PITCHTARGET, voice, pitch_target);
 	if (master || evoice->epcm->type == PLAYBACK_EFX)
@@ -799,7 +799,7 @@ static int snd_emu10k1_capture_trigger(struct snd_pcm_substream *substream,
 			} else
 				snd_emu10k1_ptr_write(emu, FXWC, 0, epcm->capture_cr_val);
 			break;
-		default:	
+		default:
 			break;
 		}
 		snd_emu10k1_ptr_write(emu, epcm->capture_bs_reg, 0, epcm->capture_bs_val);
@@ -875,7 +875,7 @@ static int snd_emu10k1_efx_playback_trigger(struct snd_pcm_substream *substream,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* prepare voices */
-		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {
 			snd_emu10k1_playback_invalidate_cache(emu, 0, epcm->voices[i]);
 		}
 		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);
@@ -899,7 +899,7 @@ static int snd_emu10k1_efx_playback_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		epcm->running = 0;
-		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {
 			snd_emu10k1_playback_stop_voice(emu, epcm->voices[i]);
 		}
 		snd_emu10k1_playback_stop_voice(emu, epcm->extra);
@@ -985,8 +985,8 @@ static struct snd_pcm_hardware snd_emu10k1_capture_efx =
 				 SNDRV_PCM_INFO_RESUME |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | 
-				 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | 
+	.rates =		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
 				 SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
 	.rate_min =		44100,
 	.rate_max =		192000,
@@ -1008,7 +1008,7 @@ static void snd_emu10k1_pcm_mixer_notify1(struct snd_emu10k1 *emu, struct snd_kc
 {
 	struct snd_ctl_elem_id id;
 
-	if (! kctl)
+	if (!kctl)
 		return;
 	if (activate)
 		kctl->vd[idx].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
@@ -1066,13 +1066,13 @@ static int snd_emu10k1_efx_playback_open(struct snd_pcm_substream *substream)
 	epcm->emu = emu;
 	epcm->type = PLAYBACK_EFX;
 	epcm->substream = substream;
-	
+
 	emu->pcm_playback_efx_substream = substream;
 
 	runtime->private_data = epcm;
 	runtime->private_free = snd_emu10k1_pcm_free_substream;
 	runtime->hw = snd_emu10k1_efx_playback;
-	
+
 	for (i = 0; i < NUM_EFX_PLAYBACK; i++) {
 		mix = &emu->efx_pcm_mixer[i];
 		mix->send_routing[0][0] = i;
@@ -1243,7 +1243,7 @@ static int snd_emu10k1_capture_efx_open(struct snd_pcm_substream *substream)
 		 * channels_min = 16,
 		 * channels_max = 16,
 		 * Need to add mixer control to fix sample rate
-		 *                 
+		 *
 		 * There are 32 mono channels of 16bits each.
 		 * 24bit Audio uses 2x channels over 16bit
 		 * 96kHz uses 2x channels over 48kHz
@@ -1470,7 +1470,7 @@ static int snd_emu10k1_pcm_efx_voices_mask_get(struct snd_kcontrol *kcontrol, st
 	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
 	int nefx = emu->audigy ? 64 : 32;
 	int idx;
-	
+
 	spin_lock_irq(&emu->reg_lock);
 	for (idx = 0; idx < nefx; idx++)
 		ucontrol->value.integer.value[idx] = (emu->efx_voices_mask[idx / 32] & (1 << (idx % 32))) ? 1 : 0;
@@ -1485,18 +1485,18 @@ static int snd_emu10k1_pcm_efx_voices_mask_put(struct snd_kcontrol *kcontrol, st
 	int nefx = emu->audigy ? 64 : 32;
 	int nefxb = emu->audigy ? 7 : 6;
 	int change, idx;
-	
+
 	nval[0] = nval[1] = 0;
 	for (idx = 0, bits = 0; idx < nefx; idx++)
 		if (ucontrol->value.integer.value[idx]) {
 			nval[idx / 32] |= 1 << (idx % 32);
 			bits++;
 		}
-		
+
 	for (idx = 0; idx < nefxb; idx++)
 		if (1 << idx == bits)
 			break;
-	
+
 	if (idx >= nefxb)
 		return -EINVAL;
 
@@ -1622,7 +1622,7 @@ static int snd_emu10k1_fx8010_playback_prepare(struct snd_pcm_substream *substre
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_emu10k1_fx8010_pcm *pcm = &emu->fx8010.pcm[substream->number];
 	unsigned int i;
-	
+
 	/* printk("prepare: etram_pages = 0x%p, dma_area = 0x%x, buffer_size = 0x%x (0x%x)\n", emu->fx8010.etram_pages, runtime->dma_area, runtime->buffer_size, runtime->buffer_size << 2); */
 	memset(&pcm->pcm_rec, 0, sizeof(pcm->pcm_rec));
 	pcm->pcm_rec.hw_buffer_size = pcm->buffer_size * 2; /* byte size */
@@ -1682,7 +1682,7 @@ static int snd_emu10k1_fx8010_playback_trigger(struct snd_pcm_substream *substre
 		result = -EINVAL;
 		break;
 	}
-      __err:
+__err:
 	spin_unlock(&emu->reg_lock);
 	return result;
 }
@@ -1783,10 +1783,10 @@ int __devinit snd_emu10k1_pcm_efx(struct snd_emu10k1 * emu, int device, struct s
 	if (rpcm)
 		*rpcm = pcm;
 
-	/* EFX capture - record the "FXBUS2" channels, by default we connect the EXTINs 
+	/* EFX capture - record the "FXBUS2" channels, by default we connect the EXTINs
 	 * to these
-	 */	
-	
+	 */
+
 	/* emu->efx_voices_mask[0] = FXWC_DEFAULTROUTE_C | FXWC_DEFAULTROUTE_A; */
 	if (emu->audigy) {
 		emu->efx_voices_mask[0] = 0;
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index 216f974..012c0c3 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -46,7 +46,7 @@ static void snd_emu10k1_proc_spdif_status(struct snd_emu10k1 * emu,
 	static char *channel[16] = { "unspec", "left", "right", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15" };
 	static char *emphasis[8] = { "none", "50/15 usec 2 channel", "2", "3", "4", "5", "6", "7" };
 	unsigned int status, rate = 0;
-	
+
 	status = snd_emu10k1_ptr_read(emu, status_reg, 0);
 
 	snd_iprintf(buffer, "\n%s\n", title);
@@ -70,7 +70,7 @@ static void snd_emu10k1_proc_spdif_status(struct snd_emu10k1 * emu,
 			snd_iprintf(buffer, "S/PDIF Locked         : %s\n", rate & SRCS_SPDIFLOCKED ? "on" : "off");
 			snd_iprintf(buffer, "Rate Locked           : %s\n", rate & SRCS_RATELOCKED ? "on" : "off");
 			/* From ((Rate * 48000 ) / 262144); */
-			snd_iprintf(buffer, "Estimated Sample Rate : %d\n", ((rate & 0xFFFFF ) * 375) >> 11); 
+			snd_iprintf(buffer, "Estimated Sample Rate : %d\n", ((rate & 0xFFFFF ) * 375) >> 11);
 		}
 	} else {
 		snd_iprintf(buffer, "No signal detected.\n");
@@ -78,7 +78,7 @@ static void snd_emu10k1_proc_spdif_status(struct snd_emu10k1 * emu,
 
 }
 
-static void snd_emu10k1_proc_read(struct snd_info_entry *entry, 
+static void snd_emu10k1_proc_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	/* FIXME - output names are in emufx.c too */
@@ -189,7 +189,7 @@ static void snd_emu10k1_proc_read(struct snd_info_entry *entry,
 	int nefx = emu->audigy ? 64 : 32;
 	char **outputs = emu->audigy ? audigy_outs : creative_outs;
 	int idx;
-	
+
 	snd_iprintf(buffer, "EMU10K1\n\n");
 	snd_iprintf(buffer, "Card                  : %s\n",
 		    emu->audigy ? "Audigy" : (emu->card_capabilities->ecard ? "EMU APS" : "Creative"));
@@ -235,7 +235,7 @@ static void snd_emu10k1_proc_read(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "  Output %02i [%s]\n", idx, outputs[idx]);
 }
 
-static void snd_emu10k1_proc_spdif_read(struct snd_info_entry *entry, 
+static void snd_emu10k1_proc_spdif_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct snd_emu10k1 *emu = entry->private_data;
@@ -253,7 +253,7 @@ static void snd_emu10k1_proc_spdif_read(struct snd_info_entry *entry,
 			snd_emu1010_fpga_read(emu, 0x2a, &value);
 			snd_emu1010_fpga_read(emu, 0x2b, &value2);
 			spin_unlock_irqrestore(&emu->emu_lock, flags);
-			rate = 0x1770000 / (((value << 5) | value2)+1);	
+			rate = 0x1770000 / (((value << 5) | value2)+1);
 			snd_iprintf(buffer, "ADAT Locked : %u\n", rate);
 		} else {
 			snd_iprintf(buffer, "ADAT Unlocked\n");
@@ -266,7 +266,7 @@ static void snd_emu10k1_proc_spdif_read(struct snd_info_entry *entry,
 			snd_emu1010_fpga_read(emu, 0x28, &value);
 			snd_emu1010_fpga_read(emu, 0x29, &value2);
 			spin_unlock_irqrestore(&emu->emu_lock, flags);
-			rate = 0x1770000 / (((value << 5) | value2)+1);	
+			rate = 0x1770000 / (((value << 5) | value2)+1);
 			snd_iprintf(buffer, "SPDIF Locked : %d\n", rate);
 		} else {
 			snd_iprintf(buffer, "SPDIF Unlocked\n");
@@ -283,7 +283,7 @@ static void snd_emu10k1_proc_spdif_read(struct snd_info_entry *entry,
 #endif
 }
 
-static void snd_emu10k1_proc_rates_read(struct snd_info_entry *entry, 
+static void snd_emu10k1_proc_rates_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	static int samplerate[8] = { 44100, 48000, 96000, 192000, 4, 5, 6, 7 };
@@ -298,7 +298,7 @@ static void snd_emu10k1_proc_rates_read(struct snd_info_entry *entry,
 	}
 }
 
-static void snd_emu10k1_proc_acode_read(struct snd_info_entry *entry, 
+static void snd_emu10k1_proc_acode_read(struct snd_info_entry *entry,
 				        struct snd_info_buffer *buffer)
 {
 	u32 pc;
@@ -308,7 +308,7 @@ static void snd_emu10k1_proc_acode_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "  Code dump      :\n");
 	for (pc = 0; pc < (emu->audigy ? 1024 : 512); pc++) {
 		u32 low, high;
-			
+
 		low = snd_emu10k1_efx_read(emu, pc * 2);
 		high = snd_emu10k1_efx_read(emu, pc * 2 + 1);
 		if (emu->audigy)
@@ -350,7 +350,7 @@ static long snd_emu10k1_fx8010_read(struct snd_info_entry *entry,
 	struct snd_emu10k1 *emu = entry->private_data;
 	unsigned int offset;
 	int tram_addr = 0;
-	
+
 	if (!strcmp(entry->name, "fx8010_tram_addr")) {
 		offset = TANKMEMADDRREGBASE;
 		tram_addr = 1;
@@ -374,7 +374,7 @@ static long snd_emu10k1_fx8010_read(struct snd_info_entry *entry,
 			if (tram_addr && emu->audigy) {
 				tmp[idx] = snd_emu10k1_ptr_read(emu, offset + idx + (pos >> 2), 0) >> 11;
 				tmp[idx] |= snd_emu10k1_ptr_read(emu, 0x100 + idx + (pos >> 2), 0) << 20;
-			} else 
+			} else
 				tmp[idx] = snd_emu10k1_ptr_read(emu, offset + idx + (pos >> 2), 0);
 		if (copy_to_user(buf, ((char *)tmp) + (pos & 3), size))
 			res = -EFAULT;
@@ -387,13 +387,13 @@ static long snd_emu10k1_fx8010_read(struct snd_info_entry *entry,
 	return 0;
 }
 
-static void snd_emu10k1_proc_voices_read(struct snd_info_entry *entry, 
+static void snd_emu10k1_proc_voices_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct snd_emu10k1 *emu = entry->private_data;
 	struct snd_emu10k1_voice *voice;
 	int idx;
-	
+
 	snd_iprintf(buffer, "ch\tuse\tpcm\tefx\tsynth\tmidi\n");
 	for (idx = 0; idx < NUM_G; idx++) {
 		voice = &emu->voices[idx];
@@ -417,7 +417,7 @@ static void snd_emu_proc_emu1010_reg_read(struct snd_info_entry *entry,
 	int i;
 	snd_iprintf(buffer, "EMU1010 Registers:\n\n");
 
-	for(i = 0; i < 0x40; i+=1) {
+	for (i = 0; i < 0x40; i++) {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		snd_emu1010_fpga_read(emu, i, &value);
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
@@ -433,7 +433,7 @@ static void snd_emu_proc_io_reg_read(struct snd_info_entry *entry,
 	unsigned long flags;
 	int i;
 	snd_iprintf(buffer, "IO Registers:\n\n");
-	for(i = 0; i < 0x40; i+=4) {
+	for (i = 0; i < 0x40; i += 4) {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		value = inl(emu->port + i);
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
@@ -451,7 +451,7 @@ static void snd_emu_proc_io_reg_write(struct snd_info_entry *entry,
 	while (!snd_info_get_line(buffer, line, sizeof(line))) {
 		if (sscanf(line, "%x %x", &reg, &val) != 2)
 			continue;
-		if ((reg < 0x40) && (reg >= 0) && (val <= 0xffffffff) ) {
+		if ((reg < 0x40) && (reg >= 0) && (val <= 0xffffffff)) {
 			spin_lock_irqsave(&emu->emu_lock, flags);
 			outl(val, emu->port + (reg & 0xfffffffc));
 			spin_unlock_irqrestore(&emu->emu_lock, flags);
@@ -505,10 +505,10 @@ static void snd_emu_proc_ptr_reg_read(struct snd_info_entry *entry,
 		return;
 	}
 	snd_iprintf(buffer, "Registers 0x%x\n", iobase);
-	for(i = offset; i < offset+length; i++) {
+	for (i = offset; i < offset+length; i++) {
 		snd_iprintf(buffer, "%02X: ",i);
 		for (j = 0; j < voices; j++) {
-			if(iobase == 0)
+			if (iobase == 0)
                 		value = snd_ptr_read(emu, 0, i, j);
 			else
                 		value = snd_ptr_read(emu, 0x20, i, j);
@@ -527,7 +527,7 @@ static void snd_emu_proc_ptr_reg_write(struct snd_info_entry *entry,
 	while (!snd_info_get_line(buffer, line, sizeof(line))) {
 		if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
 			continue;
-		if ((reg < 0xa0) && (reg >= 0) && (val <= 0xffffffff) && (channel_id >= 0) && (channel_id <= 3) )
+		if ((reg < 0xa0) && (reg >= 0) && (val <= 0xffffffff) && (channel_id >= 0) && (channel_id <= 3))
 			snd_ptr_write(emu, iobase, reg, channel_id, val);
 	}
 }
@@ -543,7 +543,7 @@ static void snd_emu_proc_ptr_reg_write20(struct snd_info_entry *entry,
 {
 	snd_emu_proc_ptr_reg_write(entry, buffer, 0x20);
 }
-	
+
 
 static void snd_emu_proc_ptr_reg_read00a(struct snd_info_entry *entry,
 					 struct snd_info_buffer *buffer)
@@ -585,85 +585,85 @@ int __devinit snd_emu10k1_proc_init(struct snd_emu10k1 * emu)
 	struct snd_info_entry *entry;
 #ifdef CONFIG_SND_DEBUG
 	if (emu->card_capabilities->emu_model) {
-		if (! snd_card_proc_new(emu->card, "emu1010_regs", &entry)) 
+		if (!snd_card_proc_new(emu->card, "emu1010_regs", &entry))
 			snd_info_set_text_ops(entry, emu, snd_emu_proc_emu1010_reg_read);
 	}
-	if (! snd_card_proc_new(emu->card, "io_regs", &entry)) {
+	if (!snd_card_proc_new(emu->card, "io_regs", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_io_reg_read);
 		entry->c.text.write = snd_emu_proc_io_reg_write;
 		entry->mode |= S_IWUSR;
 	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs00a", &entry)) {
+	if (!snd_card_proc_new(emu->card, "ptr_regs00a", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read00a);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
 		entry->mode |= S_IWUSR;
 	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs00b", &entry)) {
+	if (!snd_card_proc_new(emu->card, "ptr_regs00b", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read00b);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
 		entry->mode |= S_IWUSR;
 	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs20a", &entry)) {
+	if (!snd_card_proc_new(emu->card, "ptr_regs20a", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20a);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
 		entry->mode |= S_IWUSR;
 	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs20b", &entry)) {
+	if (!snd_card_proc_new(emu->card, "ptr_regs20b", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20b);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
 		entry->mode |= S_IWUSR;
 	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs20c", &entry)) {
+	if (!snd_card_proc_new(emu->card, "ptr_regs20c", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20c);
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
 		entry->mode |= S_IWUSR;
 	}
 #endif
-	
-	if (! snd_card_proc_new(emu->card, "emu10k1", &entry))
+
+	if (!snd_card_proc_new(emu->card, "emu10k1", &entry))
 		snd_info_set_text_ops(entry, emu, snd_emu10k1_proc_read);
 
 	if (emu->card_capabilities->emu10k2_chip) {
-		if (! snd_card_proc_new(emu->card, "spdif-in", &entry))
+		if (!snd_card_proc_new(emu->card, "spdif-in", &entry))
 			snd_info_set_text_ops(entry, emu, snd_emu10k1_proc_spdif_read);
 	}
 	if (emu->card_capabilities->ca0151_chip) {
-		if (! snd_card_proc_new(emu->card, "capture-rates", &entry))
+		if (!snd_card_proc_new(emu->card, "capture-rates", &entry))
 			snd_info_set_text_ops(entry, emu, snd_emu10k1_proc_rates_read);
 	}
 
-	if (! snd_card_proc_new(emu->card, "voices", &entry))
+	if (!snd_card_proc_new(emu->card, "voices", &entry))
 		snd_info_set_text_ops(entry, emu, snd_emu10k1_proc_voices_read);
 
-	if (! snd_card_proc_new(emu->card, "fx8010_gpr", &entry)) {
+	if (!snd_card_proc_new(emu->card, "fx8010_gpr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
 		entry->size = emu->audigy ? A_TOTAL_SIZE_GPR : TOTAL_SIZE_GPR;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
-	if (! snd_card_proc_new(emu->card, "fx8010_tram_data", &entry)) {
+	if (!snd_card_proc_new(emu->card, "fx8010_tram_data", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
-		entry->size = emu->audigy ? A_TOTAL_SIZE_TANKMEM_DATA : TOTAL_SIZE_TANKMEM_DATA ;
+		entry->size = emu->audigy ? A_TOTAL_SIZE_TANKMEM_DATA : TOTAL_SIZE_TANKMEM_DATA;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
-	if (! snd_card_proc_new(emu->card, "fx8010_tram_addr", &entry)) {
+	if (!snd_card_proc_new(emu->card, "fx8010_tram_addr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
-		entry->size = emu->audigy ? A_TOTAL_SIZE_TANKMEM_ADDR : TOTAL_SIZE_TANKMEM_ADDR ;
+		entry->size = emu->audigy ? A_TOTAL_SIZE_TANKMEM_ADDR : TOTAL_SIZE_TANKMEM_ADDR;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
-	if (! snd_card_proc_new(emu->card, "fx8010_code", &entry)) {
+	if (!snd_card_proc_new(emu->card, "fx8010_code", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
 		entry->size = emu->audigy ? A_TOTAL_SIZE_CODE : TOTAL_SIZE_CODE;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
-	if (! snd_card_proc_new(emu->card, "fx8010_acode", &entry)) {
+	if (!snd_card_proc_new(emu->card, "fx8010_acode", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_TEXT;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
diff --git a/sound/pci/emu10k1/io.c b/sound/pci/emu10k1/io.c
index b5a802b..c77f5f2 100644
--- a/sound/pci/emu10k1/io.c
+++ b/sound/pci/emu10k1/io.c
@@ -42,16 +42,16 @@ unsigned int snd_emu10k1_ptr_read(struct snd_emu10k1 * emu, unsigned int reg, un
 
 	if (reg & 0xff000000) {
 		unsigned char size, offset;
-		
+
 		size = (reg >> 24) & 0x3f;
 		offset = (reg >> 16) & 0x1f;
 		mask = ((1 << size) - 1) << offset;
-		
+
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		outl(regptr, emu->port + PTR);
 		val = inl(emu->port + DATA);
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
-		
+
 		return (val & mask) >> offset;
 	} else {
 		spin_lock_irqsave(&emu->emu_lock, flags);
@@ -90,7 +90,7 @@ void snd_emu10k1_ptr_write(struct snd_emu10k1 *emu, unsigned int reg, unsigned i
 		outl(regptr, emu->port + PTR);
 		data |= inl(emu->port + DATA) & ~mask;
 		outl(data, emu->port + DATA);
-		spin_unlock_irqrestore(&emu->emu_lock, flags);		
+		spin_unlock_irqrestore(&emu->emu_lock, flags);
 	} else {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		outl(regptr, emu->port + PTR);
@@ -101,13 +101,13 @@ void snd_emu10k1_ptr_write(struct snd_emu10k1 *emu, unsigned int reg, unsigned i
 
 EXPORT_SYMBOL(snd_emu10k1_ptr_write);
 
-unsigned int snd_emu10k1_ptr20_read(struct snd_emu10k1 * emu, 
-					  unsigned int reg, 
+unsigned int snd_emu10k1_ptr20_read(struct snd_emu10k1 * emu,
+					  unsigned int reg,
 					  unsigned int chn)
 {
 	unsigned long flags;
 	unsigned int regptr, val;
-  
+
 	regptr = (reg << 16) | chn;
 
 	spin_lock_irqsave(&emu->emu_lock, flags);
@@ -117,9 +117,9 @@ unsigned int snd_emu10k1_ptr20_read(struct snd_emu10k1 * emu,
 	return val;
 }
 
-void snd_emu10k1_ptr20_write(struct snd_emu10k1 *emu, 
-				   unsigned int reg, 
-				   unsigned int chn, 
+void snd_emu10k1_ptr20_write(struct snd_emu10k1 *emu,
+				   unsigned int reg,
+				   unsigned int chn,
 				   unsigned int data)
 {
 	unsigned int regptr;
@@ -230,7 +230,7 @@ int snd_emu10k1_i2c_write(struct snd_emu10k1 *emu,
 				break;
 			}
 		}
-		//Read back and see if the transaction is successful
+		/* Read back and see if the transaction is successful */
 		if ((status & I2C_A_ADC_ABORT) == 0)
 			break;
 	}
@@ -242,7 +242,7 @@ int snd_emu10k1_i2c_write(struct snd_emu10k1 *emu,
 		/* dump_stack(); */
 		err = -EINVAL;
 	}
-    
+
 	spin_unlock(&emu->i2c_lock);
 	return err;
 }
@@ -291,10 +291,10 @@ int snd_emu1010_fpga_read(struct snd_emu10k1 * emu, u32 reg, u32 *value)
  */
 int snd_emu1010_fpga_link_dst_src_write(struct snd_emu10k1 * emu, u32 dst, u32 src)
 {
-	snd_emu1010_fpga_write(emu, 0x00, ((dst >> 8) & 0x3f) );
-	snd_emu1010_fpga_write(emu, 0x01, (dst & 0x3f) );
-	snd_emu1010_fpga_write(emu, 0x02, ((src >> 8) & 0x3f) );
-	snd_emu1010_fpga_write(emu, 0x03, (src & 0x3f) );
+	snd_emu1010_fpga_write(emu, 0x00, ((dst >> 8) & 0x3f));
+	snd_emu1010_fpga_write(emu, 0x01, (dst & 0x3f));
+	snd_emu1010_fpga_write(emu, 0x02, ((src >> 8) & 0x3f));
+	snd_emu1010_fpga_write(emu, 0x03, (src & 0x3f));
 
 	return 0;
 }
diff --git a/sound/pci/emu10k1/irq.c b/sound/pci/emu10k1/irq.c
index 30bfed6..e4947a6 100644
--- a/sound/pci/emu10k1/irq.c
+++ b/sound/pci/emu10k1/irq.c
@@ -157,19 +157,19 @@ irqreturn_t snd_emu10k1_interrupt(int irq, void *dev_id)
 				struct snd_emu10k1_voice *pvoice = &(emu->p16v_voices[0]);
 				struct snd_emu10k1_voice *cvoice = &(emu->p16v_capture_voice);
 
-				//printk(KERN_INFO "status2=0x%x\n", status2);
+				/* printk(KERN_INFO "status2=0x%x\n", status2); */
 				orig_status2 = status2;
-				if(status2 & mask) {
-					if(pvoice->use) {
+				if (status2 & mask) {
+					if (pvoice->use) {
 						snd_pcm_period_elapsed(pvoice->epcm->substream);
-					} else { 
+					} else {
 						snd_printk(KERN_ERR "p16v: status: 0x%08x, mask=0x%08x, pvoice=%p, use=%d\n", status2, mask, pvoice, pvoice->use);
 					}
 				}
-				if(status2 & 0x110000) {
-					//printk(KERN_INFO "capture int found\n");
-					if(cvoice->use) {
-						//printk(KERN_INFO "capture period_elapsed\n");
+				if (status2 & 0x110000) {
+					/* printk(KERN_INFO "capture int found\n"); */
+					if (cvoice->use) {
+						/* printk(KERN_INFO "capture period_elapsed\n"); */
 						snd_pcm_period_elapsed(cvoice->epcm->substream);
 					}
 				}
@@ -181,7 +181,7 @@ irqreturn_t snd_emu10k1_interrupt(int irq, void *dev_id)
 		if (status) {
 			unsigned int bits;
 			snd_printk(KERN_ERR "emu10k1: unhandled interrupt: 0x%08x\n", status);
-			//make sure any interrupts we don't handle are disabled:
+			/* make sure any interrupts we don't handle are disabled: */
 			bits = INTE_FXDSPENABLE |
 				INTE_PCIERRORENABLE |
 				INTE_VOLINCRENABLE |
diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index 6a47672..e6067f6 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -323,7 +323,7 @@ snd_emu10k1_alloc_pages(struct snd_emu10k1 *emu, struct snd_pcm_substream *subst
 		unsigned long ofs = idx << PAGE_SHIFT;
 		dma_addr_t addr;
 		addr = snd_pcm_sgbuf_get_addr(substream, ofs);
-		if (! is_valid_page(emu, addr)) {
+		if (!is_valid_page(emu, addr)) {
 			printk(KERN_ERR "emu: failure page = %d\n", idx);
 			mutex_unlock(&hdr->block_mutex);
 			return NULL;
@@ -368,7 +368,7 @@ struct snd_util_memblk *
 snd_emu10k1_synth_alloc(struct snd_emu10k1 *hw, unsigned int size)
 {
 	struct snd_emu10k1_memblk *blk;
-	struct snd_util_memhdr *hdr = hw->memhdr; 
+	struct snd_util_memhdr *hdr = hw->memhdr;
 
 	mutex_lock(&hdr->block_mutex);
 	blk = (struct snd_emu10k1_memblk *)__snd_util_mem_alloc(hdr, size);
@@ -394,7 +394,7 @@ EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
 int
 snd_emu10k1_synth_free(struct snd_emu10k1 *emu, struct snd_util_memblk *memblk)
 {
-	struct snd_util_memhdr *hdr = emu->memhdr; 
+	struct snd_util_memhdr *hdr = emu->memhdr;
 	struct snd_emu10k1_memblk *blk = (struct snd_emu10k1_memblk *)memblk;
 	unsigned long flags;
 
@@ -499,7 +499,7 @@ static inline void *offset_ptr(struct snd_emu10k1 *emu, int page, int offset)
 	if (snd_BUG_ON(page < 0 || page >= emu->max_cache_pages))
 		return NULL;
 	ptr = emu->page_ptr_table[page];
-	if (! ptr) {
+	if (!ptr) {
 		printk(KERN_ERR "emu10k1: access to NULL ptr: page = %d\n", page);
 		return NULL;
 	}
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 749a21b..dd71b65 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -123,17 +123,17 @@
 
  /* hardware definition */
 static struct snd_pcm_hardware snd_p16v_playback_hw = {
-	.info =			SNDRV_PCM_INFO_MMAP | 
+	.info =			SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				SNDRV_PCM_INFO_RESUME |
 				SNDRV_PCM_INFO_MMAP_VALID |
 				SNDRV_PCM_INFO_SYNC_START,
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE, /* Only supports 24-bit samples padded to 32 bits. */
-	.rates =		SNDRV_PCM_RATE_192000 | SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100, 
+	.rates =		SNDRV_PCM_RATE_192000 | SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100,
 	.rate_min =		44100,
 	.rate_max =		192000,
-	.channels_min =		8, 
+	.channels_min =		8,
 	.channels_max =		8,
 	.buffer_bytes_max =	((65536 - 64) * 8),
 	.period_bytes_min =	64,
@@ -150,7 +150,7 @@ static struct snd_pcm_hardware snd_p16v_capture_hw = {
 				 SNDRV_PCM_INFO_RESUME |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		SNDRV_PCM_RATE_192000 | SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100, 
+	.rates =		SNDRV_PCM_RATE_192000 | SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100,
 	.rate_min =		44100,
 	.rate_max =		192000,
 	.channels_min =		2,
@@ -166,9 +166,9 @@ static struct snd_pcm_hardware snd_p16v_capture_hw = {
 static void snd_p16v_pcm_free_substream(struct snd_pcm_runtime *runtime)
 {
 	struct snd_emu10k1_pcm *epcm = runtime->private_data;
-  
+
 	if (epcm) {
-        	//snd_printk("epcm free: %p\n", epcm);
+        	/* snd_printk("epcm free: %p\n", epcm); */
 		kfree(epcm);
 	}
 }
@@ -183,26 +183,26 @@ static int snd_p16v_pcm_open_playback_channel(struct snd_pcm_substream *substrea
 	int err;
 
 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
-        //snd_printk("epcm kcalloc: %p\n", epcm);
+        /* snd_printk("epcm kcalloc: %p\n", epcm); */
 
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
 	epcm->substream = substream;
-        //snd_printk("epcm device=%d, channel_id=%d\n", substream->pcm->device, channel_id);
-  
+        /* snd_printk("epcm device=%d, channel_id=%d\n", substream->pcm->device, channel_id); */
+
 	runtime->private_data = epcm;
 	runtime->private_free = snd_p16v_pcm_free_substream;
-  
+
 	runtime->hw = snd_p16v_playback_hw;
 
         channel->emu = emu;
         channel->number = channel_id;
 
         channel->use=1;
-	//snd_printk("p16v: open channel_id=%d, channel=%p, use=0x%x\n", channel_id, channel, channel->use);
-        //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
-        //channel->interrupt = snd_p16v_pcm_channel_interrupt;
+	/* snd_printk("p16v: open channel_id=%d, channel=%p, use=0x%x\n", channel_id, channel, channel->use); */
+        /* printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel); */
+        /* channel->interrupt = snd_p16v_pcm_channel_interrupt; */
         channel->epcm=epcm;
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                 return err;
@@ -224,26 +224,26 @@ static int snd_p16v_pcm_open_capture_channel(struct snd_pcm_substream *substream
 	int err;
 
 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
-	//snd_printk("epcm kcalloc: %p\n", epcm);
+	/* snd_printk("epcm kcalloc: %p\n", epcm); */
 
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
 	epcm->substream = substream;
-	//snd_printk("epcm device=%d, channel_id=%d\n", substream->pcm->device, channel_id);
+	/* snd_printk("epcm device=%d, channel_id=%d\n", substream->pcm->device, channel_id); */
 
 	runtime->private_data = epcm;
 	runtime->private_free = snd_p16v_pcm_free_substream;
-  
+
 	runtime->hw = snd_p16v_capture_hw;
 
 	channel->emu = emu;
 	channel->number = channel_id;
 
 	channel->use=1;
-	//snd_printk("p16v: open channel_id=%d, channel=%p, use=0x%x\n", channel_id, channel, channel->use);
-	//printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
-	//channel->interrupt = snd_p16v_pcm_channel_interrupt;
+	/* snd_printk("p16v: open channel_id=%d, channel=%p, use=0x%x\n", channel_id, channel, channel->use); */
+	/* printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel); */
+	/* channel->interrupt = snd_p16v_pcm_channel_interrupt; */
 	channel->epcm=epcm;
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
 		return err;
@@ -256,8 +256,8 @@ static int snd_p16v_pcm_open_capture_channel(struct snd_pcm_substream *substream
 static int snd_p16v_pcm_close_playback(struct snd_pcm_substream *substream)
 {
 	struct snd_emu10k1 *emu = snd_pcm_substream_chip(substream);
-	//struct snd_pcm_runtime *runtime = substream->runtime;
-	//struct snd_emu10k1_pcm *epcm = runtime->private_data;
+	/* struct snd_pcm_runtime *runtime = substream->runtime; */
+	/* struct snd_emu10k1_pcm *epcm = runtime->private_data; */
 	emu->p16v_voices[substream->pcm->device - emu->p16v_device_offset].use = 0;
 	/* FIXME: maybe zero others */
 	return 0;
@@ -267,8 +267,8 @@ static int snd_p16v_pcm_close_playback(struct snd_pcm_substream *substream)
 static int snd_p16v_pcm_close_capture(struct snd_pcm_substream *substream)
 {
 	struct snd_emu10k1 *emu = snd_pcm_substream_chip(substream);
-	//struct snd_pcm_runtime *runtime = substream->runtime;
-	//struct snd_emu10k1_pcm *epcm = runtime->private_data;
+	/* struct snd_pcm_runtime *runtime = substream->runtime; */
+	/* struct snd_emu10k1_pcm *epcm = runtime->private_data; */
 	emu->p16v_capture_voice.use = 0;
 	/* FIXME: maybe zero others */
 	return 0;
@@ -281,7 +281,7 @@ static int snd_p16v_pcm_open_playback_front(struct snd_pcm_substream *substream)
 
 static int snd_p16v_pcm_open_capture(struct snd_pcm_substream *substream)
 {
-	// Only using channel 0 for now, but the card has 2 channels.
+	/* Only using channel 0 for now, but the card has 2 channels. */
 	return snd_p16v_pcm_open_capture_channel(substream, 0);
 }
 
@@ -333,10 +333,10 @@ static int snd_p16v_pcm_prepare_playback(struct snd_pcm_substream *substream)
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
 	int i;
 	u32 tmp;
-	
-        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
-        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
-	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->p16v_buffer.addr, emu->p16v_buffer.area, emu->p16v_buffer.bytes);
+
+        /* snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1)); */
+        /* snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base); */
+	/* snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->p16v_buffer.addr, emu->p16v_buffer.area, emu->p16v_buffer.bytes); */
 	tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, channel);
         switch (runtime->rate) {
 	case 44100:
@@ -354,17 +354,17 @@ static int snd_p16v_pcm_prepare_playback(struct snd_pcm_substream *substream)
 	  break;
 	}
 	/* FIXME: Check emu->buffer.size before actually writing to it. */
-	for(i = 0; i < runtime->periods; i++) {
+	for (i = 0; i < runtime->periods; i++) {
 		table_base[i*2]=runtime->dma_addr+(i*period_size_bytes);
 		table_base[(i*2)+1]=period_size_bytes<<16;
 	}
- 
+
 	snd_emu10k1_ptr20_write(emu, PLAYBACK_LIST_ADDR, channel, emu->p16v_buffer.addr+(8*16*channel));
 	snd_emu10k1_ptr20_write(emu, PLAYBACK_LIST_SIZE, channel, (runtime->periods - 1) << 19);
 	snd_emu10k1_ptr20_write(emu, PLAYBACK_LIST_PTR, channel, 0);
 	snd_emu10k1_ptr20_write(emu, PLAYBACK_DMA_ADDR, channel, runtime->dma_addr);
-	//snd_emu10k1_ptr20_write(emu, PLAYBACK_PERIOD_SIZE, channel, frames_to_bytes(runtime, runtime->period_size)<<16); // buffer size in bytes
-	snd_emu10k1_ptr20_write(emu, PLAYBACK_PERIOD_SIZE, channel, 0); // buffer size in bytes
+	/* snd_emu10k1_ptr20_write(emu, PLAYBACK_PERIOD_SIZE, channel, frames_to_bytes(runtime, runtime->period_size)<<16); buffer size in bytes */
+	snd_emu10k1_ptr20_write(emu, PLAYBACK_PERIOD_SIZE, channel, 0); /* buffer size in bytes */
 	snd_emu10k1_ptr20_write(emu, PLAYBACK_POINTER, channel, 0);
 	snd_emu10k1_ptr20_write(emu, 0x07, channel, 0x0);
 	snd_emu10k1_ptr20_write(emu, 0x08, channel, 0);
@@ -379,7 +379,7 @@ static int snd_p16v_pcm_prepare_capture(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int channel = substream->pcm->device - emu->p16v_device_offset;
 	u32 tmp;
-	//printk("prepare capture:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
+	/* printk("prepare capture:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1)); */
 	tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, channel);
         switch (runtime->rate) {
 	case 44100:
@@ -399,10 +399,10 @@ static int snd_p16v_pcm_prepare_capture(struct snd_pcm_substream *substream)
 	/* FIXME: Check emu->buffer.size before actually writing to it. */
 	snd_emu10k1_ptr20_write(emu, 0x13, channel, 0);
 	snd_emu10k1_ptr20_write(emu, CAPTURE_DMA_ADDR, channel, runtime->dma_addr);
-	snd_emu10k1_ptr20_write(emu, CAPTURE_BUFFER_SIZE, channel, frames_to_bytes(runtime, runtime->buffer_size) << 16); // buffer size in bytes
+	snd_emu10k1_ptr20_write(emu, CAPTURE_BUFFER_SIZE, channel, frames_to_bytes(runtime, runtime->buffer_size) << 16); /* buffer size in bytes */
 	snd_emu10k1_ptr20_write(emu, CAPTURE_POINTER, channel, 0);
-	//snd_emu10k1_ptr20_write(emu, CAPTURE_SOURCE, 0x0, 0x333300e4); /* Select MIC or Line in */
-	//snd_emu10k1_ptr20_write(emu, EXTENDED_INT_MASK, 0, snd_emu10k1_ptr20_read(emu, EXTENDED_INT_MASK, 0) | (0x110000<<channel));
+	/* snd_emu10k1_ptr20_write(emu, CAPTURE_SOURCE, 0x0, 0x333300e4);  Select MIC or Line in */
+	/* snd_emu10k1_ptr20_write(emu, EXTENDED_INT_MASK, 0, snd_emu10k1_ptr20_read(emu, EXTENDED_INT_MASK, 0) | (0x110000<<channel)); */
 
 	return 0;
 }
@@ -459,13 +459,13 @@ static int snd_p16v_pcm_trigger_playback(struct snd_pcm_substream *substream,
 		runtime = s->runtime;
 		epcm = runtime->private_data;
 		channel = substream->pcm->device-emu->p16v_device_offset;
-		//snd_printk("p16v channel=%d\n",channel);
+		/* snd_printk("p16v channel=%d\n",channel); */
 		epcm->running = running;
 		basic |= (0x1<<channel);
 		inte |= (INTE2_PLAYBACK_CH_0_LOOP<<channel);
                 snd_pcm_trigger_done(s, substream);
         }
-	//snd_printk("basic=0x%x, inte=0x%x\n",basic, inte);
+	/* snd_printk("basic=0x%x, inte=0x%x\n",basic, inte); */
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -503,7 +503,7 @@ static int snd_p16v_pcm_trigger_capture(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_STOP:
 		snd_emu10k1_ptr20_write(emu, BASIC_INTERRUPT, 0, snd_emu10k1_ptr20_read(emu, BASIC_INTERRUPT, 0) & ~(0x100<<channel));
 		snd_p16v_intr_disable(emu, inte);
-		//snd_emu10k1_ptr20_write(emu, EXTENDED_INT_MASK, 0, snd_emu10k1_ptr20_read(emu, EXTENDED_INT_MASK, 0) & ~(0x110000<<channel));
+		/* snd_emu10k1_ptr20_write(emu, EXTENDED_INT_MASK, 0, snd_emu10k1_ptr20_read(emu, EXTENDED_INT_MASK, 0) & ~(0x110000<<channel)); */
 		epcm->running = 0;
 		break;
 	default:
@@ -558,7 +558,7 @@ snd_p16v_pcm_pointer_capture(struct snd_pcm_substream *substream)
 		ptr -= runtime->buffer_size;
 		printk(KERN_WARNING "buffer capture limited!\n");
 	}
-	//printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);
+	/* printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate); */
 
 	return ptr;
 }
@@ -589,10 +589,10 @@ static struct snd_pcm_ops snd_p16v_capture_ops = {
 
 int snd_p16v_free(struct snd_emu10k1 *chip)
 {
-	// release the data
+	/* release the data */
 	if (chip->p16v_buffer.area) {
 		snd_dma_free_pages(&chip->p16v_buffer);
-		//snd_printk("period lables free: %p\n", &chip->p16v_buffer);
+		/* snd_printk("period lables free: %p\n", &chip->p16v_buffer); */
 	}
 	return 0;
 }
@@ -603,18 +603,18 @@ int __devinit snd_p16v_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm *
 	struct snd_pcm_substream *substream;
 	int err;
         int capture=1;
-  
-	//snd_printk("snd_p16v_pcm called. device=%d\n", device);
+
+	/* snd_printk("snd_p16v_pcm called. device=%d\n", device); */
 	emu->p16v_device_offset = device;
 	if (rpcm)
 		*rpcm = NULL;
 
 	if ((err = snd_pcm_new(emu->card, "p16v", device, 1, capture, &pcm)) < 0)
 		return err;
-  
+
 	pcm->private_data = emu;
-	// Single playback 8 channel device.
-	// Single capture 2 channel device.
+	/* Single playback 8 channel device. */
+	/* Single capture 2 channel device. */
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_p16v_playback_front_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_p16v_capture_ops);
 
@@ -623,31 +623,31 @@ int __devinit snd_p16v_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm *
 	strcpy(pcm->name, "p16v");
 	emu->pcm_p16v = pcm;
 
-	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
-	    substream; 
+	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	    substream;
 	    substream = substream->next) {
-		if ((err = snd_pcm_lib_preallocate_pages(substream, 
-							 SNDRV_DMA_TYPE_DEV, 
-							 snd_dma_pci_data(emu->pci), 
-							 ((65536 - 64) * 8), ((65536 - 64) * 8))) < 0) 
+		if ((err = snd_pcm_lib_preallocate_pages(substream,
+							 SNDRV_DMA_TYPE_DEV,
+							 snd_dma_pci_data(emu->pci),
+							 ((65536 - 64) * 8), ((65536 - 64) * 8))) < 0)
 			return err;
-		//snd_printk("preallocate playback substream: err=%d\n", err);
+		/* snd_printk("preallocate playback substream: err=%d\n", err); */
 	}
 
-	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; 
-	      substream; 
+	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+	      substream;
 	      substream = substream->next) {
- 		if ((err = snd_pcm_lib_preallocate_pages(substream, 
-	                                           SNDRV_DMA_TYPE_DEV, 
-	                                           snd_dma_pci_data(emu->pci), 
+ 		if ((err = snd_pcm_lib_preallocate_pages(substream,
+	                                           SNDRV_DMA_TYPE_DEV,
+	                                           snd_dma_pci_data(emu->pci),
 	                                           65536 - 64, 65536 - 64)) < 0)
 			return err;
-		//snd_printk("preallocate capture substream: err=%d\n", err);
+		/* snd_printk("preallocate capture substream: err=%d\n", err); */
 	}
-  
+
 	if (rpcm)
 		*rpcm = pcm;
-  
+
 	return 0;
 }
 
@@ -696,7 +696,7 @@ static int snd_p16v_volume_put(struct snd_kcontrol *kcontrol,
 	} else {
 		value &= 0xffff0000;
 		value |= ((0xff - ucontrol->value.integer.value[0]) << 8) |
-			((0xff - ucontrol->value.integer.value[1]) );
+			((0xff - ucontrol->value.integer.value[1]));
 	}
 	if (value != oval) {
 		snd_emu10k1_ptr20_write(emu, reg, 0, value);
@@ -740,7 +740,7 @@ static int snd_p16v_capture_source_put(struct snd_kcontrol *kcontrol,
 	u32 mask;
 	u32 source;
 
-	val = ucontrol->value.enumerated.item[0] ;
+	val = ucontrol->value.enumerated.item[0];
 	if (val > 7)
 		return -EINVAL;
 	change = (emu->p16v_capture_source != val);
@@ -784,7 +784,7 @@ static int snd_p16v_capture_channel_put(struct snd_kcontrol *kcontrol,
 	int change = 0;
 	u32 tmp;
 
-	val = ucontrol->value.enumerated.item[0] ;
+	val = ucontrol->value.enumerated.item[0];
 	if (val > 3)
 		return -EINVAL;
 	change = (emu->p16v_capture_channel != val);
@@ -854,7 +854,7 @@ int __devinit snd_p16v_mixer(struct snd_emu10k1 *emu)
 int __devinit snd_p16v_alloc_pm_buffer(struct snd_emu10k1 *emu)
 {
 	emu->p16v_saved = vmalloc(NUM_CHS * 4 * 0x80);
-	if (! emu->p16v_saved)
+	if (!emu->p16v_saved)
 		return -ENOMEM;
 	return 0;
 }
diff --git a/sound/pci/emu10k1/p16v.h b/sound/pci/emu10k1/p16v.h
index 1532149..7964c8e 100644
--- a/sound/pci/emu10k1/p16v.h
+++ b/sound/pci/emu10k1/p16v.h
@@ -81,14 +81,14 @@
 /********************************************************************************************************/
 /* Audigy2 P16V pointer-offset register set, accessed through the PTR2 and DATA2 registers                     */
 /********************************************************************************************************/
-                                                                                                                           
+
 /* The sample rate of the SPDIF outputs is set by modifying a register in the EMU10K2 PTR register A_SPDIF_SAMPLERATE.
  * The sample rate is also controlled by the same registers that control the rate of the EMU10K2 sample rate converters.
  */
 
 /* Initally all registers from 0x00 to 0x3f have zero contents. */
 #define PLAYBACK_LIST_ADDR	0x00		/* Base DMA address of a list of pointers to each period/size */
-						/* One list entry: 4 bytes for DMA address, 
+						/* One list entry: 4 bytes for DMA address,
 						 * 4 bytes for period_size << 16.
 						 * One list entry is 8 bytes long.
 						 * One list entry for each period in the buffer.
@@ -167,11 +167,11 @@
 						 *                               3 - 192 khz
 						 *                               7 - undefined rate.
 						 * [19] Channel 0. 1 - Valid, 0 - Not Valid.
-						 * [22:20] Channel 1 Detected sample rate. 
+						 * [22:20] Channel 1 Detected sample rate.
 						 * [23] Channel 1. 1 - Valid, 0 - Not Valid.
-						 * [26:24] Channel 2 Detected sample rate. 
+						 * [26:24] Channel 2 Detected sample rate.
 						 * [27] Channel 2. 1 - Valid, 0 - Not Valid.
-						 * [30:28] Channel 3 Detected sample rate. 
+						 * [30:28] Channel 3 Detected sample rate.
 						 * [31] Channel 3. 1 - Valid, 0 - Not Valid.
 						 */
 /* 0x18 - 0x1f unused */
@@ -204,7 +204,7 @@
 /* 0x43,0x48 do not remember settings */
 /* 0x41-45 unused */
 #define WATERMARK            0x46		/* Test bit to indicate cache level usage */
-						/* Values it can have while playing on channel 0. 
+						/* Values it can have while playing on channel 0.
 						 * 0000f000, 0000f004, 0000f008, 0000f00c.
 						 * Readonly.
 						 */
@@ -253,7 +253,7 @@
 						 * [23:16] The corresponding P16V channel to SRCMulti SPDIF enabled.
 						 * [31:24] The corresponding E10K2 channel to SRCMulti SPDIF enabled.
 						 */
-						/* Bypass P16V 0xff00ff00 
+						/* Bypass P16V 0xff00ff00
 						 * Bitmap. 0 = Off, 1 = On.
 						 * P16V playback outputs:
 						 * 0xXXXXXXX1 = PCM0 Left. (Front)
diff --git a/sound/pci/emu10k1/p17v.h b/sound/pci/emu10k1/p17v.h
index 4ef5f68..0a28974 100644
--- a/sound/pci/emu10k1/p17v.h
+++ b/sound/pci/emu10k1/p17v.h
@@ -27,11 +27,11 @@
 /* 00 - 07: Not used */
 #define P17V_PLAYBACK_FIFO_PTR	0x08	/* Current playback fifo pointer
 					 * and number of sound samples in cache.
-					 */  
+					 */
 /* 09 - 12: Not used */
 #define P17V_CAPTURE_FIFO_PTR	0x13	/* Current capture fifo pointer
 					 * and number of sound samples in cache.
-					 */  
+					 */
 /* 14 - 17: Not used */
 #define P17V_PB_CHN_SEL		0x18	/* P17v playback channel select */
 #define P17V_SE_SLOT_SEL_L	0x19	/* Sound Engine slot select low */
@@ -58,7 +58,7 @@
 #define I2C_A_ADC_LAST		0x00000400	/*I2C last transaction */
 #define I2C_A_ADC_BYTE		0x00000800	/*I2C one byte mode */
 
-#define I2C_D_ADC_REG_MASK	0xfe000000  	/*ADC address register */ 
+#define I2C_D_ADC_REG_MASK	0xfe000000  	/*ADC address register */
 #define I2C_D_ADC_DAT_MASK	0x01ff0000  	/*ADC data register */
 
 #define ADC_TIMEOUT		0x00000007	/*ADC Timeout Clock Disable */
diff --git a/sound/pci/emu10k1/voice.c b/sound/pci/emu10k1/voice.c
index d7300a1..de271d0 100644
--- a/sound/pci/emu10k1/voice.c
+++ b/sound/pci/emu10k1/voice.c
@@ -5,7 +5,7 @@
  *  Routines for control of EMU10K1 chips - voice manager
  *
  *  Rewrote voice allocator for multichannel support - rlrevell 12/2004
- * 
+ *
  *  BUGS:
  *    --
  *
@@ -32,14 +32,14 @@
 #include <sound/core.h>
 #include <sound/emu10k1.h>
 
-/* Previously the voice allocator started at 0 every time.  The new voice 
- * allocator uses a round robin scheme.  The next free voice is tracked in 
- * the card record and each allocation begins where the last left off.  The 
- * hardware requires stereo interleaved voices be aligned to an even/odd 
- * boundary.  For multichannel voice allocation we ensure than the block of 
- * voices does not cross the 32 voice boundary.  This simplifies the 
- * multichannel support and ensures we can use a single write to the 
- * (set|clear)_loop_stop registers.  Otherwise (for example) the voices would 
+/* Previously the voice allocator started at 0 every time.  The new voice
+ * allocator uses a round robin scheme.  The next free voice is tracked in
+ * the card record and each allocation begins where the last left off.  The
+ * hardware requires stereo interleaved voices be aligned to an even/odd
+ * boundary.  For multichannel voice allocation we ensure than the block of
+ * voices does not cross the 32 voice boundary.  This simplifies the
+ * multichannel support and ensures we can use a single write to the
+ * (set|clear)_loop_stop registers.  Otherwise (for example) the voices would
  * get out of sync when pausing/resuming a stream.
  *							--rlrevell
  */
@@ -52,8 +52,8 @@ static int voice_alloc(struct snd_emu10k1 *emu, int type, int number,
 
 	*rvoice = NULL;
 	first_voice = last_voice = 0;
-	for (i = emu->next_free_voice, j = 0; j < NUM_G ; i += number, j += number) {
-		// printk("i %d j %d next free %d!\n", i, j, emu->next_free_voice);
+	for (i = emu->next_free_voice, j = 0; j < NUM_G; i += number, j += number) {
+		/* printk("i %d j %d next free %d!\n", i, j, emu->next_free_voice); */
 		i %= NUM_G;
 
 		/* stereo voices must be even/odd */
@@ -61,7 +61,7 @@ static int voice_alloc(struct snd_emu10k1 *emu, int type, int number,
 			i++;
 			continue;
 		}
-			
+
 		skip = 0;
 		for (k = 0; k < number; k++) {
 			voice = &emu->voices[(i+k) % NUM_G];
@@ -71,20 +71,20 @@ static int voice_alloc(struct snd_emu10k1 *emu, int type, int number,
 			}
 		}
 		if (!skip) {
-			// printk("allocated voice %d\n", i);
+			/* printk("allocated voice %d\n", i); */
 			first_voice = i;
 			last_voice = (i + number) % NUM_G;
 			emu->next_free_voice = last_voice;
 			break;
 		}
 	}
-	
+
 	if (first_voice == last_voice)
 		return -ENOMEM;
-	
+
 	for (i = 0; i < number; i++) {
 		voice = &emu->voices[(first_voice + i) % NUM_G];
-		// printk("voice alloc - %i, %i of %i\n", voice->number, idx-first_voice+1, number);
+		/* printk("voice alloc - %i, %i of %i\n", voice->number, idx-first_voice+1, number); */
 		voice->use = 1;
 		switch (type) {
 		case EMU10K1_PCM:
