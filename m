From: Paul Davis <paul@linuxaudiosystems.com>
Subject: hdsp patch
Date: Sat, 14 Jun 2003 00:55:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306140455.h5E4tao15150@linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

this patch fixes some basic problems with the hdsp driver with respect
to the hdsp9652 card. it also cleans up a few minor issues with naming
in the driver, and slightly rationalizes initialization to involve
the minimum of special-casing for the hdsp9652.

the basic problem with the hdsp9652 was related to 8 bit versus 32 bit
offsets when addressing the mixer memory. once this was fixed,
everything worked. this driver continues to work fine on my
pci+digiface unit as well.

my apologies for this taking so long - it has taken a long time to ask
RME the "right" question, and quite a long time to get the
answer. once i got down to it, the fix took 5 minutes!

now we just need to solve the multiface initialization problems :(

--p

Index: hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.35
diff -u -u -r1.35 hdsp.c
--- hdsp.c	30 Apr 2003 11:53:23 -0000	1.35
+++ hdsp.c	14 Jun 2003 04:47:27 -0000
@@ -75,6 +75,8 @@
 #define DIGIFACE_DS_CHANNELS     14
 #define MULTIFACE_SS_CHANNELS    18
 #define MULTIFACE_DS_CHANNELS    14
+#define H9652_DS_CHANNELS        24
+#define H9652_SS_CHANNELS        24
 
 /* Write registers. These are defined as byte-offsets from the iobase value.
  */
@@ -84,7 +86,7 @@
 #define HDSP_controlRegister		64
 #define HDSP_interruptConfirmation	96
 #define HDSP_outputEnable	  	128
-#define HDSP_jtagReg  			256
+#define HDSP_control2Reg		256
 #define HDSP_midiDataOut0  		352
 #define HDSP_midiDataOut1  		356
 #define HDSP_fifoData  			368
@@ -120,7 +122,7 @@
 
 #define HDSP_IO_EXTENT     5192
 
-/* jtag register bits */
+/* control2 register bits */
 
 #define HDSP_TMS                0x01
 #define HDSP_TCK                0x02
@@ -133,6 +135,7 @@
 #define HDSP_VERSION_BIT	0x100
 #define HDSP_BIGENDIAN_MODE     0x200
 #define HDSP_RD_MULTIPLE        0x400
+#define HDSP_9652_ENABLE_MIXER  0x800
 
 #define HDSP_S_PROGRAM     	(HDSP_PROGRAM|HDSP_CONFIG_MODE_0)
 #define HDSP_S_LOAD		(HDSP_PROGRAM|HDSP_CONFIG_MODE_1)
@@ -358,15 +361,16 @@
         hdsp_midi_t           midi[2];
 	struct tasklet_struct midi_tasklet;
 	int                   precise_ptr;
-	u32                   control_register;	         /* cached value */
+	u32                   control_register;	     /* cached value */
+	u32                   control2_register;     /* cached value */
 	u32                   creg_spdif;
 	u32                   creg_spdif_stream;
-	char                 *card_name;		    /* digiface/multiface */
+	char                 *card_name;	     /* digiface/multiface */
 	HDSP_IO_Type          io_type;               /* ditto, but for code use */
         unsigned short        firmware_rev;
 	unsigned short	      state;		     /* stores state bits */
 	u32		      firmware_cache[24413]; /* this helps recover from accidental iobox power failure */
-	size_t                period_bytes; 	    /* guess what this is */
+	size_t                period_bytes; 	     /* guess what this is */
 	unsigned char         ds_channels;
 	unsigned char         ss_channels;	    /* different for multiface/digiface */
 	void                 *capture_buffer_unaligned;	 /* original buffer addresses */
@@ -452,7 +456,7 @@
 /* prototypes */
 static int __devinit snd_hdsp_create_alsa_devices(snd_card_t *card, hdsp_t *hdsp);
 static int __devinit snd_hdsp_create_pcm(snd_card_t *card, hdsp_t *hdsp);
-static inline int snd_hdsp_initialize_input_enable (hdsp_t *hdsp);
+static inline int snd_hdsp_enable_io (hdsp_t *hdsp);
 static inline void snd_hdsp_initialize_midi_flush (hdsp_t *hdsp);
 static inline void snd_hdsp_initialize_channels (hdsp_t *hdsp);
 static inline int hdsp_fifo_wait(hdsp_t *hdsp, int count, int timeout);
@@ -460,18 +464,6 @@
 static int hdsp_autosync_ref(hdsp_t *hdsp);
 static int snd_hdsp_set_defaults(hdsp_t *hdsp);
 
-static inline int hdsp_is_9652 (hdsp_t *hdsp)
-{
-	switch (hdsp->firmware_rev) {
-	case 0x64:
-	case 0x65:
-	case 0x68:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
 static inline int hdsp_playback_to_output_key (hdsp_t *hdsp, int in, int out)
 {
 	switch (hdsp->firmware_rev) {
@@ -504,12 +496,15 @@
 
 static inline int hdsp_check_for_iobox (hdsp_t *hdsp)
 {
+	return 0;
+#if 0
 	if (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_ConfigError) {
 		snd_printk ("Hammerfall-DSP: no Digiface or Multiface connected!\n");
 		hdsp->state &= ~HDSP_FirmwareLoaded;
 		return -EIO;
 	}
 	return 0;
+#endif
 }
 
 static int snd_hdsp_load_firmware_from_cache(hdsp_t *hdsp) {
@@ -521,7 +516,7 @@
 		
 		snd_printk ("loading firmware\n");
 
-		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_PROGRAM);
+		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 		
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
@@ -529,7 +524,7 @@
 			return -EIO;
 		}
 		
-		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
+		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_LOAD);
 		
 		for (i = 0; i < 24413; ++i) {
 			hdsp_write(hdsp, HDSP_fifoData, hdsp->firmware_cache[i]);
@@ -544,7 +539,12 @@
 		    	return -EIO;
 		}
 
-		hdsp_write (hdsp, HDSP_jtagReg, 0);
+#ifdef SNDRV_BIG_ENDIAN
+		hdsp->control2_register = HDSP_BIGENDIAN_MODE;
+#else
+		hdsp->control2_register = 0;
+#endif
+		hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
 		snd_printk ("finished firmware loading\n");
 		
 		if ((1000 / HZ) < 3000) {
@@ -574,25 +574,25 @@
 		return -EIO;
 	}
 
-	if ((err = snd_hdsp_initialize_input_enable(hdsp)) < 0) {
+	if ((err = snd_hdsp_enable_io(hdsp)) < 0) {
 		return err;
 	}
 		
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 	
-		hdsp_write (hdsp, HDSP_jtagReg, HDSP_PROGRAM);
+		hdsp_write (hdsp, HDSP_control2Reg, HDSP_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
 			return -EIO;
 		}
 
-		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
+		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_LOAD);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT)) {
 			hdsp->io_type = Multiface;
-			hdsp_write (hdsp, HDSP_jtagReg, HDSP_VERSION_BIT);
-			hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
+			hdsp_write (hdsp, HDSP_control2Reg, HDSP_VERSION_BIT);
+			hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_LOAD);
 			hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
 		} else {
 			hdsp->io_type = Digiface;
@@ -657,36 +657,41 @@
 {
 	unsigned int ad;
 
-	if (hdsp_is_9652 (hdsp)) {
+	if (addr >= HDSP_MATRIX_MIXER_SIZE)
+		return -1;
+		
+	if (hdsp->io_type == H9652) {
+
+		/* from martin björnsen:
+		   
+		   "You can only write dwords to the
+		   mixer memory which contain two
+		   mixer values in the low and high
+		   word. So if you want to change
+		   value 0 you have to read value 1
+		   from the cache and write both to
+		   the first dword in the mixer
+		   memory."
+		*/
 
-		if ((ad = addr/2) < 676) {
+		hdsp->mixer_matrix[addr] = data;
 
-			/* from martin björnsen:
+		/* `addr' addresses a 16-bit wide address, but
+		   the address space accessed via hdsp_write
+		   uses byte offsets. put another way, addr
+		   varies from 0 to 1351, but to access the
+		   corresponding memory location, we need
+		   to access 0 to 2703 ...
+		*/
 
-			   "You can only write dwords to the
-			   mixer memory which contain two
-			   mixer values in the low and high
-			   word. So if you want to change
-			   value 0 you have to read value 1
-			   from the cache and write both to
-			   the first dword in the mixer
-			   memory."
-			*/
-
-			hdsp->mixer_matrix[addr] = data;
-			hdsp_write (hdsp, 1024 + ad, 
-				    (hdsp->mixer_matrix[(addr&0x7fe)+1] << 16) + 
-				    hdsp->mixer_matrix[addr&0x7fe]);
-			return 0;
-		} else {
-			return -1;
-		}
+		hdsp_write (hdsp, 4096 + (addr*2), 
+			    (hdsp->mixer_matrix[(addr&0x7fe)+1] << 16) + 
+			    hdsp->mixer_matrix[addr&0x7fe]);
 		
+		return 0;
 
 	} else {
-		if (addr >= HDSP_MATRIX_MIXER_SIZE)
-			return -1;
-		
+
 		ad = (addr << 16) + data;
 		
 		if (hdsp_fifo_wait(hdsp, 127, HDSP_LONG_WAIT)) {
@@ -924,6 +929,7 @@
 			hdsp->channel_map = channel_map_mf_ss;
 			break;
 		case Digiface:
+		case H9652:
 			hdsp->channel_map = channel_map_df_ss;
 			break;
 		default:
@@ -2004,7 +2010,19 @@
 	
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = (hdsp->io_type == Digiface) ? 6 : 4;
+
+	switch (hdsp->io_type) {
+	case Digiface:
+	case H9652:
+		uinfo->value.enumerated.items = 6;
+		break;
+	case Multiface:
+		uinfo->value.enumerated.items = 4;
+	default:
+		uinfo->value.enumerated.items = 0;
+		break;
+	}
+		
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
@@ -2028,7 +2046,19 @@
 	
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
-	max = (hdsp->io_type == Digiface) ? 6 : 4;
+
+	switch (hdsp->io_type) {
+	case Digiface:
+	case H9652:
+		max = 6;
+		break;
+	case Multiface:
+		max = 4;
+		break;
+	default:
+		return -EIO;
+	}
+
 	val = ucontrol->value.enumerated.item[0] % max;
 	spin_lock_irqsave(&hdsp->lock, flags);
 	change = (int)val != hdsp_pref_sync_ref(hdsp);
@@ -2496,7 +2526,22 @@
 	hdsp_t *hdsp = _snd_kcontrol_chip(kcontrol);
 
 	offset = ucontrol->id.index - 1;
-	snd_assert(offset >= 0 || offset < ((hdsp->io_type == Digiface) ? 3 : 1), return -EINVAL);
+	snd_assert(offset >= 0);
+
+	switch (hdsp->io_type) {
+	case Digiface:
+	case H9652:
+		if (offset >= 3)
+			return -EINVAL;
+		break;
+	case Multiface:
+		if (offset >= 1) 
+			return -EINVAL;
+		break;
+	default:
+		return -EIO;
+	}
+
 	ucontrol->value.enumerated.item[0] = hdsp_adat_sync_check(hdsp, offset);
 	return 0;
 }
@@ -2593,8 +2638,9 @@
 	snd_kcontrol_t *kctl;
 
 	for (idx = 0; idx < HDSP_CONTROLS; idx++) {
-		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_hdsp_controls[idx], hdsp))) < 0)
+		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_hdsp_controls[idx], hdsp))) < 0) {
 			return err;
+		}
 		if (idx == 1)	/* IEC958 (S/PDIF) Stream */
 			hdsp->spdif_ctl = kctl;
 	}
