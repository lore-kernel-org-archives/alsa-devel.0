From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 18/24] sound/pci: coding style fixes: rme9652
Date: Tue, 9 Sep 2008 05:59:43 +0400
Message-ID: <20080909015943.GU6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 80377103839
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:59:53 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1537150fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:59:53 -0700 (PDT)
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

 sound/pci/rme9652/hdsp.c    |  530 +++++++++++++++++++++---------------------
 sound/pci/rme9652/hdspm.c   |  114 +++++-----
 sound/pci/rme9652/rme9652.c |  146 ++++++------
 3 files changed, 395 insertions(+), 395 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index d723543..de05602 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -41,7 +41,7 @@
 
 #include <asm/byteorder.h>
 #include <asm/current.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
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
@@ -599,15 +599,15 @@ MODULE_DEVICE_TABLE(pci, snd_hdsp_ids);
 /* prototypes */
 static int snd_hdsp_create_alsa_devices(struct snd_card *card, struct hdsp *hdsp);
 static int snd_hdsp_create_pcm(struct snd_card *card, struct hdsp *hdsp);
-static int snd_hdsp_enable_io (struct hdsp *hdsp);
-static void snd_hdsp_initialize_midi_flush (struct hdsp *hdsp);
-static void snd_hdsp_initialize_channels (struct hdsp *hdsp);
+static int snd_hdsp_enable_io(struct hdsp *hdsp);
+static void snd_hdsp_initialize_midi_flush(struct hdsp *hdsp);
+static void snd_hdsp_initialize_channels(struct hdsp *hdsp);
 static int hdsp_fifo_wait(struct hdsp *hdsp, int count, int timeout);
 static int hdsp_autosync_ref(struct hdsp *hdsp);
 static int snd_hdsp_set_defaults(struct hdsp *hdsp);
-static void snd_hdsp_9652_enable_mixer (struct hdsp *hdsp);
+static void snd_hdsp_9652_enable_mixer(struct hdsp *hdsp);
 
-static int hdsp_playback_to_output_key (struct hdsp *hdsp, int in, int out)
+static int hdsp_playback_to_output_key(struct hdsp *hdsp, int in, int out)
 {
 	switch (hdsp->io_type) {
 	case Multiface:
@@ -624,7 +624,7 @@ static int hdsp_playback_to_output_key (struct hdsp *hdsp, int in, int out)
 	}
 }
 
-static int hdsp_input_to_output_key (struct hdsp *hdsp, int in, int out)
+static int hdsp_input_to_output_key(struct hdsp *hdsp, int in, int out)
 {
 	switch (hdsp->io_type) {
 	case Multiface:
@@ -651,7 +651,7 @@ static unsigned int hdsp_read(struct hdsp *hdsp, int reg)
 	return readl (hdsp->iobase + reg);
 }
 
-static int hdsp_check_for_iobox (struct hdsp *hdsp)
+static int hdsp_check_for_iobox(struct hdsp *hdsp)
 {
 
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return 0;
@@ -670,19 +670,19 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
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
@@ -692,7 +692,7 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 		}
 
 		ssleep(3);
-		
+
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("Hammerfall-DSP: timeout at end of firmware loading\n");
 		    	return -EIO;
@@ -705,15 +705,15 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
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
@@ -722,7 +722,7 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 static int hdsp_get_iobox_version (struct hdsp *hdsp)
 {
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
-	
+
 		hdsp_write (hdsp, HDSP_control2Reg, HDSP_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0)
@@ -738,7 +738,7 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 			hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
 		} else {
 			hdsp->io_type = Digiface;
-		} 
+		}
 	} else {
 		/* firmware was already loaded, get iobox type */
 		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1)
@@ -754,19 +754,19 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 static int hdsp_request_fw_loader(struct hdsp *hdsp);
 #endif
 
