From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] AudigyLS updates.
Date: Fri, 25 Jun 2004 22:37:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40DC9B32.6000204@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010409060401010501030903"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2680B137
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2004 22:35:44 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010409060401010501030903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

AudigyLS now supports Digital(AC3)/Analog outputs. 5.1 Surround 
PLAYBACK. MIC and LINE IN CAPTURE.

The MIC and LINE IN use the AC97 chip.

The AC97 uses the PLAYBACK(Not CAPTURE) controls in alsamixer for 
controlling CAPTURE. Then, instead of sending that output to the 
speakers, it sends it to the Philips 1361T ADC. This results in high 
quality ADC conversion.
E.g. For LINE IN capture, set LINE IN playback volume and unmute it.
Set MASTER volume.
There is a new control for "CAPTURE feedback into PLAYBACK". If one does 
not want any feedback, leave it at it's minimum.

Once I have figured out all the controls in the AC97 and what they do 
for the AudigyLS, I will rename them so that they make sense to the user.

Please see attached patch files against the current CVS.

Still TODO:
1) Set multiple sample rates.
2) Add a CAPUTRE source switch for switch between "MIC", "Line in", 
"SPDIF in", "TAD in", "AUX in" and "What u hear". Currently, one cannot 
switch to capture "SPDIF in" or "What u hear", but all the other inputs 
are possible via switches in the AC97.
3) Set multiple periods per buffer.
4) MIDI in/out.
5) Cleaner module unload.

Cheers
James

--------------010409060401010501030903
Content-Type: text/plain;
 name="alsa-driver.audigyls.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver.audigyls.diff.txt"

Index: alsa-driver/pci/emu10k1/audigyls.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/audigyls.c,v
retrieving revision 1.2
diff -u -r1.2 audigyls.c
--- alsa-driver/pci/emu10k1/audigyls.c	23 Jun 2004 17:21:30 -0000	1.2
+++ alsa-driver/pci/emu10k1/audigyls.c	25 Jun 2004 20:15:46 -0000
@@ -5,12 +5,22 @@
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
  *    Surround40 and Surround51.
- *    Capture from MIC input.
+ *    Capture from MIC an LINE IN input.
  *    SPDIF digital playback of PCM stereo and AC3/DTS works.
