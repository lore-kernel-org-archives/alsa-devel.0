From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] AudigyLS updates.
Date: Thu, 01 Jul 2004 13:34:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E404C9.3010201@superbug.demon.co.uk>
References: <40DC9B32.6000204@superbug.demon.co.uk>	<s5hlli8dkld.wl@alsa2.suse.de>	<40E0117D.6010503@superbug.demon.co.uk> <s5hzn6l9f0u.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060004070200040905050709"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 80A6926B
	for <alsa-devel@alsa-project.org>; Thu,  1 Jul 2004 14:33:56 +0200 (MEST)
In-Reply-To: <s5hzn6l9f0u.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060004070200040905050709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Mon, 28 Jun 2004 13:39:25 +0100,
> James Courtier-Dutton wrote:
> 
>>Takashi Iwai wrote:
>>
>>>>2) Add a CAPUTRE source switch for switch between "MIC", "Line in", 
>>>>"SPDIF in", "TAD in", "AUX in" and "What u hear". Currently, one cannot 
>>>>switch to capture "SPDIF in" or "What u hear", but all the other inputs 
>>>>are possible via switches in the AC97.
>>>
>>>
>>>This will need better control on user-space.
>>>ac97 mixer will provide the generic capture source only...
>>>
>>>
>>>Takashi
>>>
>>>
>>
>>I am adding better controls as I find out what does what.
>>How is the userspace mixer controls status? (Using a lisp .conf file to 
>>control how the mixer behaves).
> 
> 
> Jaroslav has been working on this, but I think it's not ready yet...
> 
> 
>>What shall I call the AC97 capture controls?
>>1) AC97 Master CAPTURE.
>>2) AC97 MIC CAPTURE.
>>3) AC97 Line in CAPTURE.
>>4) AC97 TAD in CAPTURE.
>>5) AC97 AUX CAPTURE.
>>option (1) to (5) can act together, so one can record some from MIC and 
>>also some from Line in at the same time.
> 
> 
> In the case of SB16, it's simply like 'Mic Capture Switch'.
> 
> 
>>6) Feedback into PLAYBACK from CAPTURE.
> 
> 
> Isn't it 'what u hear'?  What's different from 'master capture'?

master capture is the renamed AC97 Master playback, but with the 
audigyls, it only effects the recorded signal. So, for recording, we 
have separate Line in, Mic volume controls, and then a master one 
covering all of them. As one is only likely to want to record from one 
source at a time, I could just remove the "AC97 Master capture" control, 
and set it at 0dB.

"Feedback into PLAYBACK from CAPTURE" is a way to send any recorded 
sounds, e.g. MIC,  directly to the speakers, without them reaching the CPU.

"what u hear" is a way to capture the sound exactly as it appears on the 
speakers. i.e. the final mix of what your are currently playing combined 
with any thing from "feedback into playback from capture".

> 
> 
>>There is also another capture source register I have found out about.
>>0 - Selects SPDIF CAPTURE.
>>1 - What you hear CAPTURE.
>>2 - Unknown
>>3 - AC97 CAPTURE. (See 1) to 5) above)
>>If this register is not set to 3, all the AC97 inputs are muted.
>>
>>I think I will add some new control renaming/deleting code, so that only 
>>the controls I know about are displayed to the user. I can put an #if 1 
>>... #endif round it, so that I can disable the renaming when I am testing.
> 
> 
> The simplest way would be to implement enum as the capture source as
> an exclusive capture source.  Of course the only drawback is that one
> cannot choose Line and CD at the same time in this case, but I don't
> think not many people will complain against this restriction.
> 
> 
> 
>>Is there a document somewhere for alsa-driver developers that states 
>>what one should set things to as the default, the "on start up" settings?
> 
> 
> No, it's up to the device.
> In general, we choose the mute as default, but I think not all volumes
> have to be muted (e.g. only PCM and Master).
> 
> 
>>E.g.
>>Initial Analog volume controls.
>>Should digital out be enabled at startup, or analog outputs.
>>
>>I think we should have the following (although the audigyls.c does not 
>>follow this yet!):-
>>Analog volume controls muted.
>>Default to Analog output.
>>
>>In windows the defaults are:
>>I don't know what the analog defaults are.
>>digital out is disabled at start up.
> 
> 
> IMO, these initial state can be handled better from the user-space,
> once when we have dB-based volume controls.
> 
> 
>>The windows driver controls digital output using a on/off switch called 
>>"SPDIF Out"
>>
>>I think it might be a good idea to change the "Audigy Analog/Digital 
>>Output Jack"  to instead say "SPDIF Out", with it defaulting to off for 
>>Analog.
> 
> 
> Well, this is a switch for the shared output jack, so "SPDIF Out"
> would be too ambiguous for its purpose.  But I agree with the renaming
> to a more reasonable one.

