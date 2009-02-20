From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] ALSA: hdsp - whitespace cleanup
Date: Fri, 20 Feb 2009 19:38:16 +0100
Message-ID: <20090220193816.0242b07c@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id CC76F10381D
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 19:38:18 +0100 (CET)
Received: from thinkpad (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-6) with ESMTP id n1KIcH1S021334
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 19:38:18 +0100
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

Impact: remove trailing spaces

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/rme9652/hdsp.c |  474 +++++++++++++++++++++++-----------------------
 1 files changed, 237 insertions(+), 237 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index a586a80..796b989 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -113,7 +113,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
 
 /* the meters are regular i/o-mapped registers, but offset
    considerably from the rest. the peak registers are reset
-   when read; the least-significant 4 bits are full-scale counters; 
+   when read; the least-significant 4 bits are full-scale counters;
    the actual peak value is in the most-significant 24 bits.
 */
 
@@ -131,7 +131,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
    26*3 values are read in ss mode
    14*3 in ds mode, with no gap between values
 */
-#define HDSP_9652_peakBase	7164	
+#define HDSP_9652_peakBase	7164
 #define HDSP_9652_rmsBase	4096
 
 /* c.f. the hdsp_9632_meters_t struct */
@@ -173,12 +173,12 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
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
@@ -314,7 +314,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
 #define HDSP_TimecodeSync       (1<<27)
 #define HDSP_AEBO          	(1<<28) /* H9632 specific Analog Extension Boards */
 #define HDSP_AEBI		(1<<29) /* 0 = present, 1 = absent */
-#define HDSP_midi0IRQPending    (1<<30) 
+#define HDSP_midi0IRQPending    (1<<30)
 #define HDSP_midi1IRQPending    (1<<31)
 
 #define HDSP_spdifFrequencyMask    (HDSP_spdifFrequency0|HDSP_spdifFrequency1|HDSP_spdifFrequency2)
@@ -391,7 +391,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
 #define HDSP_CHANNEL_BUFFER_BYTES    (4*HDSP_CHANNEL_BUFFER_SAMPLES)
 
 /* the size of the area we need to allocate for DMA transfers. the
-   size is the same regardless of the number of channels - the 
+   size is the same regardless of the number of channels - the
    Multiface still uses the same memory area.
 
    Note that we allocate 1 more channel than is apparently needed
@@ -460,7 +460,7 @@ struct hdsp {
 	unsigned char	      qs_in_channels;	     /* quad speed mode for H9632 */
 	unsigned char         ds_in_channels;
 	unsigned char         ss_in_channels;	    /* different for multiface/digiface */
-	unsigned char	      qs_out_channels;	    
+	unsigned char	      qs_out_channels;
 	unsigned char         ds_out_channels;
 	unsigned char         ss_out_channels;
 