- *    (One can use a standard stereo mini-jack to two RCA plugs cable.
+ *    (One can use a standard mono mini-jack to one RCA plugs cable.
+ *     or one can use a standard stereo mini-jack to two RCA plugs cable.
  *     Plug one of the RCA plugs into the Coax input of the external decoder/receiver.)
+ *    ( In theory one could output 3 different AC3 streams at once, to 3 different SPDIF outputs. )
+ *    Notes on how to capture sound:
+ *      The AC97 is used in the PLAYBACK direction.
+ *      The output from the AC97 chip, instead of reaching the speakers, is fed into the Philips 1361T ADC.
+ *      So, to record from the MIC, set the MIC Playback volume to max,
+ *      unmute the MIC and turn up the MASTER Playback volume.
+ *      So, to prevent feedback when capturing, minimise the "Capture feedback into Playback" volume.
+ *      The Digital/Analog switch must be in Analog mode for CAPTURE.
  *
  *  BUGS:
+ *    Some stability problems when unloading the snd-audigyls kernel module.
  *    --
  *
  *  TODO:
@@ -45,6 +55,7 @@
  *
  */
 #include <sound/driver.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
@@ -98,6 +109,7 @@
 #define INTE			0x0c		/* Interrupt enable register			*/
 #define INTE_CH_0_LOOP          0x00000800      /* Channel 0 loop                               */
 #define INTE_CH_0_HALF_LOOP     0x00000100      /* Channel 0 half loop                          */
+#define INTE_TIMER              0x00000008      /* Interrupt based on Timer                     */
 
 #define HCFG			0x14		/* Hardware config register			*/
 
@@ -111,25 +123,29 @@
 /* Audigy LS pointer-offset register set, accessed through the PTR and DATA registers                     */
 /********************************************************************************************************/
                                                                                                                            
+/* Initally all registers from 0x00 to 0x3f have zero contents. */
 #define PLAYBACK_UNKNOWN0	0x00		/* Something used in playback */
 #define PLAYBACK_UNKNOWN1	0x01		/* Something used in playback */
 #define PLAYBACK_UNKNOWN2	0x02		/* Something used in playback */
 #define PLAYBACK_UNKNOWN3	0x03		/* Something ?? */
-#define PLAYBACK_DMA_ADDR	0x04		/* Something used in playback */
-#define PLAYBACK_BUFFER_SIZE	0x05		/* Something used in playback */
+#define PLAYBACK_DMA_ADDR	0x04		/* Playback DMA addresss */
+#define PLAYBACK_BUFFER_SIZE	0x05		/* Playback buffer size. win2000 uses 0x04000000 */
 #define PLAYBACK_POINTER	0x06		/* Playback buffer pointer. Sample currently in DAC */
 #define PLAYBACK_UNKNOWN7	0x07		/* Something used in playback */
 #define PLAYBACK_UNKNOWN8	0x08		/* Something used in playback */
 #define PLAYBACK_UNKNOWN9	0x09		/* Something ?? */
-#define CAPTURE_DMA_ADDR	0x10		/* Something used in capture */
-#define CAPTURE_BUFFER_SIZE	0x11		/* Something used in capture */
+#define CAPTURE_DMA_ADDR	0x10		/* Capture DMA address */
+#define CAPTURE_BUFFER_SIZE	0x11		/* Capture buffer size */
 #define CAPTURE_POINTER		0x12		/* Capture buffer pointer. Sample currently in ADC */
 #define CAPTURE_UNKNOWN13	0x13		/* Something used in capture */
 #define AC97DATA		0x1c		/* AC97 register set data register (16 bit)	*/
 
 #define AC97ADDRESS		0x1e		/* AC97 register set address register (8 bit)	*/
-#define PLAYBACk_LAST_SAMPLE    0x20            /* The sample currently being played */
-#define BASIC_INTERRUPT         0x40            /* Used by both playback and capture interrupt handler */
+#define PLAYBACk_LAST_SAMPLE    0x20		/* The sample currently being played */
+/* 0x21 - 0x3f unused */
+#define BASIC_INTERRUPT         0x40		/* Used by both playback and capture interrupt handler */
+						/* Playback (0x1<<channel_id) */
+						/* Capture  (0x100<<channel_id) */
 /* The Digital out jack is shared with the Center/LFE Analogue output. 
  * The jack has 4 poles. I will call 1 - Tip, 2 - Next to 1, 3 - Next to 2, 4 - Next to 3
  * For Analogue: 1 -> Center Speaker, 2 -> Sub Woofer, 3 -> Ground, 4 -> Ground
@@ -145,8 +161,6 @@
 /* A standard 2 pole mono mini-jack to RCA plug can be used for SPDIF Stereo PCM output from the Front channel.
  * A standard 3 pole stereo mini-jack to 2 RCA plugs can be used for SPDIF AC3/DTS and Stereo PCM output utilising the Rear channel and just one of the RCA plugs. 
  */
-
-
 #define SPCS0			0x41		/* SPDIF output Channel Status 0 register. For Rear. default=0x02108004, non-audio=0x02108006	*/
 #define SPCS1			0x42		/* SPDIF output Channel Status 1 register. For Front */
 #define SPCS2			0x43		/* SPDIF output Channel Status 2 register. For Center/LFE */
@@ -175,34 +189,63 @@
 #define SPCS_NOTAUDIODATA	0x00000002	/* 0 = Digital audio, 1 = not audio		*/
 #define SPCS_PROFESSIONAL	0x00000001	/* 0 = Consumer (IEC-958), 1 = pro (AES3-1992)	*/
 
-#define SPDIF_SELECT		0x45		/* Enables SPDIF or Analogue outputs 0-Analogue, 0xf00-SPDIF */
+#define SPDIF_SELECT1		0x45		/* Enables SPDIF or Analogue outputs 0-SPDIF, 0xf00-Analogue */
+						/* 0x100 - Front, 0x800 - Rear, 0x200 - Center/LFE.
+						 * But as the jack is shared, use 0xf00.
+						 * The Windows2000 driver uses 0x0000000f for both digital and analog.
+						 */
 #define CAPTURE_SOURCE          0x60            /* Capture Source 0 = MIC */
 #define CAPTURE_SOURCE_CHANNEL0 0xf0000000	/* Mask for selecting the Capture sources */
-#define CAPTURE_SOURCE_CHANNEL1 0x0f000000	/* 0 - MIC input. */
-#define CAPTURE_SOURCE_CHANNEL2 0x00f00000      /* 1 - ??, 2-??, 3-?? */
-#define CAPTURE_SOURCE_CHANNEL3 0x000f0000
-#define CAPTURE_SOURCE_LOOPBACK 0x0000ffff
+#define CAPTURE_SOURCE_CHANNEL1 0x0f000000	/* 0 - SPDIF input. */
+#define CAPTURE_SOURCE_CHANNEL2 0x00f00000      /* 1 - What you hear. 2 - ?? */
+#define CAPTURE_SOURCE_CHANNEL3 0x000f0000	/* 3 - Mic in, Line in, TAD in, Aux in. */
+#define CAPTURE_SOURCE_LOOPBACK 0x0000ffff	/* Default 0x00e4 */
 
 #define CAPTURE_VOLUME1         0x61            /* Capture  volume per voice */
 #define CAPTURE_VOLUME2         0x62            /* Capture  volume per voice */
-#define UNKNOWN_VOLUME          0x66            /* Unknown  volume per voice */
-#define PLAYBACK_VOLUME         0x6a            /* Playback volume per voice */
+
+#define PLAYBACK_ROUTING1       0x63            /* Playback routing. Effects AC3 output. Default 0x32765410 */
+#define ROUTING1_REAR           0x77000000      /* Channel_id 0 sends to 10, Channel_id 1 sends to 32 */
+#define ROUTING1_NULL           0x00770000      /* Channel_id 2 sends to 54, Channel_id 3 sends to 76 */
+#define ROUTING1_CENTER_LFE     0x00007700      /* 0x32765410 means, send Channel_id 0 to FRONT, Channel_id 1 to REAR */
+#define ROUTING1_FRONT          0x00000077	/* Channel_id 2 to CENTER_LFE, Channel_id 3 to NULL. */
+
+#define PLAYBACK_ROUTING2       0x64            /* Unknown Routing. Effects AC3 output. Default 0x76767676 */
+#define PLAYBACK_MUTE           0x65            /* Unknown. While playing 0x0, while silent 0x00fc0000 */
+#define PLAYBACK_VOLUME1        0x66            /* Playback volume per voice. Set to the same PLAYBACK_VOLUME(0x6a) */
+						/* PLAYBACK_VOLUME1 must be set to 30303030 for SPDIF AC3 Playback */
+#define CAPTURE_ROUTING1        0x67            /* Playback Routing. Default 0x32765410 */
+#define CAPTURE_ROUTING2        0x68            /* Unknown Routing. Default 0x76767676 */
+#define CAPTURE_MUTE            0x69            /* Unknown. While capturing 0x0, while silent 0x00fc0000 */
+#define PLAYBACK_VOLUME2        0x6a            /* Playback volume per voice. Does not effect AC3 output */
+#define UNKNOWN6b               0x6b            /* Unknown. Readonly. Default 00400000 00400000 00400000 00400000 */
 #define UART1                   0x6c            /* Uart, used in setting sample rates, bits per sample etc. */
 #define UART2                   0x6d            /* Uart, used in setting sample rates, bits per sample etc. */
-#define ROUTING1                0x71            /* Some sort of routing. default = 0xf0000000 */
-#define ROUTING2                0x72            /* Some sort of routing. default = 0x0f0f003f */
-#define CHIP_VERSION            0x74            /* P17 Chip version */
+#define UNKNOWN_UART1           0x6e            /* Uart, Unknown. */
+#define UNKNOWN_UART2           0x6f            /* Uart, Unknown. */
+#define UNKNOWN70               0x70            /* Unknown. Readonly. Default 00108000 00108000 00500000 00500000 */
+#define CAPTURE_CONTROL         0x71            /* Some sort of routing. default = 40c81000 30303030 30300000 00700000 */
+						/* Channel_id 0: 0x40c81000 must be changed to 0x40c80000 for SPDIF AC3 input or output. */
+						/* Channel_id 1: 0xffffffff(mute) 0x30303030(max) controls CAPTURE feedback into PLAYBACK. */
+#define SPDIF_SELECT2           0x72            /* Some sort of routing. Channel_id 0 only. default = 0x0f0f003f. Analog 0x000b0000, Digital 0x0b000000 */
+#define ROUTING2_FRONT_MASK     0x00010000      /* Enable for Front speakers. */
+#define ROUTING2_CENTER_LFE_MASK 0x00020000     /* Enable for Center/LFE speakers. */
+#define ROUTING2_REAR_MASK      0x00080000      /* Enable for Rear speakers. */
+#define UNKNOWN73               0x73            /* Unknown. Readonly. Default 0x0 */
+#define CHIP_VERSION            0x74            /* P17 Chip version. Channel_id 0 only. Default 00000071 */
 #define EXTENDED_INT_MASK       0x75            /* Used by both playback and capture interrupt handler */
 						/* Sets which Interrupts are enabled. */
 #define EXTENDED_INT            0x76            /* Used by both playback and capture interrupt handler */
 						/* Shows which interrupts are active at the moment. */
-#define EXTENDED_INT_TIMER      0x79            /* Used by both playback and capture interrupt handler */
+#define COUNTER77               0x77		/* Counter range 0 to 0x3fffff, 192000 counts per second. */
+#define COUNTER78               0x78		/* Counter range 0 to 0x3fffff, 44100 counts per second. */
+#define EXTENDED_INT_TIMER      0x79            /* Channel_id 0 only. Used by both playback and capture interrupt handler */
 						/* Causes interrupts based on timer intervals. */
 #define SET_CHANNEL 0  /* Testing channel outputs 0=Front, 1=Center/LFE, 2=Unknown, 3=Rear */
 #define PCM_FRONT_CHANNEL 0
-#define PCM_CENTER_LFE_CHANNEL 1
-#define PCM_UNKNOWN_CHANNEL 2
-#define PCM_REAR_CHANNEL 3
+#define PCM_REAR_CHANNEL 1
+#define PCM_CENTER_LFE_CHANNEL 2
+#define PCM_UNKNOWN_CHANNEL 3
 
 #define chip_t audigyls_t
 
@@ -260,6 +303,7 @@
 	audigyls_channel_t channels[4];
 	audigyls_channel_t capture_channel;
 	u32 spdif_bits[4];             /* s/pdif out setup */
+	int digital_analog;
 
 	struct snd_dma_device dma_dev;
 	struct snd_dma_buffer buffer;
@@ -402,8 +446,9 @@
 {
 	audigyls_pcm_t *epcm = snd_magic_cast(audigyls_pcm_t, runtime->private_data, return);
   
-	if (epcm)
+	if (epcm) {
 		snd_magic_kfree(epcm);
+	}
 }
 
 static void snd_audigyls_pcm_interrupt(audigyls_t *emu, audigyls_voice_t *voice)
@@ -439,6 +484,7 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	epcm = snd_magic_kcalloc(audigyls_pcm_t, 0, GFP_KERNEL);
+
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = chip;
@@ -603,6 +649,7 @@
 	audigyls_pcm_t *epcm = snd_magic_cast(audigyls_pcm_t, runtime->private_data, return -ENXIO);
 	int voice = epcm->voice->number;
         voice=epcm->channel_id;
+	
         //printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
 	snd_audigyls_ptr_write(emu, 0x00, voice, 0);
 	snd_audigyls_ptr_write(emu, 0x01, voice, 0);
@@ -612,18 +659,19 @@
 	snd_audigyls_ptr_write(emu, PLAYBACK_POINTER, voice, 0);
 	snd_audigyls_ptr_write(emu, 0x07, voice, 0);
 	snd_audigyls_ptr_write(emu, 0x08, voice, 0);
-        snd_audigyls_ptr_write(emu, 0x67, 0x0, 0x76543210); /* FIXME: What is this */
+        snd_audigyls_ptr_write(emu, PLAYBACK_MUTE, 0x0, 0x0); /* Unmute output */
 #if 0
 	snd_audigyls_ptr_write(emu, SPCS0, 0,
 			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
 			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
 			       SPCS_GENERATIONSTATUS | 0x00001200 |
-			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT | SPCS_NOTAUDIODATA);
+			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT );
+	}
 #endif