I think "SPDIF out" is not too ambiguous.
If "SPDIF Out" is off, you are not doing digital output, so one can 
switch the shared jack to analog.
If "SPDIF Out" in on, you want to use digital output, so one can switch 
the shared jack to digital.

I think that a even better approach would be using a 
"Speaker-arrangement" control.
Options:
"2.0"
"4.0"
"4.1"
"5.0"
"5.1"
...
"SPDIF digital output."

So, if someone set it to "2.0", it would remove any mixer controls that 
controlled the rear and center_lfe channels.
I expect that will be best done in user space with the lisp .conf files 
when they are ready.

> 
> 
>>The "Audigy Analog/Digital Output Jack" being an on/off switch was 
>>confusing, because it was not clear to a casual user what [off] meant. 
>>Does that mean "Analog off", or "Digital off".
> 
> 
> Yes.
> 
> 
> Takashi
> 
> 

I attach a new patch for the current CVS.
My CVS is delayed with respect to yours, so your latest MODULE... 
changes are not included, so the patch might fail.

I still need to implement your suggestion for moving the periods list to 
card DMA, instead of using the substream DMA buffer.

Cheers
James

--------------060004070200040905050709
Content-Type: text/plain;
 name="audigyls1.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigyls1.diff.txt"

Index: alsa-driver/pci/emu10k1/audigyls.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/audigyls.c,v
retrieving revision 1.4
diff -u -r1.4 audigyls.c
--- alsa-driver/pci/emu10k1/audigyls.c	29 Jun 2004 16:16:29 -0000	1.4
+++ alsa-driver/pci/emu10k1/audigyls.c	1 Jul 2004 12:14:16 -0000
@@ -1,6 +1,7 @@
 /*
  *  Copyright (c) by James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver AUDIGYLS chips
+ *  Version: 0.5
  *
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
@@ -17,16 +18,37 @@
  *      So, to record from the MIC, set the MIC Playback volume to max,
  *      unmute the MIC and turn up the MASTER Playback volume.
  *      So, to prevent feedback when capturing, minimise the "Capture feedback into Playback" volume.
- *      The Digital/Analog switch must be in Analog mode for CAPTURE.
+ *   
+ *    The only playback controls that currently do anything are: -
+ *    Analog Front
+ *    Analog Rear
+ *    Analog Center/LFE
+ *    SPDIF Front
+ *    SPDIF Rear
+ *    SPDIF Center/LFE
+ *   
+ *    For capture from Mic in or Line in.
+ *    (The AudigyLS uses the AC97 playback channel for capture. The AC97 capture channel is not used at all.)
+ *    Master
+ *    Mic  (The one marked as playback)
+ *    Mic boost
+ *    Line (The one marked as playback)
+ *    Digital/Analog ( switch must be in Analog mode for CAPTURE. )
+ *    CAPTURE feedback into PLAYBACK
+ * 
+ *    Changelog:
+ *    Support interrupts per period.
+ *    Removed noise from Center/LFE channel when in Analog mode.
+ *    Rename and remove mixer controls.
+ *    
  *
  *  BUGS:
  *    Some stability problems when unloading the snd-audigyls kernel module.
  *    --
  *
  *  TODO:
- *    Need to add a way to select capture source.
+ *    Playback period list using card based DMA instead of top bit of substream DMA.
  *    4 Capture channels, only one implemented so far.
- *    Need to find out what the AC97 chip actually does.
  *    Other rates apart from 48khz not implemented.
  *    MIDI
  *    --
@@ -111,6 +133,7 @@
 #define INTE_CH_0_HALF_LOOP     0x00000100      /* Channel 0 half loop                          */
 #define INTE_TIMER              0x00000008      /* Interrupt based on Timer                     */
 
+#define UNKNOWN14		0x10		/* Unknown ??. Defaults to 0 */
 #define HCFG			0x14		/* Hardware config register			*/
 
 #define HCFG_LOCKSOUNDCACHE	0x00000008	/* 1 = Cancel bustmaster accesses to soundcache */
@@ -118,19 +141,28 @@
 #define HCFG_AUDIOENABLE	0x00000001	/* 0 = CODECs transmit zero-valued samples	*/
 						/* Should be set to 1 when the EMU10K1 is	*/
 						/* completely initialized.			*/
