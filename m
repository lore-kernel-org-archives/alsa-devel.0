From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx Phase reversal fixes and some AC3 pass through progress
Date: Mon, 09 Dec 2002 01:12:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF3DFD9.2060002@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050605010208070708020902"
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

This is a multi-part message in MIME format.
--------------050605010208070708020902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

In this patch the phase problems should be gone, if still think that you 
got "phase reversal" problem
please sendme a dump of the /proc/asound/card0/dsp/sample content while 
you are playbacking
whatever giving you "phase reversal" problem.

On the AC3 front I've managed to get my receiver to switch on to 
"Digital Surround" mode (instead of PCM), which
must mean that it finally detected the AC3 stream. But still no sound, 
 got no idea why, but please if you
have time give it a test.

Consider this patch as "experimental", just in the mean, dont be 
surprised if something that worked
OK before is now broken.

Summar of changes:
- Phase reversal fixes.
- Some rewrites on playback code, related to the sample rate setup.
- AC3 stuff ....

/Benny

--------------050605010208070708020902
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=CVS -Naur alsa-kernel/include/cs46xx.h ../cvs/alsa-kernel/include/cs46xx.h
--- alsa-kernel/include/cs46xx.h	Mon Nov  4 10:57:10 2002
+++ ../cvs/alsa-kernel/include/cs46xx.h	Sun Dec  8 19:03:27 2002
@@ -1663,6 +1663,8 @@
 	snd_pcm_substream_t *substream;
 
 	pcm_channel_descriptor_t * pcm_channel;
+
+	int pcm_channel_id;    /* Fron Rear, Center Lfe  ... */
 } cs46xx_pcm_t;
 
 typedef struct {
diff --exclude=CVS -Naur alsa-kernel/include/cs46xx_dsp_spos.h ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h
--- alsa-kernel/include/cs46xx_dsp_spos.h	Sun Dec  8 13:21:47 2002
+++ ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h	Sun Dec  8 19:04:51 2002
@@ -140,7 +140,6 @@
 	dsp_scb_descriptor_t * pcm_reader_scb;
 	dsp_scb_descriptor_t * src_scb;
 	dsp_scb_descriptor_t * mixer_scb;
-	int pcm_channel_id;
 
 	void * private_data;
 } pcm_channel_descriptor_t;
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Dec  8 13:21:55 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Dec  8 20:29:22 2002
@@ -952,7 +952,7 @@
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 		/* magic value to unmute PCM stream  playback volume */
 		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 
-				       SCBVolumeCtrl) << 2, 0x80007fff);
+				       SCBVolumeCtrl) << 2, 0x80008000);
 
 		if (cpcm->pcm_channel->unlinked)
 			cs46xx_dsp_pcm_link(chip,cpcm->pcm_channel);
@@ -1032,32 +1032,27 @@
 static int _cs46xx_adjust_sample_rate (cs46xx_t *chip, cs46xx_pcm_t *cpcm,
 				       int sample_rate) 
 {
-	/* if this is the only PCMReaderSCB child under current
-	   SrcTask then there no need to re-create pcm-channel */
-	if ( cpcm->pcm_channel->src_scb->ref_count == 1 &&
-	     cpcm->pcm_channel->sample_rate != sample_rate &&
-	     /* never set a 0 khz sample rate */
-	     sample_rate) {
-		/* sample rate not set or we can reuse
-		   the same SRC*/
-		cs46xx_dsp_set_src_sample_rate (chip,cpcm->pcm_channel->src_scb,sample_rate);
-		cpcm->pcm_channel->sample_rate = sample_rate;
-	} 
 
-	/* if there is more then 1 PCMReaderSCB child's under current
-	   SrcTask then we must recreate channel */
-	if (cpcm->pcm_channel->sample_rate != sample_rate &&
-	    cpcm->pcm_channel->src_scb->ref_count != 1 &&
-	    /* never set a 0 khz sample rate */
-	    sample_rate) {
+	/* If PCMReaderSCB and SrcTaskSCB not created yet ... */
+	if ( cpcm->pcm_channel == NULL) {
+		cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, sample_rate, 
+								   cpcm, cpcm->hw_addr,cpcm->pcm_channel_id);
+		if (cpcm->pcm_channel == NULL) {
+			snd_printk(KERN_ERR "cs46xx: failed to create virtual PCM channel\n");
+			return -ENOMEM;
+		}
+		cpcm->pcm_channel->sample_rate = sample_rate;
+	} else
+	/* if sample rate is changed */
+	if (cpcm->pcm_channel->sample_rate != sample_rate) {
 		int unlinked = cpcm->pcm_channel->unlinked;
 		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
 
 		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, sample_rate, cpcm, 
 									 cpcm->hw_addr,
-									 cpcm->pcm_channel->pcm_channel_id)) == NULL) {
+									 cpcm->pcm_channel_id)) == NULL) {
 			snd_printk(KERN_ERR "cs46xx: failed to re-create virtual PCM channel\n");
-			return -ENXIO;
+			return -ENOMEM;
 		}
 
 		if (!unlinked) cs46xx_dsp_pcm_link (chip,cpcm->pcm_channel);