-	snd_audigyls_ptr_write(emu, SPCS0, 0, 0x2108006);
-	//snd_audigyls_ptr_write(emu, 0x75, 0, 0x33); /* Routing of some sort */
-	//snd_audigyls_ptr_write(emu, 0x75, 0, 0x11 << voice); /* Routing of some sort */
-	snd_audigyls_ptr_write(emu, 0x75, 0, snd_audigyls_ptr_read(emu, 0x75, 0) | (0x11<<voice));
+	//snd_audigyls_ptr_write(emu, SPCS0, 0, 0x2108006);
+	//snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, 0x33); /* Routing of some sort */
+	//snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, 0x11 << voice); /* Routing of some sort */
+	snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) | (0x11<<voice));
 
 	return 0;
 }
@@ -641,8 +689,8 @@
 	snd_audigyls_ptr_write(emu, CAPTURE_DMA_ADDR, voice, runtime->dma_addr);
 	snd_audigyls_ptr_write(emu, CAPTURE_BUFFER_SIZE, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
 	snd_audigyls_ptr_write(emu, CAPTURE_POINTER, voice, 0);
-        snd_audigyls_ptr_write(emu, 0x60, 0x0, 0x0); /* FIXME: What is this */
-	snd_audigyls_ptr_write(emu, 0x75, 0, snd_audigyls_ptr_read(emu, 0x75, 0) | (0x110000<<voice));
+        snd_audigyls_ptr_write(emu, CAPTURE_SOURCE, 0x0, 0x333300e4); /* Select MIC or Line in */
+	snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) | (0x110000<<voice));
 
 	return 0;
 }