@@ -2602,10 +2648,18 @@
 	snd_hdsp_playback_mixer.name = "Chn";
 	snd_hdsp_adat_sync_check.name = "ADAT Lock Status";
 
-	if (hdsp->io_type == Digiface) {
+	switch (hdsp->io_type) {
+	case Digiface:
 		limit = DIGIFACE_SS_CHANNELS;
-	} else {
+		break;
+	case H9652:
+		limit = H9652_SS_CHANNELS;
+		break;
+	case Multiface:
 		limit = MULTIFACE_SS_CHANNELS;
+		break;
+	default:
+		return -EIO;
 	}
 	
 	/* The index values are one greater than the channel ID so that alsamixer
@@ -2627,7 +2681,7 @@
 	if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_adat_sync_check, hdsp)))) {
 		return err;
 	}	
-	if (hdsp->io_type == Digiface) {
+	if (hdsp->io_type == Digiface || hdsp->io_type == H9652) {
 		for (idx = 1; idx < 3; ++idx) {
 			snd_hdsp_adat_sync_check.index = idx+1;
 			if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_adat_sync_check, hdsp)))) {
@@ -2681,6 +2735,7 @@
 	snd_iprintf(buffer, "IRQ: %d Registers bus: 0x%lx VM: 0x%lx\n",
 		    hdsp->irq, hdsp->port, hdsp->iobase);
 	snd_iprintf(buffer, "Control register: 0x%x\n", hdsp->control_register);
+	snd_iprintf(buffer, "Control2 register: 0x%x\n", hdsp->control2_register);
 	snd_iprintf(buffer, "Status register: 0x%x\n", status);
 	snd_iprintf(buffer, "Status2 register: 0x%x\n", status2);
 	snd_iprintf(buffer, "FIFO status: %d\n", hdsp_read(hdsp, HDSP_fifoStatus) & 0xff);
@@ -2854,6 +2909,7 @@
 
 	switch (hdsp->io_type) {
 	case Digiface:
+	case H9652:
 		x = status & HDSP_Sync1;
 		if (status & HDSP_Lock1) {
 			snd_iprintf(buffer, "ADAT2: %s\n", x ? "Sync" : "Lock");
@@ -3025,13 +3081,13 @@
 		hdsp->mixer_matrix[i] = MINUS_INFINITY_GAIN;
 	}
 
-	for (i = 0; i < (hdsp_is_9652(hdsp) ? 1352 : HDSP_MATRIX_MIXER_SIZE); i++) {
+	for (i = 0; i < (hdsp->io_type == H9652 ? 1352 : HDSP_MATRIX_MIXER_SIZE); i++) {
 		if (hdsp_write_gain (hdsp, i, MINUS_INFINITY_GAIN)) {
 			return -EIO;
 		}
 	}
 	
-	if (!hdsp_is_9652(hdsp) && line_outs_monitor[hdsp->dev]) {
+	if ((hdsp->io_type != H9652) && line_outs_monitor[hdsp->dev]) {
 		
 		snd_printk ("sending all inputs and playback streams to line outs.\n");
 
@@ -3783,7 +3839,7 @@
 			return -EFAULT;
 		break;
 	case SNDRV_HDSP_IOCTL_GET_VERSION:
-		if (hdsp_is_9652(hdsp)) return -EINVAL;
+		if (hdsp->io_type == H9652) return -EINVAL;
 		if (hdsp->io_type == Undefined) {
 			if ((err = hdsp_get_iobox_version(hdsp)) < 0) {
 				return err;
@@ -3796,7 +3852,7 @@
 		}
 		break;
 	case SNDRV_HDSP_IOCTL_UPLOAD_FIRMWARE:
-		if (hdsp_is_9652(hdsp)) return -EINVAL;
+		if (hdsp->io_type == H9652) return -EINVAL;
 		/* SNDRV_HDSP_IOCTL_GET_VERSION must have been called */
 		if (hdsp->io_type == Undefined) return -EINVAL;
 
@@ -3904,7 +3960,19 @@
 	return 0;
 }
 
