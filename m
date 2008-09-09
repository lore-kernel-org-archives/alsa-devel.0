From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 04/24] sound/pci: coding style fixes: ca0106
Date: Tue, 9 Sep 2008 05:47:50 +0400
Message-ID: <20080909014750.GH6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 703DD10380F
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:47:57 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1534697fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:47:57 -0700 (PDT)
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

 sound/pci/ca0106/ca0106.h       |   32 +++---
 sound/pci/ca0106/ca0106_main.c  |  262 +++++++++++++++++++-------------------
 sound/pci/ca0106/ca0106_mixer.c |   22 ++--
 sound/pci/ca0106/ca0106_proc.c  |   66 +++++-----
 sound/pci/ca0106/ca_midi.c      |   14 +-
 sound/pci/ca0106/ca_midi.h      |    6 +-
 6 files changed, 201 insertions(+), 201 deletions(-)

diff --git a/sound/pci/ca0106/ca0106.h b/sound/pci/ca0106/ca0106.h
index 74175fc..645980f 100644
--- a/sound/pci/ca0106/ca0106.h
+++ b/sound/pci/ca0106/ca0106.h
@@ -5,7 +5,7 @@
  *
  *  FEATURES currently supported:
  *    See ca0106_main.c for features.
- * 
+ *
  *  Changelog:
  *    Support interrupts per period.
  *    Removed noise from Center/LFE channel when in Analog mode.
@@ -174,10 +174,10 @@
 /********************************************************************************************************/
 /* CA0106 pointer-offset register set, accessed through the PTR and DATA registers                     */
 /********************************************************************************************************/
-                                                                                                                           
+
 /* Initally all registers from 0x00 to 0x3f have zero contents. */
 #define PLAYBACK_LIST_ADDR	0x00		/* Base DMA address of a list of pointers to each period/size */
-						/* One list entry: 4 bytes for DMA address, 
+						/* One list entry: 4 bytes for DMA address,
 						 * 4 bytes for period_size << 16.
 						 * One list entry is 8 bytes long.
 						 * One list entry for each period in the buffer.
@@ -219,7 +219,7 @@
 						 * Playback mixer in enable [27:24] (one bit per channel)
 						 * Playback mixer out enable [31:28] (one bit per channel)
 						 */
-/* The Digital out jack is shared with the Center/LFE Analogue output. 
+/* The Digital out jack is shared with the Center/LFE Analogue output.
  * The jack has 4 poles. I will call 1 - Tip, 2 - Next to 1, 3 - Next to 2, 4 - Next to 3
  * For Analogue: 1 -> Center Speaker, 2 -> Sub Woofer, 3 -> Ground, 4 -> Ground
  * For Digital: 1 -> Front SPDIF, 2 -> Rear SPDIF, 3 -> Center/Subwoofer SPDIF, 4 -> Ground.
@@ -232,7 +232,7 @@
  * Summary: For ALSA we use the Rear channel for SPDIF Digital AC3/DTS output
  */
 /* A standard 2 pole mono mini-jack to RCA plug can be used for SPDIF Stereo PCM output from the Front channel.
- * A standard 3 pole stereo mini-jack to 2 RCA plugs can be used for SPDIF AC3/DTS and Stereo PCM output utilising the Rear channel and just one of the RCA plugs. 
+ * A standard 3 pole stereo mini-jack to 2 RCA plugs can be used for SPDIF AC3/DTS and Stereo PCM output utilising the Rear channel and just one of the RCA plugs.
  */
 #define SPCS0			0x41		/* SPDIF output Channel Status 0 register. For Rear. default=0x02108004, non-audio=0x02108006	*/
 #define SPCS1			0x42		/* SPDIF output Channel Status 1 register. For Front */
@@ -331,7 +331,7 @@
 #define CAPTURE_SOURCE_CHANNEL2 0x00f00000      /* 1 - What you hear or . 2 - ?? */
 #define CAPTURE_SOURCE_CHANNEL3 0x000f0000	/* 3 - Mic in, Line in, TAD in, Aux in. */
 #define CAPTURE_SOURCE_RECORD_MAP 0x0000ffff	/* Default 0x00e4 */
-						/* Record Map [7:0] (2 bits per channel) 0=mapped to channel 0, 1=mapped to channel 1, 2=mapped to channel2, 3=mapped to channel3 
+						/* Record Map [7:0] (2 bits per channel) 0=mapped to channel 0, 1=mapped to channel 1, 2=mapped to channel2, 3=mapped to channel3
 						 * Record source select for channel 0 [18:16]
 						 * Record source select for channel 1 [22:20]
 						 * Record source select for channel 2 [26:24]
@@ -432,7 +432,7 @@
 						 * Sample input rate [3:2] (0=48kHz, 1=Not available, 2=96kHz, 3=192Khz)
 						 * SRC input source select [4] 0=Audio from digital mixer, 1=Audio from analog source.
 						 * Record rate [9:8] (0=48kHz, 1=Not available, 2=96kHz, 3=192Khz)
-						 * Record mixer output enable [12:10] 
+						 * Record mixer output enable [12:10]
 						 * I2S input rate master mode [15:14] (0=48kHz, 1=44.1kHz, 2=96kHz, 3=192Khz)
 						 * I2S output rate [17:16] (0=48kHz, 1=44.1kHz, 2=96kHz, 3=192Khz)
 						 * I2S output source select [18] (0=Audio from host, 1=Audio from SRC)
@@ -445,7 +445,7 @@
 						 * Not used [27]
 						 * Record Source 0 input [29:28] (0=SPDIF in, 1=I2S in, 2=AC97 Mic, 3=AC97 PCM)
 						 * Record Source 1 input [31:30] (0=SPDIF in, 1=I2S in, 2=AC97 Mic, 3=AC97 PCM)
-						 */ 
+						 */
 						/* Sample rate output control register Channel=1
 						 * I2S Input 0 volume Right [7:0]
 						 * I2S Input 0 volume Left [15:8]
@@ -467,7 +467,7 @@
 						 * AC97 output enable [5:0]
 						 * I2S output enable [19:16]
 						 * SPDIF output enable [27:24]
-						 */ 
+						 */
 #define UNKNOWN73               0x73            /* Unknown. Readonly. Default 0x0 */
 #define CHIP_VERSION            0x74            /* P17 Chip version. Channel_id 0 only. Default 00000071 */
 #define EXTENDED_INT_MASK       0x75            /* Used by both playback and capture interrupt handler */
@@ -502,14 +502,14 @@
 #define I2C_A_ADC_LAST_MASK	0x00000040	//Bit mask for Last word transaction
 #define I2C_A_ADC_BYTE_MASK	0x00000080	//Bit mask for Byte Mode
 
-#define I2C_A_ADC_ADD		0x00000034	//This is the Device address for ADC 
+#define I2C_A_ADC_ADD		0x00000034	//This is the Device address for ADC
 #define I2C_A_ADC_READ		0x00000001	//To perform a read operation
 #define I2C_A_ADC_START		0x00000100	//Start I2C transaction
 #define I2C_A_ADC_ABORT		0x00000200	//I2C transaction abort
 #define I2C_A_ADC_LAST		0x00000400	//I2C last transaction
 #define I2C_A_ADC_BYTE		0x00000800	//I2C one byte mode
 