@@ -660,12 +708,12 @@
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_audigyls_ptr_write(emu, 0x40, 0, snd_audigyls_ptr_read(emu, 0x40, 0)|(0x1<<channel));
+		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0)|(0x1<<channel));
 		epcm->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_audigyls_ptr_write(emu, 0x40, 0, snd_audigyls_ptr_read(emu, 0x40, 0) & ~(0x1<<channel));
-		snd_audigyls_ptr_write(emu, 0x75, 0, snd_audigyls_ptr_read(emu, 0x75, 0) & ~(0x11<<channel));
+		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0) & ~(0x1<<channel));
+		snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) & ~(0x11<<channel));
 		epcm->running = 0;
 		break;
 	default:
@@ -688,12 +736,12 @@
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_audigyls_ptr_write(emu, 0x40, 0, snd_audigyls_ptr_read(emu, 0x40, 0)|(0x100<<channel));
+		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0)|(0x100<<channel));
 		epcm->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_audigyls_ptr_write(emu, 0x40, 0, snd_audigyls_ptr_read(emu, 0x40, 0) & ~(0x100<<channel));
-		snd_audigyls_ptr_write(emu, 0x75, 0, snd_audigyls_ptr_read(emu, 0x75, 0) & ~(0x110000<<channel));
+		snd_audigyls_ptr_write(emu, BASIC_INTERRUPT, 0, snd_audigyls_ptr_read(emu, BASIC_INTERRUPT, 0) & ~(0x100<<channel));
+		snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) & ~(0x110000<<channel));
 		epcm->running = 0;
 		break;
 	default:
@@ -852,11 +900,24 @@
 
 static int snd_audigyls_free(audigyls_t *chip)
 {
-	snd_audigyls_ptr_write(chip, 0x40, 0, 0);
-	// disable interrupts
-	outl(0, chip->port + INTE);
-	// disable audio
-	outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
+	if (chip->res_port != NULL) {    /* avoid access to already used hardware */
+		// disable interrupts
+		snd_audigyls_ptr_write(chip, BASIC_INTERRUPT, 0, 0);
+		outl(0, chip->port + INTE);
+		snd_audigyls_ptr_write(chip, EXTENDED_INT_MASK, 0, 0);
+		udelay(1000);
+		// disable audio
+		outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
+		/* FIXME: We need to stop and DMA transfers here.
+		 *        But as I am not sure how yet, we cannot from the dma pages.
+		 * So we can fix: snd-malloc: Memory leak?  pages not freed = 8
+		 */
+	}
+	// release the data
+#if 1
+	if (chip->buffer.area)
+		snd_dma_free_pages(&chip->dma_dev, &chip->buffer);
+#endif
 
 	// release the i/o port
 	if (chip->res_port) {
@@ -866,7 +927,6 @@
 	// release the irq
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
-	// release the data
 	snd_magic_kfree(chip);
 	return 0;
 }
@@ -963,13 +1023,13 @@
 	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_audigyls_capture_ops);
           break;
 	case 1:
-	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_audigyls_playback_center_lfe_ops);
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_audigyls_playback_rear_ops);
           break;
 	case 2:
-	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_audigyls_playback_unknown_ops);
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_audigyls_playback_center_lfe_ops);
           break;
 	case 3:
-	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_audigyls_playback_rear_ops);
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_audigyls_playback_unknown_ops);
           break;
         }
 
@@ -980,22 +1040,23 @@
 
 	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
 	    substream; 
-	    substream = substream->next)
+	    substream = substream->next) {
 		if ((err = snd_pcm_lib_preallocate_pages(substream, 
 							 SNDRV_DMA_TYPE_DEV, 
 							 snd_dma_pci_data(emu->pci), 
 							 32*1024, 32*1024)) < 0)
 			return err;
-
+	}
 
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; 
 	      substream; 
