From: Paul Davis <paul@linuxaudiosystems.com>
Subject: patch for h-dsp driver
Date: Tue, 4 Mar 2003 16:07:36 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303042107.h24L7ag02873@linuxaudiosystems.com>
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

Enclosed below is a substantial patch (against current CVS) for the
HDSP driver. It does a number of things:

       * read access to mixer
       * remove "force_firmware" option, since it does nothing (the
                h/w can't be reloaded without a power cycle)
       * fix RMS meter offsets (from Thomas Charbonnel)
       * fix number of output peak meter controls (from Thomas Charbonnel)
       * handle various newer PCI rev numbers
       * create a more informational card_name field
       * support for HDSP rev11 (0xb) mixer 
       * attempts to implement HDSP9652 mixer control (untested)
       * add new "rev11 config file" (sort-of-firmware)

the new firmware will be enclosed in a separate message, compressed, etc.

Still to come: RMS meter controls for the HDSP9652 hardware, firmware
loading from a file, use of udelay() to handle "wait loops".

--p


Index: hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.26
diff -u -u -r1.26 hdsp.c
--- hdsp.c	4 Mar 2003 16:47:35 -0000	1.26
+++ hdsp.c	4 Mar 2003 20:47:31 -0000
@@ -23,7 +23,6 @@
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 
@@ -42,13 +41,14 @@
 
 #include "multiface_firmware.dat"
 #include "digiface_firmware.dat"
+#include "multiface_firmware_rev11.dat"
+#include "digiface_firmware_rev11.dat"
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
 static int precise_ptr[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0 }; /* Enable precise pointer */
 static int line_outs_monitor[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0}; /* Send all inputs/playback to line outs */
-static int force_firmware[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0}; /* Force firmware reload */
 
 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(index, "Index value for RME Hammerfall DSP interface.");
@@ -65,19 +65,17 @@
 MODULE_PARM(line_outs_monitor,"1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(line_outs_monitor, "Send all input and playback streams to line outs by default.");
 MODULE_PARM_SYNTAX(line_outs_monitor, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
-MODULE_PARM(force_firmware,"1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(force_firmware, "Force a reload of the I/O box firmware");
-MODULE_PARM_SYNTAX(force_firmware, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);
 MODULE_AUTHOR("Paul Davis <pbd@op.net>");
 MODULE_DESCRIPTION("RME Hammerfall DSP");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
-MODULE_DEVICES("{{RME,Hammerfall-DSP}}");
+MODULE_DEVICES("{{RME Hammerfall-DSP},"
+	        "{RME HDSP-9652}}");
 
 typedef enum {
 	Digiface,
-	Multiface
-} HDSP_Type;
+	Multiface,
+} HDSP_IO_Type;
 
 #define HDSP_MAX_CHANNELS        26
 #define DIGIFACE_SS_CHANNELS     26
@@ -123,9 +121,9 @@
 
 #define HDSP_playbackPeakLevel  4096  /* 26 * 32 bit values */
 #define HDSP_inputPeakLevel     4224  /* 26 * 32 bit values */
-#define HDSP_outputPeakLevel    4100  /* 26 * 32 bit values */
+#define HDSP_outputPeakLevel    4352  /* 26 * 32 bit values */
 #define HDSP_playbackRmsLevel   4612  /* 26 * 64 bit values */
-#define HDSP_inputRmsLevel      4884  /* 26 * 64 bit values */
+#define HDSP_inputRmsLevel      4868  /* 26 * 64 bit values */
 
 #define HDSP_IO_EXTENT     5192
 
@@ -287,10 +285,6 @@
 #define HDSP_LONG_WAIT	 40000
 #define HDSP_SHORT_WAIT  100
 
-/* Computing addresses for adjusting gains */
-
-#define INPUT_TO_OUTPUT_KEY(in,out)     ((64 * (out)) + (in))
-#define PLAYBACK_TO_OUTPUT_KEY(chn,out) ((64 * (out)) + 32 + (chn))
 #define UNITY_GAIN                       32768
 #define MINUS_INFINITY_GAIN              0
 
@@ -335,42 +329,43 @@
 };
 
 struct _hdsp {
-	spinlock_t lock;
+	spinlock_t           lock;
 	snd_pcm_substream_t *capture_substream;
 	snd_pcm_substream_t *playback_substream;
-        hdsp_midi_t midi[2];
-	int precise_ptr;
-	u32 control_register;	         /* cached value */
-	u32 creg_spdif;
-	u32 creg_spdif_stream;
-	char *card_name;		 /* digiface/multiface */
-        HDSP_Type type;                  /* ditto, but for code use */
-	size_t period_bytes;		 /* guess what this is */
-	unsigned char ds_channels;
-	unsigned char ss_channels;	 /* different for multiface/digiface */
-	void *capture_buffer_unaligned;	 /* original buffer addresses */
-	void *playback_buffer_unaligned; /* original buffer addresses */
-	unsigned char *capture_buffer;	 /* suitably aligned address */
-	unsigned char *playback_buffer;	 /* suitably aligned address */
-	dma_addr_t capture_buffer_addr;
-	dma_addr_t playback_buffer_addr;
-	pid_t capture_pid;
-	pid_t playback_pid;
-	int running;
-        int passthru;                   /* non-zero if doing pass-thru */
-	int last_spdif_sample_rate;	/* so that we can catch externally ... */
-	int last_adat_sample_rate;	/* ... induced rate changes            */
-        char *channel_map;
-	int dev;
-	int irq;
-	unsigned long port;
-	struct resource *res_port;
-        unsigned long iobase;
-	snd_card_t *card;
-	snd_pcm_t *pcm;
-	struct pci_dev *pci;
-	snd_kcontrol_t *spdif_ctl;
-        unsigned short mixer_matrix[HDSP_MATRIX_MIXER_SIZE];
+        hdsp_midi_t          midi[2];
+	int                  precise_ptr;
+	u32                  control_register;	         /* cached value */
+	u32                  creg_spdif;
+	u32                  creg_spdif_stream;
+	char                *card_name;		    /* digiface/multiface */
+        HDSP_IO_Type         io_type;               /* ditto, but for code use */
+        unsigned short       firmware_rev;
+	size_t               period_bytes; 	    /* guess what this is */
+	unsigned char        ds_channels;
+	unsigned char        ss_channels;	    /* different for multiface/digiface */
+	void                *capture_buffer_unaligned;	 /* original buffer addresses */
+	void                *playback_buffer_unaligned; /* original buffer addresses */
+	unsigned char       *capture_buffer;	    /* suitably aligned address */
+	unsigned char       *playback_buffer;	    /* suitably aligned address */
+	dma_addr_t           capture_buffer_addr;
+	dma_addr_t           playback_buffer_addr;
+	pid_t                capture_pid;
+	pid_t                playback_pid;
+	int                  running;
+        int                  passthru;              /* non-zero if doing pass-thru */
+	int                  last_spdif_sample_rate;/* so that we can catch externally ... */
+	int                  last_adat_sample_rate; /* ... induced rate changes            */
+        char                *channel_map;
+	int                  dev;
+	int                  irq;
+	unsigned long        port;
+	struct resource     *res_port;
+        unsigned long        iobase;
+	snd_card_t          *card;
+	snd_pcm_t           *pcm;
+	struct pci_dev      *pci;
+	snd_kcontrol_t      *spdif_ctl;
+        unsigned short       mixer_matrix[HDSP_MATRIX_MIXER_SIZE];
 };
 
 /* These tables map the ALSA channels 1..N to the channels that we
@@ -414,8 +409,8 @@
 
 static struct pci_device_id snd_hdsp_ids[] __devinitdata = {
 	{
-		.vendor	   = PCI_VENDOR_ID_XILINX,
-		.device	   = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP, 
+		.vendor = PCI_VENDOR_ID_XILINX,
+		.device = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP, 
 		.subvendor = PCI_ANY_ID,
 		.subdevice = PCI_ANY_ID,
 	}, /* RME Hammerfall-DSP */
@@ -424,6 +419,37 @@
 
 MODULE_DEVICE_TABLE(pci, snd_hdsp_ids);
 
+static inline int hdsp_is_9652 (hdsp_t *hdsp)
+{
+	switch (hdsp->firmware_rev) {
+	case 0xb:
+	case 0x68:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static inline int hdsp_playback_to_output_key (hdsp_t *hdsp, int in, int out)
+{
+	switch (hdsp->firmware_rev) {
+	case 0xa:
+		return (64 * out) + (32 + (in));
+	default:
+		return (52 * out) + (26 + (in));
+	}
+}
+
+static inline int hdsp_input_to_output_key (hdsp_t *hdsp, int in, int out)
+{
+	switch (hdsp->firmware_rev) {
+	case 0xa:
+		return (64 * out) + in;
+	default:
+		return (52 * out) + in;
+	}
+}
+
 static inline void hdsp_write(hdsp_t *hdsp, int reg, int val)
 {
 	writel(val, hdsp->iobase + reg);
@@ -477,20 +503,57 @@
 	return hdsp->mixer_matrix[addr];
 }
 
+/*
+ if (xc2s200) {
+  int a = addr / 2;
+  if (a < 676)
+   MemBase[1024+a] = 65536 * Vol[(addr & 0x7FE) + 1] + Vol[(addr & 0x7FE)];
+  return true;
+ } else {
+  for (int j = 0; j < 100; j++) {
+   if ((*FifoStatus & 0xFF) >= 128) {
+    _sleep(1);
+   } else {
+    *FifoReg = addr*65536+Vol[addr];
+    return true;
+   }
+  }
+  return false;
+ }
+}
+*/
+
 static inline int hdsp_write_gain(hdsp_t *hdsp, unsigned int addr, unsigned short data)
 {
 	unsigned int ad;
 
-	if (addr >= HDSP_MATRIX_MIXER_SIZE)
-		return -1;
+	if (hdsp_is_9652 (hdsp)) {
 
-	ad = data + addr * 65536;
+		if ((ad = addr/2) < 676) {
+			hdsp->mixer_matrix[addr] = data;
+			hdsp_write (hdsp, 1024 + ad, 
+				    65536 * hdsp->mixer_matrix[(addr&0x7fe)+1] + 
+				    hdsp->mixer_matrix[addr&0x7fe]);
+			return 0;
+		} else {
+			return -1;
+		}
+		
+
+	} else {
+		if (addr >= HDSP_MATRIX_MIXER_SIZE)
+			return -1;
+		
+		ad = data + addr * 65536;
+		
+		if (hdsp_fifo_wait(hdsp, 127, HDSP_LONG_WAIT)) {
+			return -1;
+		}
+
+		hdsp_write (hdsp, HDSP_fifoData, ad);
+		hdsp->mixer_matrix[addr] = data;
 
-	if (hdsp_fifo_wait(hdsp, 127, HDSP_LONG_WAIT)) {
-		return -1;
 	}
-	hdsp_write (hdsp, HDSP_fifoData, ad);
-	hdsp->mixer_matrix[addr] = data;
 
 	return 0;
 }
@@ -571,17 +634,7 @@
 
 static inline void hdsp_reset_hw_pointer(hdsp_t *hdsp)
 {
-#if 0
-	/* reset the hw pointer to zero. We do this by writing to 8
-	   registers, each of which is a 32bit wide register, and set
-	   them all to zero. 
-	*/
-
-	for (i = 0; i < 8; ++i) {
-		hdsp_write(hdsp, i, 0);
-		udelay(10);
-	}
-#endif
+	hdsp_write (hdsp, HDSP_resetPointer, 0);
 }
 
 static inline void hdsp_start_audio(hdsp_t *s)
@@ -707,7 +760,7 @@
 	if (rate > 48000) {
 		hdsp->channel_map = channel_map_ds;
 	} else {
-		switch (hdsp->type) {
+		switch (hdsp->io_type) {
 		case Multiface:
 			hdsp->channel_map = channel_map_mf_ss;
 			break;
@@ -734,11 +787,11 @@
 
 		if (enable) {
 			for (i = 0; i < 26; i++) {
-				hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY(i,i), UNITY_GAIN);
+				hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,i,i), UNITY_GAIN);
 			}
 		} else {
 			for (i = 0; i < 26; i++) {
-				hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY(i,i), MINUS_INFINITY_GAIN);
+				hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,i,i), MINUS_INFINITY_GAIN);
 			}
 		}
 
@@ -752,9 +805,9 @@
 		snd_assert(mapped_channel > -1, return);
 
 		if (enable) {
-			hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY(mapped_channel,mapped_channel), UNITY_GAIN);
+			hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,mapped_channel,mapped_channel), UNITY_GAIN);
 		} else {
-			hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY(mapped_channel,mapped_channel), MINUS_INFINITY_GAIN);
+			hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,mapped_channel,mapped_channel), MINUS_INFINITY_GAIN);
 		}
 	}
 }