-#define I2C_D_ADC_REG_MASK	0xfe000000  	//ADC address register 
+#define I2C_D_ADC_REG_MASK	0xfe000000  	//ADC address register
 #define I2C_D_ADC_DAT_MASK	0x01ff0000  	//ADC data register
 
 #define ADC_TIMEOUT		0x00000007	//ADC Timeout Clock Disable
@@ -708,13 +708,13 @@ struct snd_ca0106 {
 int snd_ca0106_mixer(struct snd_ca0106 *emu);
 int snd_ca0106_proc_init(struct snd_ca0106 * emu);
 
-unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu, 
-				 unsigned int reg, 
+unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu,
+				 unsigned int reg,
 				 unsigned int chn);
 
-void snd_ca0106_ptr_write(struct snd_ca0106 *emu, 
-			  unsigned int reg, 
-			  unsigned int chn, 
+void snd_ca0106_ptr_write(struct snd_ca0106 *emu,
+			  unsigned int reg,
+			  unsigned int chn,
 			  unsigned int data);
 
 int snd_ca0106_i2c_write(struct snd_ca0106 *emu, u32 reg, u32 value);
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 6abe8a3..6d4534a 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -18,7 +18,7 @@
  *      So, to record from the MIC, set the MIC Playback volume to max,
  *      unmute the MIC and turn up the MASTER Playback volume.
  *      So, to prevent feedback when capturing, minimise the "Capture feedback into Playback" volume.
- *   
+ *
  *    The only playback controls that currently do anything are: -
  *    Analog Front
  *    Analog Rear
@@ -26,12 +26,12 @@
  *    SPDIF Front
  *    SPDIF Rear
  *    SPDIF Center/LFE
- *   
+ *
  *    For capture from Mic in or Line in.
  *    Digital/Analog ( switch must be in Analog mode for CAPTURE. )
- * 
+ *
  *    CAPTURE feedback into PLAYBACK
- * 
+ *
  *  Changelog:
  *    Support interrupts per period.
  *    Removed noise from Center/LFE channel when in Analog mode.
@@ -108,7 +108,7 @@
  *    DAC: CS4382 (114 dB, 24-Bit, 192 kHz, 8-Channel D/A Converter with DSD Support)
  *    SPDIF Out control switches between Mic in and SPDIF out.
  *    No sound out or mic input working yet.
- * 
+ *
  *  GENERAL INFO:
  *    Model: SB0413
  *    P17 Chip: CA0106-DAT
@@ -202,7 +202,7 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 	 /* AudigyLS[SB0310] */
 	 { .serial = 0x10021102,
 	   .name   = "AudigyLS [SB0310]",
-	   .ac97   = 1 } , 
+	   .ac97   = 1 } ,
 	 /* Unknown AudigyLS that also says SB0310 on it */
 	 { .serial = 0x10051102,
 	   .name   = "AudigyLS [SB0310b]",
@@ -279,7 +279,7 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 
 /* hardware definition */
 static struct snd_pcm_hardware snd_ca0106_playback_hw = {
-	.info =			SNDRV_PCM_INFO_MMAP | 
+	.info =			SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				SNDRV_PCM_INFO_MMAP_VALID |
@@ -289,8 +289,8 @@ static struct snd_pcm_hardware snd_ca0106_playback_hw = {
 				 SNDRV_PCM_RATE_192000),
 	.rate_min =		48000,
 	.rate_max =		192000,
-	.channels_min =		2,  //1,
-	.channels_max =		2,  //6,
+	.channels_min =		2,  /* 1, */
+	.channels_max =		2,  /* 6, */
 	.buffer_bytes_max =	((65536 - 64) * 8),
 	.period_bytes_min =	64,
 	.period_bytes_max =	(65536 - 64),
@@ -300,7 +300,7 @@ static struct snd_pcm_hardware snd_ca0106_playback_hw = {
 };
 
 static struct snd_pcm_hardware snd_ca0106_capture_hw = {
-	.info =			(SNDRV_PCM_INFO_MMAP | 
+	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
@@ -319,13 +319,13 @@ static struct snd_pcm_hardware snd_ca0106_capture_hw = {
 	.fifo_size =		0,
 };
 
-unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu, 
-					  unsigned int reg, 
+unsigned int snd_ca0106_ptr_read(struct snd_ca0106 *emu,
+					  unsigned int reg,
 					  unsigned int chn)
 {
 	unsigned long flags;
 	unsigned int regptr, val;
-  
+
 	regptr = (reg << 16) | chn;
 
 	spin_lock_irqsave(&emu->emu_lock, flags);
@@ -335,9 +335,9 @@ unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu,
 	return val;
 }
 
-void snd_ca0106_ptr_write(struct snd_ca0106 *emu, 
-				   unsigned int reg, 
-				   unsigned int chn, 
+void snd_ca0106_ptr_write(struct snd_ca0106 *emu,
+				   unsigned int reg,
+				   unsigned int chn,
 				   unsigned int data)
 {
 	unsigned int regptr;
@@ -351,7 +351,7 @@ void snd_ca0106_ptr_write(struct snd_ca0106 *emu,
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
-int snd_ca0106_spi_write(struct snd_ca0106 * emu,
+int snd_ca0106_spi_write(struct snd_ca0106 *emu,
 				   unsigned int data)
 {
 	unsigned int reset, set;
@@ -398,7 +398,7 @@ int snd_ca0106_i2c_write(struct snd_ca0106 *emu,
 	}
 
 	tmp = reg << 25 | value << 16;
-	// snd_printk("I2C-write:reg=0x%x, value=0x%x\n", reg, value);
+	/* snd_printk("I2C-write:reg=0x%x, value=0x%x\n", reg, value); */
 	/* Not sure what this I2C channel controls. */
 	/* snd_ca0106_ptr_write(emu, I2C_D0, 0, tmp); */
 
@@ -407,8 +407,8 @@ int snd_ca0106_i2c_write(struct snd_ca0106 *emu,
 
 	for (retry = 0; retry < 10; retry++) {
 		/* Send the data to i2c */
-		//tmp = snd_ca0106_ptr_read(emu, I2C_A, 0);
-		//tmp = tmp & ~(I2C_A_ADC_READ|I2C_A_ADC_LAST|I2C_A_ADC_START|I2C_A_ADC_ADD_MASK);
+		/* tmp = snd_ca0106_ptr_read(emu, I2C_A, 0); */
+		/* tmp = tmp & ~(I2C_A_ADC_READ|I2C_A_ADC_LAST|I2C_A_ADC_START|I2C_A_ADC_ADD_MASK); */
 		tmp = 0;
 		tmp = tmp | (I2C_A_ADC_LAST|I2C_A_ADC_START|I2C_A_ADC_ADD);
 		snd_ca0106_ptr_write(emu, I2C_A, 0, tmp);
@@ -416,7 +416,7 @@ int snd_ca0106_i2c_write(struct snd_ca0106 *emu,
 		/* Wait till the transaction ends */
 		while (1) {
 			status = snd_ca0106_ptr_read(emu, I2C_A, 0);
-                	//snd_printk("I2C:status=0x%x\n", status);
+                	/* snd_printk("I2C:status=0x%x\n", status); */
 			timeout++;
 			if ((status & I2C_A_ADC_START) == 0)
 				break;
@@ -424,7 +424,7 @@ int snd_ca0106_i2c_write(struct snd_ca0106 *emu,
 			if (timeout > 1000)
 				break;
 		}
-		//Read back and see if the transaction is successful
+		/* Read back and see if the transaction is successful */
 		if ((status & I2C_A_ADC_ABORT) == 0)
 			break;
 	}
@@ -433,7 +433,7 @@ int snd_ca0106_i2c_write(struct snd_ca0106 *emu,
 		snd_printk(KERN_ERR "Writing to ADC failed!\n");
 		return -EINVAL;
 	}
-    
+
     	return 0;
 }
 
@@ -496,18 +496,18 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
 	epcm->emu = chip;
 	epcm->substream = substream;
         epcm->channel_id=channel_id;
-  
+
 	runtime->private_data = epcm;
 	runtime->private_free = snd_ca0106_pcm_free_substream;
-  
+
 	runtime->hw = snd_ca0106_playback_hw;
 
         channel->emu = chip;
         channel->number = channel_id;
 
 	channel->use = 1;
-        //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
-        //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
+        /* printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel); */
+        /* channel->interrupt = snd_ca0106_pcm_channel_interrupt; */
 	channel->epcm = epcm;
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                 return err;
@@ -584,22 +584,22 @@ static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substre
 	epcm->emu = chip;
 	epcm->substream = substream;
         epcm->channel_id=channel_id;
-  
+
 	runtime->private_data = epcm;
 	runtime->private_free = snd_ca0106_pcm_free_substream;
-  
+
 	runtime->hw = snd_ca0106_capture_hw;
 
         channel->emu = chip;
         channel->number = channel_id;
 
 	channel->use = 1;
-        //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
-        //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
+        /* printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel); */
+        /* channel->interrupt = snd_ca0106_pcm_channel_interrupt; */
         channel->epcm = epcm;
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                 return err;
-	//snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
+	/* snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes); */
 	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
                 return err;
 	return 0;
@@ -680,37 +680,37 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 	u32 reg40_set = 0;
 	u32 reg40;
 	/* FIXME: Depending on mixer selection of SPDIF out or not, select the spdif rate or the DAC rate. */
-	u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
+	u32 reg71_mask = 0x03030000; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
 	u32 reg71_set = 0;
 	u32 reg71;
 	int i;
-	
-        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
-        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
-	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
+
+        /* snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1)); */
+        /* snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base); */
+	/* snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes); */
 	/* Rate can be set per channel. */
 	/* reg40 control host to fifo */
 	/* reg71 controls DAC rate. */
 	switch (runtime->rate) {
 	case 44100:
 		reg40_set = 0x10000 << (channel<<1);
-		reg71_set = 0x01010000; 
+		reg71_set = 0x01010000;
 		break;
         case 48000:
 		reg40_set = 0;
-		reg71_set = 0; 
+		reg71_set = 0;
 		break;
 	case 96000:
 		reg40_set = 0x20000 << (channel<<1);
-		reg71_set = 0x02020000; 
+		reg71_set = 0x02020000;
 		break;
 	case 192000:
 		reg40_set = 0x30000 << (channel<<1);
-		reg71_set = 0x03030000; 
+		reg71_set = 0x03030000;
 		break;
 	default:
 		reg40_set = 0;
-		reg71_set = 0; 
+		reg71_set = 0;
 		break;
 	}
 	/* Format is a global setting */
@@ -726,7 +726,7 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 		hcfg_set = 0;
 		break;
 	}
-	hcfg = inl(emu->port + HCFG) ;
+	hcfg = inl(emu->port + HCFG);
 	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
 	outl(hcfg, emu->port + HCFG);
 	reg40 = snd_ca0106_ptr_read(emu, 0x40, 0);
@@ -737,18 +737,18 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 	snd_ca0106_ptr_write(emu, 0x71, 0, reg71);
 
 	/* FIXME: Check emu->buffer.size before actually writing to it. */
-        for(i=0; i < runtime->periods; i++) {
+        for (i = 0; i < runtime->periods; i++) {
 		table_base[i*2] = runtime->dma_addr + (i * period_size_bytes);
 		table_base[i*2+1] = period_size_bytes << 16;
 	}
- 
+
 	snd_ca0106_ptr_write(emu, PLAYBACK_LIST_ADDR, channel, emu->buffer.addr+(8*16*channel));
 	snd_ca0106_ptr_write(emu, PLAYBACK_LIST_SIZE, channel, (runtime->periods - 1) << 19);
 	snd_ca0106_ptr_write(emu, PLAYBACK_LIST_PTR, channel, 0);
 	snd_ca0106_ptr_write(emu, PLAYBACK_DMA_ADDR, channel, runtime->dma_addr);
-	snd_ca0106_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, frames_to_bytes(runtime, runtime->period_size)<<16); // buffer size in bytes
+	snd_ca0106_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, frames_to_bytes(runtime, runtime->period_size)<<16); /* buffer size in bytes */
 	/* FIXME  test what 0 bytes does. */
-	snd_ca0106_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, 0); // buffer size in bytes
+	snd_ca0106_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, 0); /* buffer size in bytes */
 	snd_ca0106_ptr_write(emu, PLAYBACK_POINTER, channel, 0);
 	snd_ca0106_ptr_write(emu, 0x07, channel, 0x0);
 	snd_ca0106_ptr_write(emu, 0x08, channel, 0);
@@ -758,7 +758,7 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
 			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
 			       SPCS_GENERATIONSTATUS | 0x00001200 |
-			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT );
+			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 	}
 #endif
 
@@ -776,31 +776,31 @@ static int snd_ca0106_pcm_prepare_capture(struct snd_pcm_substream *substream)
 	u32 hcfg_set = 0x00000000;
 	u32 hcfg;
 	u32 over_sampling=0x2;
-	u32 reg71_mask = 0x0000c000 ; /* Global. Set ADC rate. */
+	u32 reg71_mask = 0x0000c000; /* Global. Set ADC rate. */
 	u32 reg71_set = 0;
 	u32 reg71;
-	
-        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
-        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
-	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
+
+        /* snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1)); */
+        /* snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base); */
+	/* snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes); */
 	/* reg71 controls ADC rate. */
 	switch (runtime->rate) {
 	case 44100:
 		reg71_set = 0x00004000;
 		break;
         case 48000:
-		reg71_set = 0; 
+		reg71_set = 0;
 		break;
 	case 96000:
 		reg71_set = 0x00008000;
 		over_sampling=0xa;
 		break;
 	case 192000:
-		reg71_set = 0x0000c000; 
+		reg71_set = 0x0000c000;
 		over_sampling=0xa;
 		break;
 	default:
-		reg71_set = 0; 
+		reg71_set = 0;
 		break;
 	}
 	/* Format is a global setting */
@@ -816,7 +816,7 @@ static int snd_ca0106_pcm_prepare_capture(struct snd_pcm_substream *substream)
 		hcfg_set = 0;
 		break;
 	}
-	hcfg = inl(emu->port + HCFG) ;
+	hcfg = inl(emu->port + HCFG);
 	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
 	outl(hcfg, emu->port + HCFG);
 	reg71 = snd_ca0106_ptr_read(emu, 0x71, 0);
@@ -827,10 +827,10 @@ static int snd_ca0106_pcm_prepare_capture(struct snd_pcm_substream *substream)
 	}
 
 
-        //printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
+        /* printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1)); */
 	snd_ca0106_ptr_write(emu, 0x13, channel, 0);
 	snd_ca0106_ptr_write(emu, CAPTURE_DMA_ADDR, channel, runtime->dma_addr);
-	snd_ca0106_ptr_write(emu, CAPTURE_BUFFER_SIZE, channel, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
+	snd_ca0106_ptr_write(emu, CAPTURE_BUFFER_SIZE, channel, frames_to_bytes(runtime, runtime->buffer_size)<<16); /* buffer size in bytes */
 	snd_ca0106_ptr_write(emu, CAPTURE_POINTER, channel, 0);
 
 	return 0;
@@ -866,13 +866,13 @@ static int snd_ca0106_pcm_trigger_playback(struct snd_pcm_substream *substream,
 		runtime = s->runtime;
 		epcm = runtime->private_data;
 		channel = epcm->channel_id;
-		//snd_printk("channel=%d\n",channel);
+		/* snd_printk("channel=%d\n",channel); */
 		epcm->running = running;
 		basic |= (0x1<<channel);
 		extended |= (0x10<<channel);
                 snd_pcm_trigger_done(s, substream);
         }
-	//snd_printk("basic=0x%x, extended=0x%x\n",basic, extended);
+	/* snd_printk("basic=0x%x, extended=0x%x\n",basic, extended); */
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -940,7 +940,7 @@ snd_ca0106_pcm_pointer_playback(struct snd_pcm_substream *substream)
 	ptr=ptr2;
         if (ptr >= runtime->buffer_size)
 		ptr -= runtime->buffer_size;
-	//printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);
+	/* printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate); */
 
 	return ptr;
 }
@@ -963,7 +963,7 @@ snd_ca0106_pcm_pointer_capture(struct snd_pcm_substream *substream)
 	ptr=ptr2;
         if (ptr >= runtime->buffer_size)
 		ptr -= runtime->buffer_size;
-	//printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);
+	/* printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate); */
 
 	return ptr;
 }
@@ -1030,9 +1030,9 @@ static struct snd_pcm_ops snd_ca0106_playback_center_lfe_ops = {
         .ioctl =        snd_pcm_lib_ioctl,
         .hw_params =    snd_ca0106_pcm_hw_params_playback,
         .hw_free =      snd_ca0106_pcm_hw_free_playback,
-        .prepare =      snd_ca0106_pcm_prepare_playback,     
-        .trigger =      snd_ca0106_pcm_trigger_playback,  
-        .pointer =      snd_ca0106_pcm_pointer_playback, 
+        .prepare =      snd_ca0106_pcm_prepare_playback,
+        .trigger =      snd_ca0106_pcm_trigger_playback,
+        .pointer =      snd_ca0106_pcm_pointer_playback,
 };
 
 static struct snd_pcm_ops snd_ca0106_playback_unknown_ops = {
@@ -1041,9 +1041,9 @@ static struct snd_pcm_ops snd_ca0106_playback_unknown_ops = {
         .ioctl =        snd_pcm_lib_ioctl,
         .hw_params =    snd_ca0106_pcm_hw_params_playback,
         .hw_free =      snd_ca0106_pcm_hw_free_playback,
-        .prepare =      snd_ca0106_pcm_prepare_playback,     
-        .trigger =      snd_ca0106_pcm_trigger_playback,  
-        .pointer =      snd_ca0106_pcm_pointer_playback, 
+        .prepare =      snd_ca0106_pcm_prepare_playback,
+        .trigger =      snd_ca0106_pcm_trigger_playback,
+        .pointer =      snd_ca0106_pcm_pointer_playback,
 };
 
 static struct snd_pcm_ops snd_ca0106_playback_rear_ops = {
@@ -1052,9 +1052,9 @@ static struct snd_pcm_ops snd_ca0106_playback_rear_ops = {
         .ioctl =        snd_pcm_lib_ioctl,
         .hw_params =    snd_ca0106_pcm_hw_params_playback,
 		.hw_free =      snd_ca0106_pcm_hw_free_playback,
-        .prepare =      snd_ca0106_pcm_prepare_playback,     
-        .trigger =      snd_ca0106_pcm_trigger_playback,  
-        .pointer =      snd_ca0106_pcm_pointer_playback, 
+        .prepare =      snd_ca0106_pcm_prepare_playback,
+        .trigger =      snd_ca0106_pcm_trigger_playback,
+        .pointer =      snd_ca0106_pcm_pointer_playback,
 };
 
 
@@ -1077,7 +1077,7 @@ static void snd_ca0106_ac97_write(struct snd_ac97 *ac97,
 {
 	struct snd_ca0106 *emu = ac97->private_data;
 	unsigned long flags;
-  
+
 	spin_lock_irqsave(&emu->emu_lock, flags);
 	outb(reg, emu->port + AC97ADDRESS);
 	outw(val, emu->port + AC97DATA);
@@ -1093,7 +1093,7 @@ static int snd_ca0106_ac97(struct snd_ca0106 *chip)
 		.write = snd_ca0106_ac97_write,
 		.read = snd_ca0106_ac97_read,
 	};
-  
+
 	if ((err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus)) < 0)
 		return err;
 	pbus->no_vra = 1; /* we don't need VRA */
@@ -1107,13 +1107,13 @@ static int snd_ca0106_ac97(struct snd_ca0106 *chip)
 static int snd_ca0106_free(struct snd_ca0106 *chip)
 {
 	if (chip->res_port != NULL) {    /* avoid access to already used hardware */
-		// disable interrupts
+		/* disable interrupts */
 		snd_ca0106_ptr_write(chip, BASIC_INTERRUPT, 0, 0);
 		outl(0, chip->port + INTE);
 		snd_ca0106_ptr_write(chip, EXTENDED_INT_MASK, 0, 0);
 		udelay(1000);
-		// disable audio
-		//outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
+		/* disable audio */
+		/* outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG); */
 		outl(0, chip->port + HCFG);
 		/* FIXME: We need to stop and DMA transfers here.
 		 *        But as I am not sure how yet, we cannot from the dma pages.
@@ -1122,13 +1122,13 @@ static int snd_ca0106_free(struct snd_ca0106 *chip)
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
-	// release the data
+	/* release the data */
 #if 1
 	if (chip->buffer.area)
 		snd_dma_free_pages(&chip->buffer);
 #endif
 
-	// release the i/o port
+	/* release the i/o port */
 	release_and_free_resource(chip->res_port);
 
 	pci_disable_device(chip->pci);
@@ -1153,38 +1153,38 @@ static irqreturn_t snd_ca0106_interrupt(int irq, void *dev_id)
 	struct snd_ca0106_channel *pchannel;
 
 	status = inl(chip->port + IPR);
-	if (! status)
+	if (!status)
 		return IRQ_NONE;
 
         stat76 = snd_ca0106_ptr_read(chip, EXTENDED_INT, 0);
-	//snd_printk("interrupt status = 0x%08x, stat76=0x%08x\n", status, stat76);
-	//snd_printk("ptr=0x%08x\n",snd_ca0106_ptr_read(chip, PLAYBACK_POINTER, 0));
+	/* snd_printk("interrupt status = 0x%08x, stat76=0x%08x\n", status, stat76); */
+	/* snd_printk("ptr=0x%08x\n",snd_ca0106_ptr_read(chip, PLAYBACK_POINTER, 0)); */
         mask = 0x11; /* 0x1 for one half, 0x10 for the other half period. */
-	for(i = 0; i < 4; i++) {
+	for (i = 0; i < 4; i++) {
 		pchannel = &(chip->playback_channels[i]);
 		if (stat76 & mask) {
 /* FIXME: Select the correct substream for period elapsed */
-			if(pchannel->use) {
+			if (pchannel->use) {
 				snd_pcm_period_elapsed(pchannel->epcm->substream);
-				//printk(KERN_INFO "interrupt [%d] used\n", i);
+				/* printk(KERN_INFO "interrupt [%d] used\n", i); */
                         }
 		}
-	        //printk(KERN_INFO "channel=%p\n",pchannel);
-	        //printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number);
+	        /* printk(KERN_INFO "channel=%p\n",pchannel); */
+	        /* printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number); */
 		mask <<= 1;
 	}
         mask = 0x110000; /* 0x1 for one half, 0x10 for the other half period. */
-	for(i = 0; i < 4; i++) {
+	for (i = 0; i < 4; i++) {
 		pchannel = &(chip->capture_channels[i]);
 		if (stat76 & mask) {
 /* FIXME: Select the correct substream for period elapsed */
-			if(pchannel->use) {
+			if (pchannel->use) {
 				snd_pcm_period_elapsed(pchannel->epcm->substream);
-				//printk(KERN_INFO "interrupt [%d] used\n", i);
+				/* printk(KERN_INFO "interrupt [%d] used\n", i); */
                         }
 		}
-	        //printk(KERN_INFO "channel=%p\n",pchannel);
-	        //printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number);
+	        /* printk(KERN_INFO "channel=%p\n",pchannel); */
+	        /* printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number); */
 		mask <<= 1;
 	}
 
@@ -1198,7 +1198,7 @@ static irqreturn_t snd_ca0106_interrupt(int irq, void *dev_id)
 			chip->midi.interrupt_disable(&chip->midi, chip->midi.tx_enable | chip->midi.rx_enable);
 	}
 
-	// acknowledge the interrupt if necessary
+	/* acknowledge the interrupt if necessary */
 	outl(status, chip->port+IPR);
 
 	return IRQ_HANDLED;
@@ -1209,12 +1209,12 @@ static int __devinit snd_ca0106_pcm(struct snd_ca0106 *emu, int device, struct s
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *substream;
 	int err;
-  
+
 	if (rpcm)
 		*rpcm = NULL;
 	if ((err = snd_pcm_new(emu->card, "ca0106", device, 1, 1, &pcm)) < 0)
 		return err;
-  
+
 	pcm->private_data = emu;
 
 	switch (device) {
@@ -1241,29 +1241,29 @@ static int __devinit snd_ca0106_pcm(struct snd_ca0106 *emu, int device, struct s
 	strcpy(pcm->name, "CA0106");
 	emu->pcm = pcm;
 
-	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
-	    substream; 
+	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	    substream;
 	    substream = substream->next) {
-		if ((err = snd_pcm_lib_preallocate_pages(substream, 
-							 SNDRV_DMA_TYPE_DEV, 
-							 snd_dma_pci_data(emu->pci), 
+		if ((err = snd_pcm_lib_preallocate_pages(substream,
+							 SNDRV_DMA_TYPE_DEV,
+							 snd_dma_pci_data(emu->pci),
 							 64*1024, 64*1024)) < 0) /* FIXME: 32*1024 for sound buffer, between 32and64 for Periods table. */
 			return err;
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
 	                                           64*1024, 64*1024)) < 0)
 			return err;
 	}
-  
+
 	if (rpcm)
 		*rpcm = pcm;
-  
+
 	return 0;
 }
 
@@ -1313,9 +1313,9 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	static struct snd_device_ops ops = {
 		.dev_free = snd_ca0106_dev_free,
 	};
-  
+
 	*rchip = NULL;
-  
+
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0 ||
@@ -1324,22 +1324,22 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
-  
+
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
-  
+
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
 
 	spin_lock_init(&chip->emu_lock);
-  
+
 	chip->port = pci_resource_start(pci, 0);
 	if ((chip->res_port = request_region(chip->port, 0x20,
-					     "snd_ca0106")) == NULL) { 
+					     "snd_ca0106")) == NULL) {
 		snd_ca0106_free(chip);
 		printk(KERN_ERR "cannot allocate the port\n");
 		return -EBUSY;
@@ -1352,9 +1352,9 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-  
- 	/* This stores the periods table. */ 
-	if(snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci), 1024, &chip->buffer) < 0) {
+
+ 	/* This stores the periods table. */
+	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci), 1024, &chip->buffer) < 0) {
 		snd_ca0106_free(chip);
 		return -ENOMEM;
 	}
@@ -1441,13 +1441,13 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	snd_ca0106_ptr_write(chip, 0x44, 0, 0x2108006);
 #endif
 
-	//snd_ca0106_ptr_write(chip, SPDIF_SELECT2, 0, 0xf0f003f); /* OSS drivers set this. */
+	/* snd_ca0106_ptr_write(chip, SPDIF_SELECT2, 0, 0xf0f003f); OSS drivers set this. */
 	/* Analog or Digital output */
 	snd_ca0106_ptr_write(chip, SPDIF_SELECT1, 0, 0xf);
 	snd_ca0106_ptr_write(chip, SPDIF_SELECT2, 0, 0x000f0000); /* 0x0b000000 for digital, 0x000b0000 for analog, from win2000 drivers. Use 0x000f0000 for surround71 */
 	chip->spdif_enable = 0; /* Set digital SPDIF output off */
-	//snd_ca0106_ptr_write(chip, 0x45, 0, 0); /* Analogue out */
-	//snd_ca0106_ptr_write(chip, 0x45, 0, 0xf00); /* Digital out */
+	/* snd_ca0106_ptr_write(chip, 0x45, 0, 0); Analogue out */
+	/* snd_ca0106_ptr_write(chip, 0x45, 0, 0xf00); Digital out */
 
 	snd_ca0106_ptr_write(chip, CAPTURE_CONTROL, 0, 0x40c81000); /* goes to 0x40c80000 when doing SPDIF IN/OUT */
 	snd_ca0106_ptr_write(chip, CAPTURE_CONTROL, 1, 0xffffffff); /* (Mute) CAPTURE feedback into PLAYBACK volume. Only lower 16 bits matter. */
@@ -1457,11 +1457,11 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	snd_ca0106_ptr_write(chip, PLAYBACK_ROUTING2, 0, 0x76767676);
 	snd_ca0106_ptr_write(chip, CAPTURE_ROUTING1, 0, 0x32765410);
 	snd_ca0106_ptr_write(chip, CAPTURE_ROUTING2, 0, 0x76767676);
-	for(ch = 0; ch < 4; ch++) {
+	for (ch = 0; ch < 4; ch++) {
 		snd_ca0106_ptr_write(chip, CAPTURE_VOLUME1, ch, 0x30303030); /* Only high 16 bits matter */
 		snd_ca0106_ptr_write(chip, CAPTURE_VOLUME2, ch, 0x30303030);
-		//snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0x40404040); /* Mute */
-		//snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0x40404040); /* Mute */
+		/* snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0x40404040);  Mute */
+		/* snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0x40404040);  Mute */
 		snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0xffffffff); /* Mute */
 		snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0xffffffff); /* Mute */
 	}
@@ -1485,30 +1485,30 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
         if (chip->details->gpio_type == 2) { /* The SB0438 use GPIO differently. */
 		/* FIXME: Still need to find out what the other GPIO bits do. E.g. For digital spdif out. */
 		outl(0x0, chip->port+GPIO);
-		//outl(0x00f0e000, chip->port+GPIO); /* Analog */
+		/* outl(0x00f0e000, chip->port+GPIO);  Analog */
 		outl(0x005f5301, chip->port+GPIO); /* Analog */
 	} else if (chip->details->gpio_type == 1) { /* The SB0410 and SB0413 use GPIO differently. */
 		/* FIXME: Still need to find out what the other GPIO bits do. E.g. For digital spdif out. */
 		outl(0x0, chip->port+GPIO);
-		//outl(0x00f0e000, chip->port+GPIO); /* Analog */
+		/* outl(0x00f0e000, chip->port+GPIO);  Analog */
 		outl(0x005f5301, chip->port+GPIO); /* Analog */
 	} else {
 		outl(0x0, chip->port+GPIO);
 		outl(0x005f03a3, chip->port+GPIO); /* Analog */
-		//outl(0x005f02a2, chip->port+GPIO);   /* SPDIF */
+		/* outl(0x005f02a2, chip->port+GPIO);   SPDIF */
 	}
 	snd_ca0106_intr_enable(chip, 0x105); /* Win2000 uses 0x1e0 */
 
-	//outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
-	//outl(0x00001409, chip->port+HCFG); /* 0x1000 causes AC3 to fails. Maybe it effects 24 bit output. */
-	//outl(0x00000009, chip->port+HCFG);
+	/* outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG); */
+	/* outl(0x00001409, chip->port+HCFG);  0x1000 causes AC3 to fails. Maybe it effects 24 bit output. */
+	/* outl(0x00000009, chip->port+HCFG); */
 	outl(HCFG_AC97 | HCFG_AUDIOENABLE, chip->port+HCFG); /* AC97 2.0, Enable outputs. */
 
         if (chip->details->i2c_adc == 1) { /* The SB0410 and SB0413 use I2C to control ADC. */
 		int size, n;
 
 		size = ARRAY_SIZE(i2c_adc_init);
-                //snd_printk("I2C:array size=0x%x\n", size);
+                /* snd_printk("I2C:array size=0x%x\n", size); */
 		for (n=0; n < size; n++) {
 			snd_ca0106_i2c_write(chip, i2c_adc_init[n][0], i2c_adc_init[n][1]);
 		}
@@ -1517,7 +1517,7 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 			chip->i2c_capture_volume[n][1]= 0xcf;
 		}
 		chip->i2c_capture_source=2; /* Line in */
-	        //snd_ca0106_i2c_write(chip, ADC_MUX, ADC_MUX_LINEIN); /* Enable Line-in capture. MIC in currently untested. */
+	        /* snd_ca0106_i2c_write(chip, ADC_MUX, ADC_MUX_LINEIN); Enable Line-in capture. MIC in currently untested. */
 	}
         if (chip->details->spi_dac == 1) { /* The SB0570 use SPI to control DAC. */
 		int size, n;
@@ -1616,7 +1616,7 @@ static int __devinit snd_ca0106_midi(struct snd_ca0106 *chip, unsigned int chann
 	midi->get_dev_id_port = ca0106_dev_id_port;
 
 	midi->dev_id = chip;
-	
+
 	if ((err = ca_midi_init(chip, midi, 0, name)) < 0)
 		return err;
 
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index 3025ed1..9bfc92d 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -5,7 +5,7 @@
  *
  *  FEATURES currently supported:
  *    See ca0106_main.c for features.
- * 
+ *
  *  Changelog:
  *    Support interrupts per period.
  *    Removed noise from Center/LFE channel when in Analog mode.
@@ -71,7 +71,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
 #include <sound/tlv.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "ca0106.h"
 
@@ -157,7 +157,7 @@ static int snd_ca0106_capture_source_put(struct snd_kcontrol *kcontrol,
 	u32 mask;
 	u32 source;
 
-	val = ucontrol->value.enumerated.item[0] ;
+	val = ucontrol->value.enumerated.item[0];
 	if (val >= 6)
 		return -EINVAL;
 	change = (emu->capture_source != val);
@@ -207,7 +207,7 @@ static int snd_ca0106_i2c_capture_source_put(struct snd_kcontrol *kcontrol,
 	 * update the capture volume from the cached value
 	 * for the particular source.
 	 */
-	source_id = ucontrol->value.enumerated.item[0] ;
+	source_id = ucontrol->value.enumerated.item[0];
 	if (source_id >= 4)
 		return -EINVAL;
 	change = (emu->i2c_capture_source != source_id);
@@ -273,23 +273,23 @@ static int snd_ca0106_capture_mic_line_in_put(struct snd_kcontrol *kcontrol,
 	int change = 0;
 	u32 tmp;
 
-	val = ucontrol->value.enumerated.item[0] ;
+	val = ucontrol->value.enumerated.item[0];
 	if (val > 1)
 		return -EINVAL;
 	change = (emu->capture_mic_line_in != val);
 	if (change) {
 		emu->capture_mic_line_in = val;
 		if (val) {
-			//snd_ca0106_i2c_write(emu, ADC_MUX, 0); /* Mute input */
+			/* snd_ca0106_i2c_write(emu, ADC_MUX, 0);  Mute input */
 			tmp = inl(emu->port+GPIO) & ~0x400;
 			tmp = tmp | 0x400;
 			outl(tmp, emu->port+GPIO);
-			//snd_ca0106_i2c_write(emu, ADC_MUX, ADC_MUX_MIC);
+			/* snd_ca0106_i2c_write(emu, ADC_MUX, ADC_MUX_MIC); */
 		} else {
-			//snd_ca0106_i2c_write(emu, ADC_MUX, 0); /* Mute input */
+			/* snd_ca0106_i2c_write(emu, ADC_MUX, 0);  Mute input */
 			tmp = inl(emu->port+GPIO) & ~0x400;
 			outl(tmp, emu->port+GPIO);
-			//snd_ca0106_i2c_write(emu, ADC_MUX, ADC_MUX_LINEIN);
+			/* snd_ca0106_i2c_write(emu, ADC_MUX, ADC_MUX_LINEIN); */
 		}
 	}
         return change;
@@ -405,7 +405,7 @@ static int snd_ca0106_volume_put(struct snd_kcontrol *kcontrol,
 	nval = ((0xff - ucontrol->value.integer.value[0]) << 24) |
 		((0xff - ucontrol->value.integer.value[1]) << 16);
         nval |= ((0xff - ucontrol->value.integer.value[0]) << 8) |
-		((0xff - ucontrol->value.integer.value[1]) );
+		((0xff - ucontrol->value.integer.value[1]));
 	if (oval == nval)
 		return 0;
 	snd_ca0106_ptr_write(emu, reg, channel_id, nval);
@@ -451,7 +451,7 @@ static int snd_ca0106_i2c_volume_put(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 	if (ogain != ngain) {
 		if (emu->i2c_capture_source == source_id)
-			snd_ca0106_i2c_write(emu, ADC_ATTEN_ADCL, ((ngain) & 0xff) );
+			snd_ca0106_i2c_write(emu, ADC_ATTEN_ADCL, ((ngain) & 0xff));
 		emu->i2c_capture_volume[source_id][0] = ucontrol->value.integer.value[0];
 		change = 1;
 	}
diff --git a/sound/pci/ca0106/ca0106_proc.c b/sound/pci/ca0106/ca0106_proc.c
index c62b7d1..16789b4 100644
--- a/sound/pci/ca0106/ca0106_proc.c
+++ b/sound/pci/ca0106/ca0106_proc.c
@@ -5,7 +5,7 @@
  *
  *  FEATURES currently supported:
  *    See ca0106_main.c for features.
- * 
+ *
  *  Changelog:
  *    Support interrupts per period.
  *    Removed noise from Center/LFE channel when in Analog mode.
@@ -71,7 +71,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
 #include <sound/asoundef.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "ca0106.h"
 
@@ -98,7 +98,7 @@ static struct snd_ca0106_category_str snd_ca0106_con_category[] = {
 };
 
 
-static void snd_ca0106_proc_dump_iec958( struct snd_info_buffer *buffer, u32 value)
+static void snd_ca0106_proc_dump_iec958(struct snd_info_buffer *buffer, u32 value)
 {
 	int i;
 	u32 status[4];
@@ -106,8 +106,8 @@ static void snd_ca0106_proc_dump_iec958( struct snd_info_buffer *buffer, u32 val
 	status[1] = (value >> 8) & 0xff;
 	status[2] = (value >> 16)  & 0xff;
 	status[3] = (value >> 24)  & 0xff;
-	
-	if (! (status[0] & IEC958_AES0_PROFESSIONAL)) {
+
+	if (!(status[0] & IEC958_AES0_PROFESSIONAL)) {
 		/* consumer */
 		snd_iprintf(buffer, "Mode: consumer\n");
 		snd_iprintf(buffer, "Data: ");
@@ -272,7 +272,7 @@ static void snd_ca0106_proc_dump_iec958( struct snd_info_buffer *buffer, u32 val
 	}
 }
 
-static void snd_ca0106_proc_iec958(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_iec958(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -282,9 +282,9 @@ static void snd_ca0106_proc_iec958(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "Status: %s, %s, %s\n",
 		  (value & 0x100000) ? "Rate Locked" : "Not Rate Locked",
 		  (value & 0x200000) ? "SPDIF Locked" : "No SPDIF Lock",
-		  (value & 0x400000) ? "Audio Valid" : "No valid audio" );
-	snd_iprintf(buffer, "Estimated sample rate: %u\n", 
-		  ((value & 0xfffff) * 48000) / 0x8000 );
+		  (value & 0x400000) ? "Audio Valid" : "No valid audio");
+	snd_iprintf(buffer, "Estimated sample rate: %u\n",
+		  ((value & 0xfffff) * 48000) / 0x8000);
 	if (value & 0x200000) {
 		snd_iprintf(buffer, "IEC958/SPDIF input status:\n");
         	value = snd_ca0106_ptr_read(emu, SPDIF_INPUT_STATUS, 0);
@@ -294,7 +294,7 @@ static void snd_ca0106_proc_iec958(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "\n");
 }
 
-static void snd_ca0106_proc_reg_write32(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_reg_write32(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -304,7 +304,7 @@ static void snd_ca0106_proc_reg_write32(struct snd_info_entry *entry,
         while (!snd_info_get_line(buffer, line, sizeof(line))) {
                 if (sscanf(line, "%x %x", &reg, &val) != 2)
                         continue;
-                if ((reg < 0x40) && (reg >=0) && (val <= 0xffffffff) ) {
+                if ((reg < 0x40) && (reg >=0) && (val <= 0xffffffff)) {
 			spin_lock_irqsave(&emu->emu_lock, flags);
 			outl(val, emu->port + (reg & 0xfffffffc));
 			spin_unlock_irqrestore(&emu->emu_lock, flags);
@@ -312,7 +312,7 @@ static void snd_ca0106_proc_reg_write32(struct snd_info_entry *entry,
         }
 }
 
-static void snd_ca0106_proc_reg_read32(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_reg_read32(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -320,7 +320,7 @@ static void snd_ca0106_proc_reg_read32(struct snd_info_entry *entry,
 	unsigned long flags;
 	int i;
 	snd_iprintf(buffer, "Registers:\n\n");
-	for(i = 0; i < 0x20; i+=4) {
+	for (i = 0; i < 0x20; i += 4) {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		value = inl(emu->port + i);
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
@@ -328,7 +328,7 @@ static void snd_ca0106_proc_reg_read32(struct snd_info_entry *entry,
 	}
 }
 
-static void snd_ca0106_proc_reg_read16(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_reg_read16(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -336,7 +336,7 @@ static void snd_ca0106_proc_reg_read16(struct snd_info_entry *entry,
 	unsigned long flags;
 	int i;
 	snd_iprintf(buffer, "Registers:\n\n");
-	for(i = 0; i < 0x20; i+=2) {
+	for (i = 0; i < 0x20; i += 2) {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		value = inw(emu->port + i);
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
@@ -344,7 +344,7 @@ static void snd_ca0106_proc_reg_read16(struct snd_info_entry *entry,
 	}
 }
 
-static void snd_ca0106_proc_reg_read8(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_reg_read8(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -352,7 +352,7 @@ static void snd_ca0106_proc_reg_read8(struct snd_info_entry *entry,
 	unsigned long flags;
 	int i;
 	snd_iprintf(buffer, "Registers:\n\n");
-	for(i = 0; i < 0x20; i+=1) {
+	for (i = 0; i < 0x20; i++) {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		value = inb(emu->port + i);
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
@@ -360,7 +360,7 @@ static void snd_ca0106_proc_reg_read8(struct snd_info_entry *entry,
 	}
 }
 
-static void snd_ca0106_proc_reg_read1(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_reg_read1(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -368,7 +368,7 @@ static void snd_ca0106_proc_reg_read1(struct snd_info_entry *entry,
 	int i,j;
 
 	snd_iprintf(buffer, "Registers\n");
-	for(i = 0; i < 0x40; i++) {
+	for (i = 0; i < 0x40; i++) {
 		snd_iprintf(buffer, "%02X: ",i);
 		for (j = 0; j < 4; j++) {
                   value = snd_ca0106_ptr_read(emu, i, j);
@@ -378,7 +378,7 @@ static void snd_ca0106_proc_reg_read1(struct snd_info_entry *entry,
 	}
 }
 
-static void snd_ca0106_proc_reg_read2(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_reg_read2(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -386,7 +386,7 @@ static void snd_ca0106_proc_reg_read2(struct snd_info_entry *entry,
 	int i,j;
 
 	snd_iprintf(buffer, "Registers\n");
-	for(i = 0x40; i < 0x80; i++) {
+	for (i = 0x40; i < 0x80; i++) {
 		snd_iprintf(buffer, "%02X: ",i);
 		for (j = 0; j < 4; j++) {
                   value = snd_ca0106_ptr_read(emu, i, j);
@@ -396,7 +396,7 @@ static void snd_ca0106_proc_reg_read2(struct snd_info_entry *entry,
 	}
 }
 
-static void snd_ca0106_proc_reg_write(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_reg_write(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -405,12 +405,12 @@ static void snd_ca0106_proc_reg_write(struct snd_info_entry *entry,
         while (!snd_info_get_line(buffer, line, sizeof(line))) {
                 if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
                         continue;
-                if ((reg < 0x80) && (reg >=0) && (val <= 0xffffffff) && (channel_id >=0) && (channel_id <= 3) )
+                if ((reg < 0x80) && (reg >=0) && (val <= 0xffffffff) && (channel_id >=0) && (channel_id <= 3))
                         snd_ca0106_ptr_write(emu, reg, channel_id, val);
         }
 }
 
-static void snd_ca0106_proc_i2c_write(struct snd_info_entry *entry, 
+static void snd_ca0106_proc_i2c_write(struct snd_info_entry *entry,
 				       struct snd_info_buffer *buffer)
 {
 	struct snd_ca0106 *emu = entry->private_data;
@@ -425,32 +425,32 @@ static void snd_ca0106_proc_i2c_write(struct snd_info_entry *entry,
         }
 }
 
-int __devinit snd_ca0106_proc_init(struct snd_ca0106 * emu)
+int __devinit snd_ca0106_proc_init(struct snd_ca0106 *emu)
 {
 	struct snd_info_entry *entry;
-	
-	if(! snd_card_proc_new(emu->card, "iec958", &entry))
+
+	if (!snd_card_proc_new(emu->card, "iec958", &entry))
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_iec958);
-	if(! snd_card_proc_new(emu->card, "ca0106_reg32", &entry)) {
+	if (!snd_card_proc_new(emu->card, "ca0106_reg32", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read32);
 		entry->c.text.write = snd_ca0106_proc_reg_write32;
 		entry->mode |= S_IWUSR;
 	}
-	if(! snd_card_proc_new(emu->card, "ca0106_reg16", &entry))
+	if (!snd_card_proc_new(emu->card, "ca0106_reg16", &entry))
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read16);
-	if(! snd_card_proc_new(emu->card, "ca0106_reg8", &entry))
+	if (!snd_card_proc_new(emu->card, "ca0106_reg8", &entry))
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read8);
-	if(! snd_card_proc_new(emu->card, "ca0106_regs1", &entry)) {
+	if (!snd_card_proc_new(emu->card, "ca0106_regs1", &entry)) {
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read1);
 		entry->c.text.write = snd_ca0106_proc_reg_write;
 		entry->mode |= S_IWUSR;
 	}
-	if(! snd_card_proc_new(emu->card, "ca0106_i2c", &entry)) {
+	if (!snd_card_proc_new(emu->card, "ca0106_i2c", &entry)) {
 		entry->c.text.write = snd_ca0106_proc_i2c_write;
 		entry->private_data = emu;
 		entry->mode |= S_IWUSR;
 	}
-	if(! snd_card_proc_new(emu->card, "ca0106_regs2", &entry)) 
+	if (!snd_card_proc_new(emu->card, "ca0106_regs2", &entry))
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read2);
 	return 0;
 }
diff --git a/sound/pci/ca0106/ca_midi.c b/sound/pci/ca0106/ca_midi.c
index c788511..3056f98 100644
--- a/sound/pci/ca0106/ca_midi.c
+++ b/sound/pci/ca0106/ca_midi.c
@@ -1,4 +1,4 @@
-/* 
+/*
  *  Copyright 10/16/2005 Tilman Kranz <tilde@tk-sls.de>
  *  Creative Audio MIDI, for the CA0106 Driver
  *  Version: 0.0.1
@@ -66,7 +66,7 @@ static void ca_midi_interrupt(struct snd_ca_midi *midi, unsigned int status)
 			ca_midi_clear_rx(midi);
 		} else {
 			byte = ca_midi_read_data(midi);
-			if(midi->substream_input)
+			if (midi->substream_input)
 				snd_rawmidi_receive(midi->substream_input, &byte, 1);
 
 
@@ -124,7 +124,7 @@ static int ca_midi_input_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_ca_midi *midi = substream->rmidi->private_data;
 	unsigned long flags;
-	
+
 	if (snd_BUG_ON(!midi->dev_id))
 		return -ENXIO;
 	spin_lock_irqsave(&midi->open_lock, flags);
@@ -187,13 +187,13 @@ static int ca_midi_output_close(struct snd_rawmidi_substream *substream)
 
 	if (snd_BUG_ON(!midi->dev_id))
 		return -ENXIO;
-	
+
 	spin_lock_irqsave(&midi->open_lock, flags);
 
 	midi->interrupt_disable(midi,midi->tx_enable);
 	midi->midi_mode &= ~CA_MIDI_MODE_OUTPUT;
 	midi->substream_output = NULL;
-	
+
 	if (!(midi->midi_mode & CA_MIDI_MODE_INPUT)) {
 		spin_unlock_irqrestore(&midi->open_lock, flags);
 		ca_midi_cmd(midi, midi->reset, 0);
@@ -230,7 +230,7 @@ static void ca_midi_output_trigger(struct snd_rawmidi_substream *substream, int
 		unsigned char byte;
 
 		spin_lock_irqsave(&midi->output_lock, flags);
-	
+
 		/* try to send some amount of bytes here before interrupts */
 		while (max > 0) {
 			if (ca_midi_output_ready(midi)) {
@@ -309,7 +309,7 @@ int __devinit ca_midi_init(void *dev_id, struct snd_ca_midi *midi, int device, c
 	                     SNDRV_RAWMIDI_INFO_DUPLEX;
 	rmidi->private_data = midi;
 	rmidi->private_free = ca_rmidi_free;
-	
+
 	midi->rmidi = rmidi;
 	return 0;
 }
diff --git a/sound/pci/ca0106/ca_midi.h b/sound/pci/ca0106/ca_midi.h
index 922ed3e..d285456 100644
--- a/sound/pci/ca0106/ca_midi.h
+++ b/sound/pci/ca0106/ca_midi.h
@@ -1,4 +1,4 @@
-/* 
+/*
  *  Copyright 10/16/2005 Tilman Kranz <tilde@tk-sls.de>
  *  Creative Audio MIDI, for the CA0106 Driver
  *  Version: 0.0.1
@@ -46,8 +46,8 @@ struct snd_ca_midi {
 	unsigned int midi_mode;
 	int port;
 	int tx_enable, rx_enable;
-	int ipr_tx, ipr_rx;            
-	
+	int ipr_tx, ipr_rx;
+
 	int input_avail, output_ready;
 	int ack, reset, enter_uart;