+#define GPIO			0x18		/* Defaults: 005f03a3-Analog, 005f02a2-SPDIF.   */
+#define AC97DATA		0x1c		/* AC97 register set data register (16 bit)	*/
+
+#define AC97ADDRESS		0x1e		/* AC97 register set address register (8 bit)	*/
 
 /********************************************************************************************************/
 /* Audigy LS pointer-offset register set, accessed through the PTR and DATA registers                     */
 /********************************************************************************************************/
                                                                                                                            
 /* Initally all registers from 0x00 to 0x3f have zero contents. */
-#define PLAYBACK_UNKNOWN0	0x00		/* Something used in playback */
-#define PLAYBACK_UNKNOWN1	0x01		/* Something used in playback */
-#define PLAYBACK_UNKNOWN2	0x02		/* Something used in playback */
-#define PLAYBACK_UNKNOWN3	0x03		/* Something ?? */
+#define PLAYBACK_LIST_ADDR	0x00		/* Base DMA address of a list of pointers to each period/size */
+						/* One list entry: 4 bytes for DMA address, 
+						 * 4 bytes for period_size << 16.
+						 * One list entry is 8 bytes long.
+						 * One list entry for each period in the buffer.
+						 */
+#define PLAYBACK_LIST_SIZE	0x01		/* Size of list in bytes << 16. E.g. 8 periods -> 0x00380000  */
+#define PLAYBACK_LIST_PTR	0x02		/* Pointer to the current period being played */
+#define PLAYBACK_UNKNOWN3	0x03		/* Not used ?? */
 #define PLAYBACK_DMA_ADDR	0x04		/* Playback DMA addresss */
-#define PLAYBACK_BUFFER_SIZE	0x05		/* Playback buffer size. win2000 uses 0x04000000 */
-#define PLAYBACK_POINTER	0x06		/* Playback buffer pointer. Sample currently in DAC */
+#define PLAYBACK_PERIOD_SIZE	0x05		/* Playback period size. win2000 uses 0x04000000 */
+#define PLAYBACK_POINTER	0x06		/* Playback period pointer. Used with PLAYBACK_LIST_PTR to determine buffer position currently in DAC */
 #define PLAYBACK_UNKNOWN7	0x07		/* Something used in playback */
 #define PLAYBACK_UNKNOWN8	0x08		/* Something used in playback */
 #define PLAYBACK_UNKNOWN9	0x09		/* Something ?? */
@@ -138,10 +170,7 @@
 #define CAPTURE_BUFFER_SIZE	0x11		/* Capture buffer size */
 #define CAPTURE_POINTER		0x12		/* Capture buffer pointer. Sample currently in ADC */
 #define CAPTURE_UNKNOWN13	0x13		/* Something used in capture */
-#define AC97DATA		0x1c		/* AC97 register set data register (16 bit)	*/
-
-#define AC97ADDRESS		0x1e		/* AC97 register set address register (8 bit)	*/
-#define PLAYBACk_LAST_SAMPLE    0x20		/* The sample currently being played */
+#define PLAYBACK_LAST_SAMPLE    0x20		/* The sample currently being played */
 /* 0x21 - 0x3f unused */
 #define BASIC_INTERRUPT         0x40		/* Used by both playback and capture interrupt handler */
 						/* Playback (0x1<<channel_id) */
@@ -193,6 +222,12 @@
 						/* 0x100 - Front, 0x800 - Rear, 0x200 - Center/LFE.
 						 * But as the jack is shared, use 0xf00.
 						 * The Windows2000 driver uses 0x0000000f for both digital and analog.
+						 * 0xf00 introduces interesting noises onto the Center/LFE.
+						 * If you turn the volume up, you hear computer noise,
+						 * e.g. mouse moving, changing between app windows etc.
+						 * So, I am going to set this to 0x0000000f all the time now,
+						 * same as the windows driver does.
+						 * Use register SPDIF_SELECT2(0x72) to switch between SPDIF and Analog.
 						 */
 #define CAPTURE_SOURCE          0x60            /* Capture Source 0 = MIC */
 #define CAPTURE_SOURCE_CHANNEL0 0xf0000000	/* Mask for selecting the Capture sources */
@@ -246,6 +281,10 @@
 #define PCM_REAR_CHANNEL 1
 #define PCM_CENTER_LFE_CHANNEL 2
 #define PCM_UNKNOWN_CHANNEL 3