@@ -1082,15 +1077,21 @@
 	cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -ENXIO);
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
+	snd_assert (sample_rate != 0, return -ENXIO);
+
 	down (&chip->spos_mutex);
 
-	snd_assert (cpcm->pcm_channel != NULL);
-	
 	if (_cs46xx_adjust_sample_rate (chip,cpcm,sample_rate)) {
 		up (&chip->spos_mutex);
 		return -ENXIO;
 	}
 
+	snd_assert (cpcm->pcm_channel != NULL);
+	if (!cpcm->pcm_channel) {
+		up (&chip->spos_mutex);
+		return -ENXIO;
+	}
+
 	if (cs46xx_dsp_pcm_channel_set_period (chip,cpcm->pcm_channel,period_size * 4)) {
 		 up (&chip->spos_mutex);
 		 return -EINVAL;
@@ -1108,11 +1109,11 @@
 
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-		if (cpcm->pcm_channel->pcm_channel_id == DSP_PCM_MAIN_CHANNEL) {
+		if (cpcm->pcm_channel_id == DSP_PCM_MAIN_CHANNEL) {
 			substream->ops = &snd_cs46xx_playback_ops;
-		} else if (cpcm->pcm_channel->pcm_channel_id == DSP_PCM_REAR_CHANNEL) {
+		} else if (cpcm->pcm_channel_id == DSP_PCM_REAR_CHANNEL) {
 			substream->ops = &snd_cs46xx_playback_rear_ops;
-		} else if (cpcm->pcm_channel->pcm_channel_id == DSP_IEC958_CHANNEL) {
+		} else if (cpcm->pcm_channel_id == DSP_IEC958_CHANNEL) {
 			substream->ops = &snd_cs46xx_playback_iec958_ops;
 		} else {
 			snd_assert(0);
@@ -1135,11 +1136,11 @@
 		}
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-		if (cpcm->pcm_channel->pcm_channel_id == DSP_PCM_MAIN_CHANNEL) {
+		if (cpcm->pcm_channel_id == DSP_PCM_MAIN_CHANNEL) {
 			substream->ops = &snd_cs46xx_playback_indirect_ops;
-		} else if (cpcm->pcm_channel->pcm_channel_id == DSP_PCM_REAR_CHANNEL) {
+		} else if (cpcm->pcm_channel_id == DSP_PCM_REAR_CHANNEL) {
 			substream->ops = &snd_cs46xx_playback_indirect_rear_ops;
-		} else if (cpcm->pcm_channel->pcm_channel_id == DSP_IEC958_CHANNEL) {
+		} else if (cpcm->pcm_channel_id == DSP_IEC958_CHANNEL) {
 			substream->ops = &snd_cs46xx_playback_indirect_iec958_ops;
 		} else {
 			snd_assert(0);
@@ -1165,6 +1166,10 @@
 
 	cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -ENXIO);
 
+	/* if play_back open fails, then this function
+	   is called and cpcm can actually be NULL here */
+	if (!cpcm) return -ENXIO;
+
 	if (runtime->dma_area != cpcm->hw_area)
 		snd_pcm_lib_free_pages(substream);
     
@@ -1482,15 +1487,8 @@
 	cpcm->substream = substream;
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	down (&chip->spos_mutex);
-	cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr,pcm_channel_id);
-
-	if (cpcm->pcm_channel == NULL) {
-		snd_printk(KERN_ERR "cs46xx: failed to create virtual PCM channel\n");
-		snd_free_pci_pages(chip->pci, cpcm->hw_size, cpcm->hw_area, cpcm->hw_addr);
-		snd_magic_kfree(cpcm);
-		up (&chip->spos_mutex);
-		return -ENOMEM;
-	}
+	cpcm->pcm_channel = NULL; 
+	cpcm->pcm_channel_id = pcm_channel_id;
 
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
 				   &hw_constraints_period_sizes);
@@ -1583,6 +1581,9 @@
 
 	cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -ENXIO);
 
