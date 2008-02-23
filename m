From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] hdsp: Remove all eol tabs/spaces and space
	stuffing
Date: Sat, 23 Feb 2008 14:04:16 -0400
Message-ID: <87b21007d0f9bcd3e481.1203793456@am2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C54224414
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 20:02:24 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so611173rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 11:02:22 -0800 (PST)
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

I have one of these cards and was looking through the file and saw lots of
eol tabs/spaces as well as some space stuffing on various lines.

diff -r 8087414481e8 -r 87b21007d0f9 pci/rme9652/hdsp.c
--- a/pci/rme9652/hdsp.c	Sat Feb 23 11:34:12 2008 +0100
+++ b/pci/rme9652/hdsp.c	Sat Feb 23 14:01:54 2008 -0500
@@ -90,12 +90,12 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 #define HDSP_inputBufferAddress		36
 #define HDSP_controlRegister		64
 #define HDSP_interruptConfirmation	96
-#define HDSP_outputEnable	  	128
+#define HDSP_outputEnable		128
 #define HDSP_control2Reg		256
-#define HDSP_midiDataOut0  		352
-#define HDSP_midiDataOut1  		356
-#define HDSP_fifoData  			368
-#define HDSP_inputEnable	 	384
+#define HDSP_midiDataOut0		352
+#define HDSP_midiDataOut1		356
+#define HDSP_fifoData			368
+#define HDSP_inputEnable		384
 
 /* Read registers. These are defined as byte-offsets from the iobase value
  */
@@ -113,7 +113,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 
 /* the meters are regular i/o-mapped registers, but offset
    considerably from the rest. the peak registers are reset
-   when read; the least-significant 4 bits are full-scale counters; 
+   when read; the least-significant 4 bits are full-scale counters;
    the actual peak value is in the most-significant 24 bits.
 */
 
@@ -131,7 +131,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11
    26*3 values are read in ss mode
    14*3 in ds mode, with no gap between values
 */
-#define HDSP_9652_peakBase	7164	
+#define HDSP_9652_peakBase	7164
 #define HDSP_9652_rmsBase	4096
 
 /* c.f. the hdsp_9632_meters_t struct */
@@ -155,7 +155,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 #define HDSP_9652_ENABLE_MIXER  0x800
 #define HDSP_TDO                0x10000000
 
-#define HDSP_S_PROGRAM     	(HDSP_PROGRAM|HDSP_CONFIG_MODE_0)
+#define HDSP_S_PROGRAM		(HDSP_PROGRAM|HDSP_CONFIG_MODE_0)
 #define HDSP_S_LOAD		(HDSP_PROGRAM|HDSP_CONFIG_MODE_1)
 
 /* Control Register bits */
@@ -173,12 +173,12 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 #define HDSP_SPDIFEmphasis        (1<<10) /* 0=none, 1=on */
 #define HDSP_SPDIFNonAudio        (1<<11) /* 0=off, 1=on */
 #define HDSP_SPDIFOpticalOut      (1<<12) /* 1=use 1st ADAT connector for SPDIF, 0=do not */
-#define HDSP_SyncRef2             (1<<13) 
-#define HDSP_SPDIFInputSelect0    (1<<14) 
-#define HDSP_SPDIFInputSelect1    (1<<15) 
-#define HDSP_SyncRef0             (1<<16) 
+#define HDSP_SyncRef2             (1<<13)
+#define HDSP_SPDIFInputSelect0    (1<<14)
+#define HDSP_SPDIFInputSelect1    (1<<15)
+#define HDSP_SyncRef0             (1<<16)
 #define HDSP_SyncRef1             (1<<17)
-#define HDSP_AnalogExtensionBoard (1<<18) /* For H9632 cards */ 
+#define HDSP_AnalogExtensionBoard (1<<18) /* For H9632 cards */
 #define HDSP_XLRBreakoutCable     (1<<20) /* For H9632 cards */
 #define HDSP_Midi0InterruptEnable (1<<22)
 #define HDSP_Midi1InterruptEnable (1<<23)
@@ -189,7 +189,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 #define HDSP_DAGain1		  (1<<28)
 #define HDSP_PhoneGain0		  (1<<29)
 #define HDSP_PhoneGain1		  (1<<30)
-#define HDSP_QuadSpeed	  	  (1<<31)
+#define HDSP_QuadSpeed		  (1<<31)
 
 #define HDSP_ADGainMask       (HDSP_ADGain0|HDSP_ADGain1)
 #define HDSP_ADGainMinus10dBV  HDSP_ADGainMask
@@ -312,9 +312,9 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 #define HDSP_SPDIFErrorFlag     (1<<25)
 #define HDSP_BufferID           (1<<26)
 #define HDSP_TimecodeSync       (1<<27)
-#define HDSP_AEBO          	(1<<28) /* H9632 specific Analog Extension Boards */
+#define HDSP_AEBO		(1<<28) /* H9632 specific Analog Extension Boards */
 #define HDSP_AEBI		(1<<29) /* 0 = present, 1 = absent */
-#define HDSP_midi0IRQPending    (1<<30) 
+#define HDSP_midi0IRQPending    (1<<30)
 #define HDSP_midi1IRQPending    (1<<31)
 
 #define HDSP_spdifFrequencyMask    (HDSP_spdifFrequency0|HDSP_spdifFrequency1|HDSP_spdifFrequency2)
@@ -391,7 +391,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11
 #define HDSP_CHANNEL_BUFFER_BYTES    (4*HDSP_CHANNEL_BUFFER_SAMPLES)
 
 /* the size of the area we need to allocate for DMA transfers. the
-   size is the same regardless of the number of channels - the 
+   size is the same regardless of the number of channels - the
    Multiface still uses the same memory area.
 
    Note that we allocate 1 more channel than is apparently needed
@@ -441,7 +441,7 @@ struct hdsp {
 	spinlock_t            lock;
 	struct snd_pcm_substream *capture_substream;
 	struct snd_pcm_substream *playback_substream;
-        struct hdsp_midi      midi[2];
+	struct hdsp_midi      midi[2];
 	struct tasklet_struct midi_tasklet;
 	int		      use_midi_tasklet;
 	int                   precise_ptr;
@@ -452,15 +452,15 @@ struct hdsp {
 	int                   clock_source_locked;
 	char                 *card_name;	     /* digiface/multiface */
 	enum HDSP_IO_Type     io_type;               /* ditto, but for code use */
-        unsigned short        firmware_rev;
+	unsigned short        firmware_rev;
 	unsigned short	      state;		     /* stores state bits */
 	u32		      firmware_cache[24413]; /* this helps recover from accidental iobox power failure */
-	size_t                period_bytes; 	     /* guess what this is */
+	size_t                period_bytes;	     /* guess what this is */
 	unsigned char	      max_channels;
 	unsigned char	      qs_in_channels;	     /* quad speed mode for H9632 */
 	unsigned char         ds_in_channels;
 	unsigned char         ss_in_channels;	    /* different for multiface/digiface */
-	unsigned char	      qs_out_channels;	    
+	unsigned char	      qs_out_channels;
 	unsigned char         ds_out_channels;
 	unsigned char         ss_out_channels;
 
@@ -477,13 +477,13 @@ struct hdsp {
 	int                   dev;
 	int                   irq;
 	unsigned long         port;
-        void __iomem         *iobase;
+	void __iomem         *iobase;
 	struct snd_card *card;
 	struct snd_pcm *pcm;
 	struct snd_hwdep          *hwdep;
 	struct pci_dev       *pci;
 	struct snd_kcontrol *spdif_ctl;
-        unsigned short        mixer_matrix[HDSP_MATRIX_MIXER_SIZE];
+	unsigned short        mixer_matrix[HDSP_MATRIX_MIXER_SIZE];
 	unsigned int          dds_value; /* last value written to freq register */
 };
 