+#define CONTROL_FRONT_CHANNEL 0
+#define CONTROL_REAR_CHANNEL 3
+#define CONTROL_CENTER_LFE_CHANNEL 1
+#define CONTROL_UNKNOWN_CHANNEL 2
 
 typedef struct snd_audigyls_voice audigyls_voice_t;
 typedef struct snd_audigyls_channel audigyls_channel_t;
@@ -301,7 +340,8 @@
 	audigyls_channel_t channels[4];
 	audigyls_channel_t capture_channel;
 	u32 spdif_bits[4];             /* s/pdif out setup */
-	int digital_analog;
+	int spdif_enable;
+	int capture_source;
 
 	struct snd_dma_device dma_dev;
 	struct snd_dma_buffer buffer;
@@ -320,8 +360,8 @@
 	.rates =		SNDRV_PCM_RATE_48000,
 	.rate_min =		48000,
 	.rate_max =		48000,
-	.channels_min =		1,
-	.channels_max =		6,
+	.channels_min =		2,  //1,
+	.channels_max =		2,  //6,
 	.buffer_bytes_max =	(32*1024),
 	.period_bytes_min =	64,
 	.period_bytes_max =	(16*1024),
@@ -644,18 +684,26 @@
 {
 	audigyls_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
+	u32 *table_base = (u32 *)(runtime->dma_area+(32*1024));
 	audigyls_pcm_t *epcm = runtime->private_data;
-	int voice = epcm->voice->number;
-        voice=epcm->channel_id;
+	int voice = voice=epcm->channel_id;
+	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
+	int i;
 	
-        //printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
-	snd_audigyls_ptr_write(emu, 0x00, voice, 0);
-	snd_audigyls_ptr_write(emu, 0x01, voice, 0);
-	snd_audigyls_ptr_write(emu, 0x02, voice, 0);
+        //snd_printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
+        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
+        for(i=0; i < runtime->periods; i++) {
+		table_base[i*2]=runtime->dma_addr+(i*period_size_bytes);
+		table_base[(i*2)+1]=period_size_bytes<<16;
+	}
+ 
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_ADDR, voice, runtime->dma_addr + (32*1024));
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_SIZE, voice, (runtime->periods - 1) << 19);
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_PTR, voice, 0);
 	snd_audigyls_ptr_write(emu, PLAYBACK_DMA_ADDR, voice, runtime->dma_addr);
-	snd_audigyls_ptr_write(emu, PLAYBACK_BUFFER_SIZE, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
+	snd_audigyls_ptr_write(emu, PLAYBACK_PERIOD_SIZE, voice, frames_to_bytes(runtime, runtime->period_size)<<16); // buffer size in bytes
 	snd_audigyls_ptr_write(emu, PLAYBACK_POINTER, voice, 0);
-	snd_audigyls_ptr_write(emu, 0x07, voice, 0);
+	snd_audigyls_ptr_write(emu, 0x07, voice, 0x0);
 	snd_audigyls_ptr_write(emu, 0x08, voice, 0);
         snd_audigyls_ptr_write(emu, PLAYBACK_MUTE, 0x0, 0x0); /* Unmute output */
 #if 0
@@ -756,15 +804,19 @@
 	audigyls_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	audigyls_pcm_t *epcm = runtime->private_data;
-	snd_pcm_uframes_t ptr, ptr1, ptr2 = 0;
+	snd_pcm_uframes_t ptr, ptr1, ptr2,ptr3,ptr4 = 0;
 	int channel = epcm->voice->number;
         channel=epcm->channel_id;
 
 	if (!epcm->running)
 		return 0;
 
+	ptr3 = snd_audigyls_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
 	ptr1 = snd_audigyls_ptr_read(emu, PLAYBACK_POINTER, channel);
+	ptr4 = snd_audigyls_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
+	if (ptr3 != ptr4) ptr1 = snd_audigyls_ptr_read(emu, PLAYBACK_POINTER, channel);
 	ptr2 = bytes_to_frames(runtime, ptr1);
+	ptr2+= (ptr4 >> 3) * runtime->period_size;
 	ptr=ptr2;
         if (ptr >= runtime->buffer_size)
 		ptr -= runtime->buffer_size;
@@ -905,7 +957,8 @@
 		snd_audigyls_ptr_write(chip, EXTENDED_INT_MASK, 0, 0);
 		udelay(1000);
 		// disable audio
-		outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
+		//outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
+		outl(0, chip->port + HCFG);
 		/* FIXME: We need to stop and DMA transfers here.
 		 *        But as I am not sure how yet, we cannot from the dma pages.
 		 * So we can fix: snd-malloc: Memory leak?  pages not freed = 8
@@ -957,7 +1010,7 @@
 		return IRQ_NONE;
 
 	//printk(KERN_INFO "interrupt status = %08x, chip=%p, channel=%p\n", status,chip, chip->channels);
-        stat76 = snd_audigyls_ptr_read(chip, 0x76, 0);
+        stat76 = snd_audigyls_ptr_read(chip, EXTENDED_INT, 0);
 	//mask = IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP;
         mask = 0x11; /* 0x1 for one half, 0x10 for the other half period. */
 	for(i = 0; i < 4; i++) {
@@ -981,7 +1034,7 @@
                 }
         }
 