@@ -974,7 +1027,6 @@
 	if (up)
 		snd_hdsp_midi_output_write(hmidi);
 }
-
 static int snd_hdsp_midi_input_open(snd_rawmidi_substream_t * substream)
 {
 	hdsp_midi_t *hmidi;
@@ -1178,9 +1230,12 @@
 }
 
 #define HDSP_SPDIF_IN(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, .name = xname, .index = xindex, \
+{ .iface = SNDRV_CTL_ELEM_IFACE_PCM,  \
+  .name = xname, \
+  .index = xindex, \
   .info = snd_hdsp_info_spdif_in, \
-  .get = snd_hdsp_get_spdif_in, .put = snd_hdsp_put_spdif_in }
+  .get = snd_hdsp_get_spdif_in, \
+  .put = snd_hdsp_put_spdif_in }
 
 static unsigned int hdsp_spdif_in(hdsp_t *hdsp)
 {
@@ -1238,9 +1293,9 @@
 }
 
 #define HDSP_SPDIF_OUT(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, .name = xname, .index = xindex, \
+{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, name: xname, index: xindex, \
   .info = snd_hdsp_info_spdif_out, \
-  .get = snd_hdsp_get_spdif_out, .put = snd_hdsp_put_spdif_out }
+  .get = snd_hdsp_get_spdif_out, put: snd_hdsp_put_spdif_out }
 
 static int hdsp_spdif_out(hdsp_t *hdsp)
 {
@@ -1296,9 +1351,13 @@
 }
 
 #define HDSP_SYNC_PREF(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, .name = xname, .index = xindex, \