@@ -502,9 +502,9 @@ static char channel_map_df_ss[HDSP_MAX_CHANNELS] = {
 
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
@@ -525,11 +525,11 @@ static char channel_map_H9632_ss[HDSP_MAX_CHANNELS] = {
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
 
@@ -539,7 +539,7 @@ static char channel_map_H9632_ds[HDSP_MAX_CHANNELS] = {
 	/* SPDIF */
 	8, 9,
 	/* Analog */
-	10, 11, 
+	10, 11,
 	/* AO4S-192 and AI4S-192 extension boards */
 	12, 13, 14, 15,
 	/* others don't exist */
@@ -587,7 +587,7 @@ static void snd_hammerfall_free_buffer(struct snd_dma_buffer *dmab, struct pci_d
 static struct pci_device_id snd_hdsp_ids[] = {
 	{
 		.vendor = PCI_VENDOR_ID_XILINX,
-		.device = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP, 
+		.device = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP,
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 	}, /* RME Hammerfall-DSP */
@@ -689,19 +689,19 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
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
@@ -711,7 +711,7 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 		}
 
 		ssleep(3);
-		
+
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("Hammerfall-DSP: timeout at end of firmware loading\n");
 		    	return -EIO;
@@ -724,15 +724,15 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
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
+		spin_unlock_irqrestore(&hdsp->lock, flags);
 	}
-	
+
 	hdsp->state |= HDSP_FirmwareLoaded;
 
 	return 0;
@@ -741,7 +741,7 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 static int hdsp_get_iobox_version (struct hdsp *hdsp)
 {
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
-	
+
 		hdsp_write (hdsp, HDSP_control2Reg, HDSP_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0)
@@ -757,7 +757,7 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 			hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
 		} else {
 			hdsp->io_type = Digiface;
-		} 
+		}
 	} else {
 		/* firmware was already loaded, get iobox type */
 		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1)
@@ -805,13 +805,13 @@ static int hdsp_check_for_firmware (struct hdsp *hdsp, int load_on_demand)
 
 
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
@@ -843,11 +843,11 @@ static int hdsp_write_gain(struct hdsp *hdsp, unsigned int addr, unsigned short
 
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
@@ -866,7 +866,7 @@ static int hdsp_write_gain(struct hdsp *hdsp, unsigned int addr, unsigned short
 
 		hdsp->mixer_matrix[addr] = data;
 
-		
+
 		/* `addr' addresses a 16-bit wide address, but
 		   the address space accessed via hdsp_write
 		   uses byte offsets. put another way, addr
@@ -875,17 +875,17 @@ static int hdsp_write_gain(struct hdsp *hdsp, unsigned int addr, unsigned short
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
 
@@ -921,7 +921,7 @@ static int hdsp_spdif_sample_rate(struct hdsp *hdsp)
 
 	if (status & HDSP_SPDIFErrorFlag)
 		return 0;
-	
+
 	switch (rate_bits) {
 	case HDSP_spdifFrequency32KHz: return 32000;
 	case HDSP_spdifFrequency44_1KHz: return 44100;
@@ -929,13 +929,13 @@ static int hdsp_spdif_sample_rate(struct hdsp *hdsp)
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
@@ -1046,7 +1046,7 @@ static void hdsp_set_dds_value(struct hdsp *hdsp, int rate)
 {
 	u64 n;
 	u32 r;
-	
+
 	if (rate >= 112000)
 		rate /= 4;
 	else if (rate >= 56000)
@@ -1072,35 +1072,35 @@ static int hdsp_set_rate(struct hdsp *hdsp, int rate, int called_internally)
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
@@ -1108,7 +1108,7 @@ static int hdsp_set_rate(struct hdsp *hdsp, int rate, int called_internally)
 
 	if (rate > 96000 && hdsp->io_type != H9632)
 		return -EINVAL;
-	
+
 	switch (rate) {
 	case 32000:
 		if (current_rate > 48000)
@@ -1198,7 +1198,7 @@ static int hdsp_set_rate(struct hdsp *hdsp, int rate, int called_internally)
 			break;
 		}
 	}
-	
+
 	hdsp->system_sample_rate = rate;
 
 	return 0;
@@ -1264,16 +1264,16 @@ static int snd_hdsp_midi_output_write (struct hdsp_midi *hmidi)
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
@@ -1344,14 +1344,14 @@ static void snd_hdsp_midi_output_timer(unsigned long data)
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
@@ -1520,7 +1520,7 @@ static int snd_hdsp_control_spdif_info(struct snd_kcontrol *kcontrol, struct snd
 static int snd_hdsp_control_spdif_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_hdsp_convert_to_aes(&ucontrol->value.iec958, hdsp->creg_spdif);
 	return 0;
 }
@@ -1530,7 +1530,7 @@ static int snd_hdsp_control_spdif_put(struct snd_kcontrol *kcontrol, struct snd_
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_hdsp_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&hdsp->lock);
 	change = val != hdsp->creg_spdif;
@@ -1549,7 +1549,7 @@ static int snd_hdsp_control_spdif_stream_info(struct snd_kcontrol *kcontrol, str
 static int snd_hdsp_control_spdif_stream_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_hdsp_convert_to_aes(&ucontrol->value.iec958, hdsp->creg_spdif_stream);
 	return 0;
 }
@@ -1559,7 +1559,7 @@ static int snd_hdsp_control_spdif_stream_put(struct snd_kcontrol *kcontrol, stru
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_hdsp_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&hdsp->lock);
 	change = val != hdsp->creg_spdif_stream;
@@ -1621,7 +1621,7 @@ static int snd_hdsp_info_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_
 static int snd_hdsp_get_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_spdif_in(hdsp);
 	return 0;
 }
@@ -1631,7 +1631,7 @@ static int snd_hdsp_put_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0] % ((hdsp->io_type == H9632) ? 4 : 3);
@@ -1668,7 +1668,7 @@ static int hdsp_set_spdif_output(struct hdsp *hdsp, int out)
 static int snd_hdsp_get_spdif_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_out(hdsp);
 	return 0;
 }
@@ -1678,7 +1678,7 @@ static int snd_hdsp_put_spdif_out(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1712,7 +1712,7 @@ static int hdsp_set_spdif_professional(struct hdsp *hdsp, int val)
 static int snd_hdsp_get_spdif_professional(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_professional(hdsp);
 	return 0;
 }
@@ -1722,7 +1722,7 @@ static int snd_hdsp_put_spdif_professional(struct snd_kcontrol *kcontrol, struct
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1756,7 +1756,7 @@ static int hdsp_set_spdif_emphasis(struct hdsp *hdsp, int val)
 static int snd_hdsp_get_spdif_emphasis(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_emphasis(hdsp);
 	return 0;
 }
@@ -1766,7 +1766,7 @@ static int snd_hdsp_put_spdif_emphasis(struct snd_kcontrol *kcontrol, struct snd
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1800,7 +1800,7 @@ static int hdsp_set_spdif_nonaudio(struct hdsp *hdsp, int val)
 static int snd_hdsp_get_spdif_nonaudio(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_nonaudio(hdsp);
 	return 0;
 }
@@ -1810,7 +1810,7 @@ static int snd_hdsp_put_spdif_nonaudio(struct snd_kcontrol *kcontrol, struct snd
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1847,7 +1847,7 @@ static int snd_hdsp_info_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct
 static int snd_hdsp_get_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	switch (hdsp_spdif_sample_rate(hdsp)) {
 	case 32000:
 		ucontrol->value.enumerated.item[0] = 0;
@@ -1877,7 +1877,7 @@ static int snd_hdsp_get_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct
 		ucontrol->value.enumerated.item[0] = 9;
 		break;
 	default:
-		ucontrol->value.enumerated.item[0] = 6;		
+		ucontrol->value.enumerated.item[0] = 6;
 	}
 	return 0;
 }
@@ -1901,7 +1901,7 @@ static int snd_hdsp_info_system_sample_rate(struct snd_kcontrol *kcontrol, struc
 static int snd_hdsp_get_system_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp->system_sample_rate;
 	return 0;
 }
@@ -1918,7 +1918,7 @@ static int snd_hdsp_get_system_sample_rate(struct snd_kcontrol *kcontrol, struct
 static int snd_hdsp_info_autosync_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};	
+	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = (hdsp->io_type == H9632) ? 10 : 7 ;
@@ -1931,7 +1931,7 @@ static int snd_hdsp_info_autosync_sample_rate(struct snd_kcontrol *kcontrol, str
 static int snd_hdsp_get_autosync_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	switch (hdsp_external_sample_rate(hdsp)) {
 	case 32000:
 		ucontrol->value.enumerated.item[0] = 0;
@@ -1959,9 +1959,9 @@ static int snd_hdsp_get_autosync_sample_rate(struct snd_kcontrol *kcontrol, stru
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
@@ -1987,7 +1987,7 @@ static int hdsp_system_clock_mode(struct hdsp *hdsp)
 static int snd_hdsp_info_system_clock_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Master", "Slave" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 2;
@@ -2000,7 +2000,7 @@ static int snd_hdsp_info_system_clock_mode(struct snd_kcontrol *kcontrol, struct
 static int snd_hdsp_get_system_clock_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_system_clock_mode(hdsp);
 	return 0;
 }
@@ -2037,7 +2037,7 @@ static int hdsp_clock_source(struct hdsp *hdsp)
 		case 192000:
 			return 9;
 		default:
-			return 3;	
+			return 3;
 		}
 	} else {
 		return 0;
@@ -2051,7 +2051,7 @@ static int hdsp_set_clock_source(struct hdsp *hdsp, int mode)
 	case HDSP_CLOCK_SOURCE_AUTOSYNC:
 		if (hdsp_external_sample_rate(hdsp) != 0) {
 		    if (!hdsp_set_rate(hdsp, hdsp_external_sample_rate(hdsp), 1)) {
-			hdsp->control_register &= ~HDSP_ClockModeMaster;		
+			hdsp->control_register &= ~HDSP_ClockModeMaster;
 			hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
 			return 0;
 		    }
@@ -2062,7 +2062,7 @@ static int hdsp_set_clock_source(struct hdsp *hdsp, int mode)
 		break;
 	case HDSP_CLOCK_SOURCE_INTERNAL_44_1KHZ:
 		rate = 44100;
-		break;	    
+		break;
 	case HDSP_CLOCK_SOURCE_INTERNAL_48KHZ:
 		rate = 48000;
 		break;
@@ -2097,13 +2097,13 @@ static int snd_hdsp_info_clock_source(struct snd_kcontrol *kcontrol, struct snd_
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
@@ -2113,7 +2113,7 @@ static int snd_hdsp_info_clock_source(struct snd_kcontrol *kcontrol, struct snd_
 static int snd_hdsp_get_clock_source(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_clock_source(hdsp);
 	return 0;
 }
@@ -2123,7 +2123,7 @@ static int snd_hdsp_put_clock_source(struct snd_kcontrol *kcontrol, struct snd_c
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2149,7 +2149,7 @@ static int snd_hdsp_put_clock_source(struct snd_kcontrol *kcontrol, struct snd_c
 static int snd_hdsp_get_clock_source_lock(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp->clock_source_locked;
 	return 0;
 }
@@ -2184,7 +2184,7 @@ static int hdsp_da_gain(struct hdsp *hdsp)
 	case HDSP_DAGainMinus10dBV:
 		return 2;
 	default:
-		return 1;	
+		return 1;
 	}
 }
 
@@ -2199,8 +2199,8 @@ static int hdsp_set_da_gain(struct hdsp *hdsp, int mode)
 		hdsp->control_register |= HDSP_DAGainPlus4dBu;
 		break;
 	case 2:
-		hdsp->control_register |= HDSP_DAGainMinus10dBV;		
-		break;	    
+		hdsp->control_register |= HDSP_DAGainMinus10dBV;
+		break;
 	default:
 		return -1;
 
@@ -2212,7 +2212,7 @@ static int hdsp_set_da_gain(struct hdsp *hdsp, int mode)
 static int snd_hdsp_info_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Hi Gain", "+4 dBu", "-10 dbV"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2225,7 +2225,7 @@ static int snd_hdsp_info_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 static int snd_hdsp_get_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_da_gain(hdsp);
 	return 0;
 }
@@ -2235,7 +2235,7 @@ static int snd_hdsp_put_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2269,7 +2269,7 @@ static int hdsp_ad_gain(struct hdsp *hdsp)
 	case HDSP_ADGainLowGain:
 		return 2;
 	default:
-		return 1;	
+		return 1;
 	}
 }
 
@@ -2281,11 +2281,11 @@ static int hdsp_set_ad_gain(struct hdsp *hdsp, int mode)
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
 
@@ -2297,7 +2297,7 @@ static int hdsp_set_ad_gain(struct hdsp *hdsp, int mode)
 static int snd_hdsp_info_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"-10 dBV", "+4 dBu", "Lo Gain"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2310,7 +2310,7 @@ static int snd_hdsp_info_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 static int snd_hdsp_get_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_ad_gain(hdsp);
 	return 0;
 }
@@ -2320,7 +2320,7 @@ static int snd_hdsp_put_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2354,7 +2354,7 @@ static int hdsp_phone_gain(struct hdsp *hdsp)
 	case HDSP_PhoneGainMinus12dB:
 		return 2;
 	default:
-		return 0;	
+		return 0;
 	}
 }
 
@@ -2366,11 +2366,11 @@ static int hdsp_set_phone_gain(struct hdsp *hdsp, int mode)
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
 
@@ -2382,7 +2382,7 @@ static int hdsp_set_phone_gain(struct hdsp *hdsp, int mode)
 static int snd_hdsp_info_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"0 dB", "-6 dB", "-12 dB"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2395,7 +2395,7 @@ static int snd_hdsp_info_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ct
 static int snd_hdsp_get_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_phone_gain(hdsp);
 	return 0;
 }
@@ -2405,7 +2405,7 @@ static int snd_hdsp_put_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2451,7 +2451,7 @@ static int hdsp_set_xlr_breakout_cable(struct hdsp *hdsp, int mode)
 static int snd_hdsp_get_xlr_breakout_cable(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_xlr_breakout_cable(hdsp);
 	return 0;
 }
@@ -2461,7 +2461,7 @@ static int snd_hdsp_put_xlr_breakout_cable(struct snd_kcontrol *kcontrol, struct
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2507,7 +2507,7 @@ static int hdsp_set_aeb(struct hdsp *hdsp, int mode)
 static int snd_hdsp_get_aeb(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_aeb(hdsp);
 	return 0;
 }
@@ -2517,7 +2517,7 @@ static int snd_hdsp_put_aeb(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2595,7 +2595,7 @@ static int snd_hdsp_info_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd
 {
 	static char *texts[] = {"Word", "IEC958", "ADAT1", "ADAT Sync", "ADAT2", "ADAT3" };
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 
@@ -2614,7 +2614,7 @@ static int snd_hdsp_info_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd
 		uinfo->value.enumerated.items = 0;
 		break;
 	}
-		
+
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
@@ -2624,7 +2624,7 @@ static int snd_hdsp_info_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd
 static int snd_hdsp_get_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_pref_sync_ref(hdsp);
 	return 0;
 }
@@ -2634,7 +2634,7 @@ static int snd_hdsp_put_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd_
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change, max;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 
@@ -2683,7 +2683,7 @@ static int hdsp_autosync_ref(struct hdsp *hdsp)
 	case HDSP_SelSyncRef_SPDIF:
 		return HDSP_AUTOSYNC_FROM_SPDIF;
 	case HDSP_SelSyncRefMask:
-		return HDSP_AUTOSYNC_FROM_NONE;	
+		return HDSP_AUTOSYNC_FROM_NONE;
 	case HDSP_SelSyncRef_ADAT1:
 		return HDSP_AUTOSYNC_FROM_ADAT1;
 	case HDSP_SelSyncRef_ADAT2:
@@ -2699,7 +2699,7 @@ static int hdsp_autosync_ref(struct hdsp *hdsp)
 static int snd_hdsp_info_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Word", "ADAT Sync", "IEC958", "None", "ADAT1", "ADAT2", "ADAT3" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 7;
@@ -2712,7 +2712,7 @@ static int snd_hdsp_info_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_
 static int snd_hdsp_get_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_autosync_ref(hdsp);
 	return 0;
 }
@@ -2746,7 +2746,7 @@ static int hdsp_set_line_output(struct hdsp *hdsp, int out)
 static int snd_hdsp_get_line_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp_line_out(hdsp);
 	spin_unlock_irq(&hdsp->lock);
@@ -2758,7 +2758,7 @@ static int snd_hdsp_put_line_out(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2792,7 +2792,7 @@ static int hdsp_set_precise_pointer(struct hdsp *hdsp, int precise)
 static int snd_hdsp_get_precise_pointer(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp->precise_ptr;
 	spin_unlock_irq(&hdsp->lock);
@@ -2804,7 +2804,7 @@ static int snd_hdsp_put_precise_pointer(struct snd_kcontrol *kcontrol, struct sn
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2838,7 +2838,7 @@ static int hdsp_set_use_midi_tasklet(struct hdsp *hdsp, int use_tasklet)
 static int snd_hdsp_get_use_midi_tasklet(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp->use_midi_tasklet;
 	spin_unlock_irq(&hdsp->lock);
@@ -2850,7 +2850,7 @@ static int snd_hdsp_put_use_midi_tasklet(struct snd_kcontrol *kcontrol, struct s
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2892,12 +2892,12 @@ static int snd_hdsp_get_mixer(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 
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
@@ -2945,7 +2945,7 @@ static int snd_hdsp_put_mixer(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 
 static int snd_hdsp_info_sync_check(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"No Lock", "Lock", "Sync" };	
+	static char *texts[] = {"No Lock", "Lock", "Sync" };
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2990,7 +2990,7 @@ static int hdsp_spdif_sync_check(struct hdsp *hdsp)
 	int status = hdsp_read(hdsp, HDSP_statusRegister);
 	if (status & HDSP_SPDIFErrorFlag)
 		return 0;
-	else {	
+	else {
 		if (status & HDSP_SPDIFSync)
 			return 2;
 		else
@@ -3026,7 +3026,7 @@ static int hdsp_adatsync_sync_check(struct hdsp *hdsp)
 			return 1;
 	} else
 		return 0;
-}	
+}
 
 static int snd_hdsp_get_adatsync_sync_check(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
@@ -3044,17 +3044,17 @@ static int snd_hdsp_get_adatsync_sync_check(struct snd_kcontrol *kcontrol, struc
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
@@ -3072,7 +3072,7 @@ static int snd_hdsp_get_adat_sync_check(struct snd_kcontrol *kcontrol, struct sn
 		break;
 	case Multiface:
 	case H9632:
-		if (offset >= 1) 
+		if (offset >= 1)
 			return -EINVAL;
 		break;
 	default:
@@ -3134,7 +3134,7 @@ static int snd_hdsp_info_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ct
 static int snd_hdsp_get_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_dds_offset(hdsp);
 	return 0;
 }
@@ -3144,7 +3144,7 @@ static int snd_hdsp_put_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -3189,7 +3189,7 @@ static struct snd_kcontrol_new snd_hdsp_controls[] = {
 	.get =		snd_hdsp_control_spdif_mask_get,
 	.private_value = IEC958_AES0_NONAUDIO |
   			 IEC958_AES0_PROFESSIONAL |
-			 IEC958_AES0_CON_EMPHASIS,	                                                                                      
+			 IEC958_AES0_CON_EMPHASIS,
 },
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
@@ -3207,7 +3207,7 @@ HDSP_SPDIF_OUT("IEC958 Output also on ADAT1", 0),
 HDSP_SPDIF_PROFESSIONAL("IEC958 Professional Bit", 0),
 HDSP_SPDIF_EMPHASIS("IEC958 Emphasis Bit", 0),
 HDSP_SPDIF_NON_AUDIO("IEC958 Non-audio Bit", 0),
-/* 'Sample Clock Source' complies with the alsa control naming scheme */ 
+/* 'Sample Clock Source' complies with the alsa control naming scheme */
 HDSP_CLOCK_SOURCE("Sample Clock Source", 0),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -3259,7 +3259,7 @@ static int snd_hdsp_create_controls(struct snd_card *card, struct hdsp *hdsp)
 				return err;
 		}
 	}
-	
+
 	/* DA, AD and Phone gain and XLR breakout cable controls for H9632 cards */
 	if (hdsp->io_type == H9632) {
 		for (idx = 0; idx < ARRAY_SIZE(snd_hdsp_9632_controls); idx++) {
@@ -3278,7 +3278,7 @@ static int snd_hdsp_create_controls(struct snd_card *card, struct hdsp *hdsp)
 }
 
 /*------------------------------------------------------------
-   /proc interface 
+   /proc interface
  ------------------------------------------------------------*/
 
 static void
@@ -3317,7 +3317,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 			}
 		}
 	}