@@ -502,9 +502,9 @@ static char channel_map_df_ss[HDSP_MAX_C
 
 static char channel_map_mf_ss[HDSP_MAX_CHANNELS] = { /* Multiface */
 	/* Analog */
-	0, 1, 2, 3, 4, 5, 6, 7, 
+	0, 1, 2, 3, 4, 5, 6, 7,
 	/* ADAT 2 */
-	16, 17, 18, 19, 20, 21, 22, 23, 
+	16, 17, 18, 19, 20, 21, 22, 23,
 	/* SPDIF */
 	24, 25,
 	-1, -1, -1, -1, -1, -1, -1, -1
@@ -525,11 +525,11 @@ static char channel_map_H9632_ss[HDSP_MA
 	/* SPDIF */
 	8, 9,
 	/* Analog */
-	10, 11, 
+	10, 11,
 	/* AO4S-192 and AI4S-192 extension boards */
 	12, 13, 14, 15,
 	/* others don't exist */
-	-1, -1, -1, -1, -1, -1, -1, -1, 
+	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1
 };
 
@@ -539,7 +539,7 @@ static char channel_map_H9632_ds[HDSP_MA
 	/* SPDIF */
 	8, 9,
 	/* Analog */
-	10, 11, 
+	10, 11,
 	/* AO4S-192 and AI4S-192 extension boards */
 	12, 13, 14, 15,
 	/* others don't exist */
@@ -587,7 +587,7 @@ static struct pci_device_id snd_hdsp_ids
 static struct pci_device_id snd_hdsp_ids[] = {
 	{
 		.vendor = PCI_VENDOR_ID_XILINX,
-		.device = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP, 
+		.device = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 	}, /* RME Hammerfall-DSP */
@@ -670,19 +670,19 @@ static int snd_hdsp_load_firmware_from_c
 	unsigned long flags;
 
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
-		
+
 		snd_printk ("Hammerfall-DSP: loading firmware\n");
 
 		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
-		
+
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("Hammerfall-DSP: timeout waiting for download preparation\n");
 			return -EIO;
 		}
-		
+
 		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_LOAD);
-		
+
 		for (i = 0; i < 24413; ++i) {
 			hdsp_write(hdsp, HDSP_fifoData, hdsp->firmware_cache[i]);
 			if (hdsp_fifo_wait (hdsp, 127, HDSP_LONG_WAIT)) {
@@ -692,10 +692,10 @@ static int snd_hdsp_load_firmware_from_c
 		}
 
 		ssleep(3);
-		
+
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("Hammerfall-DSP: timeout at end of firmware loading\n");
-		    	return -EIO;
+			return -EIO;
 		}
 
 #ifdef SNDRV_BIG_ENDIAN
@@ -705,15 +705,15 @@ static int snd_hdsp_load_firmware_from_c
 #endif
 		hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
 		snd_printk ("Hammerfall-DSP: finished firmware loading\n");
-		
+
 	}
 	if (hdsp->state & HDSP_InitializationComplete) {
 		snd_printk(KERN_INFO "Hammerfall-DSP: firmware loaded from cache, restoring defaults\n");
 		spin_lock_irqsave(&hdsp->lock, flags);
 		snd_hdsp_set_defaults(hdsp);
-		spin_unlock_irqrestore(&hdsp->lock, flags); 
-	}
-	
+		spin_unlock_irqrestore(&hdsp->lock, flags);
+	}
+
 	hdsp->state |= HDSP_FirmwareLoaded;
 
 	return 0;
@@ -722,7 +722,7 @@ static int hdsp_get_iobox_version (struc
 static int hdsp_get_iobox_version (struct hdsp *hdsp)
 {
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
-	
+
 		hdsp_write (hdsp, HDSP_control2Reg, HDSP_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0)
@@ -738,7 +738,7 @@ static int hdsp_get_iobox_version (struc
 			hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
 		} else {
 			hdsp->io_type = Digiface;
-		} 
+		}
 	} else {
 		/* firmware was already loaded, get iobox type */
 		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1)