+{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, \
+  .name = xname, \
+  .index = xindex, \
   .info = snd_hdsp_info_sync_pref, \
-  .get = snd_hdsp_get_sync_pref, .put = snd_hdsp_put_sync_pref }
+  .get = snd_hdsp_get_sync_pref, \
+  .put = snd_hdsp_put_sync_pref \
+}
 
 static int hdsp_sync_pref(hdsp_t *hdsp)
 {
@@ -1374,7 +1433,7 @@
 	
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = (hdsp->type == Digiface) ? 7 : 6;
+	uinfo->value.enumerated.items = (hdsp->io_type == Digiface) ? 7 : 6;
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
@@ -1401,7 +1460,7 @@
 	
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
-	max = hdsp->ss_channels == (hdsp->type == Digiface) ? 7 : 6;
+	max = hdsp->ss_channels == (hdsp->io_type == Digiface) ? 7 : 6;
 	val = ucontrol->value.enumerated.item[0] % max;
 	spin_lock_irqsave(&hdsp->lock, flags);
 	change = (int)val != hdsp_sync_pref(hdsp);
@@ -1411,10 +1470,13 @@
 }
 
 #define HDSP_PASSTHRU(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, .name = xname, .index = xindex, \
+{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, \
+  .name = xname, \
+  .index = xindex, \
   .info = snd_hdsp_info_passthru, \
   .put = snd_hdsp_put_passthru, \
-  .get = snd_hdsp_get_passthru }
+  .get = snd_hdsp_get_passthru \
+}
 
 static int snd_hdsp_info_passthru(snd_kcontrol_t * kcontrol, snd_ctl_elem_info_t * uinfo)
 {
@@ -1457,9 +1519,13 @@
 }
 
 #define HDSP_LINE_OUT(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, .name = xname, .index = xindex, \