+	/* when playback_open fails, then cpcm can be NULL */
+	if (!cpcm) return -ENXIO;
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	down (&chip->spos_mutex);
 	if (cpcm->pcm_channel) {
@@ -1887,8 +1888,8 @@
 {
 	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.integer.value[0] = chip->dsp_spos_instance->dac_volume_right;
-	ucontrol->value.integer.value[1] = chip->dsp_spos_instance->dac_volume_left;
+	ucontrol->value.integer.value[0] = chip->dsp_spos_instance->dac_volume_left;
+	ucontrol->value.integer.value[1] = chip->dsp_spos_instance->dac_volume_right;
 
 	return 0;
 }
@@ -3331,8 +3332,8 @@
 	
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	/* set the attenuation to 0dB */ 
-	snd_cs46xx_poke(chip, (MASTERMIX_SCB_ADDR + 0xE) << 2, 0x80008000); 
-	snd_cs46xx_poke(chip, (VARIDECIMATE_SCB_ADDR + 0xE) << 2, 0x80008000);
+	/* snd_cs46xx_poke(chip, (MASTERMIX_SCB_ADDR + 0xE) << 2, 0x80008000); 
+	   snd_cs46xx_poke(chip, (VARIDECIMATE_SCB_ADDR + 0xE) << 2, 0x80008000); */
 
 	/*
 	 * Initialize cs46xx SPDIF controller
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.h ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h
--- alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sun Dec  8 13:21:55 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sun Dec  8 18:55:22 2002
@@ -152,6 +152,7 @@
                                                         dsp_scb_descriptor_t * parent_scb,
                                                         int scb_child_type);
 dsp_scb_descriptor_t *  cs46xx_dsp_create_src_task_scb(cs46xx_t * chip,char * scb_name,
+						       int sample_rate,
                                                        u16 src_buffer_addr,
                                                        u16 src_delay_buffer_addr,u32 dest,
                                                        dsp_scb_descriptor_t * parent_scb,
@@ -202,8 +203,6 @@
                                                           int pcm_channel_id);
 void                       cs46xx_dsp_destroy_pcm_channel (cs46xx_t * chip,
                                                            pcm_channel_descriptor_t * pcm_channel);
-void                       cs46xx_dsp_set_src_sample_rate(cs46xx_t * chip,dsp_scb_descriptor_t * src, 
-                                                          u32 rate);
 int                        cs46xx_dsp_pcm_unlink (cs46xx_t * chip,pcm_channel_descriptor_t * pcm_channel);
 int                        cs46xx_dsp_pcm_link (cs46xx_t * chip,pcm_channel_descriptor_t * pcm_channel);
 dsp_scb_descriptor_t *     cs46xx_add_record_source (cs46xx_t *chip,dsp_scb_descriptor_t * source,
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Sun Dec  8 13:21:55 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Sun Dec  8 19:08:46 2002
@@ -615,7 +615,7 @@
 	snd_iprintf(buffer,"\nMIX_SAMPLE_BUF1:\n");
 
 	col = 0;
-	for (i = MIX_SAMPLE_BUF1;i < MIX_SAMPLE_BUF1 + 0x30; i += sizeof(u32),col ++) {
+	for (i = MIX_SAMPLE_BUF1;i < MIX_SAMPLE_BUF1 + 0x40; i += sizeof(u32),col ++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -628,14 +628,14 @@
 		snd_iprintf(buffer,"%08X ",readl(dst + i));
 	}
 
-	snd_iprintf(buffer,"\n\n");
+	snd_iprintf(buffer,"\nSRC_TASK_SCB1:\n");
 	col = 0;
-	for (i = SPDIFI_IP_OUTPUT_BUFFER1;i < SPDIFI_IP_OUTPUT_BUFFER1 + 0x40; i += sizeof(u32),col ++) {
+	for (i = 0x2580 ; i < 0x2580 + 0x40 ; i += sizeof(u32),col ++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
 		}
-
+		
 		if (col == 0) {
 			snd_iprintf(buffer, "%04X ",i);
 		}
@@ -646,7 +646,7 @@
 
 	snd_iprintf(buffer,"\nSPDIFO_BUFFER:\n");
 	col = 0;
-	for (i = SPDIFO_IP_OUTPUT_BUFFER1;i < SPDIFO_IP_OUTPUT_BUFFER1 + 0x40; i += sizeof(u32),col ++) {
+	for (i = SPDIFO_IP_OUTPUT_BUFFER1;i < SPDIFO_IP_OUTPUT_BUFFER1 + 0x30; i += sizeof(u32),col ++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -1356,6 +1356,7 @@
 
 	/* SPDIF input sampel rate converter */
 	src_task_scb = cs46xx_dsp_create_src_task_scb(chip,"SrcTaskSCB_SPDIFI",
+						      48000,
 						      SRC_OUTPUT_BUF1,
 						      SRC_DELAY_BUF1,SRCTASK_SCB_ADDR,
 						      master_mix_scb,
@@ -1601,7 +1602,7 @@
 
 	/* set SPDIF input sample rate and unmute
 	   NOTE: only 48khz support for SPDIF input this time */
-	cs46xx_dsp_set_src_sample_rate(chip,ins->spdif_in_src,48000);
+	/* cs46xx_dsp_set_src_sample_rate(chip,ins->spdif_in_src,48000); */
 
 	/* monitor state */
 	ins->spdif_status_in = 1;
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sun Dec  8 13:21:55 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Mon Dec  9 00:49:07 2002
@@ -576,8 +576,11 @@
 	return scb;
 }
 
+#define GOF_PER_SEC 200
+
 dsp_scb_descriptor_t * 
 cs46xx_dsp_create_src_task_scb(cs46xx_t * chip,char * scb_name,
+			       int rate,
                                u16 src_buffer_addr,
                                u16 src_delay_buffer_addr,u32 dest,
                                dsp_scb_descriptor_t * parent_scb,
@@ -586,45 +589,81 @@
 
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 	dsp_scb_descriptor_t * scb;
-    
-	src_task_scb_t src_task_scb = {
-		0x0028,0x00c8,
-		0x5555,0x0000,
-		0x0000,0x0000,
-		src_buffer_addr,1,
-		0x0028,0x00c8,
-		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_32,  
-		0x0000,src_delay_buffer_addr,                  
-		0x0,                                            
-		0x80,(src_delay_buffer_addr + (24 * 4)),
-		0,0, /* next_scb, sub_list_ptr */
-		0,0, /* entry, this_spb */
-		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_8,
-		src_buffer_addr << 0x10,
-		0x04000000,
-		{ 
-			0xffff - ins->dac_volume_right,0xffff - ins->dac_volume_left,
-			0xffff - ins->dac_volume_right,0xffff - ins->dac_volume_left
-		}
-	};
+	unsigned int tmp1, tmp2;
+	unsigned int phiIncr;
+	unsigned int correctionPerGOF, correctionPerSec;
 
-	if (ins->s16_up == NULL) {
-		ins->s16_up =  cs46xx_dsp_lookup_symbol (chip,"S16_UPSRC",
-							 SYMBOL_CODE);
-    
-		if (ins->s16_up == NULL) {
-			snd_printk (KERN_ERR "dsp_spos: symbol S16_UPSRC not found\n");
-			return NULL;
-		}    
-	}
+	snd_printdd( "dsp_spos: setting %s rate to %u\n",scb_name,rate);
 
-	/* clear buffers */
-	_dsp_clear_sample_buffer (chip,src_buffer_addr,8);
-	_dsp_clear_sample_buffer (chip,src_delay_buffer_addr,32);
+	/*
+	 *  Compute the values used to drive the actual sample rate conversion.
+	 *  The following formulas are being computed, using inline assembly
+	 *  since we need to use 64 bit arithmetic to compute the values:
+	 *
+	 *  phiIncr = floor((Fs,in * 2^26) / Fs,out)
+	 *  correctionPerGOF = floor((Fs,in * 2^26 - Fs,out * phiIncr) /
+	 *                                   GOF_PER_SEC)
+	 *  ulCorrectionPerSec = Fs,in * 2^26 - Fs,out * phiIncr -M
+	 *                       GOF_PER_SEC * correctionPerGOF
+	 *
+	 *  i.e.
+	 *
+	 *  phiIncr:other = dividend:remainder((Fs,in * 2^26) / Fs,out)
+	 *  correctionPerGOF:correctionPerSec =
+	 *      dividend:remainder(ulOther / GOF_PER_SEC)
+	 */
+	tmp1 = rate << 16;
+	phiIncr = tmp1 / 48000;
+	tmp1 -= phiIncr * 48000;
+	tmp1 <<= 10;
+	phiIncr <<= 10;
+	tmp2 = tmp1 / 48000;
+	phiIncr += tmp2;
+	tmp1 -= tmp2 * 48000;
+	correctionPerGOF = tmp1 / GOF_PER_SEC;
+	tmp1 -= correctionPerGOF * GOF_PER_SEC;
+	correctionPerSec = tmp1;
 
-	scb = _dsp_create_generic_scb(chip,scb_name,(u32 *)&src_task_scb,
-				      dest,ins->s16_up,parent_scb,
-				      scb_child_type);
+	{
+		src_task_scb_t src_task_scb = {
+			0x0028,0x00c8,
+			0x5555,0x0000,
+			0x0000,0x0000,
+			src_buffer_addr,1,
+			correctionPerGOF,correctionPerSec,
+			RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_32,  
+			0x0000,src_delay_buffer_addr,                  
+			0x0,                                            
+			0x080,(src_delay_buffer_addr + (24 * 4)),
+			0,0, /* next_scb, sub_list_ptr */
+			0,0, /* entry, this_spb */
+			RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_8,
+			src_buffer_addr << 0x10,
+			phiIncr,
+			{ 
+				0xffff - ins->dac_volume_right,0xffff - ins->dac_volume_left,
+				0xffff - ins->dac_volume_right,0xffff - ins->dac_volume_left
+			}
+		};
+		
+		if (ins->s16_up == NULL) {
+			ins->s16_up =  cs46xx_dsp_lookup_symbol (chip,"S16_UPSRC",
+								 SYMBOL_CODE);
+			
+			if (ins->s16_up == NULL) {
+				snd_printk (KERN_ERR "dsp_spos: symbol S16_UPSRC not found\n");
+				return NULL;
+			}    
+		}
+		
+		/* clear buffers */
+		_dsp_clear_sample_buffer (chip,src_buffer_addr,8);
+		_dsp_clear_sample_buffer (chip,src_delay_buffer_addr,32);
+		
+		scb = _dsp_create_generic_scb(chip,scb_name,(u32 *)&src_task_scb,
+					      dest,ins->s16_up,parent_scb,
+					      scb_child_type);
+	}
 
 	return scb;
 }
@@ -796,7 +835,7 @@
 
 		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_16,
 		0,
-		0,input_scb->address, 
+		0,input_scb->address,
 		{
 			0x8000,0x8000,
 			0x8000,0x8000
@@ -1007,7 +1046,7 @@
 		/* C */ snoop_buffer_address  << 0x10,
 		/* D */ 0,
 		/* E */ { 0x8000,0x8000,
-			  /* F */   0xffff,0xffff
+	        /* F */   0xffff,0xffff
 		}
 	};
 
@@ -1093,6 +1132,8 @@
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 	dsp_scb_descriptor_t * src_scb = NULL,* pcm_scb, * mixer_scb = NULL;
+	dsp_scb_descriptor_t * src_parent_scb = NULL;
+
 	/*dsp_scb_descriptor_t * pcm_parent_scb;*/
 	char scb_name[DSP_MAX_SCB_NAME];
 	int i,pcm_index = -1, insert_point, src_index = -1;
@@ -1116,13 +1157,14 @@
 	case DSP_IEC958_CHANNEL:
 		snd_assert (ins->asynch_tx_scb != NULL, return NULL);
 		mixer_scb = ins->asynch_tx_scb;
-#if 0
-		if (ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE) {
-			snd_printdd ("IEC958 opened in AC3 mode\n");
-			/*src_scb = ins->asynch_tx_scb;
-			  ins->asynch_tx_scb->ref_count ++;*/
+
+		/* if sample rate is set to 48khz we pass
+		   the Sample Rate Converted (which could
+		   alter the raw data stream ...) */
+		if (sample_rate == 48000) {
+			snd_printdd ("IEC958 pass through\n");
+			src_parent_scb = ins->asynch_tx_scb;
 		}
-#endif
 		break;
 	default:
 		snd_assert (0);
@@ -1158,8 +1200,6 @@
 	}
 
 	if (src_scb == NULL) {
-		dsp_scb_descriptor_t * src_parent_scb;
-
 		if (ins->nsrc_scb >= DSP_MAX_SRC_NR) {
 			snd_printk(KERN_ERR "dsp_spos: to many SRC instances\n!");
 			return NULL;
@@ -1176,18 +1216,21 @@
 		snd_assert (src_index != -1,return NULL);
 
 		/* we need to create a new SRC SCB */
-		if (mixer_scb->sub_list_ptr == ins->the_null_scb) {
-			src_parent_scb = mixer_scb;
-			insert_point = SCB_ON_PARENT_SUBLIST_SCB;
-		} else {
-			src_parent_scb = find_next_free_scb(chip,mixer_scb->sub_list_ptr);
-			insert_point = SCB_ON_PARENT_NEXT_SCB;
-		}
+		if (src_parent_scb == NULL) {
+			if (mixer_scb->sub_list_ptr == ins->the_null_scb) {
+				src_parent_scb = mixer_scb;
+				insert_point = SCB_ON_PARENT_SUBLIST_SCB;
+			} else {
+				src_parent_scb = find_next_free_scb(chip,mixer_scb->sub_list_ptr);
+				insert_point = SCB_ON_PARENT_NEXT_SCB;
+			}
+		} else insert_point = SCB_ON_PARENT_NEXT_SCB;
 
 		snprintf (scb_name,DSP_MAX_SCB_NAME,"SrcTask_SCB%d",src_index);
 
 		snd_printdd( "dsp_spos: creating SRC \"%s\"\n",scb_name);
 		src_scb = cs46xx_dsp_create_src_task_scb(chip,scb_name,
+							 sample_rate,
 							 src_output_buffer_addr[src_index],
 							 src_delay_buffer_addr[src_index],
 							 /* 0x400 - 0x600 source SCBs */
@@ -1200,7 +1243,7 @@
 			return NULL;
 		}
 
-		cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate);
+		/* cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate); */
 
 		ins->nsrc_scb ++;
 	} 
@@ -1226,6 +1269,19 @@
 		return NULL;
 	}
 