-        snd_audigyls_ptr_write(chip, 0x76, 0, stat76);
+        snd_audigyls_ptr_write(chip, EXTENDED_INT, 0, stat76);
 	spin_lock(&chip->emu_lock);
 	// acknowledge the interrupt if necessary
 	outl(status, chip->port+IPR);
@@ -1041,7 +1094,7 @@
 		if ((err = snd_pcm_lib_preallocate_pages(substream, 
 							 SNDRV_DMA_TYPE_DEV, 
 							 snd_dma_pci_data(emu->pci), 
-							 32*1024, 32*1024)) < 0)
+							 64*1024, 64*1024)) < 0) /* FIXME: 32*1024 for sound buffer, between 32and64 for Periods table. */
 			return err;
 	}
 
@@ -1192,12 +1245,13 @@
 	//snd_audigyls_ptr_write(chip, SPDIF_SELECT2, 0, 0xf0f003f); /* OSS drivers set this. */
 	/* Analog or Digital output */
 	snd_audigyls_ptr_write(chip, SPDIF_SELECT1, 0, 0xf);
-	snd_audigyls_ptr_write(chip, SPDIF_SELECT2, 0, 0x0b000000); /* 0x000b0000 for analog, from win2000 drivers */
-	chip->digital_analog = 0; /* Set digital SPDIF output on */
+	snd_audigyls_ptr_write(chip, SPDIF_SELECT2, 0, 0x000b0000); /* 0x0b000000 for digital, 0x000b0000 for analog, from win2000 drivers */
+	chip->spdif_enable = 0; /* Set digital SPDIF output off */
+	chip->capture_source = 3; /* Set CAPTURE_SOURCE */
 	//snd_audigyls_ptr_write(chip, 0x45, 0, 0); /* Analogue out */
 	//snd_audigyls_ptr_write(chip, 0x45, 0, 0xf00); /* Digital out */
 
-	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 0, 0x40c80000); /* goes to 0x40c81000 when not doing SPDIF IN/OUT */
+	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 0, 0x40c81000); /* goes to 0x40c80000 when doing SPDIF IN/OUT */
 	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 1, 0xffffffff); /* (Mute) CAPTURE feedback into PLAYBACK volume. Only lower 16 bits matter. */
 	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 2, 0x30300000); /* SPDIF IN Volume */
 	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 3, 0x00700000); /* SPDIF IN Volume, 0x70 = (vol & 0x3f) | 0x40 */
@@ -1208,16 +1262,20 @@
 	for(ch = 0; ch < 4; ch++) {
 		snd_audigyls_ptr_write(chip, CAPTURE_VOLUME1, ch, 0x30303030); /* Only high 16 bits matter */
 		snd_audigyls_ptr_write(chip, CAPTURE_VOLUME2, ch, 0x30303030);
-		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0x30303030);
-		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0x30303030);
+		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0xffffffff); /* Mute */
+		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0xffffffff); /* Mute */
 	}
         snd_audigyls_ptr_write(chip, CAPTURE_SOURCE, 0x0, 0x333300e4); /* Select MIC, Line in, TAD in, AUX in */
+	chip->capture_source = 3; /* Set CAPTURE_SOURCE */
 
-	outl(0, chip->port+0x18);
-	snd_audigyls_intr_enable(chip, 0x105);
-
-	outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
+	//outl(0, chip->port+GPIO);
+	outl(0x005f03a3, chip->port+GPIO); /* Analog */
+	//outl(0x005f02a2, chip->port+GPIO);   /* SPDIF */
+	snd_audigyls_intr_enable(chip, 0x105); /* Win2000 uses 0x1e0 */
 