+{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, \
+  .name = xname, \
+  .index = xindex, \
   .info = snd_hdsp_info_line_out, \
-  .get = snd_hdsp_get_line_out, .put = snd_hdsp_put_line_out }
+  .get = snd_hdsp_get_line_out, \
+  .put = snd_hdsp_put_line_out \
+}
 
 static int hdsp_line_out(hdsp_t *hdsp)
 {
@@ -1515,9 +1581,15 @@
 }
 
 #define HDSP_MIXER(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, .name = xname, .index = xindex, \
+{ .iface = SNDRV_CTL_ELEM_IFACE_PCM, \
+  .name = xname, \
+  .index = xindex, \
+  .access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_WRITE | \
+		 SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
   .info = snd_hdsp_info_mixer, \
-  .get = snd_hdsp_get_mixer, .put = snd_hdsp_put_mixer }
+  .get = snd_hdsp_get_mixer, \
+  .put = snd_hdsp_put_mixer \
+}
 
 static int snd_hdsp_info_mixer(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
@@ -1541,9 +1613,9 @@
 	destination = ucontrol->value.integer.value[1];
 
 	if (source > 25) {
-		addr = PLAYBACK_TO_OUTPUT_KEY(source-26,destination);
+		addr = hdsp_playback_to_output_key(hdsp,source-26,destination);
 	} else {
-		addr = INPUT_TO_OUTPUT_KEY(source, destination);
+		addr = hdsp_input_to_output_key(hdsp,source, destination);
 	}
 	
 	spin_lock_irqsave(&hdsp->lock, flags);
@@ -1569,9 +1641,9 @@
 	destination = ucontrol->value.integer.value[1];
 
 	if (source > 25) {
-		addr = PLAYBACK_TO_OUTPUT_KEY(source-26, destination);
+		addr = hdsp_playback_to_output_key(hdsp,source-26, destination);
 	} else {
-		addr = INPUT_TO_OUTPUT_KEY(source, destination);
+		addr = hdsp_input_to_output_key(hdsp,source, destination);
 	}
 
 	gain = ucontrol->value.integer.value[2];
@@ -1594,7 +1666,9 @@
   .access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_WRITE | \
 		 SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
   .info = snd_hdsp_info_playback_mixer, \
-  .get = snd_hdsp_get_playback_mixer, .put = snd_hdsp_put_playback_mixer }
+  .get = snd_hdsp_get_playback_mixer, \
+  .put = snd_hdsp_put_playback_mixer \
+}
 
 static int snd_hdsp_info_playback_mixer(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
@@ -1622,7 +1696,7 @@
 		return -EINVAL;
 	}
 