+	if (pcm_channel_id == DSP_IEC958_CHANNEL && sample_rate == 48000) {
+		snd_assert (ins->spdif_pcm_input_scb = NULL);
+
+		/* a hack to make the skip the SRC and pass the stream 
+		   directly to the SPDIF task */
+		ins->spdif_pcm_input_scb = 
+			cs46xx_dsp_create_pcm_serial_input_scb(chip,"PCMSerialInput_PCM",
+							       PCMSERIALINII_SCB_ADDR,
+							       pcm_scb,
+							       ins->asynch_tx_scb,
+							       SCB_ON_PARENT_SUBLIST_SCB);		
+	}
+
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	ins->pcm_channels[pcm_index].sample_rate = sample_rate;
 	ins->pcm_channels[pcm_index].pcm_reader_scb = pcm_scb;
@@ -1236,7 +1292,6 @@
 	ins->pcm_channels[pcm_index].active = 1;
 	ins->pcm_channels[pcm_index].pcm_slot = pcm_index;
 	ins->pcm_channels[pcm_index].mixer_scb = mixer_scb;
-	ins->pcm_channels[pcm_index].pcm_channel_id = pcm_channel_id;
 	ins->npcm_channels ++;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
@@ -1416,59 +1471,6 @@
 	return 0;
 }
 