-	
+
 	status = hdsp_read(hdsp, HDSP_statusRegister);
 	status2 = hdsp_read(hdsp, HDSP_status2Register);
 
@@ -3381,17 +3381,17 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
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
@@ -3416,7 +3416,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		break;
 	}
 	snd_iprintf (buffer, "Preferred Sync Reference: %s\n", pref_sync_ref);
-	
+
 	switch (hdsp_autosync_ref (hdsp)) {
 	case HDSP_AUTOSYNC_FROM_WORD:
 		autosync_ref = "Word Clock";
@@ -3429,7 +3429,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		break;
 	case HDSP_AUTOSYNC_FROM_NONE:
 		autosync_ref = "None";
-		break;	
+		break;
 	case HDSP_AUTOSYNC_FROM_ADAT1:
 		autosync_ref = "ADAT1";
 		break;
@@ -3444,14 +3444,14 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
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
@@ -3471,7 +3471,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		snd_iprintf(buffer, "IEC958 input: ???\n");
 		break;
 	}
-	
+
 	if (hdsp->control_register & HDSP_SPDIFOpticalOut)
 		snd_iprintf(buffer, "IEC958 output: Coaxial & ADAT1\n");
 	else
@@ -3529,13 +3529,13 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
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
@@ -3543,11 +3543,11 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
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
@@ -3573,7 +3573,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 			break;
 		}
 		snd_iprintf(buffer, "DA Gain : %s\n", tmp);