-	      substream = substream->next)
- 	  if ((err = snd_pcm_lib_preallocate_pages(substream, 
+	      substream = substream->next) {
+ 		if ((err = snd_pcm_lib_preallocate_pages(substream, 
 	                                           SNDRV_DMA_TYPE_DEV, 
 	                                           snd_dma_pci_data(emu->pci), 
 	                                           64*1024, 64*1024)) < 0)
-	    return err;
+			return err;
+	}
   
 	if (rpcm)
 		*rpcm = pcm;
@@ -1066,8 +1127,10 @@
 	pci_read_config_byte(pci, PCI_REVISION_ID, (char *)&chip->revision);
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
+#if 0
 	printk(KERN_INFO "Model %04x Rev %08x Serial %08x\n", chip->model,
 	       chip->revision, chip->serial);
+#endif
 
 	outl(0, chip->port + INTE);
 
@@ -1116,9 +1179,8 @@
 				SPCS_GENERATIONSTATUS | 0x00001200 |
 				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 
-	/* Select analogue output */
-        //snd_audigyls_ptr_write(chip, 0x41, 0, 0x70f); // ???
-        //snd_audigyls_ptr_write(chip, 0x65, 0, 0x1000);
+        snd_audigyls_ptr_write(chip, PLAYBACK_MUTE, 0, 0x00fc0000);
+        snd_audigyls_ptr_write(chip, CAPTURE_MUTE, 0, 0x00fc0000);
 
         /* Write 0x8000 to AC97_REC_GAIN to mute it. */
         outb(AC97_REC_GAIN, chip->port + AC97ADDRESS);
@@ -1130,16 +1192,30 @@
 	snd_audigyls_ptr_write(chip, 0x44, 0, 0x2108006);
 #endif
 
-	snd_audigyls_ptr_write(chip, 0x72, 0, 0xf0f003f);
-
-	snd_audigyls_ptr_write(chip, 0x71, 0, 0xf0000000);
-	//snd_audigyls_ptr_write(chip, 0x61, 0, 0x0);
-	//snd_audigyls_ptr_write(chip, 0x62, 0, 0x0);
-	snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME, 0, 0x30303030);
-
-	snd_audigyls_ptr_write(chip, 0x45, 0, 0); /* Analogue out */
+	//snd_audigyls_ptr_write(chip, SPDIF_SELECT2, 0, 0xf0f003f); /* OSS drivers set this. */
+	/* Analog or Digital output */
+	snd_audigyls_ptr_write(chip, SPDIF_SELECT1, 0, 0xf);
+	snd_audigyls_ptr_write(chip, SPDIF_SELECT2, 0, 0x0b000000); /* 0x000b0000 for analog, from win2000 drivers */
+	chip->digital_analog = 0; /* Set digital SPDIF output on */
+	//snd_audigyls_ptr_write(chip, 0x45, 0, 0); /* Analogue out */
 	//snd_audigyls_ptr_write(chip, 0x45, 0, 0xf00); /* Digital out */
 
+	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 0, 0x40c80000); /* goes to 0x40c81000 when not doing SPDIF IN/OUT */
+	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 1, 0xffffffff); /* (Mute) CAPTURE feedback into PLAYBACK volume. Only lower 16 bits matter. */
+	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 2, 0x30300000); /* SPDIF IN Volume */
+	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 3, 0x00700000); /* SPDIF IN Volume, 0x70 = (vol & 0x3f) | 0x40 */
+	snd_audigyls_ptr_write(chip, PLAYBACK_ROUTING1, 0, 0x32765410);
+	snd_audigyls_ptr_write(chip, PLAYBACK_ROUTING2, 0, 0x76767676);
+	snd_audigyls_ptr_write(chip, CAPTURE_ROUTING1, 0, 0x32765410);
+	snd_audigyls_ptr_write(chip, CAPTURE_ROUTING2, 0, 0x76767676);
+	for(ch = 0; ch < 4; ch++) {
+		snd_audigyls_ptr_write(chip, CAPTURE_VOLUME1, ch, 0x30303030); /* Only high 16 bits matter */
+		snd_audigyls_ptr_write(chip, CAPTURE_VOLUME2, ch, 0x30303030);
+		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0x30303030);
+		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0x30303030);
+	}
+        snd_audigyls_ptr_write(chip, CAPTURE_SOURCE, 0x0, 0x333300e4); /* Select MIC, Line in, TAD in, AUX in */
+
 	outl(0, chip->port+0x18);
 	snd_audigyls_intr_enable(chip, 0x105);
 
@@ -1276,10 +1352,14 @@
 
 static int snd_audigyls_shared_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	static char *texts[2] = { "Digital", "Analog " };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item > 1)
+                uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
 	return 0;
 }
 
@@ -1288,24 +1368,34 @@
 {
 	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.integer.value[0] = snd_audigyls_ptr_read(emu, SPDIF_SELECT, 0);
-        return 0;
+	ucontrol->value.enumerated.item[0] = emu->digital_analog;
+	return 0;
 }
 
 static int snd_audigyls_shared_spdif_put(snd_kcontrol_t * kcontrol,
 					snd_ctl_elem_value_t * ucontrol)
 {
 	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
-	unsigned int reg, val;
+	unsigned int val;
 	int change = 0;
 
-	reg = snd_audigyls_ptr_read(emu, SPDIF_SELECT, 0);
-	val = ucontrol->value.integer.value[0] ;
-	/* FIXME: Check whether we want ON == SPDIF on, or OFF == SPDIF on */
-	change = ((reg == 0xf00) != val);
+	val = ucontrol->value.enumerated.item[0] ;
+	change = (emu->digital_analog != val);
 	if (change) {
-		reg ^= 0xf00;
-		snd_audigyls_ptr_write(emu, SPDIF_SELECT, 0, reg);
+		emu->digital_analog = val;
+		if (val == 0) {
+			/* Digital */
+			snd_audigyls_ptr_write(emu, SPDIF_SELECT1, 0, 0xf);
+			snd_audigyls_ptr_write(emu, SPDIF_SELECT2, 0, 0x0b000000);
+			snd_audigyls_ptr_write(emu, CAPTURE_CONTROL, 0,
+				snd_audigyls_ptr_read(emu, CAPTURE_CONTROL, 0) & ~0x1000);
+		} else {
+			/* Analog */
+			snd_audigyls_ptr_write(emu, SPDIF_SELECT1, 0, 0xf00);
+			snd_audigyls_ptr_write(emu, SPDIF_SELECT2, 0, 0x000b0000);
+			snd_audigyls_ptr_write(emu, CAPTURE_CONTROL, 0,
+				snd_audigyls_ptr_read(emu, CAPTURE_CONTROL, 0) | 0x1000);
+		}
 	}
         return change;
 }