-static int hdsp_check_for_firmware (struct hdsp *hdsp, int load_on_demand)
+static int hdsp_check_for_firmware(struct hdsp *hdsp, int load_on_demand)
 {
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
 		return 0;
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 		hdsp->state &= ~HDSP_FirmwareLoaded;
-		if (! load_on_demand)
+		if (!load_on_demand)
 			return -EIO;
 		snd_printk(KERN_ERR "Hammerfall-DSP: firmware not present.\n");
 		/* try to load firmware */
-		if (! (hdsp->state & HDSP_FirmwareCached)) {
+		if (!(hdsp->state & HDSP_FirmwareCached)) {
 #ifdef HDSP_FW_LOADER
-			if (! hdsp_request_fw_loader(hdsp))
+			if (!hdsp_request_fw_loader(hdsp))
 				return 0;
 #endif
 			snd_printk(KERN_ERR
@@ -786,13 +786,13 @@ static int hdsp_check_for_firmware (struct hdsp *hdsp, int load_on_demand)
 
 
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
@@ -824,11 +824,11 @@ static int hdsp_write_gain(struct hdsp *hdsp, unsigned int addr, unsigned short
 
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
@@ -847,7 +847,7 @@ static int hdsp_write_gain(struct hdsp *hdsp, unsigned int addr, unsigned short
 
 		hdsp->mixer_matrix[addr] = data;
 
-		
+
 		/* `addr' addresses a 16-bit wide address, but
 		   the address space accessed via hdsp_write
 		   uses byte offsets. put another way, addr
@@ -856,17 +856,17 @@ static int hdsp_write_gain(struct hdsp *hdsp, unsigned int addr, unsigned short
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
 
@@ -902,7 +902,7 @@ static int hdsp_spdif_sample_rate(struct hdsp *hdsp)
 
 	if (status & HDSP_SPDIFErrorFlag)
 		return 0;
-	
+
 	switch (rate_bits) {
 	case HDSP_spdifFrequency32KHz: return 32000;
 	case HDSP_spdifFrequency44_1KHz: return 44100;
@@ -910,13 +910,13 @@ static int hdsp_spdif_sample_rate(struct hdsp *hdsp)
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
@@ -1027,7 +1027,7 @@ static void hdsp_set_dds_value(struct hdsp *hdsp, int rate)
 {
 	u64 n;
 	u32 r;
-	
+
 	if (rate >= 112000)
 		rate /= 4;
 	else if (rate >= 56000)
@@ -1053,35 +1053,35 @@ static int hdsp_set_rate(struct hdsp *hdsp, int rate, int called_internally)
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
@@ -1089,7 +1089,7 @@ static int hdsp_set_rate(struct hdsp *hdsp, int rate, int called_internally)
 
 	if (rate > 96000 && hdsp->io_type != H9632)
 		return -EINVAL;
-	
+
 	switch (rate) {
 	case 32000:
 		if (current_rate > 48000)
@@ -1179,7 +1179,7 @@ static int hdsp_set_rate(struct hdsp *hdsp, int rate, int called_internally)
 			break;
 		}
 	}
-	
+
 	hdsp->system_sample_rate = rate;
 
 	return 0;
@@ -1189,7 +1189,7 @@ static int hdsp_set_rate(struct hdsp *hdsp, int rate, int called_internally)
    MIDI
   ----------------------------------------------------------------------------*/
 
-static unsigned char snd_hdsp_midi_read_byte (struct hdsp *hdsp, int id)
+static unsigned char snd_hdsp_midi_read_byte(struct hdsp *hdsp, int id)
 {
 	/* the hardware already does the relevant bit-mask with 0xff */
 	if (id)
@@ -1198,7 +1198,7 @@ static unsigned char snd_hdsp_midi_read_byte (struct hdsp *hdsp, int id)
 		return hdsp_read(hdsp, HDSP_midiDataIn0);
 }
 
-static void snd_hdsp_midi_write_byte (struct hdsp *hdsp, int id, int val)
+static void snd_hdsp_midi_write_byte(struct hdsp *hdsp, int id, int val)
 {
 	/* the hardware already does the relevant bit-mask with 0xff */
 	if (id)
@@ -1207,7 +1207,7 @@ static void snd_hdsp_midi_write_byte (struct hdsp *hdsp, int id, int val)
 		hdsp_write(hdsp, HDSP_midiDataOut0, val);
 }
 
-static int snd_hdsp_midi_input_available (struct hdsp *hdsp, int id)
+static int snd_hdsp_midi_input_available(struct hdsp *hdsp, int id)
 {
 	if (id)
 		return (hdsp_read(hdsp, HDSP_midiStatusIn1) & 0xff);
@@ -1215,7 +1215,7 @@ static int snd_hdsp_midi_input_available (struct hdsp *hdsp, int id)
 		return (hdsp_read(hdsp, HDSP_midiStatusIn0) & 0xff);
 }
 
-static int snd_hdsp_midi_output_possible (struct hdsp *hdsp, int id)
+static int snd_hdsp_midi_output_possible(struct hdsp *hdsp, int id)
 {
 	int fifo_bytes_used;
 
@@ -1230,13 +1230,13 @@ static int snd_hdsp_midi_output_possible (struct hdsp *hdsp, int id)
 		return 0;
 }
 
-static void snd_hdsp_flush_midi_input (struct hdsp *hdsp, int id)
+static void snd_hdsp_flush_midi_input(struct hdsp *hdsp, int id)
 {
 	while (snd_hdsp_midi_input_available (hdsp, id))
 		snd_hdsp_midi_read_byte (hdsp, id);
 }
 
-static int snd_hdsp_midi_output_write (struct hdsp_midi *hmidi)
+static int snd_hdsp_midi_output_write(struct hdsp_midi *hmidi)
 {
 	unsigned long flags;
 	int n_pending;
@@ -1245,16 +1245,16 @@ static int snd_hdsp_midi_output_write (struct hdsp_midi *hmidi)
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
@@ -1264,7 +1264,7 @@ static int snd_hdsp_midi_output_write (struct hdsp_midi *hmidi)
 	return 0;
 }
 
-static int snd_hdsp_midi_input_read (struct hdsp_midi *hmidi)
+static int snd_hdsp_midi_input_read(struct hdsp_midi *hmidi)
 {
 	unsigned char buf[128]; /* this buffer is designed to match the MIDI input FIFO size */
 	unsigned long flags;
@@ -1325,14 +1325,14 @@ static void snd_hdsp_midi_output_timer(unsigned long data)
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
@@ -1435,7 +1435,7 @@ static struct snd_rawmidi_ops snd_hdsp_midi_input =
 	.trigger =	snd_hdsp_midi_input_trigger,
 };
 
-static int snd_hdsp_create_midi (struct snd_card *card, struct hdsp *hdsp, int id)
+static int snd_hdsp_create_midi(struct snd_card *card, struct hdsp *hdsp, int id)
 {
 	char buf[32];
 
@@ -1501,7 +1501,7 @@ static int snd_hdsp_control_spdif_info(struct snd_kcontrol *kcontrol, struct snd
 static int snd_hdsp_control_spdif_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_hdsp_convert_to_aes(&ucontrol->value.iec958, hdsp->creg_spdif);
 	return 0;
 }
@@ -1511,7 +1511,7 @@ static int snd_hdsp_control_spdif_put(struct snd_kcontrol *kcontrol, struct snd_
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_hdsp_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&hdsp->lock);
 	change = val != hdsp->creg_spdif;
@@ -1530,7 +1530,7 @@ static int snd_hdsp_control_spdif_stream_info(struct snd_kcontrol *kcontrol, str
 static int snd_hdsp_control_spdif_stream_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_hdsp_convert_to_aes(&ucontrol->value.iec958, hdsp->creg_spdif_stream);
 	return 0;
 }
@@ -1540,7 +1540,7 @@ static int snd_hdsp_control_spdif_stream_put(struct snd_kcontrol *kcontrol, stru
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_hdsp_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&hdsp->lock);
 	change = val != hdsp->creg_spdif_stream;
@@ -1602,7 +1602,7 @@ static int snd_hdsp_info_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_
 static int snd_hdsp_get_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_spdif_in(hdsp);
 	return 0;
 }
@@ -1612,7 +1612,7 @@ static int snd_hdsp_put_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0] % ((hdsp->io_type == H9632) ? 4 : 3);
@@ -1649,7 +1649,7 @@ static int hdsp_set_spdif_output(struct hdsp *hdsp, int out)
 static int snd_hdsp_get_spdif_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_out(hdsp);
 	return 0;
 }
@@ -1659,7 +1659,7 @@ static int snd_hdsp_put_spdif_out(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1693,7 +1693,7 @@ static int hdsp_set_spdif_professional(struct hdsp *hdsp, int val)
 static int snd_hdsp_get_spdif_professional(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_professional(hdsp);
 	return 0;
 }
@@ -1703,7 +1703,7 @@ static int snd_hdsp_put_spdif_professional(struct snd_kcontrol *kcontrol, struct
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1737,7 +1737,7 @@ static int hdsp_set_spdif_emphasis(struct hdsp *hdsp, int val)
 static int snd_hdsp_get_spdif_emphasis(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_emphasis(hdsp);
 	return 0;
 }
@@ -1747,7 +1747,7 @@ static int snd_hdsp_put_spdif_emphasis(struct snd_kcontrol *kcontrol, struct snd
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1781,7 +1781,7 @@ static int hdsp_set_spdif_nonaudio(struct hdsp *hdsp, int val)
 static int snd_hdsp_get_spdif_nonaudio(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp_spdif_nonaudio(hdsp);
 	return 0;
 }
@@ -1791,7 +1791,7 @@ static int snd_hdsp_put_spdif_nonaudio(struct snd_kcontrol *kcontrol, struct snd
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1828,7 +1828,7 @@ static int snd_hdsp_info_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct
 static int snd_hdsp_get_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	switch (hdsp_spdif_sample_rate(hdsp)) {
 	case 32000:
 		ucontrol->value.enumerated.item[0] = 0;
@@ -1858,7 +1858,7 @@ static int snd_hdsp_get_spdif_sample_rate(struct snd_kcontrol *kcontrol, struct
 		ucontrol->value.enumerated.item[0] = 9;
 		break;
 	default:
-		ucontrol->value.enumerated.item[0] = 6;		
+		ucontrol->value.enumerated.item[0] = 6;
 	}
 	return 0;
 }
@@ -1882,7 +1882,7 @@ static int snd_hdsp_info_system_sample_rate(struct snd_kcontrol *kcontrol, struc
 static int snd_hdsp_get_system_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp->system_sample_rate;
 	return 0;
 }
@@ -1899,10 +1899,10 @@ static int snd_hdsp_get_system_sample_rate(struct snd_kcontrol *kcontrol, struct
 static int snd_hdsp_info_autosync_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};	
+	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = (hdsp->io_type == H9632) ? 10 : 7 ;
+	uinfo->value.enumerated.items = (hdsp->io_type == H9632) ? 10 : 7;
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
@@ -1912,7 +1912,7 @@ static int snd_hdsp_info_autosync_sample_rate(struct snd_kcontrol *kcontrol, str
 static int snd_hdsp_get_autosync_sample_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	switch (hdsp_external_sample_rate(hdsp)) {
 	case 32000:
 		ucontrol->value.enumerated.item[0] = 0;
@@ -1940,9 +1940,9 @@ static int snd_hdsp_get_autosync_sample_rate(struct snd_kcontrol *kcontrol, stru
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
@@ -1968,7 +1968,7 @@ static int hdsp_system_clock_mode(struct hdsp *hdsp)
 static int snd_hdsp_info_system_clock_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Master", "Slave" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 2;
@@ -1981,7 +1981,7 @@ static int snd_hdsp_info_system_clock_mode(struct snd_kcontrol *kcontrol, struct
 static int snd_hdsp_get_system_clock_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_system_clock_mode(hdsp);
 	return 0;
 }
@@ -2018,7 +2018,7 @@ static int hdsp_clock_source(struct hdsp *hdsp)
 		case 192000:
 			return 9;
 		default:
-			return 3;	
+			return 3;
 		}
 	} else {
 		return 0;
@@ -2032,7 +2032,7 @@ static int hdsp_set_clock_source(struct hdsp *hdsp, int mode)
 	case HDSP_CLOCK_SOURCE_AUTOSYNC:
 		if (hdsp_external_sample_rate(hdsp) != 0) {
 		    if (!hdsp_set_rate(hdsp, hdsp_external_sample_rate(hdsp), 1)) {
-			hdsp->control_register &= ~HDSP_ClockModeMaster;		
+			hdsp->control_register &= ~HDSP_ClockModeMaster;
 			hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
 			return 0;
 		    }
@@ -2043,7 +2043,7 @@ static int hdsp_set_clock_source(struct hdsp *hdsp, int mode)
 		break;
 	case HDSP_CLOCK_SOURCE_INTERNAL_44_1KHZ:
 		rate = 44100;
-		break;	    
+		break;
 	case HDSP_CLOCK_SOURCE_INTERNAL_48KHZ:
 		rate = 48000;
 		break;
@@ -2078,13 +2078,13 @@ static int snd_hdsp_info_clock_source(struct snd_kcontrol *kcontrol, struct snd_
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
@@ -2094,7 +2094,7 @@ static int snd_hdsp_info_clock_source(struct snd_kcontrol *kcontrol, struct snd_
 static int snd_hdsp_get_clock_source(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_clock_source(hdsp);
 	return 0;
 }
@@ -2104,7 +2104,7 @@ static int snd_hdsp_put_clock_source(struct snd_kcontrol *kcontrol, struct snd_c
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2130,7 +2130,7 @@ static int snd_hdsp_put_clock_source(struct snd_kcontrol *kcontrol, struct snd_c
 static int snd_hdsp_get_clock_source_lock(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.integer.value[0] = hdsp->clock_source_locked;
 	return 0;
 }
@@ -2165,7 +2165,7 @@ static int hdsp_da_gain(struct hdsp *hdsp)
 	case HDSP_DAGainMinus10dBV:
 		return 2;
 	default:
-		return 1;	
+		return 1;
 	}
 }
 
@@ -2180,8 +2180,8 @@ static int hdsp_set_da_gain(struct hdsp *hdsp, int mode)
 		hdsp->control_register |= HDSP_DAGainPlus4dBu;
 		break;
 	case 2:
-		hdsp->control_register |= HDSP_DAGainMinus10dBV;		
-		break;	    
+		hdsp->control_register |= HDSP_DAGainMinus10dBV;
+		break;
 	default:
 		return -1;
 
@@ -2193,7 +2193,7 @@ static int hdsp_set_da_gain(struct hdsp *hdsp, int mode)
 static int snd_hdsp_info_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Hi Gain", "+4 dBu", "-10 dbV"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2206,7 +2206,7 @@ static int snd_hdsp_info_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 static int snd_hdsp_get_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_da_gain(hdsp);
 	return 0;
 }
@@ -2216,7 +2216,7 @@ static int snd_hdsp_put_da_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2250,7 +2250,7 @@ static int hdsp_ad_gain(struct hdsp *hdsp)
 	case HDSP_ADGainLowGain:
 		return 2;
 	default:
-		return 1;	
+		return 1;
 	}
 }
 
@@ -2262,11 +2262,11 @@ static int hdsp_set_ad_gain(struct hdsp *hdsp, int mode)
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
 
@@ -2278,7 +2278,7 @@ static int hdsp_set_ad_gain(struct hdsp *hdsp, int mode)
 static int snd_hdsp_info_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"-10 dBV", "+4 dBu", "Lo Gain"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2291,7 +2291,7 @@ static int snd_hdsp_info_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 static int snd_hdsp_get_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_ad_gain(hdsp);
 	return 0;
 }
@@ -2301,7 +2301,7 @@ static int snd_hdsp_put_ad_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2335,7 +2335,7 @@ static int hdsp_phone_gain(struct hdsp *hdsp)
 	case HDSP_PhoneGainMinus12dB:
 		return 2;
 	default:
-		return 0;	
+		return 0;
 	}
 }
 
@@ -2347,11 +2347,11 @@ static int hdsp_set_phone_gain(struct hdsp *hdsp, int mode)
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
 
@@ -2363,7 +2363,7 @@ static int hdsp_set_phone_gain(struct hdsp *hdsp, int mode)
 static int snd_hdsp_info_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"0 dB", "-6 dB", "-12 dB"};
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2376,7 +2376,7 @@ static int snd_hdsp_info_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ct
 static int snd_hdsp_get_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_phone_gain(hdsp);
 	return 0;
 }
@@ -2386,7 +2386,7 @@ static int snd_hdsp_put_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -2432,7 +2432,7 @@ static int hdsp_set_xlr_breakout_cable(struct hdsp *hdsp, int mode)
 static int snd_hdsp_get_xlr_breakout_cable(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_xlr_breakout_cable(hdsp);
 	return 0;
 }
@@ -2442,7 +2442,7 @@ static int snd_hdsp_put_xlr_breakout_cable(struct snd_kcontrol *kcontrol, struct
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2488,7 +2488,7 @@ static int hdsp_set_aeb(struct hdsp *hdsp, int mode)
 static int snd_hdsp_get_aeb(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_aeb(hdsp);
 	return 0;
 }
@@ -2498,7 +2498,7 @@ static int snd_hdsp_put_aeb(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2576,7 +2576,7 @@ static int snd_hdsp_info_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd
 {
 	static char *texts[] = {"Word", "IEC958", "ADAT1", "ADAT Sync", "ADAT2", "ADAT3" };
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 
@@ -2595,7 +2595,7 @@ static int snd_hdsp_info_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd
 		uinfo->value.enumerated.items = 0;
 		break;
 	}
-		
+
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
@@ -2605,7 +2605,7 @@ static int snd_hdsp_info_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd
 static int snd_hdsp_get_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_pref_sync_ref(hdsp);
 	return 0;
 }
@@ -2615,7 +2615,7 @@ static int snd_hdsp_put_pref_sync_ref(struct snd_kcontrol *kcontrol, struct snd_
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change, max;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 
@@ -2664,7 +2664,7 @@ static int hdsp_autosync_ref(struct hdsp *hdsp)
 	case HDSP_SelSyncRef_SPDIF:
 		return HDSP_AUTOSYNC_FROM_SPDIF;
 	case HDSP_SelSyncRefMask:
-		return HDSP_AUTOSYNC_FROM_NONE;	
+		return HDSP_AUTOSYNC_FROM_NONE;
 	case HDSP_SelSyncRef_ADAT1:
 		return HDSP_AUTOSYNC_FROM_ADAT1;
 	case HDSP_SelSyncRef_ADAT2:
@@ -2680,7 +2680,7 @@ static int hdsp_autosync_ref(struct hdsp *hdsp)
 static int snd_hdsp_info_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[] = {"Word", "ADAT Sync", "IEC958", "None", "ADAT1", "ADAT2", "ADAT3" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 7;
@@ -2693,7 +2693,7 @@ static int snd_hdsp_info_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_
 static int snd_hdsp_get_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_autosync_ref(hdsp);
 	return 0;
 }
@@ -2727,7 +2727,7 @@ static int hdsp_set_line_output(struct hdsp *hdsp, int out)
 static int snd_hdsp_get_line_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp_line_out(hdsp);
 	spin_unlock_irq(&hdsp->lock);
@@ -2739,7 +2739,7 @@ static int snd_hdsp_put_line_out(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2773,7 +2773,7 @@ static int hdsp_set_precise_pointer(struct hdsp *hdsp, int precise)
 static int snd_hdsp_get_precise_pointer(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp->precise_ptr;
 	spin_unlock_irq(&hdsp->lock);
@@ -2785,7 +2785,7 @@ static int snd_hdsp_put_precise_pointer(struct snd_kcontrol *kcontrol, struct sn
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2819,7 +2819,7 @@ static int hdsp_set_use_midi_tasklet(struct hdsp *hdsp, int use_tasklet)
 static int snd_hdsp_get_use_midi_tasklet(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&hdsp->lock);
 	ucontrol->value.integer.value[0] = hdsp->use_midi_tasklet;
 	spin_unlock_irq(&hdsp->lock);
@@ -2831,7 +2831,7 @@ static int snd_hdsp_put_use_midi_tasklet(struct snd_kcontrol *kcontrol, struct s
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -2873,12 +2873,12 @@ static int snd_hdsp_get_mixer(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 
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
@@ -2926,7 +2926,7 @@ static int snd_hdsp_put_mixer(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 
 static int snd_hdsp_info_sync_check(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = {"No Lock", "Lock", "Sync" };	
+	static char *texts[] = {"No Lock", "Lock", "Sync" };
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -2971,7 +2971,7 @@ static int hdsp_spdif_sync_check(struct hdsp *hdsp)
 	int status = hdsp_read(hdsp, HDSP_statusRegister);
 	if (status & HDSP_SPDIFErrorFlag)
 		return 0;
-	else {	
+	else {
 		if (status & HDSP_SPDIFSync)
 			return 2;
 		else
@@ -3007,7 +3007,7 @@ static int hdsp_adatsync_sync_check(struct hdsp *hdsp)
 			return 1;
 	} else
 		return 0;
-}	
+}
 
 static int snd_hdsp_get_adatsync_sync_check(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
@@ -3025,17 +3025,17 @@ static int snd_hdsp_get_adatsync_sync_check(struct snd_kcontrol *kcontrol, struc
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
@@ -3053,7 +3053,7 @@ static int snd_hdsp_get_adat_sync_check(struct snd_kcontrol *kcontrol, struct sn
 		break;
 	case Multiface:
 	case H9632:
-		if (offset >= 1) 
+		if (offset >= 1)
 			return -EINVAL;
 		break;
 	default:
@@ -3115,7 +3115,7 @@ static int snd_hdsp_info_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ct
 static int snd_hdsp_get_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	
+
 	ucontrol->value.enumerated.item[0] = hdsp_dds_offset(hdsp);
 	return 0;
 }
@@ -3125,7 +3125,7 @@ static int snd_hdsp_put_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 	int change;
 	int val;
-	
+
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0];
@@ -3170,7 +3170,7 @@ static struct snd_kcontrol_new snd_hdsp_controls[] = {
 	.get =		snd_hdsp_control_spdif_mask_get,
 	.private_value = IEC958_AES0_NONAUDIO |
   			 IEC958_AES0_PROFESSIONAL |
-			 IEC958_AES0_CON_EMPHASIS,	                                                                                      
+			 IEC958_AES0_CON_EMPHASIS,
 },
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
@@ -3188,7 +3188,7 @@ HDSP_SPDIF_OUT("IEC958 Output also on ADAT1", 0),
 HDSP_SPDIF_PROFESSIONAL("IEC958 Professional Bit", 0),
 HDSP_SPDIF_EMPHASIS("IEC958 Emphasis Bit", 0),
 HDSP_SPDIF_NON_AUDIO("IEC958 Non-audio Bit", 0),
-/* 'Sample Clock Source' complies with the alsa control naming scheme */ 
+/* 'Sample Clock Source' complies with the alsa control naming scheme */
 HDSP_CLOCK_SOURCE("Sample Clock Source", 0),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -3240,7 +3240,7 @@ static int snd_hdsp_create_controls(struct snd_card *card, struct hdsp *hdsp)
 				return err;
 		}
 	}
-	
+
 	/* DA, AD and Phone gain and XLR breakout cable controls for H9632 cards */
 	if (hdsp->io_type == H9632) {
 		for (idx = 0; idx < ARRAY_SIZE(snd_hdsp_9632_controls); idx++) {
@@ -3259,7 +3259,7 @@ static int snd_hdsp_create_controls(struct snd_card *card, struct hdsp *hdsp)
 }
 
 /*------------------------------------------------------------
-   /proc interface 
+   /proc interface
  ------------------------------------------------------------*/
 
 static void
@@ -3298,7 +3298,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 			}
 		}
 	}
-	
+
 	status = hdsp_read(hdsp, HDSP_statusRegister);
 	status2 = hdsp_read(hdsp, HDSP_status2Register);
 
@@ -3362,17 +3362,17 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
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
@@ -3397,7 +3397,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		break;
 	}
 	snd_iprintf (buffer, "Preferred Sync Reference: %s\n", pref_sync_ref);
-	
+
 	switch (hdsp_autosync_ref (hdsp)) {
 	case HDSP_AUTOSYNC_FROM_WORD:
 		autosync_ref = "Word Clock";
@@ -3410,7 +3410,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		break;
 	case HDSP_AUTOSYNC_FROM_NONE:
 		autosync_ref = "None";
-		break;	
+		break;
 	case HDSP_AUTOSYNC_FROM_ADAT1:
 		autosync_ref = "ADAT1";
 		break;
@@ -3425,14 +3425,14 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
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
@@ -3452,7 +3452,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		snd_iprintf(buffer, "IEC958 input: ???\n");
 		break;
 	}
-	
+
 	if (hdsp->control_register & HDSP_SPDIFOpticalOut)
 		snd_iprintf(buffer, "IEC958 output: Coaxial & ADAT1\n");
 	else
@@ -3510,13 +3510,13 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
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
@@ -3524,11 +3524,11 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
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
@@ -3554,7 +3554,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 			break;
 		}
 		snd_iprintf(buffer, "DA Gain : %s\n", tmp);
-		
+
 		switch (hdsp_phone_gain(hdsp)) {
 		case 0:
 			tmp = "0 dB";
@@ -3568,8 +3568,8 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		}
 		snd_iprintf(buffer, "Phones Gain : %s\n", tmp);
 
-		snd_iprintf(buffer, "XLR Breakout Cable : %s\n", hdsp_xlr_breakout_cable(hdsp) ? "yes" : "no");	
-		
+		snd_iprintf(buffer, "XLR Breakout Cable : %s\n", hdsp_xlr_breakout_cable(hdsp) ? "yes" : "no");
+
 		if (hdsp->control_register & HDSP_AnalogExtensionBoard)
 			snd_iprintf(buffer, "AEB : on (ADAT1 internal)\n");
 		else
@@ -3583,7 +3583,7 @@ static void snd_hdsp_proc_init(struct hdsp *hdsp)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(hdsp->card, "hdsp", &entry))
+	if (!snd_card_proc_new(hdsp->card, "hdsp", &entry))
 		snd_info_set_text_ops(entry, hdsp, snd_hdsp_proc_read);
 }
 
@@ -3632,18 +3632,18 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
 
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
 
@@ -3661,7 +3661,7 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
 	hdsp_compute_period_size(hdsp);
 
 	/* silence everything */
-	
+
 	for (i = 0; i < HDSP_MATRIX_MIXER_SIZE; ++i)
 		hdsp->mixer_matrix[i] = MINUS_INFINITY_GAIN;
 
@@ -3669,7 +3669,7 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
 		if (hdsp_write_gain (hdsp, i, MINUS_INFINITY_GAIN))
 			return -EIO;
 	}
-	
+
 	/* H9632 specific defaults */
 	if (hdsp->io_type == H9632) {
 		hdsp->control_register |= (HDSP_DAGainPlus4dBu | HDSP_ADGainPlus4dBu | HDSP_PhoneGain0dB);
@@ -3687,12 +3687,12 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
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
@@ -3704,7 +3704,7 @@ static irqreturn_t snd_hdsp_interrupt(int irq, void *dev_id)
 	unsigned int midi0status;
 	unsigned int midi1status;
 	int schedule = 0;
-	
+
 	status = hdsp_read(hdsp, HDSP_statusRegister);
 
 	audio = status & HDSP_audioIRQPending;
@@ -3718,15 +3718,15 @@ static irqreturn_t snd_hdsp_interrupt(int irq, void *dev_id)
 
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
@@ -3769,10 +3769,10 @@ static char *hdsp_channel_buffer_location(struct hdsp *hdsp,
 
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
@@ -3910,7 +3910,7 @@ static int snd_hdsp_hw_params(struct snd_pcm_substream *substream,
 	 */
 
 	spin_lock_irq(&hdsp->lock);
-	if (! hdsp->clock_source_locked) {
+	if (!hdsp->clock_source_locked) {
 		if ((err = hdsp_set_rate(hdsp, params_rate(params), 0)) < 0) {
 			spin_unlock_irq(&hdsp->lock);
 			_snd_pcm_hw_param_setempty(params, SNDRV_PCM_HW_PARAM_RATE);
@@ -3965,7 +3965,7 @@ static int snd_hdsp_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *other;
 	int running;
-	
+
 	if (hdsp_check_for_iobox (hdsp))
 		return -EIO;
 
@@ -4016,7 +4016,7 @@ static int snd_hdsp_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 				hdsp_silence_playback(hdsp);
 	}
- _ok:
+_ok:
 	snd_pcm_trigger_done(substream, substream);
 	if (!hdsp->running && running)
 		hdsp_start_audio(hdsp);
@@ -4059,10 +4059,10 @@ static struct snd_pcm_hardware snd_hdsp_playback_subinfo =
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
@@ -4088,10 +4088,10 @@ static struct snd_pcm_hardware snd_hdsp_capture_subinfo =
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
@@ -4170,7 +4170,7 @@ static int snd_hdsp_hw_rule_in_channels_rate(struct snd_pcm_hw_params *params,
 			.max = hdsp->qs_in_channels,
 			.integer = 1,
 		};
-		return snd_interval_refine(c, &t);	
+		return snd_interval_refine(c, &t);
 	} else if (r->min > 48000 && r->max <= 96000) {
 		struct snd_interval t = {
 			.min = hdsp->ds_in_channels,
@@ -4201,7 +4201,7 @@ static int snd_hdsp_hw_rule_out_channels_rate(struct snd_pcm_hw_params *params,
 			.max = hdsp->qs_out_channels,
 			.integer = 1,
 		};
-		return snd_interval_refine(c, &t);	
+		return snd_interval_refine(c, &t);
 	} else if (r->min > 48000 && r->max <= 96000) {
 		struct snd_interval t = {
 			.min = hdsp->ds_out_channels,
@@ -4318,8 +4318,8 @@ static int snd_hdsp_playback_open(struct snd_pcm_substream *substream)
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
@@ -4536,7 +4536,7 @@ static int hdsp_get_peak(struct hdsp *hdsp, struct hdsp_peak_rms __user *peak_rm
 				hdsp->iobase + HDSP_playbackRmsLevel + i * 8 + 4,
 				hdsp->iobase + HDSP_playbackRmsLevel + i * 8))
 			return -EFAULT;
-		if (copy_u64_le(&peak_rms->input_rms[i], 
+		if (copy_u64_le(&peak_rms->input_rms[i],
 				hdsp->iobase + HDSP_inputRmsLevel + i * 8 + 4,
 				hdsp->iobase + HDSP_inputRmsLevel + i * 8))
 			return -EFAULT;
@@ -4546,7 +4546,7 @@ static int hdsp_get_peak(struct hdsp *hdsp, struct hdsp_peak_rms __user *peak_rm
 
 static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct hdsp *hdsp = (struct hdsp *)hw->private_data;	
+	struct hdsp *hdsp = (struct hdsp *)hw->private_data;
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
@@ -4571,9 +4571,9 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
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
@@ -4601,7 +4601,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 			info.ad_gain = (unsigned char)hdsp_ad_gain(hdsp);
 			info.phone_gain = (unsigned char)hdsp_phone_gain(hdsp);
 			info.xlr_breakout_cable = (unsigned char)hdsp_xlr_breakout_cable(hdsp);
-		
+
 		}
 		if (hdsp->io_type == H9632 || hdsp->io_type == H9652)
 			info.analog_extension_board = (unsigned char)hdsp_aeb(hdsp);
@@ -4612,7 +4612,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 	}
 	case SNDRV_HDSP_IOCTL_GET_9632_AEB: {
 		struct hdsp_9632_aeb h9632_aeb;
-		
+
 		if (hdsp->io_type != H9632) return -EINVAL;
 		h9632_aeb.aebi = hdsp->ss_in_channels - H9632_SS_CHANNELS;
 		h9632_aeb.aebo = hdsp->ss_out_channels - H9632_SS_CHANNELS;
@@ -4623,7 +4623,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 	case SNDRV_HDSP_IOCTL_GET_VERSION: {
 		struct hdsp_version hdsp_version;
 		int err;
-		
+
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
 		if (hdsp->io_type == Undefined) {
 			if ((err = hdsp_get_iobox_version(hdsp)) < 0)
@@ -4639,7 +4639,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 		struct hdsp_firmware __user *firmware;
 		u32 __user *firmware_data;
 		int err;
-		
+
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
 		/* SNDRV_HDSP_IOCTL_GET_VERSION must have been called */
 		if (hdsp->io_type == Undefined) return -EINVAL;
@@ -4652,25 +4652,25 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 
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
@@ -4717,10 +4717,10 @@ static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
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
@@ -4728,7 +4728,7 @@ static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
 	hw->ops.open = snd_hdsp_hwdep_dummy_op;
 	hw->ops.ioctl = snd_hdsp_hwdep_ioctl;
 	hw->ops.release = snd_hdsp_hwdep_dummy_op;
-		
+
 	return 0;
 }
 
@@ -4752,33 +4752,33 @@ static int snd_hdsp_create_pcm(struct snd_card *card, struct hdsp *hdsp)
 	return 0;
 }
 
-static void snd_hdsp_9652_enable_mixer (struct hdsp *hdsp)
+static void snd_hdsp_9652_enable_mixer(struct hdsp *hdsp)
 {
         hdsp->control2_register |= HDSP_9652_ENABLE_MIXER;
 	hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
 }
 
-static int snd_hdsp_enable_io (struct hdsp *hdsp)
+static int snd_hdsp_enable_io(struct hdsp *hdsp)
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
@@ -4791,7 +4791,7 @@ static void snd_hdsp_initialize_channels(struct hdsp *hdsp)
 		hdsp->ss_in_channels = hdsp->ss_out_channels = H9652_SS_CHANNELS;
 		hdsp->ds_in_channels = hdsp->ds_out_channels = H9652_DS_CHANNELS;
 		break;
-	
+
 	case H9632:
 		status = hdsp_read(hdsp, HDSP_statusRegister);
 		/* HDSP_AEBx bits are low when AEB are connected */
@@ -4811,14 +4811,14 @@ static void snd_hdsp_initialize_channels(struct hdsp *hdsp)
 		hdsp->ss_in_channels = hdsp->ss_out_channels = MULTIFACE_SS_CHANNELS;
 		hdsp->ds_in_channels = hdsp->ds_out_channels = MULTIFACE_DS_CHANNELS;
 		break;
-		
+
 	default:
  		/* should never get here */
 		break;
 	}
 }
 
-static void snd_hdsp_initialize_midi_flush (struct hdsp *hdsp)
+static void snd_hdsp_initialize_midi_flush(struct hdsp *hdsp)
 {
 	snd_hdsp_flush_midi_input (hdsp, 0);
 	snd_hdsp_flush_midi_input (hdsp, 1);
@@ -4827,12 +4827,12 @@ static void snd_hdsp_initialize_midi_flush (struct hdsp *hdsp)
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
@@ -4863,19 +4863,19 @@ static int snd_hdsp_create_alsa_devices(struct snd_card *card, struct hdsp *hdsp
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
 
@@ -4886,7 +4886,7 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
 	const char *fwfile;
 	const struct firmware *fw;
 	int err;
-		
+
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
 		return 0;
 	if (hdsp->io_type == Undefined) {
@@ -4895,7 +4895,7 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
 		if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
 			return 0;
 	}
-	
+
 	/* caution: max length of firmware filename is 30! */
 	switch (hdsp->io_type) {
 	case Multiface:
@@ -4929,12 +4929,12 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
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
@@ -4981,14 +4981,14 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
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
@@ -4997,7 +4997,7 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 	    to its maximum 255 to avoid problems with some computers."
 	*/
 	pci_write_config_byte(hdsp->pci, PCI_LATENCY_TIMER, 0xFF);
-	
+
 	strcpy(card->driver, "H-DSP");
 	strcpy(card->mixername, "Xilinx FPGA");
 
@@ -5011,7 +5011,7 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 	} else {
 		hdsp->card_name = "RME HDSP 9632";
 		hdsp->max_channels = 16;
-		is_9632 = 1;	
+		is_9632 = 1;
 	}
 
 	if ((err = pci_enable_device(pci)) < 0)
@@ -5040,7 +5040,7 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 
 	if ((err = snd_hdsp_initialize_memory(hdsp)) < 0)
 		return err;
-	
+
 	if (!is_9652 && !is_9632) {
 		/* we wait 2 seconds to let freshly inserted cardbus cards do their hardware init */
 		ssleep(2);
@@ -5063,35 +5063,35 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
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
@@ -5107,13 +5107,13 @@ static int snd_hdsp_free(struct hdsp *hdsp)
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
@@ -5156,7 +5156,7 @@ static int __devinit snd_hdsp_probe(struct pci_dev *pci,
 	}
 
 	strcpy(card->shortname, "Hammerfall DSP");
-	sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name, 
+	sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name,
 		hdsp->port, hdsp->irq);
 
 	if ((err = snd_card_register(card)) < 0) {
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 98762f9..16ca8ab 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -29,7 +29,7 @@
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -84,7 +84,7 @@ MODULE_DESCRIPTION("RME HDSPM");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 
-/* --- Write registers. --- 
+/* --- Write registers. ---
   These are defined as byte-offsets from the iobase value.  */
 
 #define HDSPM_controlRegister	     64
@@ -96,10 +96,10 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_eeprom_wr		     384  /* for AES32 */
 
 /* DMA enable for 64 channels, only Bit 0 is relevant */
-#define HDSPM_outputEnableBase       512  /* 512-767  input  DMA */ 
+#define HDSPM_outputEnableBase       512  /* 512-767  input  DMA */
 #define HDSPM_inputEnableBase        768  /* 768-1023 output DMA */
 
-/* 16 page addresses for each of the 64 channels DMA buffer in and out 
+/* 16 page addresses for each of the 64 channels DMA buffer in and out
    (each 64k=16*4k) Buffer must be 4k aligned (which is default i386 ????) */
 #define HDSPM_pageAddressBufferOut       8192
 #define HDSPM_pageAddressBufferIn        (HDSPM_pageAddressBufferOut+64*16*4)
@@ -122,15 +122,15 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_midiDataIn1     364
 
 /* status is data bytes in MIDI-FIFO (0-128) */
-#define HDSPM_midiStatusOut0  384	
-#define HDSPM_midiStatusOut1  388	
-#define HDSPM_midiStatusIn0   392	
-#define HDSPM_midiStatusIn1   396	
+#define HDSPM_midiStatusOut0  384
+#define HDSPM_midiStatusOut1  388
+#define HDSPM_midiStatusIn0   392
+#define HDSPM_midiStatusIn1   396
 
 
 /* the meters are regular i/o-mapped registers, but offset
    considerably from the rest. the peak registers are reset
-   when read; the least-significant 4 bits are full-scale counters; 
+   when read; the least-significant 4 bits are full-scale counters;
    the actual peak value is in the most-significant 24 bits.
 */
 #define HDSPM_MADI_peakrmsbase 	4096	/* 4096-8191 2x64x32Bit Meters */
@@ -156,7 +156,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 				     56channelMODE=0 */ /* MADI ONLY*/
 #define HDSPM_Emphasis    (1<<10) /* Emphasis */ /* AES32 ONLY */
 
-#define HDSPM_AutoInp     (1<<11) /* Auto Input (takeover) == Safe Mode, 
+#define HDSPM_AutoInp     (1<<11) /* Auto Input (takeover) == Safe Mode,
                                      0=off, 1=on  */ /* MADI ONLY */
 #define HDSPM_Dolby       (1<<11) /* Dolby = "NonAudio" ?? */ /* AES32 ONLY */
 
@@ -171,7 +171,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_SyncRef3     (1<<25)
 
 #define HDSPM_SMUX         (1<<18) /* Frame ??? */ /* MADI ONY */
-#define HDSPM_clr_tms      (1<<19) /* clear track marker, do not use 
+#define HDSPM_clr_tms      (1<<19) /* clear track marker, do not use
                                       AES additional bits in
 				      lower 5 Audiodatabits ??? */
 #define HDSPM_taxi_reset   (1<<20) /* ??? */ /* MADI ONLY ? */
@@ -272,7 +272,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_madiLock           (1<<3)	/* MADI Locked =1, no=0 */
 
 #define HDSPM_BufferPositionMask 0x000FFC0 /* Bit 6..15 : h/w buffer pointer */
-                                           /* since 64byte accurate last 6 bits 
+                                           /* since 64byte accurate last 6 bits
                                               are not used */
 
 #define HDSPM_madiSync          (1<<18) /* MADI is in sync */
@@ -344,7 +344,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 /* status */
 #define HDSPM_AES32_wcLock	0x0200000
 #define HDSPM_AES32_wcFreq_bit  22
-/* (status >> HDSPM_AES32_wcFreq_bit) & 0xF gives WC frequency (cf function 
+/* (status >> HDSPM_AES32_wcFreq_bit) & 0xF gives WC frequency (cf function
   HDSPM_bit2freq */
 #define HDSPM_AES32_syncref_bit  16
 /* (status >> HDSPM_AES32_syncref_bit) & 0xF gives sync source */
@@ -403,7 +403,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 
 /* the size of the area we need to allocate for DMA transfers. the
    size is the same regardless of the number of channels, and
-   also the latency to use. 
+   also the latency to use.
    for one direction !!!
 */
 #define HDSPM_DMA_AREA_BYTES (HDSPM_MAX_CHANNELS * HDSPM_CHANNEL_BUFFER_BYTES)
@@ -563,8 +563,8 @@ static inline unsigned int hdspm_read(struct hdspm * hdspm, unsigned int reg)
 	return readl(hdspm->iobase + reg);
 }
 
-/* for each output channel (chan) I have an Input (in) and Playback (pb) Fader 
-   mixer is write only on hardware so we have to cache him for read 
+/* for each output channel (chan) I have an Input (in) and Playback (pb) Fader
+   mixer is write only on hardware so we have to cache him for read
    each fader is a u32, but uses only the first 16 bit */
 
 static inline int hdspm_read_in_gain(struct hdspm * hdspm, unsigned int chan,
@@ -764,7 +764,7 @@ static snd_pcm_uframes_t hdspm_hw_pointer(struct hdspm * hdspm)
 
 	/* hwpointer comes in bytes and is 64Bytes accurate (by docu since
 	   PCI Burst)
-	   i have experimented that it is at most 64 Byte to much for playing 
+	   i have experimented that it is at most 64 Byte to much for playing
 	   so substraction of 64 byte should be ok for ALSA, but use it only
 	   for application where you know what you do since if you come to
 	   near with record pointer it can be a disaster */
@@ -832,16 +832,16 @@ static void hdspm_set_dds_value(struct hdspm *hdspm, int rate)
 {
 	u64 n;
 	u32 r;
-	
+
 	if (rate >= 112000)
 		rate /= 4;
 	else if (rate >= 56000)
 		rate /= 2;
 
 	/* RME says n = 104857600000000, but in the windows MADI driver, I see:
-//	return 104857600000000 / rate; // 100 MHz
-	return 110100480000000 / rate; // 105 MHz
-        */	   
+//	return 104857600000000 / rate; //100 MHz
+	return 110100480000000 / rate; //105 MHz
+        */
 	/* n = 104857600000000ULL; */ /*  =  2^20 * 10^8 */
 	n = 110100480000000ULL;    /* Value checked for AES32 and MADI */
 	div64_32(&n, rate, &r);
@@ -864,13 +864,13 @@ static int hdspm_set_rate(struct hdspm * hdspm, int rate, int called_internally)
 
 	if (!(hdspm->control_register & HDSPM_ClockModeMaster)) {
 
-	        /* SLAVE --- */ 
+	        /* SLAVE --- */
 		if (called_internally) {
 
-        	  /* request from ctl or card initialization 
-	             just make a warning an remember setting 
+        	  /* request from ctl or card initialization
+	             just make a warning an remember setting
 		     for future master mode switching */
-    
+
 			snd_printk(KERN_WARNING "HDSPM: "
 				   "Warning: device is not running "
 				   "as a clock master.\n");
@@ -907,7 +907,7 @@ static int hdspm_set_rate(struct hdspm * hdspm, int rate, int called_internally)
 
 	   Note that a similar but essentially insoluble problem exists for
 	   externally-driven rate changes. All we can do is to flag rate
-	   changes in the read/write routines.  
+	   changes in the read/write routines.
 	 */
 
 	if (current_rate <= 48000)
@@ -975,10 +975,10 @@ static int hdspm_set_rate(struct hdspm * hdspm, int rate, int called_internally)
 	/* For AES32, need to set DDS value in FREQ register
 	   For MADI, also apparently */
 	hdspm_set_dds_value(hdspm, rate);
-	
+
 	if (hdspm->is_aes32 && rate != current_rate)
 		hdspm_write(hdspm, HDSPM_eeprom_wr, 0);
-	
+
 	/* For AES32 and for MADI (at least rev 204), channel_map needs to
 	 * always be channel_map_madi_ss, whatever the sample rate */
 	hdspm->channel_map = channel_map_madi_ss;
@@ -1015,7 +1015,7 @@ static void all_in_all_mixer(struct hdspm * hdspm, int sgain)
    MIDI
   ----------------------------------------------------------------------------*/
 
-static inline unsigned char snd_hdspm_midi_read_byte (struct hdspm *hdspm,
+static inline unsigned char snd_hdspm_midi_read_byte(struct hdspm *hdspm,
 						      int id)
 {
 	/* the hardware already does the relevant bit-mask with 0xff */
@@ -1025,7 +1025,7 @@ static inline unsigned char snd_hdspm_midi_read_byte (struct hdspm *hdspm,
 		return hdspm_read(hdspm, HDSPM_midiDataIn0);
 }
 
-static inline void snd_hdspm_midi_write_byte (struct hdspm *hdspm, int id,
+static inline void snd_hdspm_midi_write_byte(struct hdspm *hdspm, int id,
 					      int val)
 {
 	/* the hardware already does the relevant bit-mask with 0xff */
@@ -1035,7 +1035,7 @@ static inline void snd_hdspm_midi_write_byte (struct hdspm *hdspm, int id,
 		hdspm_write(hdspm, HDSPM_midiDataOut0, val);
 }
 
-static inline int snd_hdspm_midi_input_available (struct hdspm *hdspm, int id)
+static inline int snd_hdspm_midi_input_available(struct hdspm *hdspm, int id)
 {
 	if (id)
 		return (hdspm_read(hdspm, HDSPM_midiStatusIn1) & 0xff);
@@ -1043,7 +1043,7 @@ static inline int snd_hdspm_midi_input_available (struct hdspm *hdspm, int id)
 		return (hdspm_read(hdspm, HDSPM_midiStatusIn0) & 0xff);
 }
 
-static inline int snd_hdspm_midi_output_possible (struct hdspm *hdspm, int id)
+static inline int snd_hdspm_midi_output_possible(struct hdspm *hdspm, int id)
 {
 	int fifo_bytes_used;
 
@@ -1065,7 +1065,7 @@ static void snd_hdspm_flush_midi_input(struct hdspm *hdspm, int id)
 		snd_hdspm_midi_read_byte (hdspm, id);
 }
 
-static int snd_hdspm_midi_output_write (struct hdspm_midi *hmidi)
+static int snd_hdspm_midi_output_write(struct hdspm_midi *hmidi)
 {
 	unsigned long flags;
 	int n_pending;
@@ -1074,7 +1074,7 @@ static int snd_hdspm_midi_output_write (struct hdspm_midi *hmidi)
 	unsigned char buf[128];
 
 	/* Output is not interrupt driven */
-		
+
 	spin_lock_irqsave (&hmidi->lock, flags);
 	if (hmidi->output &&
 	    !snd_rawmidi_transmit_empty (hmidi->output)) {
@@ -1083,11 +1083,11 @@ static int snd_hdspm_midi_output_write (struct hdspm_midi *hmidi)
 		if (n_pending > 0) {
 			if (n_pending > (int)sizeof (buf))
 				n_pending = sizeof (buf);
-		
+
 			to_write = snd_rawmidi_transmit (hmidi->output, buf,
 							 n_pending);
 			if (to_write > 0) {
-				for (i = 0; i < to_write; ++i) 
+				for (i = 0; i < to_write; ++i)
 					snd_hdspm_midi_write_byte (hmidi->hdspm,
 								   hmidi->id,
 								   buf[i]);
@@ -1098,7 +1098,7 @@ static int snd_hdspm_midi_output_write (struct hdspm_midi *hmidi)
 	return 0;
 }
 
-static int snd_hdspm_midi_input_read (struct hdspm_midi *hmidi)
+static int snd_hdspm_midi_input_read(struct hdspm_midi *hmidi)
 {
 	unsigned char buf[128]; /* this buffer is designed to match the MIDI
 				 * input FIFO size
@@ -1167,14 +1167,14 @@ static void snd_hdspm_midi_output_timer(unsigned long data)
 {
 	struct hdspm_midi *hmidi = (struct hdspm_midi *) data;
 	unsigned long flags;
-	
+
 	snd_hdspm_midi_output_write(hmidi);
 	spin_lock_irqsave (&hmidi->lock, flags);
 
 	/* this does not bump hmidi->istimer, because the
 	   kernel automatically removed the timer when it
 	   expired, and we are now adding it back, thus
-	   leaving istimer wherever it was set before.  
+	   leaving istimer wherever it was set before.
 	*/
 
 	if (hmidi->istimer) {
@@ -1278,7 +1278,7 @@ static struct snd_rawmidi_ops snd_hdspm_midi_input =
 	.trigger =	snd_hdspm_midi_input_trigger,
 };
 
-static int __devinit snd_hdspm_create_midi (struct snd_card *card,
+static int __devinit snd_hdspm_create_midi(struct snd_card *card,
 					    struct hdspm *hdspm, int id)
 {
 	int err;
@@ -1312,12 +1312,12 @@ static int __devinit snd_hdspm_create_midi (struct snd_card *card,
 static void hdspm_midi_tasklet(unsigned long arg)
 {
 	struct hdspm *hdspm = (struct hdspm *)arg;
-	
+
 	if (hdspm->midi[0].pending)
 		snd_hdspm_midi_input_read (&hdspm->midi[0]);
 	if (hdspm->midi[1].pending)
 		snd_hdspm_midi_input_read (&hdspm->midi[1]);
-} 
+}
 
 
 /*-----------------------------------------------------------------------------
@@ -2475,8 +2475,8 @@ static int snd_hdspm_put_qs_wire(struct snd_kcontrol *kcontrol,
 /*           Simple Mixer
   deprecated since to much faders ???
   MIXER interface says output (source, destination, value)
-   where source > MAX_channels are playback channels 
-   on MADICARD 
+   where source > MAX_channels are playback channels
+   on MADICARD
   - playback mixer matrix: [channelout+64] [output] [value]
   - input(thru) mixer matrix: [channelin] [output] [value]
   (better do 2 kontrols for seperation ?)
@@ -2586,7 +2586,7 @@ static int snd_hdspm_put_mixer(struct snd_kcontrol *kcontrol,
 
 /* The simple mixer control(s) provide gain control for the
    basic 1:1 mappings of playback streams to output
-   streams. 
+   streams.
 */
 
 #define HDSPM_PLAYBACK_MIXER \
@@ -2634,7 +2634,7 @@ static int snd_hdspm_get_playback_mixer(struct snd_kcontrol *kcontrol,
 	snd_printdd("get pb mixer index %d, channel %d, mapped_channel %d, "
 		    "value %d\n",
 		    ucontrol->id.index, channel, mapped_channel,
-		    ucontrol->value.integer.value[0]); 
+		    ucontrol->value.integer.value[0]);
 	*/
 	return 0;
 }
@@ -2906,7 +2906,7 @@ static int snd_hdspm_create_controls(struct snd_card *card, struct hdspm * hdspm
 		}
 	}
 
-	/* Channel playback mixer as default control 
+	/* Channel playback mixer as default control
 	   Note: the whole matrix would be 128*HDSPM_MIXER_CHANNELS Faders,
 	   thats too * big for any alsamixer they are accesible via special
 	   IOCTL on hwdep and the mixer 2dimensional mixer control
@@ -2934,7 +2934,7 @@ static int snd_hdspm_create_controls(struct snd_card *card, struct hdspm * hdspm
 }
 
 /*------------------------------------------------------------
-   /proc interface 
+   /proc interface
  ------------------------------------------------------------*/
 
 static void
@@ -3341,7 +3341,7 @@ static void __devinit snd_hdspm_proc_init(struct hdspm * hdspm)
 }
 
 /*------------------------------------------------------------
-   hdspm intitialize 
+   hdspm intitialize
  ------------------------------------------------------------*/
 
 static int snd_hdspm_set_defaults(struct hdspm * hdspm)
@@ -3417,7 +3417,7 @@ static int snd_hdspm_set_defaults(struct hdspm * hdspm)
 
 
 /*------------------------------------------------------------
-   interrupt 
+   interrupt
  ------------------------------------------------------------*/
 
 static irqreturn_t snd_hdspm_interrupt(int irq, void *dev_id)
@@ -3481,7 +3481,7 @@ static irqreturn_t snd_hdspm_interrupt(int irq, void *dev_id)
 }
 
 /*------------------------------------------------------------
-   pcm interface 
+   pcm interface
   ------------------------------------------------------------*/
 
 
@@ -3719,7 +3719,7 @@ static int snd_hdspm_hw_free(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 
-		/* params_channels(params) should be enough, 
+		/* params_channels(params) should be enough,
 		   but to get sure in case of error */
 		for (i = 0; i < HDSPM_MAX_CHANNELS; ++i)
 			snd_hdspm_enable_out(hdspm, i, 0);
@@ -3827,7 +3827,7 @@ static int snd_hdspm_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			hdspm_silence_playback(hdspm);
 	}
-      _ok:
+_ok:
 	snd_pcm_trigger_done(substream, substream);
 	if (!hdspm->running && running)
 		hdspm_start_audio(hdspm);
@@ -4124,13 +4124,13 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep * hw, struct file *file,
 		/* maybe there is a chance to memorymap in future
 		 * so dont touch just copy
 		 */
-		if(copy_to_user_fromio((void __user *)rms.peak,
+		if (copy_to_user_fromio((void __user *)rms.peak,
 				       hdspm->iobase+HDSPM_MADI_peakrmsbase,
-				       sizeof(struct hdspm_peak_rms)) != 0 )
+				       sizeof(struct hdspm_peak_rms)) != 0)
 			return -EFAULT;
 
 		break;
-		
+
 
 	case SNDRV_HDSPM_IOCTL_GET_CONFIG_INFO:
 
@@ -4222,7 +4222,7 @@ static int __devinit snd_hdspm_create_hwdep(struct snd_card *card,
 
 
 /*------------------------------------------------------------
-   memory interface 
+   memory interface
  ------------------------------------------------------------*/
 static int __devinit snd_hdspm_preallocate_memory(struct hdspm * hdspm)
 {
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 2570907..7a4fdad 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -1,5 +1,5 @@
 /*
- *   ALSA driver for RME Digi9652 audio interfaces 
+ *   ALSA driver for RME Digi9652 audio interfaces
  *
  *	Copyright (c) 1999 IEM - Winfried Ritsch
  *      Copyright (c) 1999-2001  Paul Davis
@@ -35,7 +35,7 @@
 #include <sound/initval.h>
 
 #include <asm/current.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
@@ -60,7 +60,7 @@ MODULE_SUPPORTED_DEVICE("{{RME,Hammerfall},"
    capture, one for playback. Both the ADAT and S/PDIF channels appear
    to the host CPU in the same block of memory. There is no functional
    difference between them in terms of access.
-   
+
    The Hammerfall Light is identical to the Hammerfall, except that it
    has 2 sets 18 channels (16 ADAT + 2 S/PDIF) for capture and playback.
 */
@@ -115,7 +115,7 @@ MODULE_SUPPORTED_DEVICE("{{RME,Hammerfall},"
 
 /* Bits 31,30,29 are bits 5,4,3 of h/w pointer position on later
    Rev G EEPROMS and Rev 1.5 cards or later.
-*/ 
+*/
 
 #define RME9652_REV15_buf_pos(x) ((((x)&0xE0000000)>>26)|((x)&RME9652_buf_pos))
 
@@ -186,7 +186,7 @@ MODULE_SUPPORTED_DEVICE("{{RME,Hammerfall},"
 #define RME9652_CHANNEL_BUFFER_BYTES    (4*RME9652_CHANNEL_BUFFER_SAMPLES)
 
 /* the size of the area we need to allocate for DMA transfers. the
-   size is the same regardless of the number of channels - the 
+   size is the same regardless of the number of channels - the
    9636 still uses the same memory area.
 
    Note that we allocate 1 more channel than is apparently needed
@@ -204,7 +204,7 @@ struct snd_rme9652 {
 	int irq;
 	unsigned long port;
 	void __iomem *iobase;
-	
+
 	int precise_ptr;
 
 	u32 control_register;	/* cached value */
@@ -217,7 +217,7 @@ struct snd_rme9652 {
 
         size_t hw_offsetmask;     	/* &-with status register to get real hw_offset */
 	size_t prev_hw_offset;		/* previous hw offset */
-	size_t max_jitter;		/* maximum jitter in frames for 
+	size_t max_jitter;		/* maximum jitter in frames for
 					   hw pointer */
 	size_t period_bytes;		/* guess what this is */
 
@@ -266,7 +266,7 @@ static char channel_map_9652_ss[26] = {
 };
 
 static char channel_map_9636_ss[26] = {
-	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
 	/* channels 16 and 17 are S/PDIF */
 	24, 25,
 	/* channels 18-25 don't exist */
@@ -367,7 +367,7 @@ static inline void rme9652_compute_period_size(struct snd_rme9652 *rme9652)
 
 	i = rme9652->control_register & RME9652_latency;
 	rme9652->period_bytes = 1 << ((rme9652_decode_latency(i) + 8));
-	rme9652->hw_offsetmask = 
+	rme9652->hw_offsetmask =
 		(rme9652->period_bytes * 2 - 1) & RME9652_buf_pos;
 	rme9652->max_jitter = 80;
 }
@@ -426,7 +426,7 @@ static inline void rme9652_reset_hw_pointer(struct snd_rme9652 *rme9652)
 	/* reset the FIFO pointer to zero. We do this by writing to 8
 	   registers, each of which is a 32bit wide register, and set
 	   them all to zero. Note that s->iobase is a pointer to
-	   int32, not pointer to char.  
+	   int32, not pointer to char.
 	*/
 
 	for (i = 0; i < 8; i++) {
@@ -494,9 +494,9 @@ static int rme9652_set_rate(struct snd_rme9652 *rme9652, int rate)
 
 	/* Changing from a "single speed" to a "double speed" rate is
 	   not allowed if any substreams are open. This is because
-	   such a change causes a shift in the location of 
+	   such a change causes a shift in the location of
 	   the DMA buffers and a reduction in the number of available
-	   buffers. 
+	   buffers.
 
 	   Note that a similar but essentially insoluble problem
 	   exists for externally-driven rate changes. All we can do
@@ -605,7 +605,7 @@ static void rme9652_set_thru(struct snd_rme9652 *rme9652, int channel, int enabl
 
 		rme9652_write(rme9652,
 			       RME9652_thru_base + mapped_channel * 4,
-			       enable ? 1 : 0);			       
+			       enable ? 1 : 0);
 	}
 }
 
@@ -619,7 +619,7 @@ static int rme9652_set_passthru(struct snd_rme9652 *rme9652, int onoff)
 		*/
 
 		rme9652->control_register =
-			RME9652_inp_0 | 
+			RME9652_inp_0 |
 			rme9652_encode_latency(7) |
 			RME9652_start_bit;
 
@@ -630,24 +630,24 @@ static int rme9652_set_passthru(struct snd_rme9652 *rme9652, int onoff)
 		rme9652->passthru = 1;
 	} else {
 		rme9652_set_thru(rme9652, -1, 0);
-		rme9652_stop(rme9652);		
+		rme9652_stop(rme9652);
 		rme9652->passthru = 0;
 	}
 
 	return 0;
 }
 
-static void rme9652_spdif_set_bit (struct snd_rme9652 *rme9652, int mask, int onoff)
+static void rme9652_spdif_set_bit(struct snd_rme9652 *rme9652, int mask, int onoff)
 {
-	if (onoff) 
+	if (onoff)
 		rme9652->control_register |= mask;
-	else 
+	else
 		rme9652->control_register &= ~mask;
-		
+
 	rme9652_write(rme9652, RME9652_control_register, rme9652->control_register);
 }
 
-static void rme9652_spdif_write_byte (struct snd_rme9652 *rme9652, const int val)
+static void rme9652_spdif_write_byte(struct snd_rme9652 *rme9652, const int val)
 {
 	long mask;
 	long i;
@@ -655,7 +655,7 @@ static void rme9652_spdif_write_byte (struct snd_rme9652 *rme9652, const int val
 	for (i = 0, mask = 0x80; i < 8; i++, mask >>= 1) {
 		if (val & mask)
 			rme9652_spdif_set_bit (rme9652, RME9652_SPDIF_WRITE, 1);
-		else 
+		else
 			rme9652_spdif_set_bit (rme9652, RME9652_SPDIF_WRITE, 0);
 
 		rme9652_spdif_set_bit (rme9652, RME9652_SPDIF_CLOCK, 1);
@@ -663,7 +663,7 @@ static void rme9652_spdif_write_byte (struct snd_rme9652 *rme9652, const int val
 	}
 }
 
-static int rme9652_spdif_read_byte (struct snd_rme9652 *rme9652)
+static int rme9652_spdif_read_byte(struct snd_rme9652 *rme9652)
 {
 	long mask;
 	long val;
@@ -681,7 +681,7 @@ static int rme9652_spdif_read_byte (struct snd_rme9652 *rme9652)
 	return val;
 }
 
-static void rme9652_write_spdif_codec (struct snd_rme9652 *rme9652, const int address, const int data)
+static void rme9652_write_spdif_codec(struct snd_rme9652 *rme9652, const int address, const int data)
 {
 	rme9652_spdif_set_bit (rme9652, RME9652_SPDIF_SELECT, 1);
 	rme9652_spdif_write_byte (rme9652, 0x20);
@@ -691,7 +691,7 @@ static void rme9652_write_spdif_codec (struct snd_rme9652 *rme9652, const int ad
 }
 
 
-static int rme9652_spdif_read_codec (struct snd_rme9652 *rme9652, const int address)
+static int rme9652_spdif_read_codec(struct snd_rme9652 *rme9652, const int address)
 {
 	int ret;
 
@@ -708,7 +708,7 @@ static int rme9652_spdif_read_codec (struct snd_rme9652 *rme9652, const int addr
 	return ret;
 }
 
-static void rme9652_initialize_spdif_receiver (struct snd_rme9652 *rme9652)
+static void rme9652_initialize_spdif_receiver(struct snd_rme9652 *rme9652)
 {
 	/* XXX what unsets this ? */
 
@@ -726,19 +726,19 @@ static inline int rme9652_spdif_sample_rate(struct snd_rme9652 *s)
 	if (rme9652_read(s, RME9652_status_register) & RME9652_ERF) {
 		return -1;	/* error condition */
 	}
-	
+
 	if (s->hw_rev == 15) {
 
 		int x, y, ret;
-		
+
 		x = rme9652_spdif_read_codec (s, 30);
 
-		if (x != 0) 
+		if (x != 0)
 			y = 48000 * 64 / x;
 		else
 			y = 0;
 
-		if      (y > 30400 && y < 33600)  ret = 32000; 
+		if      (y > 30400 && y < 33600)  ret = 32000;
 		else if (y > 41900 && y < 46000)  ret = 44100;
 		else if (y > 46000 && y < 50400)  ret = 48000;
 		else if (y > 60800 && y < 67200)  ret = 64000;
@@ -819,7 +819,7 @@ static int snd_rme9652_control_spdif_info(struct snd_kcontrol *kcontrol, struct
 static int snd_rme9652_control_spdif_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_rme9652_convert_to_aes(&ucontrol->value.iec958, rme9652->creg_spdif);
 	return 0;
 }
@@ -829,7 +829,7 @@ static int snd_rme9652_control_spdif_put(struct snd_kcontrol *kcontrol, struct s
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_rme9652_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&rme9652->lock);
 	change = val != rme9652->creg_spdif;
@@ -848,7 +848,7 @@ static int snd_rme9652_control_spdif_stream_info(struct snd_kcontrol *kcontrol,
 static int snd_rme9652_control_spdif_stream_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_rme9652_convert_to_aes(&ucontrol->value.iec958, rme9652->creg_spdif_stream);
 	return 0;
 }
@@ -858,7 +858,7 @@ static int snd_rme9652_control_spdif_stream_put(struct snd_kcontrol *kcontrol, s
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_rme9652_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&rme9652->lock);
 	change = val != rme9652->creg_spdif_stream;
@@ -891,7 +891,7 @@ static int snd_rme9652_control_spdif_mask_get(struct snd_kcontrol *kcontrol, str
 static unsigned int rme9652_adat1_in(struct snd_rme9652 *rme9652)
 {
 	if (rme9652->control_register & RME9652_ADAT1_INTERNAL)
-		return 1; 
+		return 1;
 	return 0;
 }
 
@@ -936,7 +936,7 @@ static int snd_rme9652_info_adat1_in(struct snd_kcontrol *kcontrol, struct snd_c
 static int snd_rme9652_get_adat1_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme9652->lock);
 	ucontrol->value.enumerated.item[0] = rme9652_adat1_in(rme9652);
 	spin_unlock_irq(&rme9652->lock);
@@ -948,7 +948,7 @@ static int snd_rme9652_put_adat1_in(struct snd_kcontrol *kcontrol, struct snd_ct
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_rme9652_use_is_exclusive(rme9652))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0] % 2;
@@ -1007,7 +1007,7 @@ static int snd_rme9652_info_spdif_in(struct snd_kcontrol *kcontrol, struct snd_c
 static int snd_rme9652_get_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme9652->lock);
 	ucontrol->value.enumerated.item[0] = rme9652_spdif_in(rme9652);
 	spin_unlock_irq(&rme9652->lock);
@@ -1019,7 +1019,7 @@ static int snd_rme9652_put_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ct
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_rme9652_use_is_exclusive(rme9652))
 		return -EBUSY;
 	val = ucontrol->value.enumerated.item[0] % 3;
@@ -1069,7 +1069,7 @@ static int rme9652_set_spdif_output(struct snd_rme9652 *rme9652, int out)
 static int snd_rme9652_get_spdif_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme9652->lock);
 	ucontrol->value.integer.value[0] = rme9652_spdif_out(rme9652);
 	spin_unlock_irq(&rme9652->lock);
@@ -1081,7 +1081,7 @@ static int snd_rme9652_put_spdif_out(struct snd_kcontrol *kcontrol, struct snd_c
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	if (!snd_rme9652_use_is_exclusive(rme9652))
 		return -EBUSY;
 	val = ucontrol->value.integer.value[0] & 1;
@@ -1156,7 +1156,7 @@ static int snd_rme9652_info_sync_mode(struct snd_kcontrol *kcontrol, struct snd_
 static int snd_rme9652_get_sync_mode(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme9652->lock);
 	ucontrol->value.enumerated.item[0] = rme9652_sync_mode(rme9652);
 	spin_unlock_irq(&rme9652->lock);
@@ -1168,7 +1168,7 @@ static int snd_rme9652_put_sync_mode(struct snd_kcontrol *kcontrol, struct snd_c
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 	int change;
 	unsigned int val;
-	
+
 	val = ucontrol->value.enumerated.item[0] % 3;
 	spin_lock_irq(&rme9652->lock);
 	change = (int)val != rme9652_sync_mode(rme9652);
@@ -1248,7 +1248,7 @@ static int snd_rme9652_info_sync_pref(struct snd_kcontrol *kcontrol, struct snd_
 static int snd_rme9652_get_sync_pref(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme9652->lock);
 	ucontrol->value.enumerated.item[0] = rme9652_sync_pref(rme9652);
 	spin_unlock_irq(&rme9652->lock);
@@ -1260,7 +1260,7 @@ static int snd_rme9652_put_sync_pref(struct snd_kcontrol *kcontrol, struct snd_c
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 	int change, max;
 	unsigned int val;
-	
+
 	if (!snd_rme9652_use_is_exclusive(rme9652))
 		return -EBUSY;
 	max = rme9652->ss_channels == RME9652_NCHANNELS ? 4 : 3;
@@ -1308,7 +1308,7 @@ static int snd_rme9652_put_thru(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 		if (ucontrol->value.integer.value[chn])
 			thru_bits |= 1 << chn;
 	}
-	
+
 	spin_lock_irq(&rme9652->lock);
 	change = thru_bits ^ rme9652->thru_bits;
 	if (change) {
@@ -1379,7 +1379,7 @@ static int snd_rme9652_info_spdif_rate(struct snd_kcontrol *kcontrol, struct snd
 static int snd_rme9652_get_spdif_rate(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme9652->lock);
 	ucontrol->value.integer.value[0] = rme9652_spdif_sample_rate(rme9652);
 	spin_unlock_irq(&rme9652->lock);
@@ -1409,11 +1409,11 @@ static int snd_rme9652_get_adat_sync(struct snd_kcontrol *kcontrol, struct snd_c
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
 	unsigned int mask1, mask2, val;
-	
+
 	switch (kcontrol->private_value) {
-	case 0: mask1 = RME9652_lock_0; mask2 = RME9652_sync_0; break;	
-	case 1: mask1 = RME9652_lock_1; mask2 = RME9652_sync_1; break;	
-	case 2: mask1 = RME9652_lock_2; mask2 = RME9652_sync_2; break;	
+	case 0: mask1 = RME9652_lock_0; mask2 = RME9652_sync_0; break;
+	case 1: mask1 = RME9652_lock_1; mask2 = RME9652_sync_1; break;
+	case 2: mask1 = RME9652_lock_2; mask2 = RME9652_sync_2; break;
 	default: return -EINVAL;
 	}
 	val = rme9652_read(rme9652, RME9652_status_register);
@@ -1433,8 +1433,8 @@ static int snd_rme9652_get_adat_sync(struct snd_kcontrol *kcontrol, struct snd_c
 static int snd_rme9652_get_tc_valid(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_rme9652 *rme9652 = snd_kcontrol_chip(kcontrol);
-	
-	ucontrol->value.integer.value[0] = 
+
+	ucontrol->value.integer.value[0] =
 		(rme9652_read(rme9652, RME9652_status_register) & RME9652_tc_valid) ? 1 : 0;
 	return 0;
 }
@@ -1520,7 +1520,7 @@ static struct snd_kcontrol_new snd_rme9652_controls[] = {
 	.get =		snd_rme9652_control_spdif_mask_get,
 	.private_value = IEC958_AES0_NONAUDIO |
 			IEC958_AES0_PROFESSIONAL |
-			IEC958_AES0_CON_EMPHASIS,	                                                                                      
+			IEC958_AES0_CON_EMPHASIS,
 },
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
@@ -1582,7 +1582,7 @@ static int snd_rme9652_create_controls(struct snd_card *card, struct snd_rme9652
 }
 
 /*------------------------------------------------------------
-   /proc interface 
+   /proc interface
  ------------------------------------------------------------*/
 
 static void
@@ -1606,10 +1606,10 @@ snd_rme9652_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buff
 
 	snd_iprintf(buffer, "\n");
 
-	x = 1 << (6 + rme9652_decode_latency(rme9652->control_register & 
+	x = 1 << (6 + rme9652_decode_latency(rme9652->control_register &
 					     RME9652_latency));
 
-	snd_iprintf(buffer, "Latency: %d samples (2 periods of %lu bytes)\n", 
+	snd_iprintf(buffer, "Latency: %d samples (2 periods of %lu bytes)\n",
 		    x, (unsigned long) rme9652->period_bytes);
 	snd_iprintf(buffer, "Hardware pointer (frames): %ld\n",
 		    rme9652_hw_pointer(rme9652));
@@ -1655,7 +1655,7 @@ snd_rme9652_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buff
 
 	snd_iprintf(buffer, "\n");
 
-	switch (rme9652_decode_spdif_in(rme9652->control_register & 
+	switch (rme9652_decode_spdif_in(rme9652->control_register &
 					RME9652_inp)) {
 	case RME9652_SPDIFIN_OPTICAL:
 		snd_iprintf(buffer, "IEC958 input: ADAT1\n");
@@ -1762,7 +1762,7 @@ static void __devinit snd_rme9652_proc_init(struct snd_rme9652 *rme9652)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(rme9652->card, "rme9652", &entry))
+	if (!snd_card_proc_new(rme9652->card, "rme9652", &entry))
 		snd_info_set_text_ops(entry, rme9652, snd_rme9652_proc_read);
 }
 
@@ -1828,11 +1828,11 @@ static void snd_rme9652_set_defaults(struct snd_rme9652 *rme9652)
 
 	/* set defaults:
 
-	   SPDIF Input via Coax 
+	   SPDIF Input via Coax
 	   autosync clock mode
 	   maximum latency (7 = 8192 samples, 64Kbyte buffer,
 	   which implies 2 4096 sample, 32Kbyte periods).
-	   
+
 	   if rev 1.5, initialize the S/PDIF receiver.
 
 	 */
@@ -1893,11 +1893,11 @@ static char *rme9652_channel_buffer_location(struct snd_rme9652 *rme9652,
 
 	if (snd_BUG_ON(channel < 0 || channel >= RME9652_NCHANNELS))
 		return NULL;
-        
+
 	if ((mapped_channel = rme9652->channel_map[channel]) < 0) {
 		return NULL;
 	}
-	
+
 	if (stream == SNDRV_PCM_STREAM_CAPTURE) {
 		return rme9652->capture_buffer +
 			(mapped_channel * RME9652_CHANNEL_BUFFER_BYTES);
@@ -2142,10 +2142,10 @@ static int snd_rme9652_trigger(struct snd_pcm_substream *substream,
 				rme9652_silence_playback(rme9652);
 		}
 	} else {
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) 
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			rme9652_silence_playback(rme9652);
 	}
- _ok:
+_ok:
 	snd_pcm_trigger_done(substream, substream);
 	if (!rme9652->running && running)
 		rme9652_start(rme9652);
@@ -2178,9 +2178,9 @@ static struct snd_pcm_hardware snd_rme9652_playback_subinfo =
 				 SNDRV_PCM_INFO_SYNC_START |
 				 SNDRV_PCM_INFO_DOUBLE),
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		(SNDRV_PCM_RATE_44100 | 
-				 SNDRV_PCM_RATE_48000 | 
-				 SNDRV_PCM_RATE_88200 | 
+	.rates =		(SNDRV_PCM_RATE_44100 |
+				 SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_88200 |
 				 SNDRV_PCM_RATE_96000),
 	.rate_min =		44100,
 	.rate_max =		96000,
@@ -2201,9 +2201,9 @@ static struct snd_pcm_hardware snd_rme9652_capture_subinfo =
 				 SNDRV_PCM_INFO_NONINTERLEAVED |
 				 SNDRV_PCM_INFO_SYNC_START),
 	.formats =		SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		(SNDRV_PCM_RATE_44100 | 
-				 SNDRV_PCM_RATE_48000 | 
-				 SNDRV_PCM_RATE_88200 | 
+	.rates =		(SNDRV_PCM_RATE_44100 |
+				 SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_88200 |
 				 SNDRV_PCM_RATE_96000),
 	.rate_min =		44100,
 	.rate_max =		96000,
@@ -2478,7 +2478,7 @@ static int __devinit snd_rme9652_create(struct snd_card *card,
 		snd_printk(KERN_ERR "unable to remap region 0x%lx-0x%lx\n", rme9652->port, rme9652->port + RME9652_IO_EXTENT - 1);
 		return -EBUSY;
 	}
-	
+
 	if (request_irq(pci->irq, snd_rme9652_interrupt, IRQF_SHARED,
 			"rme9652", rme9652)) {
 		snd_printk(KERN_ERR "unable to request IRQ %d\n", pci->irq);
@@ -2503,7 +2503,7 @@ static int __devinit snd_rme9652_create(struct snd_card *card,
 	   "Light", which does not have the expansion board. This
 	   method comes from information received from Mathhias
 	   Clausen at RME. Display the EEPROM and h/w revID where
-	   relevant.  
+	   relevant.
 	*/
 
 	switch (rev) {
@@ -2616,7 +2616,7 @@ static int __devinit snd_rme9652_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at 0x%lx, irq %d",
 		card->shortname, rme9652->port, rme9652->irq);
 
-	
+
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