-
-#define GOF_PER_SEC 200
-  
-void cs46xx_dsp_set_src_sample_rate(cs46xx_t *chip,dsp_scb_descriptor_t * src, u32 rate)
-{
-	unsigned long flags;
-	unsigned int tmp1, tmp2;
-	unsigned int phiIncr;
-	unsigned int correctionPerGOF, correctionPerSec;
-
-	snd_printdd( "dsp_spos: setting SRC rate to %u\n",rate);
-	/*
-	 *  Compute the values used to drive the actual sample rate conversion.
-	 *  The following formulas are being computed, using inline assembly
-	 *  since we need to use 64 bit arithmetic to compute the values:
-	 *
-	 *  phiIncr = floor((Fs,in * 2^26) / Fs,out)
-	 *  correctionPerGOF = floor((Fs,in * 2^26 - Fs,out * phiIncr) /
-	 *                                   GOF_PER_SEC)
-	 *  ulCorrectionPerSec = Fs,in * 2^26 - Fs,out * phiIncr -M
-	 *                       GOF_PER_SEC * correctionPerGOF
-	 *
-	 *  i.e.
-	 *
-	 *  phiIncr:other = dividend:remainder((Fs,in * 2^26) / Fs,out)
-	 *  correctionPerGOF:correctionPerSec =
-	 *      dividend:remainder(ulOther / GOF_PER_SEC)
-	 */
-	tmp1 = rate << 16;
-	phiIncr = tmp1 / 48000;
-	tmp1 -= phiIncr * 48000;
-	tmp1 <<= 10;
-	phiIncr <<= 10;
-	tmp2 = tmp1 / 48000;
-	phiIncr += tmp2;
-	tmp1 -= tmp2 * 48000;
-	correctionPerGOF = tmp1 / GOF_PER_SEC;
-	tmp1 -= correctionPerGOF * GOF_PER_SEC;
-	correctionPerSec = tmp1;
-
-	/*
-	 *  Fill in the SampleRateConverter control block.
-	 */
-	spin_lock_irqsave(&chip->reg_lock, flags);
-
-	snd_cs46xx_poke(chip, (src->address + SRCCorPerGof) << 2,
-	  ((correctionPerSec << 16) & 0xFFFF0000) | (correctionPerGOF & 0xFFFF));
-
-	snd_cs46xx_poke(chip, (src->address + SRCPhiIncr6Int26Frac) << 2, phiIncr);
-
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
-}
-
 dsp_scb_descriptor_t * cs46xx_add_record_source (cs46xx_t *chip,dsp_scb_descriptor_t * source,
                                                  u16 addr,char * scb_name)
 {
@@ -1655,10 +1657,16 @@
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_default);
 	
 	/* deallocate stuff */
+	if (ins->spdif_pcm_input_scb != NULL) {
+		cs46xx_dsp_remove_scb (chip,ins->spdif_pcm_input_scb);
+		ins->spdif_pcm_input_scb = NULL;
+	}
+
 	cs46xx_dsp_remove_scb (chip,ins->asynch_tx_scb);
 	ins->asynch_tx_scb = NULL;
 
 	/* restore state */
+
 	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
 		cs46xx_dsp_enable_spdif_out (chip);
 	}

--------------050605010208070708020902--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