@@ -1417,16 +1507,19 @@
 	int channel_id = PCM_REAR_CHANNEL;
         return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
 }
-
-
+static int snd_audigyls_volume_info_feedback(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	int channel_id = 1;
+        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
+}
 
 static int snd_audigyls_volume_get(snd_kcontrol_t * kcontrol,
-                                       snd_ctl_elem_value_t * ucontrol, int channel_id)
+                                       snd_ctl_elem_value_t * ucontrol, int reg, int channel_id)
 {
         audigyls_t *emu = snd_kcontrol_chip(kcontrol);
         unsigned int value;
 
-        value = snd_audigyls_ptr_read(emu, PLAYBACK_VOLUME, channel_id);
+        value = snd_audigyls_ptr_read(emu, reg, channel_id);
         ucontrol->value.integer.value[0] = 0xff - ((value >> 24) & 0xff); /* Left */
         ucontrol->value.integer.value[1] = 0xff - ((value >> 16) & 0xff); /* Right */
         return 0;
@@ -1436,68 +1529,91 @@
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int channel_id = PCM_FRONT_CHANNEL;
-        return snd_audigyls_volume_get(kcontrol, ucontrol, channel_id);
+	int reg = PLAYBACK_VOLUME1;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
 
 static int snd_audigyls_volume_get_center_lfe(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int channel_id = PCM_CENTER_LFE_CHANNEL;
-        return snd_audigyls_volume_get(kcontrol, ucontrol, channel_id);
+	int reg = PLAYBACK_VOLUME1;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
 static int snd_audigyls_volume_get_unknown(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int channel_id = PCM_UNKNOWN_CHANNEL;
-        return snd_audigyls_volume_get(kcontrol, ucontrol, channel_id);
+	int reg = PLAYBACK_VOLUME1;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
 static int snd_audigyls_volume_get_rear(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int channel_id = PCM_REAR_CHANNEL;
-        return snd_audigyls_volume_get(kcontrol, ucontrol, channel_id);
+	int reg = PLAYBACK_VOLUME1;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_get_feedback(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = 1;
+	int reg = CAPTURE_CONTROL;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
                                                                                                                            
 static int snd_audigyls_volume_put(snd_kcontrol_t * kcontrol,
-                                       snd_ctl_elem_value_t * ucontrol, int channel_id)
+                                       snd_ctl_elem_value_t * ucontrol, int reg, int channel_id)
 {
         audigyls_t *emu = snd_kcontrol_chip(kcontrol);
         unsigned int value;
-        value = snd_audigyls_ptr_read(emu, PLAYBACK_VOLUME, channel_id);
-        value = value & 0xffff;
-        value = value | ((0xff - ucontrol->value.integer.value[0]) << 24) | ((0xff - ucontrol->value.integer.value[1]) << 16);
-        snd_audigyls_ptr_write(emu, PLAYBACK_VOLUME, channel_id, value);
+        //value = snd_audigyls_ptr_read(emu, reg, channel_id);
+        //value = value & 0xffff;
+        value = ((0xff - ucontrol->value.integer.value[0]) << 24) | ((0xff - ucontrol->value.integer.value[1]) << 16);
+        value = value | ((0xff - ucontrol->value.integer.value[0]) << 8) | ((0xff - ucontrol->value.integer.value[1]) );
+        snd_audigyls_ptr_write(emu, reg, channel_id, value);
         return 1;
 }
 static int snd_audigyls_volume_put_front(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int channel_id = PCM_FRONT_CHANNEL;
-        return snd_audigyls_volume_put(kcontrol, ucontrol, channel_id);
+	int reg = PLAYBACK_VOLUME1;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
 static int snd_audigyls_volume_put_center_lfe(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int channel_id = PCM_CENTER_LFE_CHANNEL;
-        return snd_audigyls_volume_put(kcontrol, ucontrol, channel_id);
+	int reg = PLAYBACK_VOLUME1;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
 static int snd_audigyls_volume_put_unknown(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int channel_id = PCM_UNKNOWN_CHANNEL;
-        return snd_audigyls_volume_put(kcontrol, ucontrol, channel_id);
+	int reg = PLAYBACK_VOLUME1;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
 static int snd_audigyls_volume_put_rear(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
 	int channel_id = PCM_REAR_CHANNEL;
-        return snd_audigyls_volume_put(kcontrol, ucontrol, channel_id);
+	int reg = PLAYBACK_VOLUME1;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_put_feedback(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = 1;
+	int reg = CAPTURE_CONTROL;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
 
 static snd_kcontrol_new_t snd_audigyls_volume_control_front =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "Front Volume",
+        .name =         "PCM Front Volume",
         .info =         snd_audigyls_volume_info_front,
         .get =          snd_audigyls_volume_get_front,
         .put =          snd_audigyls_volume_put_front
@@ -1505,7 +1621,7 @@
 static snd_kcontrol_new_t snd_audigyls_volume_control_center_lfe =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "Center/LFE Volume",
+        .name =         "PCM Center/LFE Volume",
         .info =         snd_audigyls_volume_info_center_lfe,
         .get =          snd_audigyls_volume_get_center_lfe,
         .put =          snd_audigyls_volume_put_center_lfe
@@ -1513,7 +1629,7 @@
 static snd_kcontrol_new_t snd_audigyls_volume_control_unknown =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "Unknown Volume",
+        .name =         "PCM Unknown Volume",
         .info =         snd_audigyls_volume_info_unknown,
         .get =          snd_audigyls_volume_get_unknown,
         .put =          snd_audigyls_volume_put_unknown
@@ -1521,11 +1637,20 @@
 static snd_kcontrol_new_t snd_audigyls_volume_control_rear =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "Rear Volume",
+        .name =         "PCM Rear Volume",
         .info =         snd_audigyls_volume_info_rear,
         .get =          snd_audigyls_volume_get_rear,
         .put =          snd_audigyls_volume_put_rear
 };
+static snd_kcontrol_new_t snd_audigyls_volume_control_feedback =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "CAPTURE feedback into PLAYBACK",
+        .info =         snd_audigyls_volume_info_feedback,
+        .get =          snd_audigyls_volume_get_feedback,
+        .put =          snd_audigyls_volume_put_feedback
+};
+
 
 static int remove_ctl(snd_card_t *card, const char *name)
 {
@@ -1579,6 +1704,10 @@
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_feedback, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
 	if ((kctl = snd_ctl_new1(&snd_audigyls_spdif_mask_control, emu)) == NULL)
 		return -ENOMEM;
 	if ((err = snd_ctl_add(card, kctl)))
@@ -1645,13 +1774,11 @@
 		snd_card_free(card);
 		return err;
 	}
-#if 1
 
 	if ((err = snd_audigyls_mixer(chip)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-#endif
 
 	snd_audigyls_proc_init(chip);
 

--------------010409060401010501030903
Content-Type: text/plain;
 name="alsa-lib.audigyls.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib.audigyls.diff.txt"

Index: alsa-lib/src/conf/cards/AudigyLS.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/AudigyLS.conf,v
retrieving revision 1.2
diff -u -r1.2 AudigyLS.conf
--- alsa-lib/src/conf/cards/AudigyLS.conf	23 Jun 2004 18:09:10 -0000	1.2
+++ alsa-lib/src/conf/cards/AudigyLS.conf	25 Jun 2004 20:18:10 -0000
@@ -23,7 +23,7 @@
 	}
 	type hw
 	card $CARD
-	device 3
+	device 1
 }	
 
 <confdir:pcm/center_lfe.conf>
@@ -35,7 +35,7 @@
 	}
 	type hw
 	card $CARD
-	device 1
+	device 2
 }	
 
 <confdir:pcm/surround40.conf>
@@ -146,12 +146,19 @@
 	slave.pcm {
 		type hw
 		card $CARD
-		device 3
+		device 0
 	}
 	hooks.0 {
 		type ctl_elems
 		hook_args [
 			{
+				name "PCM Front Volume"
+				index 0
+				lock true
+				preserve true
+				value [ 207 207 ]   # Puts 0x30303030 in the Volume register. 0xff - 0x30 = 0xcf = 207
+			}
+			{
 				name "Analog/Digital Output Jack"
 				lock true
 				preserve true
@@ -159,7 +166,7 @@
 			}
 			{
 				name "IEC958 Playback Default"
-				index 0
+				index 1
 				lock true
 				preserve true
 				value [ $AES0 $AES1 $AES2 $AES3 ]

--------------010409060401010501030903--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