-static inline int snd_hdsp_initialize_input_enable (hdsp_t *hdsp)
+static inline void snd_hdsp_9652_enable_mixer (hdsp_t *hdsp)
+{
+        hdsp->control2_register |= HDSP_9652_ENABLE_MIXER;
+	hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
+}
+
+static inline void snd_hdsp_9652_disable_mixer (hdsp_t *hdsp)
+{
+        hdsp->control2_register &= ~HDSP_9652_ENABLE_MIXER;
+	hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
+}
+
+static inline int snd_hdsp_enable_io (hdsp_t *hdsp)
 {
 	int i;
 	
@@ -3922,14 +3990,27 @@
 
 static inline void snd_hdsp_initialize_channels(hdsp_t *hdsp)
 {
-	if (hdsp->io_type == Digiface) {
+	switch (hdsp->io_type) {
+	case Digiface:
 		hdsp->card_name = "RME Hammerfall DSP + Digiface";
 		hdsp->ss_channels = DIGIFACE_SS_CHANNELS;
 		hdsp->ds_channels = DIGIFACE_DS_CHANNELS;
-	} else {
+		break;
+
+	case H9652:
+		hdsp->card_name = "RME Hammerfall HDSP 9652";
+		hdsp->ss_channels = H9652_SS_CHANNELS;
+		hdsp->ds_channels = H9652_DS_CHANNELS;
+		break;
+
+	case Multiface:
 		hdsp->card_name = "RME Hammerfall DSP + Multiface";
 		hdsp->ss_channels = MULTIFACE_SS_CHANNELS;
 		hdsp->ds_channels = MULTIFACE_DS_CHANNELS;
+
+	default:
+ 		/* should never get here */
+		break;
 	}
 }
 
@@ -3937,10 +4018,6 @@
 {
 	snd_hdsp_flush_midi_input (hdsp, 0);
 	snd_hdsp_flush_midi_input (hdsp, 1);
-
-#ifdef SNDRV_BIG_ENDIAN
-	hdsp_write(hdsp, HDSP_jtagReg, HDSP_BIGENDIAN_MODE);
-#endif
 }
 
 static int __devinit snd_hdsp_create_alsa_devices(snd_card_t *card, hdsp_t *hdsp)
@@ -4001,6 +4078,7 @@
 	struct pci_dev *pci = hdsp->pci;
 	int err;
 	int i;
+	int is_9652 = 0;
 
 	hdsp->irq = -1;
 	hdsp->state = 0;
@@ -4027,23 +4105,27 @@
 	pci_read_config_word(hdsp->pci, PCI_CLASS_REVISION, &hdsp->firmware_rev);
 	strcpy(card->driver, "H-DSP");
 	strcpy(card->mixername, "Xilinx FPGA");
-	
+
 	switch (hdsp->firmware_rev & 0xff) {
 	case 0xa:
 	case 0xb:
 		hdsp->card_name = "RME Hammerfall DSP";
 		break;
+
 	case 0x64:
 	case 0x65:
 	case 0x68:
 		hdsp->card_name = "RME HDSP 9652";
+		is_9652 = 1;
 		break;
+
 	default:
 		return -ENODEV;
 	}
 
-	if ((err = pci_enable_device(pci)) < 0)
+	if ((err = pci_enable_device(pci)) < 0) {
 		return err;
+	}
 
 	pci_set_master(hdsp->pci);
 
@@ -4071,70 +4153,53 @@
 		return err;
 	}
 	
-	if (hdsp_is_9652(hdsp)) {
-		
-		if ((err = snd_hdsp_initialize_input_enable(hdsp)) != 0) {
+	if (!is_9652 && hdsp_check_for_iobox (hdsp)) {
+		/* no iobox connected, we defer initialization */
+		snd_printk("card initialization pending : waiting for firmware\n");
+		if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
 			return err;
 		}
-
-		hdsp->io_type = Digiface;		
-	
-		hdsp->ss_channels = DIGIFACE_SS_CHANNELS;
-		hdsp->ds_channels = DIGIFACE_DS_CHANNELS;
+		return 0;
+	}
 	
-		snd_hdsp_initialize_midi_flush(hdsp);
+	if ((err = snd_hdsp_enable_io(hdsp)) != 0) {
+		return err;
+	}
 	
+	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
+		snd_printk("card initialization pending : waiting for firmware\n");
 		if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
 			return err;
 		}
-
-	} else {
+		return 0;
+	} 
 	