-		
+
 		switch (hdsp_phone_gain(hdsp)) {
 		case 0:
 			tmp = "0 dB";
@@ -3587,8 +3587,8 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		}
 		snd_iprintf(buffer, "Phones Gain : %s\n", tmp);
 
-		snd_iprintf(buffer, "XLR Breakout Cable : %s\n", hdsp_xlr_breakout_cable(hdsp) ? "yes" : "no");	
-		
+		snd_iprintf(buffer, "XLR Breakout Cable : %s\n", hdsp_xlr_breakout_cable(hdsp) ? "yes" : "no");
+
 		if (hdsp->control_register & HDSP_AnalogExtensionBoard)
 			snd_iprintf(buffer, "AEB : on (ADAT1 internal)\n");
 		else
@@ -3651,18 +3651,18 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
 
 	/* set defaults:
 
-	   SPDIF Input via Coax 
+	   SPDIF Input via Coax
 	   Master clock mode
 	   maximum latency (7 => 2^7 = 8192 samples, 64Kbyte buffer,
 	                    which implies 2 4096 sample, 32Kbyte periods).
-           Enable line out.			    
+           Enable line out.
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
 
@@ -3680,7 +3680,7 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
 	hdsp_compute_period_size(hdsp);
 
 	/* silence everything */