@@ -786,13 +786,13 @@ static int hdsp_check_for_firmware (stru
 
 
 static int hdsp_fifo_wait(struct hdsp *hdsp, int count, int timeout)
-{    
+{
 	int i;
 
 	/* the fifoStatus registers reports on how many words
 	   are available in the command FIFO.
 	*/
-	
+
 	for (i = 0; i < timeout; i++) {
 
 		if ((int)(hdsp_read (hdsp, HDSP_fifoStatus) & 0xff) <= count)
@@ -824,11 +824,11 @@ static int hdsp_write_gain(struct hdsp *
 
 	if (addr >= HDSP_MATRIX_MIXER_SIZE)
 		return -1;
-	
+
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632) {
 
 		/* from martin bjornsen:
-		   
+
 		   "You can only write dwords to the
 		   mixer memory which contain two
 		   mixer values in the low and high
@@ -847,7 +847,7 @@ static int hdsp_write_gain(struct hdsp *
 
 		hdsp->mixer_matrix[addr] = data;
 
-		
+
 		/* `addr' addresses a 16-bit wide address, but
 		   the address space accessed via hdsp_write
 		   uses byte offsets. put another way, addr
@@ -856,17 +856,17 @@ static int hdsp_write_gain(struct hdsp *
 		   to access 0 to 2703 ...
 		*/
 		ad = addr/2;
-	
-		hdsp_write (hdsp, 4096 + (ad*4), 
-			    (hdsp->mixer_matrix[(addr&0x7fe)+1] << 16) + 
+
+		hdsp_write (hdsp, 4096 + (ad*4),
+			    (hdsp->mixer_matrix[(addr&0x7fe)+1] << 16) +
 			    hdsp->mixer_matrix[addr&0x7fe]);
-		
+
 		return 0;
 
 	} else {
 
 		ad = (addr << 16) + data;
-		
+
 		if (hdsp_fifo_wait(hdsp, 127, HDSP_LONG_WAIT))
 			return -1;
 
@@ -902,7 +902,7 @@ static int hdsp_spdif_sample_rate(struct
 
 	if (status & HDSP_SPDIFErrorFlag)
 		return 0;
-	
+
 	switch (rate_bits) {
 	case HDSP_spdifFrequency32KHz: return 32000;
 	case HDSP_spdifFrequency44_1KHz: return 44100;
@@ -910,13 +910,13 @@ static int hdsp_spdif_sample_rate(struct
 	case HDSP_spdifFrequency64KHz: return 64000;
 	case HDSP_spdifFrequency88_2KHz: return 88200;
 	case HDSP_spdifFrequency96KHz: return 96000;
-	case HDSP_spdifFrequency128KHz: 
+	case HDSP_spdifFrequency128KHz:
 		if (hdsp->io_type == H9632) return 128000;
 		break;
-	case HDSP_spdifFrequency176_4KHz: 
+	case HDSP_spdifFrequency176_4KHz:
 		if (hdsp->io_type == H9632) return 176400;
 		break;
-	case HDSP_spdifFrequency192KHz: 
+	case HDSP_spdifFrequency192KHz:
 		if (hdsp->io_type == H9632) return 192000;
 		break;
 	default:
@@ -1027,7 +1027,7 @@ static void hdsp_set_dds_value(struct hd
 {
 	u64 n;
 	u32 r;
-	
+
 	if (rate >= 112000)
 		rate /= 4;
 	else if (rate >= 56000)
@@ -1053,35 +1053,35 @@ static int hdsp_set_rate(struct hdsp *hd
 	   there is no need for it (e.g. during module
 	   initialization).
 	*/
-	
-	if (!(hdsp->control_register & HDSP_ClockModeMaster)) {	
+
+	if (!(hdsp->control_register & HDSP_ClockModeMaster)) {
 		if (called_internally) {
 			/* request from ctl or card initialization */
 			snd_printk(KERN_ERR "Hammerfall-DSP: device is not running as a clock master: cannot set sample rate.\n");
 			return -1;
-		} else {		
+		} else {
 			/* hw_param request while in AutoSync mode */
 			int external_freq = hdsp_external_sample_rate(hdsp);
 			int spdif_freq = hdsp_spdif_sample_rate(hdsp);
-		
+
 			if ((spdif_freq == external_freq*2) && (hdsp_autosync_ref(hdsp) >= HDSP_AUTOSYNC_FROM_ADAT1))
 				snd_printk(KERN_INFO "Hammerfall-DSP: Detected ADAT in double speed mode\n");
 			else if (hdsp->io_type == H9632 && (spdif_freq == external_freq*4) && (hdsp_autosync_ref(hdsp) >= HDSP_AUTOSYNC_FROM_ADAT1))
-				snd_printk(KERN_INFO "Hammerfall-DSP: Detected ADAT in quad speed mode\n");			
+				snd_printk(KERN_INFO "Hammerfall-DSP: Detected ADAT in quad speed mode\n");
 			else if (rate != external_freq) {
 				snd_printk(KERN_INFO "Hammerfall-DSP: No AutoSync source for requested rate\n");
 				return -1;
-			}		
-		}	
+			}
+		}
 	}
 
 	current_rate = hdsp->system_sample_rate;
 
 	/* Changing from a "single speed" to a "double speed" rate is
 	   not allowed if any substreams are open. This is because
-	   such a change causes a shift in the location of 
+	   such a change causes a shift in the location of
 	   the DMA buffers and a reduction in the number of available
-	   buffers. 
+	   buffers.
 
 	   Note that a similar but essentially insoluble problem
 	   exists for externally-driven rate changes. All we can do
@@ -1089,7 +1089,7 @@ static int hdsp_set_rate(struct hdsp *hd
 
 	if (rate > 96000 && hdsp->io_type != H9632)
 		return -EINVAL;
-	
+
 	switch (rate) {
 	case 32000:
 		if (current_rate > 48000)
@@ -1179,7 +1179,7 @@ static int hdsp_set_rate(struct hdsp *hd
 			break;
 		}
 	}
-	
+
 	hdsp->system_sample_rate = rate;
 
 	return 0;
@@ -1245,16 +1245,16 @@ static int snd_hdsp_midi_output_write (s
 	unsigned char buf[128];
 
 	/* Output is not interrupt driven */
-		
+
 	spin_lock_irqsave (&hmidi->lock, flags);
 	if (hmidi->output) {
 		if (!snd_rawmidi_transmit_empty (hmidi->output)) {
 			if ((n_pending = snd_hdsp_midi_output_possible (hmidi->hdsp, hmidi->id)) > 0) {
 				if (n_pending > (int)sizeof (buf))
 					n_pending = sizeof (buf);
-				
+
 				if ((to_write = snd_rawmidi_transmit (hmidi->output, buf, n_pending)) > 0) {
-					for (i = 0; i < to_write; ++i) 
+					for (i = 0; i < to_write; ++i)
 						snd_hdsp_midi_write_byte (hmidi->hdsp, hmidi->id, buf[i]);
 				}
 			}
@@ -1325,14 +1325,14 @@ static void snd_hdsp_midi_output_timer(u
 {
 	struct hdsp_midi *hmidi = (struct hdsp_midi *) data;
 	unsigned long flags;
-	
+
 	snd_hdsp_midi_output_write(hmidi);
 	spin_lock_irqsave (&hmidi->lock, flags);
 
 	/* this does not bump hmidi->istimer, because the
 	   kernel automatically removed the timer when it
 	   expired, and we are now adding it back, thus
-	   leaving istimer wherever it was set before.  
+	   leaving istimer wherever it was set before.
 	*/
 
 	if (hmidi->istimer) {
@@ -1501,7 +1501,7 @@ static int snd_hdsp_control_spdif_get(st
 static int snd_hdsp_control_spdif_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_hdsp_convert_to_aes(&ucontrol->value.iec958, hdsp->creg_spdif);
 	return 0;
 }
@@ -1511,7 +1511,7 @@ static int snd_hdsp_control_spdif_put(st
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_hdsp_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&hdsp->lock);
 	change = val != hdsp->creg_spdif;
@@ -1530,7 +1530,7 @@ static int snd_hdsp_control_spdif_stream
 static int snd_hdsp_control_spdif_stream_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_hdsp_convert_to_aes(&ucontrol->value.iec958, hdsp->creg_spdif_stream);
 	return 0;
 }
@@ -1540,7 +1540,7 @@ static int snd_hdsp_control_spdif_stream
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_hdsp_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&hdsp->lock);
 	change = val != hdsp->creg_spdif_stream;
@@ -1602,7 +1602,7 @@ static int snd_hdsp_get_spdif_in(struct 
 static int snd_hdsp_get_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_spdif_in(hdsp);
 	return 0;
 }
@@ -1612,7 +1612,7 @@ static int snd_hdsp_put_spdif_in(struct 
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0] % ((hdsp->io_type == H9632) ? 4 : 3);
@@ -1649,7 +1649,7 @@ static int snd_hdsp_get_spdif_out(struct
 static int snd_hdsp_get_spdif_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_out(hdsp);
 	return 0;
 }
@@ -1659,7 +1659,7 @@ static int snd_hdsp_put_spdif_out(struct
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1693,7 +1693,7 @@ static int snd_hdsp_get_spdif_profession
 static int snd_hdsp_get_spdif_professional(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_professional(hdsp);
 	return 0;
 }
@@ -1703,7 +1703,7 @@ static int snd_hdsp_put_spdif_profession
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1737,7 +1737,7 @@ static int snd_hdsp_get_spdif_emphasis(s
 static int snd_hdsp_get_spdif_emphasis(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_emphasis(hdsp);
 	return 0;
 }
@@ -1747,7 +1747,7 @@ static int snd_hdsp_put_spdif_emphasis(s
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1781,7 +1781,7 @@ static int snd_hdsp_get_spdif_nonaudio(s
 static int snd_hdsp_get_spdif_nonaudio(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_nonaudio(hdsp);
 	return 0;
 }
@@ -1791,7 +1791,7 @@ static int snd_hdsp_put_spdif_nonaudio(s
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1828,7 +1828,7 @@ static int snd_hdsp_get_spdif_sample_rat
 static int snd_hdsp_get_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	switch (hdsp_spdif_sample_rate(hdsp)) {
 	case 32000:
 		ucontrol->value.enumerated.item[0] = 0;
@@ -1858,7 +1858,7 @@ static int snd_hdsp_get_spdif_sample_rat
 		ucontrol->value.enumerated.item[0] = 9;
 		break;
 	default:
-		ucontrol->value.enumerated.item[0] = 6;		
+		ucontrol->value.enumerated.item[0] = 6;
 	}
 	return 0;
 }
@@ -1882,7 +1882,7 @@ static int snd_hdsp_get_system_sample_ra
 static int snd_hdsp_get_system_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp->system_sample_rate;
 	return 0;
 }
@@ -1899,7 +1899,7 @@ static int snd_hdsp_info_autosync_sample
 static int snd_hdsp_info_autosync_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};	
+	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = (hdsp->io_type == H9632) ? 10 : 7 ;
@@ -1912,7 +1912,7 @@ static int snd_hdsp_get_autosync_sample_
 static int snd_hdsp_get_autosync_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	switch (hdsp_external_sample_rate(hdsp)) {
 	case 32000:
 		ucontrol->value.enumerated.item[0] = 0;
@@ -1940,9 +1940,9 @@ static int snd_hdsp_get_autosync_sample_
 		break;
 	case 192000:
 		ucontrol->value.enumerated.item[0] = 9;
-		break;	
+		break;
 	default:
-		ucontrol->value.enumerated.item[0] = 6;		
+		ucontrol->value.enumerated.item[0] = 6;
 	}
 	return 0;
 }
@@ -1968,7 +1968,7 @@ static int snd_hdsp_info_system_clock_mo
 static int snd_hdsp_info_system_clock_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Master", "Slave" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 2;
@@ -1981,7 +1981,7 @@ static int snd_hdsp_get_system_clock_mod
 static int snd_hdsp_get_system_clock_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_system_clock_mode(hdsp);
 	return 0;
 }
@@ -2018,7 +2018,7 @@ static int hdsp_clock_source(struct hdsp
 		case 192000:
 			return 9;
 		default:
-			return 3;	
+			return 3;
 		}
 	} else {
 		return 0;
@@ -2032,7 +2032,7 @@ static int hdsp_set_clock_source(struct 
 	case HDSP_CLOCK_SOURCE_AUTOSYNC:
 		if (hdsp_external_sample_rate(hdsp) != 0) {
 		    if (!hdsp_set_rate(hdsp, hdsp_external_sample_rate(hdsp), 1)) {
-			hdsp->control_register &= ~HDSP_ClockModeMaster;		
+			hdsp->control_register &= ~HDSP_ClockModeMaster;
 			hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
 			return 0;
 		    }
@@ -2043,7 +2043,7 @@ static int hdsp_set_clock_source(struct 
 		break;
 	case HDSP_CLOCK_SOURCE_INTERNAL_44_1KHZ:
 		rate = 44100;
-		break;	    
+		break;
 	case HDSP_CLOCK_SOURCE_INTERNAL_48KHZ:
 		rate = 48000;
 		break;
@@ -2078,13 +2078,13 @@ static int snd_hdsp_info_clock_source(st
 {
 	static char *texts[] = {"AutoSync", "Internal 32.0 kHz", "Internal 44.1 kHz", "Internal 48.0 kHz", "Internal 64.0 kHz", "Internal 88.2 kHz", "Internal 96.0 kHz", "Internal 128 kHz", "Internal 176.4 kHz", "Internal 192.0 KHz" };
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	if (hdsp->io_type == H9632)
 	    uinfo->value.enumerated.items = 10;
 	else
-	    uinfo->value.enumerated.items = 7;	
+	    uinfo->value.enumerated.items = 7;
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
@@ -2094,7 +2094,7 @@ static int snd_hdsp_get_clock_source(str
 static int snd_hdsp_get_clock_source(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_clock_source(hdsp);
 	return 0;
 }
@@ -2104,7 +2104,7 @@ static int snd_hdsp_put_clock_source(str
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2130,7 +2130,7 @@ static int snd_hdsp_get_clock_source_loc
 static int snd_hdsp_get_clock_source_lock(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp->clock_source_locked;
 	return 0;
 }
@@ -2165,7 +2165,7 @@ static int hdsp_da_gain(struct hdsp *hds
 	case HDSP_DAGainMinus10dBV:
 		return 2;
 	default:
-		return 1;	
+		return 1;
 	}
 }
 
@@ -2180,8 +2180,8 @@ static int hdsp_set_da_gain(struct hdsp 
 		hdsp->control_register |= HDSP_DAGainPlus4dBu;
 		break;
 	case 2:
-		hdsp->control_register |= HDSP_DAGainMinus10dBV;		
-		break;	    
+		hdsp->control_register |= HDSP_DAGainMinus10dBV;
+		break;
 	default:
 		return -1;
 
@@ -2193,7 +2193,7 @@ static int snd_hdsp_info_da_gain(struct 
 static int snd_hdsp_info_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Hi Gain", "+4 dBu", "-10 dbV"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2206,7 +2206,7 @@ static int snd_hdsp_get_da_gain(struct s
 static int snd_hdsp_get_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_da_gain(hdsp);
 	return 0;
 }
@@ -2216,7 +2216,7 @@ static int snd_hdsp_put_da_gain(struct s
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2250,7 +2250,7 @@ static int hdsp_ad_gain(struct hdsp *hds
 	case HDSP_ADGainLowGain:
 		return 2;
 	default:
-		return 1;	
+		return 1;
 	}
 }
 
@@ -2262,11 +2262,11 @@ static int hdsp_set_ad_gain(struct hdsp 
 		hdsp->control_register |= HDSP_ADGainMinus10dBV;
 		break;
 	case 1:
-		hdsp->control_register |= HDSP_ADGainPlus4dBu;		
+		hdsp->control_register |= HDSP_ADGainPlus4dBu;
 		break;
 	case 2:
-		hdsp->control_register |= HDSP_ADGainLowGain;		
-		break;	    
+		hdsp->control_register |= HDSP_ADGainLowGain;
+		break;
 	default:
 		return -1;
 
@@ -2278,7 +2278,7 @@ static int snd_hdsp_info_ad_gain(struct 
 static int snd_hdsp_info_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"-10 dBV", "+4 dBu", "Lo Gain"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2291,7 +2291,7 @@ static int snd_hdsp_get_ad_gain(struct s
 static int snd_hdsp_get_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_ad_gain(hdsp);
 	return 0;
 }
@@ -2301,7 +2301,7 @@ static int snd_hdsp_put_ad_gain(struct s
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2335,7 +2335,7 @@ static int hdsp_phone_gain(struct hdsp *
 	case HDSP_PhoneGainMinus12dB:
 		return 2;
 	default:
-		return 0;	
+		return 0;
 	}
 }
 
@@ -2347,11 +2347,11 @@ static int hdsp_set_phone_gain(struct hd
 		hdsp->control_register |= HDSP_PhoneGain0dB;
 		break;
 	case 1:
-		hdsp->control_register |= HDSP_PhoneGainMinus6dB;		
+		hdsp->control_register |= HDSP_PhoneGainMinus6dB;
 		break;
 	case 2:
-		hdsp->control_register |= HDSP_PhoneGainMinus12dB;		
-		break;	    
+		hdsp->control_register |= HDSP_PhoneGainMinus12dB;
+		break;
 	default:
 		return -1;
 
@@ -2363,7 +2363,7 @@ static int snd_hdsp_info_phone_gain(stru
 static int snd_hdsp_info_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"0 dB", "-6 dB", "-12 dB"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2376,7 +2376,7 @@ static int snd_hdsp_get_phone_gain(struc
 static int snd_hdsp_get_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_phone_gain(hdsp);
 	return 0;
 }
@@ -2386,7 +2386,7 @@ static int snd_hdsp_put_phone_gain(struc
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2432,7 +2432,7 @@ static int snd_hdsp_get_xlr_breakout_cab
 static int snd_hdsp_get_xlr_breakout_cable(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_xlr_breakout_cable(hdsp);
 	return 0;
 }
@@ -2442,7 +2442,7 @@ static int snd_hdsp_put_xlr_breakout_cab
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2488,7 +2488,7 @@ static int snd_hdsp_get_aeb(struct snd_k
 static int snd_hdsp_get_aeb(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_aeb(hdsp);
 	return 0;
 }
@@ -2498,7 +2498,7 @@ static int snd_hdsp_put_aeb(struct snd_k
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2576,7 +2576,7 @@ static int snd_hdsp_info_pref_sync_ref(s
 {
 	static char *texts[] = {"Word", "IEC958", "ADAT1", "ADAT Sync", "ADAT2", "ADAT3" };
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 
@@ -2595,7 +2595,7 @@ static int snd_hdsp_info_pref_sync_ref(s
 		uinfo->value.enumerated.items = 0;
 		break;
 	}
-		
+
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
@@ -2605,7 +2605,7 @@ static int snd_hdsp_get_pref_sync_ref(st
 static int snd_hdsp_get_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_pref_sync_ref(hdsp);
 	return 0;
 }
@@ -2615,7 +2615,7 @@ static int snd_hdsp_put_pref_sync_ref(st
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change, max;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 
@@ -2664,7 +2664,7 @@ static int hdsp_autosync_ref(struct hdsp
 	case HDSP_SelSyncRef_SPDIF:
 		return HDSP_AUTOSYNC_FROM_SPDIF;
 	case HDSP_SelSyncRefMask:
-		return HDSP_AUTOSYNC_FROM_NONE;	
+		return HDSP_AUTOSYNC_FROM_NONE;
 	case HDSP_SelSyncRef_ADAT1:
 		return HDSP_AUTOSYNC_FROM_ADAT1;
 	case HDSP_SelSyncRef_ADAT2:
@@ -2680,7 +2680,7 @@ static int snd_hdsp_info_autosync_ref(st
 static int snd_hdsp_info_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Word", "ADAT Sync", "IEC958", "None", "ADAT1", "ADAT2", "ADAT3" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 7;
@@ -2693,7 +2693,7 @@ static int snd_hdsp_get_autosync_ref(str
 static int snd_hdsp_get_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_autosync_ref(hdsp);
 	return 0;
 }
@@ -2727,7 +2727,7 @@ static int snd_hdsp_get_line_out(struct 
 static int snd_hdsp_get_line_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp_line_out(hdsp);
 	spin_unlock_irq(&hdsp->lock);
@@ -2739,7 +2739,7 @@ static int snd_hdsp_put_line_out(struct 
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2773,7 +2773,7 @@ static int snd_hdsp_get_precise_pointer(
 static int snd_hdsp_get_precise_pointer(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp->precise_ptr;
 	spin_unlock_irq(&hdsp->lock);
@@ -2785,7 +2785,7 @@ static int snd_hdsp_put_precise_pointer(
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2819,7 +2819,7 @@ static int snd_hdsp_get_use_midi_tasklet
 static int snd_hdsp_get_use_midi_tasklet(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp->use_midi_tasklet;
 	spin_unlock_irq(&hdsp->lock);
@@ -2831,7 +2831,7 @@ static int snd_hdsp_put_use_midi_tasklet
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2873,12 +2873,12 @@ static int snd_hdsp_get_mixer(struct snd
 
 	source = ucontrol->value.integer.value[0];
 	destination = ucontrol->value.integer.value[1];
-	
+
 	if (source >= hdsp->max_channels)
 		addr = hdsp_playback_to_output_key(hdsp,source-hdsp->max_channels,destination);
 	else
 		addr = hdsp_input_to_output_key(hdsp,source, destination);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[2] = hdsp_read_gain (hdsp, addr);
 	spin_unlock_irq(&hdsp->lock);
@@ -2926,7 +2926,7 @@ static int snd_hdsp_put_mixer(struct snd
 
 static int snd_hdsp_info_sync_check(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"No Lock", "Lock", "Sync" };	
+	static char *texts[] = {"No Lock", "Lock", "Sync" };
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2971,7 +2971,7 @@ static int hdsp_spdif_sync_check(struct 
 	int status = hdsp_read(hdsp, HDSP_statusRegister);
 	if (status & HDSP_SPDIFErrorFlag)
 		return 0;
-	else {	
+	else {
 		if (status & HDSP_SPDIFSync)
 			return 2;
 		else
@@ -3007,7 +3007,7 @@ static int hdsp_adatsync_sync_check(stru
 			return 1;
 	} else
 		return 0;
-}	
+}
 
 static int snd_hdsp_get_adatsync_sync_check(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
@@ -3025,17 +3025,17 @@ static int snd_hdsp_get_adatsync_sync_ch
 }
 
 static int hdsp_adat_sync_check(struct hdsp *hdsp, int idx)
-{	
+{
 	int status = hdsp_read(hdsp, HDSP_statusRegister);
-	
+
 	if (status & (HDSP_Lock0>>idx)) {
 		if (status & (HDSP_Sync0>>idx))
 			return 2;
 		else
-			return 1;		
+			return 1;
 	} else
 		return 0;
-} 
+}
 
 static int snd_hdsp_get_adat_sync_check(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
@@ -3053,7 +3053,7 @@ static int snd_hdsp_get_adat_sync_check(
 		break;
 	case Multiface:
 	case H9632:
-		if (offset >= 1) 
+		if (offset >= 1)
 			return -EINVAL;
 		break;
 	default:
@@ -3115,7 +3115,7 @@ static int snd_hdsp_get_dds_offset(struc
 static int snd_hdsp_get_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_dds_offset(hdsp);
 	return 0;
 }
@@ -3125,7 +3125,7 @@ static int snd_hdsp_put_dds_offset(struc
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -3169,8 +3169,8 @@ static struct snd_kcontrol_new snd_hdsp_
 	.info =		snd_hdsp_control_spdif_mask_info,
 	.get =		snd_hdsp_control_spdif_mask_get,
 	.private_value = IEC958_AES0_NONAUDIO |
-  			 IEC958_AES0_PROFESSIONAL |
-			 IEC958_AES0_CON_EMPHASIS,	                                                                                      
+			 IEC958_AES0_PROFESSIONAL |
+			 IEC958_AES0_CON_EMPHASIS,
 },
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
@@ -3188,7 +3188,7 @@ HDSP_SPDIF_PROFESSIONAL("IEC958 Professi
 HDSP_SPDIF_PROFESSIONAL("IEC958 Professional Bit", 0),
 HDSP_SPDIF_EMPHASIS("IEC958 Emphasis Bit", 0),
 HDSP_SPDIF_NON_AUDIO("IEC958 Non-audio Bit", 0),
-/* 'Sample Clock Source' complies with the alsa control naming scheme */ 
+/* 'Sample Clock Source' complies with the alsa control naming scheme */
 HDSP_CLOCK_SOURCE("Sample Clock Source", 0),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -3240,7 +3240,7 @@ static int snd_hdsp_create_controls(stru
 				return err;
 		}
 	}
-	
+
 	/* DA, AD and Phone gain and XLR breakout cable controls for H9632 cards */
 	if (hdsp->io_type == H9632) {
 		for (idx = 0; idx < ARRAY_SIZE(snd_hdsp_9632_controls); idx++) {
@@ -3259,7 +3259,7 @@ static int snd_hdsp_create_controls(stru
 }
 
 /*------------------------------------------------------------
-   /proc interface 
+   /proc interface
  ------------------------------------------------------------*/
 
 static void
@@ -3277,7 +3277,7 @@ snd_hdsp_proc_read(struct snd_info_entry
 	if (hdsp_check_for_iobox (hdsp)) {
 		snd_iprintf(buffer, "No I/O box connected.\nPlease connect one and upload firmware.\n");
 		return;
-        }
+	}
 
 	if (hdsp_check_for_firmware(hdsp, 0)) {
 		if (hdsp->state & HDSP_FirmwareCached) {
@@ -3298,7 +3298,7 @@ snd_hdsp_proc_read(struct snd_info_entry
 			}
 		}
 	}
-	
+
 	status = hdsp_read(hdsp, HDSP_statusRegister);
 	status2 = hdsp_read(hdsp, HDSP_status2Register);
 
@@ -3362,17 +3362,17 @@ snd_hdsp_proc_read(struct snd_info_entry
 		break;
 		case HDSP_CLOCK_SOURCE_INTERNAL_192KHZ:
 		clock_source = "Internal 192 kHz";
-		break;	
+		break;
 	default:
-		clock_source = "Error";		
+		clock_source = "Error";
 	}
 	snd_iprintf (buffer, "Sample Clock Source: %s\n", clock_source);
-			
+
 	if (hdsp_system_clock_mode(hdsp))
 		system_clock_mode = "Slave";
 	else
 		system_clock_mode = "Master";
-	
+
 	switch (hdsp_pref_sync_ref (hdsp)) {
 	case HDSP_SYNC_FROM_WORD:
 		pref_sync_ref = "Word Clock";
@@ -3397,7 +3397,7 @@ snd_hdsp_proc_read(struct snd_info_entry
 		break;
 	}
 	snd_iprintf (buffer, "Preferred Sync Reference: %s\n", pref_sync_ref);
-	
+
 	switch (hdsp_autosync_ref (hdsp)) {
 	case HDSP_AUTOSYNC_FROM_WORD:
 		autosync_ref = "Word Clock";
@@ -3410,7 +3410,7 @@ snd_hdsp_proc_read(struct snd_info_entry
 		break;
 	case HDSP_AUTOSYNC_FROM_NONE:
 		autosync_ref = "None";
-		break;	
+		break;
 	case HDSP_AUTOSYNC_FROM_ADAT1:
 		autosync_ref = "ADAT1";
 		break;
@@ -3425,14 +3425,14 @@ snd_hdsp_proc_read(struct snd_info_entry
 		break;
 	}
 	snd_iprintf (buffer, "AutoSync Reference: %s\n", autosync_ref);
-	
+
 	snd_iprintf (buffer, "AutoSync Frequency: %d\n", hdsp_external_sample_rate(hdsp));
-	
+
 	snd_iprintf (buffer, "System Clock Mode: %s\n", system_clock_mode);
 
 	snd_iprintf (buffer, "System Clock Frequency: %d\n", hdsp->system_sample_rate);
 	snd_iprintf (buffer, "System Clock Locked: %s\n", hdsp->clock_source_locked ? "Yes" : "No");
-		
+
 	snd_iprintf(buffer, "\n");
 
 	switch (hdsp_spdif_in(hdsp)) {
@@ -3452,7 +3452,7 @@ snd_hdsp_proc_read(struct snd_info_entry
 		snd_iprintf(buffer, "IEC958 input: ???\n");
 		break;
 	}
-	
+
 	if (hdsp->control_register & HDSP_SPDIFOpticalOut)
 		snd_iprintf(buffer, "IEC958 output: Coaxial & ADAT1\n");
 	else
@@ -3510,13 +3510,13 @@ snd_hdsp_proc_read(struct snd_info_entry
 		snd_iprintf (buffer, "SPDIF: No Lock\n");
 	else
 		snd_iprintf (buffer, "SPDIF: %s\n", x ? "Sync" : "Lock");
-	
+
 	x = status2 & HDSP_wc_sync;
 	if (status2 & HDSP_wc_lock)
 		snd_iprintf (buffer, "Word Clock: %s\n", x ? "Sync" : "Lock");
 	else
 		snd_iprintf (buffer, "Word Clock: No Lock\n");
-	
+
 	x = status & HDSP_TimecodeSync;
 	if (status & HDSP_TimecodeLock)
 		snd_iprintf(buffer, "ADAT Sync: %s\n", x ? "Sync" : "Lock");
@@ -3524,11 +3524,11 @@ snd_hdsp_proc_read(struct snd_info_entry
 		snd_iprintf(buffer, "ADAT Sync: No Lock\n");
 
 	snd_iprintf(buffer, "\n");
-	
+
 	/* Informations about H9632 specific controls */
 	if (hdsp->io_type == H9632) {
 		char *tmp;
-	
+
 		switch (hdsp_ad_gain(hdsp)) {
 		case 0:
 			tmp = "-10 dBV";
@@ -3554,7 +3554,7 @@ snd_hdsp_proc_read(struct snd_info_entry
 			break;
 		}
 		snd_iprintf(buffer, "DA Gain : %s\n", tmp);
-		
+
 		switch (hdsp_phone_gain(hdsp)) {
 		case 0:
 			tmp = "0 dB";
@@ -3568,8 +3568,8 @@ snd_hdsp_proc_read(struct snd_info_entry
 		}
 		snd_iprintf(buffer, "Phones Gain : %s\n", tmp);
 
-		snd_iprintf(buffer, "XLR Breakout Cable : %s\n", hdsp_xlr_breakout_cable(hdsp) ? "yes" : "no");	
-		
+		snd_iprintf(buffer, "XLR Breakout Cable : %s\n", hdsp_xlr_breakout_cable(hdsp) ? "yes" : "no");
+
 		if (hdsp->control_register & HDSP_AnalogExtensionBoard)
 			snd_iprintf(buffer, "AEB : on (ADAT1 internal)\n");
 		else
@@ -3632,18 +3632,18 @@ static int snd_hdsp_set_defaults(struct 
 
 	/* set defaults:
 
-	   SPDIF Input via Coax 
+	   SPDIF Input via Coax
 	   Master clock mode
 	   maximum latency (7 => 2^7 = 8192 samples, 64Kbyte buffer,
 	                    which implies 2 4096 sample, 32Kbyte periods).
-           Enable line out.			    
+	   Enable line out.
 	 */
 
-	hdsp->control_register = HDSP_ClockModeMaster | 
-		                 HDSP_SPDIFInputCoaxial | 
-		                 hdsp_encode_latency(7) | 
+	hdsp->control_register = HDSP_ClockModeMaster |
+		                 HDSP_SPDIFInputCoaxial |
+		                 hdsp_encode_latency(7) |
 		                 HDSP_LineOut;
-	
+
 
 	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
 
@@ -3661,7 +3661,7 @@ static int snd_hdsp_set_defaults(struct 
 	hdsp_compute_period_size(hdsp);
 
 	/* silence everything */
-	
+
 	for (i = 0; i < HDSP_MATRIX_MIXER_SIZE; ++i)
 		hdsp->mixer_matrix[i] = MINUS_INFINITY_GAIN;
 
@@ -3669,7 +3669,7 @@ static int snd_hdsp_set_defaults(struct 
 		if (hdsp_write_gain (hdsp, i, MINUS_INFINITY_GAIN))
 			return -EIO;
 	}
-	
+
 	/* H9632 specific defaults */
 	if (hdsp->io_type == H9632) {
 		hdsp->control_register |= (HDSP_DAGainPlus4dBu | HDSP_ADGainPlus4dBu | HDSP_PhoneGain0dB);
@@ -3687,12 +3687,12 @@ static void hdsp_midi_tasklet(unsigned l
 static void hdsp_midi_tasklet(unsigned long arg)
 {
 	struct hdsp *hdsp = (struct hdsp *)arg;
-	
+
 	if (hdsp->midi[0].pending)
 		snd_hdsp_midi_input_read (&hdsp->midi[0]);
 	if (hdsp->midi[1].pending)
 		snd_hdsp_midi_input_read (&hdsp->midi[1]);
-} 
+}
 
 static irqreturn_t snd_hdsp_interrupt(int irq, void *dev_id)
 {
@@ -3704,7 +3704,7 @@ static irqreturn_t snd_hdsp_interrupt(in
 	unsigned int midi0status;
 	unsigned int midi1status;
 	int schedule = 0;
-	
+
 	status = hdsp_read(hdsp, HDSP_statusRegister);
 
 	audio = status & HDSP_audioIRQPending;
@@ -3718,15 +3718,15 @@ static irqreturn_t snd_hdsp_interrupt(in
 
 	midi0status = hdsp_read (hdsp, HDSP_midiStatusIn0) & 0xff;
 	midi1status = hdsp_read (hdsp, HDSP_midiStatusIn1) & 0xff;
-	
+
 	if (audio) {
 		if (hdsp->capture_substream)
 			snd_pcm_period_elapsed(hdsp->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream);
-		
+
 		if (hdsp->playback_substream)
 			snd_pcm_period_elapsed(hdsp->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream);
 	}
-	
+
 	if (midi0 && midi0status) {
 		if (hdsp->use_midi_tasklet) {
 			/* we disable interrupts for this input until processing is done */
@@ -3767,11 +3767,11 @@ static char *hdsp_channel_buffer_locatio
 {
 	int mapped_channel;
 
-        snd_assert(channel >= 0 && channel < hdsp->max_channels, return NULL);
-        
+	snd_assert(channel >= 0 && channel < hdsp->max_channels, return NULL);
+
 	if ((mapped_channel = hdsp->channel_map[channel]) < 0)
 		return NULL;
-	
+
 	if (stream == SNDRV_PCM_STREAM_CAPTURE)
 		return hdsp->capture_buffer + (mapped_channel * HDSP_CHANNEL_BUFFER_BYTES);
 	else
@@ -3894,7 +3894,7 @@ static int snd_hdsp_hw_params(struct snd
 		/* We're fine. */
 
 		spin_unlock_irq(&hdsp->lock);
- 		return 0;
+		return 0;
 
 	} else {
 		spin_unlock_irq(&hdsp->lock);
@@ -3958,7 +3958,7 @@ static int snd_hdsp_trigger(struct snd_p
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *other;
 	int running;
-	
+
 	if (hdsp_check_for_iobox (hdsp))
 		return -EIO;
 
@@ -4052,10 +4052,10 @@ static struct snd_pcm_hardware snd_hdsp_
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
 #endif
 	.rates =		(SNDRV_PCM_RATE_32000 |
-				 SNDRV_PCM_RATE_44100 | 
-				 SNDRV_PCM_RATE_48000 | 
-				 SNDRV_PCM_RATE_64000 | 
-				 SNDRV_PCM_RATE_88200 | 
+				 SNDRV_PCM_RATE_44100 |
+				 SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_64000 |
+				 SNDRV_PCM_RATE_88200 |
 				 SNDRV_PCM_RATE_96000),
 	.rate_min =		32000,
 	.rate_max =		96000,
@@ -4081,10 +4081,10 @@ static struct snd_pcm_hardware snd_hdsp_
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
 #endif
 	.rates =		(SNDRV_PCM_RATE_32000 |
-				 SNDRV_PCM_RATE_44100 | 
-				 SNDRV_PCM_RATE_48000 | 
-				 SNDRV_PCM_RATE_64000 | 
-				 SNDRV_PCM_RATE_88200 | 
+				 SNDRV_PCM_RATE_44100 |
+				 SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_64000 |
+				 SNDRV_PCM_RATE_88200 |
 				 SNDRV_PCM_RATE_96000),
 	.rate_min =		32000,
 	.rate_max =		96000,
@@ -4163,7 +4163,7 @@ static int snd_hdsp_hw_rule_in_channels_
 			.max = hdsp->qs_in_channels,
 			.integer = 1,
 		};
-		return snd_interval_refine(c, &t);	
+		return snd_interval_refine(c, &t);
 	} else if (r->min > 48000 && r->max <= 96000) {
 		struct snd_interval t = {
 			.min = hdsp->ds_in_channels,
@@ -4194,7 +4194,7 @@ static int snd_hdsp_hw_rule_out_channels
 			.max = hdsp->qs_out_channels,
 			.integer = 1,
 		};
-		return snd_interval_refine(c, &t);	
+		return snd_interval_refine(c, &t);
 	} else if (r->min > 48000 && r->max <= 96000) {
 		struct snd_interval t = {
 			.min = hdsp->ds_out_channels,
@@ -4290,7 +4290,7 @@ static int snd_hdsp_playback_open(struct
 
 	snd_pcm_set_sync(substream);
 
-        runtime->hw = snd_hdsp_playback_subinfo;
+	runtime->hw = snd_hdsp_playback_subinfo;
 	runtime->dma_area = hdsp->playback_buffer;
 	runtime->dma_bytes = HDSP_DMA_AREA_BYTES;
 
@@ -4311,8 +4311,8 @@ static int snd_hdsp_playback_open(struct
 	if (hdsp->io_type == H9632) {
 		runtime->hw.channels_min = hdsp->qs_out_channels;
 		runtime->hw.channels_max = hdsp->ss_out_channels;
-	}	
-	
+	}
+
 	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 			     snd_hdsp_hw_rule_out_channels, hdsp,
 			     SNDRV_PCM_HW_PARAM_CHANNELS, -1);
@@ -4529,7 +4529,7 @@ static int hdsp_get_peak(struct hdsp *hd
 				hdsp->iobase + HDSP_playbackRmsLevel + i * 8 + 4,
 				hdsp->iobase + HDSP_playbackRmsLevel + i * 8))
 			return -EFAULT;
-		if (copy_u64_le(&peak_rms->input_rms[i], 
+		if (copy_u64_le(&peak_rms->input_rms[i],
 				hdsp->iobase + HDSP_inputRmsLevel + i * 8 + 4,
 				hdsp->iobase + HDSP_inputRmsLevel + i * 8))
 			return -EFAULT;
@@ -4539,7 +4539,7 @@ static int hdsp_get_peak(struct hdsp *hd
 
 static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct hdsp *hdsp = (struct hdsp *)hw->private_data;	
+	struct hdsp *hdsp = (struct hdsp *)hw->private_data;
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
@@ -4564,9 +4564,9 @@ static int snd_hdsp_hwdep_ioctl(struct s
 		struct hdsp_config_info info;
 		unsigned long flags;
 		int i;
-		
+
 		if (!(hdsp->state & HDSP_FirmwareLoaded)) {
-			snd_printk(KERN_ERR "Hammerfall-DSP: Firmware needs to be uploaded to the card.\n");	
+			snd_printk(KERN_ERR "Hammerfall-DSP: Firmware needs to be uploaded to the card.\n");
 			return -EINVAL;
 		}
 		spin_lock_irqsave(&hdsp->lock, flags);
@@ -4594,7 +4594,7 @@ static int snd_hdsp_hwdep_ioctl(struct s
 			info.ad_gain = (unsigned char)hdsp_ad_gain(hdsp);
 			info.phone_gain = (unsigned char)hdsp_phone_gain(hdsp);
 			info.xlr_breakout_cable = (unsigned char)hdsp_xlr_breakout_cable(hdsp);
-		
+
 		}
 		if (hdsp->io_type == H9632 || hdsp->io_type == H9652)
 			info.analog_extension_board = (unsigned char)hdsp_aeb(hdsp);
@@ -4605,7 +4605,7 @@ static int snd_hdsp_hwdep_ioctl(struct s
 	}
 	case SNDRV_HDSP_IOCTL_GET_9632_AEB: {
 		struct hdsp_9632_aeb h9632_aeb;
-		
+
 		if (hdsp->io_type != H9632) return -EINVAL;
 		h9632_aeb.aebi = hdsp->ss_in_channels - H9632_SS_CHANNELS;
 		h9632_aeb.aebo = hdsp->ss_out_channels - H9632_SS_CHANNELS;
@@ -4616,7 +4616,7 @@ static int snd_hdsp_hwdep_ioctl(struct s
 	case SNDRV_HDSP_IOCTL_GET_VERSION: {
 		struct hdsp_version hdsp_version;
 		int err;
-		
+
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
 		if (hdsp->io_type == Undefined) {
 			if ((err = hdsp_get_iobox_version(hdsp)) < 0)
@@ -4625,14 +4625,14 @@ static int snd_hdsp_hwdep_ioctl(struct s
 		hdsp_version.io_type = hdsp->io_type;
 		hdsp_version.firmware_rev = hdsp->firmware_rev;
 		if ((err = copy_to_user(argp, &hdsp_version, sizeof(hdsp_version))))
-		    	return -EFAULT;
+			return -EFAULT;
 		break;
 	}
 	case SNDRV_HDSP_IOCTL_UPLOAD_FIRMWARE: {
 		struct hdsp_firmware __user *firmware;
 		u32 __user *firmware_data;
 		int err;
-		
+
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
 		/* SNDRV_HDSP_IOCTL_GET_VERSION must have been called */
 		if (hdsp->io_type == Undefined) return -EINVAL;
@@ -4645,25 +4645,25 @@ static int snd_hdsp_hwdep_ioctl(struct s
 
 		if (get_user(firmware_data, &firmware->firmware_data))
 			return -EFAULT;
-		
+
 		if (hdsp_check_for_iobox (hdsp))
 			return -EIO;
 
 		if (copy_from_user(hdsp->firmware_cache, firmware_data, sizeof(hdsp->firmware_cache)) != 0)
 			return -EFAULT;
-		
+
 		hdsp->state |= HDSP_FirmwareCached;
 
 		if ((err = snd_hdsp_load_firmware_from_cache(hdsp)) < 0)
 			return err;
-		
+
 		if (!(hdsp->state & HDSP_InitializationComplete)) {
 			if ((err = snd_hdsp_enable_io(hdsp)) < 0)
 				return err;
-			
-			snd_hdsp_initialize_channels(hdsp);		
+
+			snd_hdsp_initialize_channels(hdsp);
 			snd_hdsp_initialize_midi_flush(hdsp);
-	    
+
 			if ((err = snd_hdsp_create_alsa_devices(hdsp->card, hdsp)) < 0) {
 				snd_printk(KERN_ERR "Hammerfall-DSP: error creating alsa devices\n");
 				return err;
@@ -4710,10 +4710,10 @@ static int snd_hdsp_create_hwdep(struct 
 {
 	struct snd_hwdep *hw;
 	int err;
-	
+
 	if ((err = snd_hwdep_new(card, "HDSP hwdep", 0, &hw)) < 0)
 		return err;
-		
+
 	hdsp->hwdep = hw;
 	hw->private_data = hdsp;
 	strcpy(hw->name, "HDSP hwdep interface");
@@ -4721,7 +4721,7 @@ static int snd_hdsp_create_hwdep(struct 
 	hw->ops.open = snd_hdsp_hwdep_dummy_op;
 	hw->ops.ioctl = snd_hdsp_hwdep_ioctl;
 	hw->ops.release = snd_hdsp_hwdep_dummy_op;
-		
+
 	return 0;
 }
 
@@ -4747,31 +4747,31 @@ static int snd_hdsp_create_pcm(struct sn
 
 static void snd_hdsp_9652_enable_mixer (struct hdsp *hdsp)
 {
-        hdsp->control2_register |= HDSP_9652_ENABLE_MIXER;
+	hdsp->control2_register |= HDSP_9652_ENABLE_MIXER;
 	hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
 }
 
 static int snd_hdsp_enable_io (struct hdsp *hdsp)
 {
 	int i;
-	
+
 	if (hdsp_fifo_wait (hdsp, 0, 100)) {
 		snd_printk(KERN_ERR "Hammerfall-DSP: enable_io fifo_wait failed\n");
 		return -EIO;
 	}
-	
+
 	for (i = 0; i < hdsp->max_channels; ++i) {
 		hdsp_write (hdsp, HDSP_inputEnable + (4 * i), 1);
 		hdsp_write (hdsp, HDSP_outputEnable + (4 * i), 1);
 	}
-	
+
 	return 0;
 }
 
 static void snd_hdsp_initialize_channels(struct hdsp *hdsp)
 {
 	int status, aebi_channels, aebo_channels;
-	
+
 	switch (hdsp->io_type) {
 	case Digiface:
 		hdsp->card_name = "RME Hammerfall DSP + Digiface";
@@ -4784,7 +4784,7 @@ static void snd_hdsp_initialize_channels
 		hdsp->ss_in_channels = hdsp->ss_out_channels = H9652_SS_CHANNELS;
 		hdsp->ds_in_channels = hdsp->ds_out_channels = H9652_DS_CHANNELS;
 		break;
-	
+
 	case H9632:
 		status = hdsp_read(hdsp, HDSP_statusRegister);
 		/* HDSP_AEBx bits are low when AEB are connected */
@@ -4804,9 +4804,9 @@ static void snd_hdsp_initialize_channels
 		hdsp->ss_in_channels = hdsp->ss_out_channels = MULTIFACE_SS_CHANNELS;
 		hdsp->ds_in_channels = hdsp->ds_out_channels = MULTIFACE_DS_CHANNELS;
 		break;
-		
+
 	default:
- 		/* should never get here */
+		/* should never get here */
 		break;
 	}
 }
@@ -4820,12 +4820,12 @@ static int snd_hdsp_create_alsa_devices(
 static int snd_hdsp_create_alsa_devices(struct snd_card *card, struct hdsp *hdsp)
 {
 	int err;
-	
+
 	if ((err = snd_hdsp_create_pcm(card, hdsp)) < 0) {
 		snd_printk(KERN_ERR "Hammerfall-DSP: Error creating pcm interface\n");
 		return err;
 	}
-	
+
 
 	if ((err = snd_hdsp_create_midi(card, hdsp, 0)) < 0) {
 		snd_printk(KERN_ERR "Hammerfall-DSP: Error creating first midi interface\n");
@@ -4856,19 +4856,19 @@ static int snd_hdsp_create_alsa_devices(
 		snd_printk(KERN_ERR "Hammerfall-DSP: Error setting default values\n");
 		return err;
 	}
-	
+
 	if (!(hdsp->state & HDSP_InitializationComplete)) {
 		strcpy(card->shortname, "Hammerfall DSP");
-		sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name, 
+		sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name,
 			hdsp->port, hdsp->irq);
-	    
+
 		if ((err = snd_card_register(card)) < 0) {
 			snd_printk(KERN_ERR "Hammerfall-DSP: error registering card\n");
 			return err;
 		}
 		hdsp->state |= HDSP_InitializationComplete;
 	}
-	
+
 	return 0;
 }
 
@@ -4879,7 +4879,7 @@ static int hdsp_request_fw_loader(struct
 	const char *fwfile;
 	const struct firmware *fw;
 	int err;
-		
+
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
 		return 0;
 	if (hdsp->io_type == Undefined) {
@@ -4888,7 +4888,7 @@ static int hdsp_request_fw_loader(struct
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
 			return 0;
 	}
-	
+
 	/* caution: max length of firmware filename is 30! */
 	switch (hdsp->io_type) {
 	case Multiface:
@@ -4922,12 +4922,12 @@ static int hdsp_request_fw_loader(struct
 	memcpy(hdsp->firmware_cache, fw->data, sizeof(hdsp->firmware_cache));
 
 	release_firmware(fw);
-		
+
 	hdsp->state |= HDSP_FirmwareCached;
 
 	if ((err = snd_hdsp_load_firmware_from_cache(hdsp)) < 0)
 		return err;
-		
+
 	if (!(hdsp->state & HDSP_InitializationComplete)) {
 		if ((err = snd_hdsp_enable_io(hdsp)) < 0)
 			return err;
@@ -4974,14 +4974,14 @@ static int __devinit snd_hdsp_create(str
 	hdsp->max_channels = 26;
 
 	hdsp->card = card;
-	
+
 	spin_lock_init(&hdsp->lock);
 
 	tasklet_init(&hdsp->midi_tasklet, hdsp_midi_tasklet, (unsigned long)hdsp);
-	
+
 	pci_read_config_word(hdsp->pci, PCI_CLASS_REVISION, &hdsp->firmware_rev);
 	hdsp->firmware_rev &= 0xff;
-	
+
 	/* From Martin Bjoernsen :
 	    "It is important that the card's latency timer register in
 	    the PCI configuration space is set to a value much larger
@@ -4990,7 +4990,7 @@ static int __devinit snd_hdsp_create(str
 	    to its maximum 255 to avoid problems with some computers."
 	*/
 	pci_write_config_byte(hdsp->pci, PCI_LATENCY_TIMER, 0xFF);
-	
+
 	strcpy(card->driver, "H-DSP");
 	strcpy(card->mixername, "Xilinx FPGA");
 
@@ -5004,7 +5004,7 @@ static int __devinit snd_hdsp_create(str
 	} else {
 		hdsp->card_name = "RME HDSP 9632";
 		hdsp->max_channels = 16;
-		is_9632 = 1;	
+		is_9632 = 1;
 	}
 
 	if ((err = pci_enable_device(pci)) < 0)
@@ -5033,7 +5033,7 @@ static int __devinit snd_hdsp_create(str
 
 	if ((err = snd_hdsp_initialize_memory(hdsp)) < 0)
 		return err;
-	
+
 	if (!is_9652 && !is_9632) {
 		/* we wait 2 seconds to let freshly inserted cardbus cards do their hardware init */
 		ssleep(2);
@@ -5056,35 +5056,35 @@ static int __devinit snd_hdsp_create(str
 				return err;
 			return 0;
 		} else {
-			snd_printk(KERN_INFO "Hammerfall-DSP: Firmware already present, initializing card.\n");	    
+			snd_printk(KERN_INFO "Hammerfall-DSP: Firmware already present, initializing card.\n");
 			if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1)
 				hdsp->io_type = Multiface;
-			else 
+			else
 				hdsp->io_type = Digiface;
 		}
 	}
-	
+
 	if ((err = snd_hdsp_enable_io(hdsp)) != 0)
 		return err;
-	
+
 	if (is_9652)
 	        hdsp->io_type = H9652;
-	
+
 	if (is_9632)
 		hdsp->io_type = H9632;
 
 	if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0)
 		return err;
-	
+
 	snd_hdsp_initialize_channels(hdsp);
 	snd_hdsp_initialize_midi_flush(hdsp);
 
-	hdsp->state |= HDSP_FirmwareLoaded;	
+	hdsp->state |= HDSP_FirmwareLoaded;
 
 	if ((err = snd_hdsp_create_alsa_devices(card, hdsp)) < 0)
 		return err;
 
-	return 0;	
+	return 0;
 }
 
 static int snd_hdsp_free(struct hdsp *hdsp)
@@ -5100,13 +5100,13 @@ static int snd_hdsp_free(struct hdsp *hd
 		free_irq(hdsp->irq, (void *)hdsp);
 
 	snd_hdsp_free_buffers(hdsp);
-	
+
 	if (hdsp->iobase)
 		iounmap(hdsp->iobase);
 
 	if (hdsp->port)
 		pci_release_regions(hdsp->pci);
-		
+
 	pci_disable_device(hdsp->pci);
 	return 0;
 }
@@ -5149,7 +5149,7 @@ static int __devinit snd_hdsp_probe(stru
 	}
 
 	strcpy(card->shortname, "Hammerfall DSP");
-	sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name, 
+	sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name,
 		hdsp->port, hdsp->irq);
 
 	if ((err = snd_card_register(card)) < 0) {