-	addr = PLAYBACK_TO_OUTPUT_KEY(mapped_channel, mapped_channel);
+	addr = hdsp_playback_to_output_key(hdsp,mapped_channel, mapped_channel);
 
 	spin_lock_irqsave(&hdsp->lock, flags);
 	ucontrol->value.integer.value[0] = hdsp_read_gain (hdsp, addr);
@@ -1651,7 +1725,7 @@
 		return -EINVAL;
 	}
 
-	addr = PLAYBACK_TO_OUTPUT_KEY(mapped_channel, mapped_channel);
+	addr = hdsp_playback_to_output_key(hdsp,mapped_channel, mapped_channel);
 	gain = ucontrol->value.integer.value[0];
 
 
@@ -1797,8 +1871,8 @@
 	.info =		snd_hdsp_control_spdif_mask_info,
 	.get =		snd_hdsp_control_spdif_mask_get,
 	.private_value = IEC958_AES0_NONAUDIO |
-			IEC958_AES0_PROFESSIONAL |
-			IEC958_AES0_CON_EMPHASIS,	                                                                                      
+  			 IEC958_AES0_PROFESSIONAL |
+			 IEC958_AES0_CON_EMPHASIS,	                                                                                      
 },
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
@@ -1807,8 +1881,8 @@
 	.info =		snd_hdsp_control_spdif_mask_info,
 	.get =		snd_hdsp_control_spdif_mask_get,
 	.private_value = IEC958_AES0_NONAUDIO |