-		if (hdsp_check_for_iobox (hdsp)) {
-			/* no iobox connected, we defer initialization */
-			snd_printk("card initialization pending : waiting for firmware\n");
-			if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
-				return err;
-			}
-			return 0;
-		}
+	snd_printk("Firmware already loaded, initializing card.\n");
+	
+	if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1) {
+		hdsp->io_type = Multiface;
+	} else {
+		hdsp->io_type = Digiface;
+	}
 
-		if ((err = snd_hdsp_initialize_input_enable(hdsp)) != 0) {
-			return err;
-		}
-		
-		if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
-			snd_printk("card initialization pending : waiting for firmware\n");
-			if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
-				return err;
-			}
-		return 0;
-		} 
-		
-		snd_printk("Firmware already loaded, initializing card.\n");
+	if (is_9652) {
+	        hdsp->io_type = H9652;
+	        snd_hdsp_9652_enable_mixer (hdsp);
+	}
 
-		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1) {
-			hdsp->io_type = Multiface;
-		} else {
-			hdsp->io_type = Digiface;
-		}
-		
-		if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
-			return err;
-		}
-		
-		snd_hdsp_initialize_channels(hdsp);
-		
-		snd_hdsp_initialize_midi_flush(hdsp);
-		
+	if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
+		return err;
 	}
 	
+	snd_hdsp_initialize_channels(hdsp);
+	snd_hdsp_initialize_midi_flush(hdsp);
+
 	hdsp->state |= HDSP_FirmwareLoaded;	
-	
+
 	if ((err = snd_hdsp_create_alsa_devices(card, hdsp)) < 0) {
 		return err;
 	}
-	
+
 	return 0;	
 }
 
@@ -4201,7 +4266,7 @@
 	strcpy(card->shortname, "Hammerfall DSP");
 	sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name, 
 		hdsp->port, hdsp->irq);
-	
+
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