+	//outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
+	outl(0x00001409, chip->port+HCFG);
+	
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
 				  chip, &ops)) < 0) {
 		snd_audigyls_free(chip);
@@ -1349,14 +1407,10 @@
 
 static int snd_audigyls_shared_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	static char *texts[2] = { "Digital", "Analog " };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-                uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
 	return 0;
 }
 
@@ -1365,7 +1419,7 @@
 {
 	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.enumerated.item[0] = emu->digital_analog;
+	ucontrol->value.enumerated.item[0] = emu->spdif_enable;
 	return 0;
 }
 
@@ -1375,23 +1429,29 @@
 	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
 	int change = 0;
+	u32 mask;
 
 	val = ucontrol->value.enumerated.item[0] ;
-	change = (emu->digital_analog != val);
+	change = (emu->spdif_enable != val);
 	if (change) {
-		emu->digital_analog = val;
-		if (val == 0) {
+		emu->spdif_enable = val;
+		if (val == 1) {
 			/* Digital */
 			snd_audigyls_ptr_write(emu, SPDIF_SELECT1, 0, 0xf);
 			snd_audigyls_ptr_write(emu, SPDIF_SELECT2, 0, 0x0b000000);
 			snd_audigyls_ptr_write(emu, CAPTURE_CONTROL, 0,
 				snd_audigyls_ptr_read(emu, CAPTURE_CONTROL, 0) & ~0x1000);
+			mask = inl(emu->port + GPIO) & ~0x101;
+			outl(mask, emu->port + GPIO);
+
 		} else {
 			/* Analog */
-			snd_audigyls_ptr_write(emu, SPDIF_SELECT1, 0, 0xf00);
+			snd_audigyls_ptr_write(emu, SPDIF_SELECT1, 0, 0xf);
 			snd_audigyls_ptr_write(emu, SPDIF_SELECT2, 0, 0x000b0000);
 			snd_audigyls_ptr_write(emu, CAPTURE_CONTROL, 0,
 				snd_audigyls_ptr_read(emu, CAPTURE_CONTROL, 0) | 0x1000);
+			mask = inl(emu->port + GPIO) | 0x101;
+			outl(mask, emu->port + GPIO);
 		}
 	}
         return change;
@@ -1400,12 +1460,63 @@
 static snd_kcontrol_new_t snd_audigyls_shared_spdif __devinitdata =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name =		"Analog/Digital Output Jack",
+	.name =		"SPDIF Out",
 	.info =		snd_audigyls_shared_spdif_info,
 	.get =		snd_audigyls_shared_spdif_get,
 	.put =		snd_audigyls_shared_spdif_put
 };
 
+static int snd_audigyls_capture_source_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	static char *texts[4] = { "SPDIF      ", "What U Hear", "Unknown    ", "AC97       " };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 4;
+	if (uinfo->value.enumerated.item > 3)
+                uinfo->value.enumerated.item = 3;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_audigyls_capture_source_get(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = emu->capture_source;
+	return 0;
+}
+
+static int snd_audigyls_capture_source_put(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int val;
+	int change = 0;
+	u32 mask;
+	u32 source;
+
+	val = ucontrol->value.enumerated.item[0] ;
+	change = (emu->capture_source != val);
+	if (change) {
+		emu->capture_source = val;
+		source = (val << 28) | (val << 24) | (val << 20) | (val << 16);
+		mask = snd_audigyls_ptr_read(emu, CAPTURE_SOURCE, 0) & 0xffff;
+		snd_audigyls_ptr_write(emu, CAPTURE_SOURCE, 0, source | mask);
+	}
+        return change;
+}
+
+static snd_kcontrol_new_t snd_audigyls_capture_source __devinitdata =
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Capture Source",
+	.info =		snd_audigyls_capture_source_info,
+	.get =		snd_audigyls_capture_source_get,
+	.put =		snd_audigyls_capture_source_put
+};
+
 static int snd_audigyls_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
@@ -1476,7 +1587,7 @@
         .put =          snd_audigyls_spdif_put
 };
 
-static int snd_audigyls_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo, int channel_id)
+static int snd_audigyls_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
         uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
         uinfo->count = 2;
@@ -1484,31 +1595,6 @@
         uinfo->value.integer.max = 255;
         return 0;
 }