-			IEC958_AES0_PROFESSIONAL |
-			IEC958_AES0_PRO_EMPHASIS,
+			 IEC958_AES0_PROFESSIONAL |
+			 IEC958_AES0_PRO_EMPHASIS,
 },
 HDSP_MIXER("Mixer", 0),
 HDSP_SPDIF_IN("IEC958 Input Connector", 0),
@@ -1829,7 +1903,7 @@
 
 int snd_hdsp_create_controls(snd_card_t *card, hdsp_t *hdsp)
 {
-	unsigned int idx, limit;
+	unsigned int idx;
 	int err;
 	snd_kcontrol_t *kctl;
 
@@ -1840,12 +1914,6 @@
 			hdsp->spdif_ctl = kctl;
 	}
 
-	if (hdsp->type == Digiface) {
-		limit = DIGIFACE_SS_CHANNELS;
-	} else {
-		limit = MULTIFACE_SS_CHANNELS;
-	}
-
 	/* The index values are one greater than the channel ID so that alsamixer
 	   will display them correctly. We want to use the index for fast lookup
 	   of the relevant channel, but if we use it at all, most ALSA software
@@ -1859,7 +1927,7 @@
 	snd_hdsp_playback_rms.name = "Playback RMS";
 	snd_hdsp_input_rms.name = "Input RMS";
 
-	for (idx = 0; idx < limit; ++idx) {
+	for (idx = 0; idx < HDSP_MAX_CHANNELS; ++idx) {
 		snd_hdsp_playback_mixer.index = idx+1;
 		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_playback_mixer, hdsp)))) {
 			return err;
@@ -1868,10 +1936,6 @@
 		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_input_peak, hdsp)))) {
 			return err;
 		}
-		snd_hdsp_output_peak.index = idx+1;
-		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_output_peak, hdsp)))) {
-			return err;
-		}
 		snd_hdsp_playback_peak.index = idx+1;
 		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_playback_peak, hdsp)))) {
 			return err;
@@ -1886,6 +1950,13 @@
 		}
 	}
 
+	for (idx = 0; idx < HDSP_MAX_CHANNELS + 2; ++idx) {
+		snd_hdsp_output_peak.index = idx+1;
+		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_output_peak, hdsp)))) {
+			return err;
+		}
+	}
+
 	return 0;
 }
 
@@ -2057,13 +2128,17 @@
 		snd_iprintf(buffer, "ADAT2: No Lock\n");
 	}
 
-	if (hdsp->type == Digiface) {
+	switch (hdsp->io_type) {
+	case Digiface:
 		x = status & HDSP_Sync2;
 		if (status & HDSP_Lock2) {
 			snd_iprintf(buffer, "ADAT3: %s\n", x ? "Sync" : "Lock");
 		} else {
 			snd_iprintf(buffer, "ADAT3: No Lock\n");
 		}
+	default:
+		/* relax */
+		break;
 	}
 
 	snd_iprintf(buffer, "\n");