-	
+
 	for (i = 0; i < HDSP_MATRIX_MIXER_SIZE; ++i)
 		hdsp->mixer_matrix[i] = MINUS_INFINITY_GAIN;
 
@@ -3688,7 +3688,7 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
 		if (hdsp_write_gain (hdsp, i, MINUS_INFINITY_GAIN))
 			return -EIO;
 	}
-	
+
 	/* H9632 specific defaults */
 	if (hdsp->io_type == H9632) {
 		hdsp->control_register |= (HDSP_DAGainPlus4dBu | HDSP_ADGainPlus4dBu | HDSP_PhoneGain0dB);
@@ -3706,12 +3706,12 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
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
@@ -3723,7 +3723,7 @@ static irqreturn_t snd_hdsp_interrupt(int irq, void *dev_id)
 	unsigned int midi0status;
 	unsigned int midi1status;
 	int schedule = 0;
-	
+
 	status = hdsp_read(hdsp, HDSP_statusRegister);
 
 	audio = status & HDSP_audioIRQPending;
@@ -3737,15 +3737,15 @@ static irqreturn_t snd_hdsp_interrupt(int irq, void *dev_id)
 
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
@@ -3788,10 +3788,10 @@ static char *hdsp_channel_buffer_location(struct hdsp *hdsp,
 
         if (snd_BUG_ON(channel < 0 || channel >= hdsp->max_channels))
 		return NULL;
-        
+
 	if ((mapped_channel = hdsp->channel_map[channel]) < 0)
 		return NULL;
-	
+
 	if (stream == SNDRV_PCM_STREAM_CAPTURE)
 		return hdsp->capture_buffer + (mapped_channel * HDSP_CHANNEL_BUFFER_BYTES);
 	else
@@ -3984,7 +3984,7 @@ static int snd_hdsp_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *other;
 	int running;
-	
+
 	if (hdsp_check_for_iobox (hdsp))
 		return -EIO;
 
@@ -4078,10 +4078,10 @@ static struct snd_pcm_hardware snd_hdsp_playback_subinfo =
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
@@ -4107,10 +4107,10 @@ static struct snd_pcm_hardware snd_hdsp_capture_subinfo =
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
@@ -4189,7 +4189,7 @@ static int snd_hdsp_hw_rule_in_channels_rate(struct snd_pcm_hw_params *params,
 			.max = hdsp->qs_in_channels,
 			.integer = 1,
 		};
-		return snd_interval_refine(c, &t);	
+		return snd_interval_refine(c, &t);
 	} else if (r->min > 48000 && r->max <= 96000) {
 		struct snd_interval t = {
 			.min = hdsp->ds_in_channels,
@@ -4220,7 +4220,7 @@ static int snd_hdsp_hw_rule_out_channels_rate(struct snd_pcm_hw_params *params,
 			.max = hdsp->qs_out_channels,
 			.integer = 1,
 		};
-		return snd_interval_refine(c, &t);	
+		return snd_interval_refine(c, &t);
 	} else if (r->min > 48000 && r->max <= 96000) {
 		struct snd_interval t = {
 			.min = hdsp->ds_out_channels,
@@ -4337,8 +4337,8 @@ static int snd_hdsp_playback_open(struct snd_pcm_substream *substream)
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
@@ -4555,7 +4555,7 @@ static int hdsp_get_peak(struct hdsp *hdsp, struct hdsp_peak_rms __user *peak_rm
 				hdsp->iobase + HDSP_playbackRmsLevel + i * 8 + 4,
 				hdsp->iobase + HDSP_playbackRmsLevel + i * 8))
 			return -EFAULT;
-		if (copy_u64_le(&peak_rms->input_rms[i], 
+		if (copy_u64_le(&peak_rms->input_rms[i],
 				hdsp->iobase + HDSP_inputRmsLevel + i * 8 + 4,
 				hdsp->iobase + HDSP_inputRmsLevel + i * 8))
 			return -EFAULT;
@@ -4565,7 +4565,7 @@ static int hdsp_get_peak(struct hdsp *hdsp, struct hdsp_peak_rms __user *peak_rm
 
 static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct hdsp *hdsp = (struct hdsp *)hw->private_data;	
+	struct hdsp *hdsp = (struct hdsp *)hw->private_data;
 	void __user *argp = (void __user *)arg;
 	int err;
 
@@ -4599,7 +4599,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 		struct hdsp_config_info info;
 		unsigned long flags;
 		int i;
-		
+
 		err = hdsp_check_for_iobox(hdsp);
 		if (err < 0)
 			return err;
@@ -4633,7 +4633,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 			info.ad_gain = (unsigned char)hdsp_ad_gain(hdsp);
 			info.phone_gain = (unsigned char)hdsp_phone_gain(hdsp);
 			info.xlr_breakout_cable = (unsigned char)hdsp_xlr_breakout_cable(hdsp);
-		
+
 		}
 		if (hdsp->io_type == H9632 || hdsp->io_type == H9652)
 			info.analog_extension_board = (unsigned char)hdsp_aeb(hdsp);
@@ -4644,7 +4644,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 	}
 	case SNDRV_HDSP_IOCTL_GET_9632_AEB: {
 		struct hdsp_9632_aeb h9632_aeb;
-		
+
 		if (hdsp->io_type != H9632) return -EINVAL;
 		h9632_aeb.aebi = hdsp->ss_in_channels - H9632_SS_CHANNELS;
 		h9632_aeb.aebo = hdsp->ss_out_channels - H9632_SS_CHANNELS;
@@ -4655,7 +4655,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 	case SNDRV_HDSP_IOCTL_GET_VERSION: {
 		struct hdsp_version hdsp_version;
 		int err;
-		
+
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
 		if (hdsp->io_type == Undefined) {
 			if ((err = hdsp_get_iobox_version(hdsp)) < 0)
@@ -4671,7 +4671,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 		struct hdsp_firmware __user *firmware;
 		u32 __user *firmware_data;
 		int err;
-		
+
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
 		/* SNDRV_HDSP_IOCTL_GET_VERSION must have been called */
 		if (hdsp->io_type == Undefined) return -EINVAL;
@@ -4684,25 +4684,25 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 
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
@@ -4749,10 +4749,10 @@ static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
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
@@ -4760,7 +4760,7 @@ static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
 	hw->ops.open = snd_hdsp_hwdep_dummy_op;
 	hw->ops.ioctl = snd_hdsp_hwdep_ioctl;
 	hw->ops.release = snd_hdsp_hwdep_dummy_op;
-		
+
 	return 0;
 }
 
@@ -4793,24 +4793,24 @@ static void snd_hdsp_9652_enable_mixer (struct hdsp *hdsp)
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
@@ -4823,7 +4823,7 @@ static void snd_hdsp_initialize_channels(struct hdsp *hdsp)
 		hdsp->ss_in_channels = hdsp->ss_out_channels = H9652_SS_CHANNELS;
 		hdsp->ds_in_channels = hdsp->ds_out_channels = H9652_DS_CHANNELS;
 		break;
-	
+
 	case H9632:
 		status = hdsp_read(hdsp, HDSP_statusRegister);
 		/* HDSP_AEBx bits are low when AEB are connected */
@@ -4843,7 +4843,7 @@ static void snd_hdsp_initialize_channels(struct hdsp *hdsp)
 		hdsp->ss_in_channels = hdsp->ss_out_channels = MULTIFACE_SS_CHANNELS;
 		hdsp->ds_in_channels = hdsp->ds_out_channels = MULTIFACE_DS_CHANNELS;
 		break;
-		
+
 	default:
  		/* should never get here */
 		break;
@@ -4859,12 +4859,12 @@ static void snd_hdsp_initialize_midi_flush (struct hdsp *hdsp)
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
@@ -4895,19 +4895,19 @@ static int snd_hdsp_create_alsa_devices(struct snd_card *card, struct hdsp *hdsp
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
 
@@ -4918,7 +4918,7 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
 	const char *fwfile;
 	const struct firmware *fw;
 	int err;
-		
+
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
 		return 0;
 	if (hdsp->io_type == Undefined) {
@@ -4927,7 +4927,7 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
 			return 0;
 	}
-	
+
 	/* caution: max length of firmware filename is 30! */
 	switch (hdsp->io_type) {
 	case Multiface:
@@ -4961,12 +4961,12 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
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
@@ -5013,14 +5013,14 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
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
@@ -5029,7 +5029,7 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 	    to its maximum 255 to avoid problems with some computers."
 	*/
 	pci_write_config_byte(hdsp->pci, PCI_LATENCY_TIMER, 0xFF);
-	
+
 	strcpy(card->driver, "H-DSP");
 	strcpy(card->mixername, "Xilinx FPGA");
 
@@ -5043,7 +5043,7 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 	} else {
 		hdsp->card_name = "RME HDSP 9632";
 		hdsp->max_channels = 16;
-		is_9632 = 1;	
+		is_9632 = 1;
 	}
 
 	if ((err = pci_enable_device(pci)) < 0)
@@ -5072,7 +5072,7 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 
 	if ((err = snd_hdsp_initialize_memory(hdsp)) < 0)
 		return err;
-	
+
 	if (!is_9652 && !is_9632) {
 		/* we wait a maximum of 10 seconds to let freshly inserted cardbus cards do their hardware init */
 		err = hdsp_wait_for_iobox(hdsp, 1000, 10);
@@ -5098,35 +5098,35 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
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
@@ -5142,13 +5142,13 @@ static int snd_hdsp_free(struct hdsp *hdsp)
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
@@ -5191,7 +5191,7 @@ static int __devinit snd_hdsp_probe(struct pci_dev *pci,
 	}
 
 	strcpy(card->shortname, "Hammerfall DSP");
-	sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name, 
+	sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name,
 		hdsp->port, hdsp->irq);
 
 	if ((err = snd_card_register(card)) < 0) {
-- 
1.6.1.2