-static int snd_audigyls_volume_info_front(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = PCM_FRONT_CHANNEL;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
-static int snd_audigyls_volume_info_center_lfe(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = PCM_CENTER_LFE_CHANNEL;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
-static int snd_audigyls_volume_info_unknown(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = PCM_UNKNOWN_CHANNEL;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
-static int snd_audigyls_volume_info_rear(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = PCM_REAR_CHANNEL;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
-static int snd_audigyls_volume_info_feedback(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = 1;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
 
 static int snd_audigyls_volume_get(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol, int reg, int channel_id)
@@ -1522,35 +1608,65 @@
         return 0;
 }
 
-static int snd_audigyls_volume_get_front(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_get_spdif_front(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_FRONT_CHANNEL;
+	int channel_id = CONTROL_FRONT_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
 
-static int snd_audigyls_volume_get_center_lfe(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_get_spdif_center_lfe(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_CENTER_LFE_CHANNEL;
+	int channel_id = CONTROL_CENTER_LFE_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_get_unknown(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_get_spdif_unknown(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_UNKNOWN_CHANNEL;
+	int channel_id = CONTROL_UNKNOWN_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_get_rear(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_get_spdif_rear(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_REAR_CHANNEL;
+	int channel_id = CONTROL_REAR_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
+static int snd_audigyls_volume_get_analog_front(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_FRONT_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+
+static int snd_audigyls_volume_get_analog_center_lfe(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_CENTER_LFE_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_get_analog_unknown(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_UNKNOWN_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_get_analog_rear(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_REAR_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+
 static int snd_audigyls_volume_get_feedback(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
@@ -1571,34 +1687,63 @@
         snd_audigyls_ptr_write(emu, reg, channel_id, value);
         return 1;
 }
-static int snd_audigyls_volume_put_front(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_put_spdif_front(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_FRONT_CHANNEL;
+	int channel_id = CONTROL_FRONT_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_put_center_lfe(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_put_spdif_center_lfe(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_CENTER_LFE_CHANNEL;
+	int channel_id = CONTROL_CENTER_LFE_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_put_unknown(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_put_spdif_unknown(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_UNKNOWN_CHANNEL;
+	int channel_id = CONTROL_UNKNOWN_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_put_rear(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_put_spdif_rear(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_REAR_CHANNEL;
+	int channel_id = CONTROL_REAR_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
+static int snd_audigyls_volume_put_analog_front(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_FRONT_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_put_analog_center_lfe(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_CENTER_LFE_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_put_analog_unknown(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_UNKNOWN_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_put_analog_rear(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_REAR_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+
 static int snd_audigyls_volume_put_feedback(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
@@ -1607,43 +1752,76 @@
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
 
-static snd_kcontrol_new_t snd_audigyls_volume_control_front =
+static snd_kcontrol_new_t snd_audigyls_volume_control_analog_front =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "Analog Front Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_analog_front,
+        .put =          snd_audigyls_volume_put_analog_front
+};
+static snd_kcontrol_new_t snd_audigyls_volume_control_analog_center_lfe =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "Analog Center/LFE Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_analog_center_lfe,
+        .put =          snd_audigyls_volume_put_analog_center_lfe
+};
+static snd_kcontrol_new_t snd_audigyls_volume_control_analog_unknown =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "Analog Unknown Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_analog_unknown,
+        .put =          snd_audigyls_volume_put_analog_unknown
+};
+static snd_kcontrol_new_t snd_audigyls_volume_control_analog_rear =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "PCM Front Volume",
-        .info =         snd_audigyls_volume_info_front,
-        .get =          snd_audigyls_volume_get_front,
-        .put =          snd_audigyls_volume_put_front
+        .name =         "Analog Rear Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_analog_rear,
+        .put =          snd_audigyls_volume_put_analog_rear
 };
-static snd_kcontrol_new_t snd_audigyls_volume_control_center_lfe =
+static snd_kcontrol_new_t snd_audigyls_volume_control_spdif_front =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "PCM Center/LFE Volume",
-        .info =         snd_audigyls_volume_info_center_lfe,
-        .get =          snd_audigyls_volume_get_center_lfe,
-        .put =          snd_audigyls_volume_put_center_lfe
+        .name =         "SPDIF Front Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_spdif_front,
+        .put =          snd_audigyls_volume_put_spdif_front
 };
-static snd_kcontrol_new_t snd_audigyls_volume_control_unknown =
+static snd_kcontrol_new_t snd_audigyls_volume_control_spdif_center_lfe =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "PCM Unknown Volume",
-        .info =         snd_audigyls_volume_info_unknown,
-        .get =          snd_audigyls_volume_get_unknown,
-        .put =          snd_audigyls_volume_put_unknown
+        .name =         "SPDIF Center/LFE Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_spdif_center_lfe,
+        .put =          snd_audigyls_volume_put_spdif_center_lfe
 };
-static snd_kcontrol_new_t snd_audigyls_volume_control_rear =
+static snd_kcontrol_new_t snd_audigyls_volume_control_spdif_unknown =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "PCM Rear Volume",
-        .info =         snd_audigyls_volume_info_rear,
-        .get =          snd_audigyls_volume_get_rear,
-        .put =          snd_audigyls_volume_put_rear
+        .name =         "SPDIF Unknown Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_spdif_unknown,
+        .put =          snd_audigyls_volume_put_spdif_unknown
 };
+static snd_kcontrol_new_t snd_audigyls_volume_control_spdif_rear =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "SPDIF Rear Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_spdif_rear,
+        .put =          snd_audigyls_volume_put_spdif_rear
+};
+
 static snd_kcontrol_new_t snd_audigyls_volume_control_feedback =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
         .name =         "CAPTURE feedback into PLAYBACK",
-        .info =         snd_audigyls_volume_info_feedback,
+        .info =         snd_audigyls_volume_info,
         .get =          snd_audigyls_volume_get_feedback,
         .put =          snd_audigyls_volume_put_feedback
 };
@@ -1668,7 +1846,6 @@
 	return snd_ctl_find_id(card, &sid);
 }
 
-#if 0
 static int rename_ctl(snd_card_t *card, const char *src, const char *dst)
 {
 	snd_kcontrol_t *kctl = ctl_find(card, src);
@@ -1678,26 +1855,76 @@
 	}
 	return -ENOENT;
 }
-#endif
 
 static int __devinit snd_audigyls_mixer(audigyls_t *emu)
 {
         int err;
         snd_kcontrol_t *kctl;
         snd_card_t *card = emu->card;
-        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_front, emu)) == NULL)
+#if 1
+	remove_ctl(card, "Master Mono Playback Switch");
+	remove_ctl(card, "Master Mono Playback Volume");
+	remove_ctl(card, "3D Control - Switch");
+	remove_ctl(card, "3D Control Sigmatel - Depth");
+	remove_ctl(card, "PCM Playback Switch");
+	remove_ctl(card, "PCM Playback Volume");
+	remove_ctl(card, "CD Playback Switch");
+	remove_ctl(card, "CD Playback Volume");
+	remove_ctl(card, "Phone Playback Switch");
+	remove_ctl(card, "Phone Playback Volume");
+	remove_ctl(card, "Video Playback Switch");
+	remove_ctl(card, "Video Playback Volume");
+	remove_ctl(card, "PC Speaker Playback Switch");
+	remove_ctl(card, "PC Speaker Playback Volume");
+	remove_ctl(card, "Mono Output Select");
+	remove_ctl(card, "Capture Source");
+	remove_ctl(card, "Capture Switch");
+	remove_ctl(card, "Capture Volume");
+	remove_ctl(card, "External Amplifier");
+	remove_ctl(card, "Sigmatel 4-Speaker Stereo Playback Switch");
+	remove_ctl(card, "Sigmatel Surround Phase Inversion Playback ");
+	rename_ctl(card, "Master Playback Switch", "Capture Switch");
+	rename_ctl(card, "Master Playback Volume", "Capture Volume");
+	rename_ctl(card, "Line Playback Switch", "AC97 Line Capture Switch");
+	rename_ctl(card, "Line Playback Volume", "AC97 Line Capture Volume");
+	rename_ctl(card, "Aux Playback Switch", "AC97 Aux Capture Switch");
+	rename_ctl(card, "Aux Playback Volume", "AC97 Aux Capture Volume");
+	rename_ctl(card, "Mic Playback Switch", "AC97 Mic Capture Switch");
+	rename_ctl(card, "Mic Playback Volume", "AC97 Mic Capture Volume");
+	rename_ctl(card, "Mic Select", "AC97 Mic Select");
+	rename_ctl(card, "Mic Boost (+20dB)", "AC97 Mic Boost (+20dB)");
+	//rename_ctl(card, "", "");
+#endif
+
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_analog_front, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_analog_rear, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_analog_center_lfe, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_analog_unknown, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_spdif_front, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_rear, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_spdif_rear, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_center_lfe, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_spdif_center_lfe, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_unknown, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_spdif_unknown, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
@@ -1713,6 +1940,10 @@
 		return -ENOMEM;
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
+	if ((kctl = snd_ctl_new1(&snd_audigyls_capture_source, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
 	if ((kctl = ctl_find(card, SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT))) != NULL) {
 		/* already defined by ac97, remove it */
 		/* FIXME: or do we need both controls? */

--------------060004070200040905050709--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