@@ -2212,11 +2287,11 @@
 		
 		for (i = 0; i < HDSP_MAX_CHANNELS; i++) {
 			if (i & 1) { 
-				hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY (i, 26), UNITY_GAIN);
-				hdsp_write_gain (hdsp, PLAYBACK_TO_OUTPUT_KEY (i, 26), UNITY_GAIN);
+				hdsp_write_gain (hdsp, hdsp_input_to_output_key (hdsp, i, 26), UNITY_GAIN);
+				hdsp_write_gain (hdsp, hdsp_playback_to_output_key (hdsp, i, 26), UNITY_GAIN);
 			} else {
-				hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY (i, 27), UNITY_GAIN);
-				hdsp_write_gain (hdsp, PLAYBACK_TO_OUTPUT_KEY (i, 27), UNITY_GAIN);
+				hdsp_write_gain (hdsp, hdsp_input_to_output_key (hdsp, i, 27), UNITY_GAIN);
+				hdsp_write_gain (hdsp, hdsp_playback_to_output_key (hdsp, i, 27), UNITY_GAIN);
 			}
 		}
 	}
@@ -2310,8 +2385,7 @@
 
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	snd_assert(channel_buf != NULL, return -EIO);
-	if (copy_from_user(channel_buf + pos * 4, src, count * 4))
-		return -EFAULT;
+	copy_from_user(channel_buf + pos * 4, src, count * 4);
 	return count;
 }
 
@@ -2325,8 +2399,7 @@
 
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	snd_assert(channel_buf != NULL, return -EIO);
-	if (copy_to_user(dst, channel_buf + pos * 4, count * 4))
-		return -EFAULT;
+	copy_to_user(dst, channel_buf + pos * 4, count * 4);
 	return count;
 }
 
@@ -2400,7 +2473,7 @@
 		   that matter are the same.
 		 */
 
-		if ((int)params_rate(params) != hdsp_system_sample_rate(hdsp)) {
+		if (params_rate(params) != hdsp_system_sample_rate(hdsp)) {
 			spin_unlock_irq(&hdsp->lock);
 			_snd_pcm_hw_param_setempty(params, SNDRV_PCM_HW_PARAM_RATE);
 			return -EBUSY;
@@ -2577,11 +2650,11 @@
 	.channels_min =		14,
 	.channels_max =		HDSP_MAX_CHANNELS,
 	.buffer_bytes_max =	HDSP_CHANNEL_BUFFER_BYTES * HDSP_MAX_CHANNELS,
-	.period_bytes_min =	(64 * 4) *10,
+	.period_bytes_min =	(64 * 4) * 10,
 	.period_bytes_max =	(8192 * 4) * HDSP_MAX_CHANNELS,
 	.periods_min =		2,
 	.periods_max =		2,
-	.fifo_size =		0,
+	.fifo_size =		0
 };
 
 static snd_pcm_hardware_t snd_hdsp_capture_subinfo =
@@ -2606,7 +2679,7 @@
 	.period_bytes_max =	(8192 * 4) * HDSP_MAX_CHANNELS,
 	.periods_min =		2,
 	.periods_max =		2,
-	.fifo_size =		0,
+	.fifo_size =		0
 };
 
 static unsigned int period_sizes[] = { 64, 128, 256, 512, 1024, 2048, 4096, 8192 };
@@ -2638,7 +2711,7 @@
 		snd_interval_t t = {
 			.min = hdsp->ds_channels,
 			.max = hdsp->ds_channels,
-			.integer = 1,
+			integer: 1,
 		};
 		return snd_interval_refine(c, &t);
 	} else if (r->max < 64000) {
@@ -2662,7 +2735,7 @@
 		snd_interval_t t = {
 			.min = 32000,
 			.max = 48000,
-			.integer = 1,
+			integer: 1,
 		};
 		return snd_interval_refine(r, &t);
 	} else if (c->max <= hdsp->ds_channels) {
@@ -2862,7 +2935,7 @@
 		hdsp_write (hdsp, HDSP_outputEnable + (4 * i), 1);
 	}
 
-	if (force_firmware[hdsp->dev] || (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
+	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 
 		snd_printk ("loading firmware\n");
 
@@ -2877,12 +2950,12 @@
 		hdsp_write (hdsp, HDSP_fifoData, 0);
 
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT)) {
-			hdsp->type = Multiface;
+			hdsp->io_type = Multiface;
 			hdsp_write (hdsp, HDSP_jtagReg, HDSP_VERSION_BIT);
 			hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
 			hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT);
 		} else {
-			hdsp->type = Digiface;
+			hdsp->io_type = Digiface;
 		} 
 
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_PROGRAM);
@@ -2895,10 +2968,26 @@
 		
 		hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_LOAD);
 		
-		if (hdsp->type == Digiface) {
-			firmware_ptr = (u32 *) digiface_firmware;
+		if (hdsp->io_type == Digiface) {
+			switch (hdsp->firmware_rev) {
+			case 0xa:
+			case 0x64:
+				firmware_ptr = (u32 *) digiface_firmware;
+				break;
+			default:
+				firmware_ptr = (u32 *) digiface_firmware_rev11;
+				break;
+			}
+
 		} else {
-			firmware_ptr = (u32 *) multiface_firmware;
+			switch (hdsp->firmware_rev) {
+			case 0xa:
+			case 0x64:
+				firmware_ptr = (u32 *) multiface_firmware;
+			default:
+				firmware_ptr = (u32 *) multiface_firmware_rev11;
+				break;
+			}
 		}
 		
 		for (i = 0; i < 24413; ++i) {
@@ -2925,20 +3014,18 @@
 		*/
 
 		if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1) {
-			hdsp->type = Multiface;
+			hdsp->io_type = Multiface;
 		} else {
-			hdsp->type = Digiface;
+			hdsp->io_type = Digiface;
 		}
 	}
 
-	if (hdsp->type == Digiface) {
-		snd_printk ("I/O Box is a Digiface\n");
-		hdsp->card_name = "RME Hammerfall DSP (Digiface)";
+	if (hdsp->io_type == Digiface) {
+		strcat (hdsp->card_name, " + Digiface");
 		hdsp->ss_channels = DIGIFACE_SS_CHANNELS;
 		hdsp->ds_channels = DIGIFACE_DS_CHANNELS;
 	} else {
-		snd_printk ("I/O Box is a Multiface\n");
-		hdsp->card_name = "RME Hammerfall DSP (Multiface)";
+		strcat (hdsp->card_name, " + Multiface");
 		hdsp->ss_channels = MULTIFACE_SS_CHANNELS;
 		hdsp->ds_channels = MULTIFACE_DS_CHANNELS;
 	}
@@ -2959,7 +3046,6 @@
 {
 	struct pci_dev *pci = hdsp->pci;
 	int err;
-	unsigned short rev;
 
 	hdsp->irq = -1;
 	hdsp->midi[0].rmidi = 0;
@@ -2977,18 +3063,19 @@
 	
 	spin_lock_init(&hdsp->lock);
 
-	pci_read_config_word(hdsp->pci, PCI_CLASS_REVISION, &rev);
+	pci_read_config_word(hdsp->pci, PCI_CLASS_REVISION, &hdsp->firmware_rev);
 	strcpy(card->driver, "H-DSP");
 	strcpy(card->mixername, "Xilinx FPGA");
 	
-	switch (rev & 0xff) {
+	switch (hdsp->firmware_rev & 0xff) {
 	case 0xa:
 	case 0xb:
-	case 0x64:
-		/* hdsp_initialize_firmware() will reset this */
 		hdsp->card_name = "RME Hammerfall DSP";
 		break;
-
+	case 0x64:
+	case 0x68:
+		hdsp->card_name = "RME HDSP 9652";
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -3136,10 +3223,10 @@
 }
 
 static struct pci_driver driver = {
-	.name	  = "RME Hammerfall DSP",
+	.name =     "RME Hammerfall DSP",
 	.id_table = snd_hdsp_ids,
-	.probe	  = snd_hdsp_probe,
-	.remove	  = __devexit_p(snd_hdsp_remove),
+	.probe =    snd_hdsp_probe,
+	.remove = __devexit_p(snd_hdsp_remove),
 };
 
 static int __init alsa_card_hdsp_init(void)


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
