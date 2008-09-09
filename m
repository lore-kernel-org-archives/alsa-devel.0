From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 21/24] sound/pci: coding style fixes: trident
Date: Tue, 9 Sep 2008 06:01:43 +0400
Message-ID: <20080909020143.GX6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D99110384E
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 04:01:50 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so727234eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 19:01:49 -0700 (PDT)
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

 sound/pci/trident/trident.c        |    4 +-
 sound/pci/trident/trident_main.c   |  478 ++++++++++++++++++------------------
 sound/pci/trident/trident_memory.c |   12 +-
 3 files changed, 247 insertions(+), 247 deletions(-)

diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index d94b16f..11b49f7 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -63,9 +63,9 @@ module_param_array(wavetable_size, int, NULL, 0444);
 MODULE_PARM_DESC(wavetable_size, "Maximum memory size in kB for wavetable synth.");
 
 static struct pci_device_id snd_trident_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_DX), 
+	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_DX),
 		PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, 0},
-	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_NX), 
+	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_NX),
 		0, 0, 0},
 	{PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7018), 0, 0, 0},
 	{ 0, }
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index c612b43..863f34f 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -43,7 +43,7 @@
 #include <sound/trident.h>
 #include <sound/asoundef.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 static int snd_trident_pcm_mixer_build(struct snd_trident *trident,
 				       struct snd_trident_voice * voice,
@@ -87,7 +87,7 @@ static void snd_trident_print_voice_regs(struct snd_trident *trident, int voice)
 		printk("ESO: 0x%x\n", val >> 16);
 		printk("Delta: 0x%x\n", val & 0xffff);
 		val = inl(TRID_REG(trident, CH_DX_FMC_RVOL_CVOL));
-	} else {		// TRIDENT_DEVICE_ID_NX
+	} else {		/* TRIDENT_DEVICE_ID_NX */
 		val = inl(TRID_REG(trident, CH_NX_DELTA_CSO));
 		tmp = (val >> 24) & 0xff;
 		printk("CSO: 0x%x\n", val & 0x00ffffff);
@@ -107,15 +107,15 @@ static void snd_trident_print_voice_regs(struct snd_trident *trident, int voice)
 
 /*---------------------------------------------------------------------------
    unsigned short snd_trident_codec_read(struct snd_ac97 *ac97, unsigned short reg)
-  
+
    Description: This routine will do all of the reading from the external
                 CODEC (AC97).
-  
+
    Parameters:  ac97 - ac97 codec structure
                 reg - CODEC register index, from AC97 Hal.
- 
+
    returns:     16 bit value read from the AC97.
-  
+
   ---------------------------------------------------------------------------*/
 static unsigned short snd_trident_codec_read(struct snd_ac97 *ac97, unsigned short reg)
 {
@@ -167,16 +167,16 @@ static unsigned short snd_trident_codec_read(struct snd_ac97 *ac97, unsigned sho
 /*---------------------------------------------------------------------------
    void snd_trident_codec_write(struct snd_ac97 *ac97, unsigned short reg,
    unsigned short wdata)
-  
+
    Description: This routine will do all of the writing to the external
                 CODEC (AC97).
-  
+
    Parameters:	ac97 - ac97 codec structure
    	        reg - CODEC register index, from AC97 Hal.
                 data  - Lower 16 bits are the data to write to CODEC.
-  
+
    returns:     TRUE if everything went ok, else FALSE.
-  
+
   ---------------------------------------------------------------------------*/
 static void snd_trident_codec_write(struct snd_ac97 *ac97, unsigned short reg,
 				    unsigned short wdata)
@@ -236,14 +236,14 @@ static void snd_trident_codec_write(struct snd_ac97 *ac97, unsigned short reg,
 
 /*---------------------------------------------------------------------------
    void snd_trident_enable_eso(struct snd_trident *trident)
-  
+
    Description: This routine will enable end of loop interrupts.
                 End of loop interrupts will occur when a running
                 channel reaches ESO.
                 Also enables middle of loop interrupts.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_enable_eso(struct snd_trident * trident)
@@ -260,17 +260,17 @@ static void snd_trident_enable_eso(struct snd_trident * trident)
 
 /*---------------------------------------------------------------------------
    void snd_trident_disable_eso(struct snd_trident *trident)
-  
+
    Description: This routine will disable end of loop interrupts.
                 End of loop interrupts will occur when a running
                 channel reaches ESO.
                 Also disables middle of loop interrupts.
-  
-   Parameters:  
+
+   Parameters:
                 trident - pointer to target device class for 4DWave.
-  
+
    returns:     TRUE if everything went ok, else FALSE.
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_disable_eso(struct snd_trident * trident)
@@ -333,13 +333,13 @@ EXPORT_SYMBOL(snd_trident_stop_voice);
 
 /*---------------------------------------------------------------------------
     int snd_trident_allocate_pcm_channel(struct snd_trident *trident)
-  
+
     Description: Allocate hardware channel in Bank B (32-63).
-  
+
     Parameters :  trident - pointer to target device class for 4DWave.
-  
+
     Return Value: hardware channel - 32-63 or -1 when no channel is available
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_allocate_pcm_channel(struct snd_trident * trident)
@@ -360,14 +360,14 @@ static int snd_trident_allocate_pcm_channel(struct snd_trident * trident)
 
 /*---------------------------------------------------------------------------
     void snd_trident_free_pcm_channel(int channel)
-  
+
     Description: Free hardware channel in Bank B (32-63)
-  
+
     Parameters :  trident - pointer to target device class for 4DWave.
 	          channel - hardware channel number 0-63
-  
+
     Return Value: none
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_free_pcm_channel(struct snd_trident *trident, int channel)
@@ -383,13 +383,13 @@ static void snd_trident_free_pcm_channel(struct snd_trident *trident, int channe
 
 /*---------------------------------------------------------------------------
     unsigned int snd_trident_allocate_synth_channel(void)
-  
+
     Description: Allocate hardware channel in Bank A (0-31).
-  
+
     Parameters :  trident - pointer to target device class for 4DWave.
-  
+
     Return Value: hardware channel - 0-31 or -1 when no channel is available
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_allocate_synth_channel(struct snd_trident * trident)
@@ -407,15 +407,15 @@ static int snd_trident_allocate_synth_channel(struct snd_trident * trident)
 }
 
 /*---------------------------------------------------------------------------
-    void snd_trident_free_synth_channel( int channel )
-  
+    void snd_trident_free_synth_channel( int channel)
+
     Description: Free hardware channel in Bank B (0-31).
-  
+
     Parameters :  trident - pointer to target device class for 4DWave.
 	          channel - hardware channel number 0-63
-  
+
     Return Value: none
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_free_synth_channel(struct snd_trident *trident, int channel)
@@ -431,14 +431,14 @@ static void snd_trident_free_synth_channel(struct snd_trident *trident, int chan
 
 /*---------------------------------------------------------------------------
    snd_trident_write_voice_regs
-  
+
    Description: This routine will complete and write the 5 hardware channel
                 registers to hardware.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 voice - synthesizer voice structure
                 Each register field.
-  
+
   ---------------------------------------------------------------------------*/
 
 void snd_trident_write_voice_regs(struct snd_trident * trident,
@@ -509,14 +509,14 @@ EXPORT_SYMBOL(snd_trident_write_voice_regs);
 
 /*---------------------------------------------------------------------------
    snd_trident_write_cso_reg
-  
+
    Description: This routine will write the new CSO offset
                 register to hardware.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 voice - synthesizer voice structure
                 CSO - new CSO value
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_write_cso_reg(struct snd_trident * trident,
@@ -535,14 +535,14 @@ static void snd_trident_write_cso_reg(struct snd_trident * trident,
 
 /*---------------------------------------------------------------------------
    snd_trident_write_eso_reg
-  
+
    Description: This routine will write the new ESO offset
                 register to hardware.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 voice - synthesizer voice structure
                 ESO - new ESO value
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_write_eso_reg(struct snd_trident * trident,
@@ -561,14 +561,14 @@ static void snd_trident_write_eso_reg(struct snd_trident * trident,
 
 /*---------------------------------------------------------------------------
    snd_trident_write_vol_reg
-  
+
    Description: This routine will write the new voice volume
                 register to hardware.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 voice - synthesizer voice structure
                 Vol - new voice volume
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_write_vol_reg(struct snd_trident * trident,
@@ -583,7 +583,7 @@ static void snd_trident_write_vol_reg(struct snd_trident * trident,
 		outb(voice->Vol >> 2, TRID_REG(trident, CH_GVSEL_PAN_VOL_CTRL_EC + 2));
 		break;
 	case TRIDENT_DEVICE_ID_SI7018:
-		// printk("voice->Vol = 0x%x\n", voice->Vol);
+		/* printk("voice->Vol = 0x%x\n", voice->Vol); */
 		outw((voice->CTRL << 12) | voice->Vol,
 		     TRID_REG(trident, CH_GVSEL_PAN_VOL_CTRL_EC));
 		break;
@@ -592,14 +592,14 @@ static void snd_trident_write_vol_reg(struct snd_trident * trident,
 
 /*---------------------------------------------------------------------------
    snd_trident_write_pan_reg
-  
+
    Description: This routine will write the new voice pan
                 register to hardware.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 voice - synthesizer voice structure
                 Pan - new pan value
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_write_pan_reg(struct snd_trident * trident,
@@ -614,14 +614,14 @@ static void snd_trident_write_pan_reg(struct snd_trident * trident,
 
 /*---------------------------------------------------------------------------
    snd_trident_write_rvol_reg
-  
+
    Description: This routine will write the new reverb volume
                 register to hardware.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 voice - synthesizer voice structure
                 RVol - new reverb volume
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_write_rvol_reg(struct snd_trident * trident,
@@ -638,14 +638,14 @@ static void snd_trident_write_rvol_reg(struct snd_trident * trident,
 
 /*---------------------------------------------------------------------------
    snd_trident_write_cvol_reg
-  
+
    Description: This routine will write the new chorus volume
                 register to hardware.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 voice - synthesizer voice structure
                 CVol - new chorus volume
-  
+
   ---------------------------------------------------------------------------*/
 
 static void snd_trident_write_cvol_reg(struct snd_trident * trident,
@@ -664,21 +664,21 @@ static void snd_trident_write_cvol_reg(struct snd_trident * trident,
    snd_trident_convert_rate
 
    Description: This routine converts rate in HZ to hardware delta value.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 rate - Real or Virtual channel number.
-  
+
    Returns:     Delta value.
-  
+
   ---------------------------------------------------------------------------*/
 static unsigned int snd_trident_convert_rate(unsigned int rate)
 {
 	unsigned int delta;
 
-	// We special case 44100 and 8000 since rounding with the equation
-	// does not give us an accurate enough value. For 11025 and 22050
-	// the equation gives us the best answer. All other frequencies will
-	// also use the equation. JDW
+	/* We special case 44100 and 8000 since rounding with the equation */
+	/* does not give us an accurate enough value. For 11025 and 22050 */
+	/* the equation gives us the best answer. All other frequencies will */
+	/* also use the equation. JDW */
 	if (rate == 44100)
 		delta = 0xeb3;
 	else if (rate == 8000)
@@ -694,21 +694,21 @@ static unsigned int snd_trident_convert_rate(unsigned int rate)
    snd_trident_convert_adc_rate
 
    Description: This routine converts rate in HZ to hardware delta value.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 rate - Real or Virtual channel number.
-  
+
    Returns:     Delta value.
-  
+
   ---------------------------------------------------------------------------*/
 static unsigned int snd_trident_convert_adc_rate(unsigned int rate)
 {
 	unsigned int delta;
 
-	// We special case 44100 and 8000 since rounding with the equation
-	// does not give us an accurate enough value. For 11025 and 22050
-	// the equation gives us the best answer. All other frequencies will
-	// also use the equation. JDW
+	/* We special case 44100 and 8000 since rounding with the equation */
+	/* does not give us an accurate enough value. For 11025 and 22050 */
+	/* the equation gives us the best answer. All other frequencies will */
+	/* also use the equation. JDW */
 	if (rate == 44100)
 		delta = 0x116a;
 	else if (rate == 8000)
@@ -724,12 +724,12 @@ static unsigned int snd_trident_convert_adc_rate(unsigned int rate)
    snd_trident_spurious_threshold
 
    Description: This routine converts rate in HZ to spurious threshold.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 rate - Real or Virtual channel number.
-  
+
    Returns:     Delta value.
-  
+
   ---------------------------------------------------------------------------*/
 static unsigned int snd_trident_spurious_threshold(unsigned int rate,
 						   unsigned int period_size)
@@ -746,12 +746,12 @@ static unsigned int snd_trident_spurious_threshold(unsigned int rate,
    snd_trident_control_mode
 
    Description: This routine returns a control mode for a PCM channel.
-  
+
    Parameters:  trident - pointer to target device class for 4DWave.
                 substream  - PCM substream
-  
+
    Returns:     Control value.
-  
+
   ---------------------------------------------------------------------------*/
 static unsigned int snd_trident_control_mode(struct snd_pcm_substream *substream)
 {
@@ -763,11 +763,11 @@ static unsigned int snd_trident_control_mode(struct snd_pcm_substream *substream
 	 */
 	CTRL = 0x00000001;
 	if (snd_pcm_format_width(runtime->format) == 16)
-		CTRL |= 0x00000008;	// 16-bit data
+		CTRL |= 0x00000008;	/* 16-bit data */
 	if (snd_pcm_format_signed(runtime->format))
-		CTRL |= 0x00000002;	// signed data
+		CTRL |= 0x00000002;	/* signed data */
 	if (runtime->channels > 1)
-		CTRL |= 0x00000004;	// stereo data
+		CTRL |= 0x00000004;	/* stereo data */
 	return CTRL;
 }
 
@@ -777,15 +777,15 @@ static unsigned int snd_trident_control_mode(struct snd_pcm_substream *substream
 
 /*---------------------------------------------------------------------------
    snd_trident_ioctl
-  
+
    Description: Device I/O control handler for playback/capture parameters.
-  
+
    Parameters:   substream  - PCM substream class
                 cmd     - what ioctl message to process
-                arg     - additional message infoarg     
-  
+                arg     - additional message infoarg
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_ioctl(struct snd_pcm_substream *substream,
@@ -800,14 +800,14 @@ static int snd_trident_ioctl(struct snd_pcm_substream *substream,
 
 /*---------------------------------------------------------------------------
    snd_trident_allocate_pcm_mem
-  
+
    Description: Allocate PCM ring buffer for given substream
-  
+
    Parameters:  substream  - PCM substream class
 		hw_params  - hardware parameters
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_allocate_pcm_mem(struct snd_pcm_substream *substream,
@@ -834,14 +834,14 @@ static int snd_trident_allocate_pcm_mem(struct snd_pcm_substream *substream,
 
 /*---------------------------------------------------------------------------
    snd_trident_allocate_evoice
-  
+
    Description: Allocate extra voice as interrupt generator
-  
+
    Parameters:  substream  - PCM substream class
 		hw_params  - hardware parameters
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_allocate_evoice(struct snd_pcm_substream *substream,
@@ -874,14 +874,14 @@ static int snd_trident_allocate_evoice(struct snd_pcm_substream *substream,
 
 /*---------------------------------------------------------------------------
    snd_trident_hw_params
-  
+
    Description: Set the hardware parameters for the playback device.
-  
+
    Parameters:  substream  - PCM substream class
 		hw_params  - hardware parameters
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_hw_params(struct snd_pcm_substream *substream,
@@ -897,13 +897,13 @@ static int snd_trident_hw_params(struct snd_pcm_substream *substream,
 
 /*---------------------------------------------------------------------------
    snd_trident_playback_hw_free
-  
+
    Description: Release the hardware resources for the playback device.
-  
+
    Parameters:  substream  - PCM substream class
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_hw_free(struct snd_pcm_substream *substream)
@@ -929,13 +929,13 @@ static int snd_trident_hw_free(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_playback_prepare
-  
+
    Description: Prepare playback device for playback.
-  
+
    Parameters:  substream  - PCM substream class
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_playback_prepare(struct snd_pcm_substream *substream)
@@ -946,7 +946,7 @@ static int snd_trident_playback_prepare(struct snd_pcm_substream *substream)
 	struct snd_trident_voice *evoice = voice->extra;
 	struct snd_trident_pcm_mixer *mix = &trident->pcm_mixer[substream->number];
 
-	spin_lock_irq(&trident->reg_lock);	
+	spin_lock_irq(&trident->reg_lock);
 
 	/* set delta (rate) value */
 	voice->Delta = snd_trident_convert_rate(runtime->rate);
@@ -957,7 +957,7 @@ static int snd_trident_playback_prepare(struct snd_pcm_substream *substream)
 		voice->LBA = voice->memblk->offset;
 	else
 		voice->LBA = runtime->dma_addr;
- 
+
 	voice->CSO = 0;
 	voice->ESO = runtime->buffer_size - 1;	/* in samples */
 	voice->CTRL = snd_trident_control_mode(substream);
@@ -1014,14 +1014,14 @@ static int snd_trident_playback_prepare(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_capture_hw_params
-  
+
    Description: Set the hardware parameters for the capture device.
-  
+
    Parameters:  substream  - PCM substream class
 		hw_params  - hardware parameters
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_capture_hw_params(struct snd_pcm_substream *substream,
@@ -1032,13 +1032,13 @@ static int snd_trident_capture_hw_params(struct snd_pcm_substream *substream,
 
 /*---------------------------------------------------------------------------
    snd_trident_capture_prepare
-  
+
    Description: Prepare capture device for playback.
-  
+
    Parameters:  substream  - PCM substream class
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
@@ -1050,29 +1050,29 @@ static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
 
 	spin_lock_irq(&trident->reg_lock);
 
-	// Initilize the channel and set channel Mode
+	/* Initilize the channel and set channel Mode */
 	outb(0, TRID_REG(trident, LEGACY_DMAR15));
 
-	// Set DMA channel operation mode register
+	/* Set DMA channel operation mode register */
 	outb(0x54, TRID_REG(trident, LEGACY_DMAR11));
 
-	// Set channel buffer Address, DMAR0 expects contiguous PCI memory area	
+	/* Set channel buffer Address, DMAR0 expects contiguous PCI memory area */
 	voice->LBA = runtime->dma_addr;
 	outl(voice->LBA, TRID_REG(trident, LEGACY_DMAR0));
 	if (voice->memblk)
 		voice->LBA = voice->memblk->offset;
 
-	// set ESO
+	/* set ESO */
 	ESO_bytes = snd_pcm_lib_buffer_bytes(substream) - 1;
 	outb((ESO_bytes & 0x00ff0000) >> 16, TRID_REG(trident, LEGACY_DMAR6));
 	outw((ESO_bytes & 0x0000ffff), TRID_REG(trident, LEGACY_DMAR4));
 	ESO_bytes++;
 
-	// Set channel sample rate, 4.12 format
+	/* Set channel sample rate, 4.12 format */
 	val = (((unsigned int) 48000L << 12) + (runtime->rate/2)) / runtime->rate;
 	outw(val, TRID_REG(trident, T4D_SBDELTA_DELTA_R));
 
-	// Set channel interrupt blk length
+	/* Set channel interrupt blk length */
 	if (snd_pcm_format_width(runtime->format) == 16) {
 		val = (unsigned short) ((ESO_bytes >> 1) - 1);
 	} else {
@@ -1081,9 +1081,9 @@ static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
 
 	outl((val << 16) | val, TRID_REG(trident, T4D_SBBL_SBCL));
 
-	// Right now, set format and start to run captureing, 
-	// continuous run loop enable.
-	trident->bDMAStart = 0x19;	// 0001 1001b
+	/* Right now, set format and start to run captureing, */
+	/* continuous run loop enable. */
+	trident->bDMAStart = 0x19;	/* 0001 1001b */
 
 	if (snd_pcm_format_width(runtime->format) == 16)
 		trident->bDMAStart |= 0x80;
@@ -1092,7 +1092,7 @@ static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
 	if (runtime->channels > 1)
 		trident->bDMAStart |= 0x40;
 
-	// Prepare capture intr channel
+	/* Prepare capture intr channel */
 
 	voice->Delta = snd_trident_convert_rate(runtime->rate);
 	voice->spurious_threshold = snd_trident_spurious_threshold(runtime->rate, runtime->period_size);
@@ -1100,7 +1100,7 @@ static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
 	voice->isync_mark = runtime->period_size;
 	voice->isync_max = runtime->buffer_size;
 
-	// Set voice parameters
+	/* Set voice parameters */
 	voice->CSO = 0;
 	voice->ESO = voice->isync_ESO = (runtime->period_size * 2) + 6 - 1;
 	voice->CTRL = snd_trident_control_mode(substream);
@@ -1123,14 +1123,14 @@ static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_si7018_capture_hw_params
-  
+
    Description: Set the hardware parameters for the capture device.
-  
+
    Parameters:  substream  - PCM substream class
 		hw_params  - hardware parameters
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_si7018_capture_hw_params(struct snd_pcm_substream *substream,
@@ -1146,13 +1146,13 @@ static int snd_trident_si7018_capture_hw_params(struct snd_pcm_substream *substr
 
 /*---------------------------------------------------------------------------
    snd_trident_si7018_capture_hw_free
-  
+
    Description: Release the hardware resources for the capture device.
-  
+
    Parameters:  substream  - PCM substream class
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_si7018_capture_hw_free(struct snd_pcm_substream *substream)
@@ -1172,13 +1172,13 @@ static int snd_trident_si7018_capture_hw_free(struct snd_pcm_substream *substrea
 
 /*---------------------------------------------------------------------------
    snd_trident_si7018_capture_prepare
-  
+
    Description: Prepare capture device for playback.
-  
+
    Parameters:  substream  - PCM substream class
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_si7018_capture_prepare(struct snd_pcm_substream *substream)
@@ -1194,7 +1194,7 @@ static int snd_trident_si7018_capture_prepare(struct snd_pcm_substream *substrea
 	voice->Delta = snd_trident_convert_adc_rate(runtime->rate);
 	voice->spurious_threshold = snd_trident_spurious_threshold(runtime->rate, runtime->period_size);
 
-	// Set voice parameters
+	/* Set voice parameters */
 	voice->CSO = 0;
 	voice->ESO = runtime->buffer_size - 1;		/* in samples */
 	voice->CTRL = snd_trident_control_mode(substream);
@@ -1236,20 +1236,20 @@ static int snd_trident_si7018_capture_prepare(struct snd_pcm_substream *substrea
 		evoice->isync_mark = runtime->period_size;
 		evoice->ESO = (runtime->period_size * 2) - 1;
 	}
-	
+
 	spin_unlock_irq(&trident->reg_lock);
 	return 0;
 }
 
 /*---------------------------------------------------------------------------
    snd_trident_foldback_prepare
-  
+
    Description: Prepare foldback capture device for playback.
-  
+
    Parameters:  substream  - PCM substream class
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_foldback_prepare(struct snd_pcm_substream *substream)
@@ -1320,14 +1320,14 @@ static int snd_trident_foldback_prepare(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_spdif_hw_params
-  
+
    Description: Set the hardware parameters for the spdif device.
-  
+
    Parameters:  substream  - PCM substream class
 		hw_params  - hardware parameters
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_spdif_hw_params(struct snd_pcm_substream *substream,
@@ -1355,21 +1355,21 @@ static int snd_trident_spdif_hw_params(struct snd_pcm_substream *substream,
 	else
 		trident->spdif_pcm_bits &= ~(IEC958_AES3_CON_FS << 24);
 	if (params_rate(hw_params) >= 48000) {
-		trident->spdif_pcm_ctrl = 0x3c;	// 48000 Hz
+		trident->spdif_pcm_ctrl = 0x3c;	/* 48000 Hz */
 		trident->spdif_pcm_bits |=
 			trident->spdif_bits & IEC958_AES0_PROFESSIONAL ?
 				IEC958_AES0_PRO_FS_48000 :
 				(IEC958_AES3_CON_FS_48000 << 24);
 	}
 	else if (params_rate(hw_params) >= 44100) {
-		trident->spdif_pcm_ctrl = 0x3e;	// 44100 Hz
+		trident->spdif_pcm_ctrl = 0x3e;	/* 44100 Hz */
 		trident->spdif_pcm_bits |=
 			trident->spdif_bits & IEC958_AES0_PROFESSIONAL ?
 				IEC958_AES0_PRO_FS_44100 :
 				(IEC958_AES3_CON_FS_44100 << 24);
 	}
 	else {
-		trident->spdif_pcm_ctrl = 0x3d;	// 32000 Hz
+		trident->spdif_pcm_ctrl = 0x3d;	/* 32000 Hz */
 		trident->spdif_pcm_bits |=
 			trident->spdif_bits & IEC958_AES0_PROFESSIONAL ?
 				IEC958_AES0_PRO_FS_32000 :
@@ -1386,13 +1386,13 @@ static int snd_trident_spdif_hw_params(struct snd_pcm_substream *substream,
 
 /*---------------------------------------------------------------------------
    snd_trident_spdif_prepare
-  
+
    Description: Prepare SPDIF device for playback.
-  
+
    Parameters:  substream  - PCM substream class
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_spdif_prepare(struct snd_pcm_substream *substream)
@@ -1458,7 +1458,7 @@ static int snd_trident_spdif_prepare(struct snd_pcm_substream *substream)
 		outl(trident->spdif_pcm_bits, TRID_REG(trident, NX_SPCSTATUS));
 
 	} else {	/* SiS */
-	
+
 		/* set delta (rate) value */
 		voice->Delta = 0x800;
 		voice->spurious_threshold = snd_trident_spurious_threshold(48000, runtime->period_size);
@@ -1524,19 +1524,19 @@ static int snd_trident_spdif_prepare(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_trigger
-  
+
    Description: Start/stop devices
-  
+
    Parameters:  substream  - PCM substream class
    		cmd	- trigger command (STOP, GO)
-  
+
    Returns:     Error status
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_trigger(struct snd_pcm_substream *substream,
 			       int cmd)
-				    
+
 {
 	struct snd_trident *trident = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *s;
@@ -1624,13 +1624,13 @@ static int snd_trident_trigger(struct snd_pcm_substream *substream,
 
 /*---------------------------------------------------------------------------
    snd_trident_playback_pointer
-  
+
    Description: This routine return the playback position
-                
+
    Parameters:	substream  - PCM substream class
 
    Returns:     position of buffer
-  
+
   ---------------------------------------------------------------------------*/
 
 static snd_pcm_uframes_t snd_trident_playback_pointer(struct snd_pcm_substream *substream)
@@ -1649,7 +1649,7 @@ static snd_pcm_uframes_t snd_trident_playback_pointer(struct snd_pcm_substream *
 
 	if (trident->device != TRIDENT_DEVICE_ID_NX) {
 		cso = inw(TRID_REG(trident, CH_DX_CSO_ALPHA_FMS + 2));
-	} else {		// ID_4DWAVE_NX
+	} else {		/* ID_4DWAVE_NX */
 		cso = (unsigned int) inl(TRID_REG(trident, CH_NX_DELTA_CSO)) & 0x00ffffff;
 	}
 
@@ -1663,13 +1663,13 @@ static snd_pcm_uframes_t snd_trident_playback_pointer(struct snd_pcm_substream *
 
 /*---------------------------------------------------------------------------
    snd_trident_capture_pointer
-  
+
    Description: This routine return the capture position
-                
+
    Parameters:   pcm1    - PCM device class
 
    Returns:     position of buffer
-  
+
   ---------------------------------------------------------------------------*/
 
 static snd_pcm_uframes_t snd_trident_capture_pointer(struct snd_pcm_substream *substream)
@@ -1693,13 +1693,13 @@ static snd_pcm_uframes_t snd_trident_capture_pointer(struct snd_pcm_substream *s
 
 /*---------------------------------------------------------------------------
    snd_trident_spdif_pointer
-  
+
    Description: This routine return the SPDIF playback position
-                
+
    Parameters:	substream  - PCM substream class
 
    Returns:     position of buffer
-  
+
   ---------------------------------------------------------------------------*/
 
 static snd_pcm_uframes_t snd_trident_spdif_pointer(struct snd_pcm_substream *substream)
@@ -1868,10 +1868,10 @@ static int snd_trident_playback_open(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_playback_close
-  
-   Description: This routine will close the 4DWave playback device. For now 
+
+   Description: This routine will close the 4DWave playback device. For now
                 we will simply free the dma transfer buffer.
-                
+
    Parameters:	substream  - PCM substream class
 
   ---------------------------------------------------------------------------*/
@@ -1887,13 +1887,13 @@ static int snd_trident_playback_close(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_spdif_open
-  
+
    Description: This routine will open the 4DWave SPDIF device.
 
    Parameters:	substream  - PCM substream class
 
    Returns:     status  - success or failure flag
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_spdif_open(struct snd_pcm_substream *substream)
@@ -1901,7 +1901,7 @@ static int snd_trident_spdif_open(struct snd_pcm_substream *substream)
 	struct snd_trident *trident = snd_pcm_substream_chip(substream);
 	struct snd_trident_voice *voice;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	
+
 	voice = snd_trident_alloc_voice(trident, SNDRV_TRIDENT_VOICE_TYPE_PCM, 0, 0);
 	if (voice == NULL)
 		return -EAGAIN;
@@ -1930,9 +1930,9 @@ static int snd_trident_spdif_open(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_spdif_close
-  
+
    Description: This routine will close the 4DWave SPDIF device.
-                
+
    Parameters:	substream  - PCM substream class
 
   ---------------------------------------------------------------------------*/
@@ -1943,7 +1943,7 @@ static int snd_trident_spdif_close(struct snd_pcm_substream *substream)
 	unsigned int temp;
 
 	spin_lock_irq(&trident->reg_lock);
-	// restore default SPDIF setting
+	/* restore default SPDIF setting */
 	if (trident->device != TRIDENT_DEVICE_ID_SI7018) {
 		outb(trident->spdif_ctrl, TRID_REG(trident, NX_SPCTRL_SPCSO + 3));
 		outl(trident->spdif_bits, TRID_REG(trident, NX_SPCSTATUS));
@@ -1966,7 +1966,7 @@ static int snd_trident_spdif_close(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_capture_open
-  
+
    Description: This routine will open the 4DWave capture device.
 
    Parameters:	substream  - PCM substream class
@@ -1996,10 +1996,10 @@ static int snd_trident_capture_open(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_capture_close
-  
-   Description: This routine will close the 4DWave capture device. For now 
+
+   Description: This routine will close the 4DWave capture device. For now
                 we will simply free the dma transfer buffer.
-                
+
    Parameters:	substream  - PCM substream class
 
   ---------------------------------------------------------------------------*/
@@ -2010,7 +2010,7 @@ static int snd_trident_capture_close(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_foldback_open
-  
+
    Description: This routine will open the 4DWave foldback capture device.
 
    Parameters:	substream  - PCM substream class
@@ -2039,10 +2039,10 @@ static int snd_trident_foldback_open(struct snd_pcm_substream *substream)
 
 /*---------------------------------------------------------------------------
    snd_trident_foldback_close
-  
-   Description: This routine will close the 4DWave foldback capture device. 
+
+   Description: This routine will close the 4DWave foldback capture device.
 		For now we will simply free the dma transfer buffer.
-                
+
    Parameters:	substream  - PCM substream class
 
   ---------------------------------------------------------------------------*/
@@ -2052,7 +2052,7 @@ static int snd_trident_foldback_close(struct snd_pcm_substream *substream)
 	struct snd_trident_voice *voice;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	voice = runtime->private_data;
-	
+
 	/* stop capture channel */
 	spin_lock_irq(&trident->reg_lock);
 	outb(0x00, TRID_REG(trident, T4D_RCI + voice->foldback_chan));
@@ -2156,13 +2156,13 @@ static struct snd_pcm_ops snd_trident_spdif_7018_ops = {
 
 /*---------------------------------------------------------------------------
    snd_trident_pcm
-  
+
    Description: This routine registers the 4DWave device for PCM support.
-                
+
    Parameters:  trident - pointer to target device class for 4DWave.
 
    Returns:     None
-  
+
   ---------------------------------------------------------------------------*/
 
 int __devinit snd_trident_pcm(struct snd_trident * trident,
@@ -2214,13 +2214,13 @@ int __devinit snd_trident_pcm(struct snd_trident * trident,
 
 /*---------------------------------------------------------------------------
    snd_trident_foldback_pcm
-  
+
    Description: This routine registers the 4DWave device for foldback PCM support.
-                
+
    Parameters:  trident - pointer to target device class for 4DWave.
 
    Returns:     None
-  
+
   ---------------------------------------------------------------------------*/
 
 int __devinit snd_trident_foldback_pcm(struct snd_trident * trident,
@@ -2271,13 +2271,13 @@ int __devinit snd_trident_foldback_pcm(struct snd_trident * trident,
 
 /*---------------------------------------------------------------------------
    snd_trident_spdif
-  
+
    Description: This routine registers the 4DWave-NX device for SPDIF support.
-                
+
    Parameters:  trident - pointer to target device class for 4DWave-NX.
 
    Returns:     None
-  
+
   ---------------------------------------------------------------------------*/
 
 int __devinit snd_trident_spdif_pcm(struct snd_trident * trident,
@@ -2904,7 +2904,7 @@ static void snd_trident_notify_pcm_change1(struct snd_card *card,
 {
 	struct snd_ctl_elem_id id;
 
-	if (! kctl)
+	if (!kctl)
 		return;
 	if (activate)
 		kctl->vd[num].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
@@ -2957,13 +2957,13 @@ static int snd_trident_pcm_mixer_free(struct snd_trident *trident, struct snd_tr
 
 /*---------------------------------------------------------------------------
    snd_trident_mixer
-  
+
    Description: This routine registers the 4DWave device for mixer support.
-                
+
    Parameters:  trident - pointer to target device class for 4DWave.
 
    Returns:     None
-  
+
   ---------------------------------------------------------------------------*/
 
 static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spdif_device)
@@ -2989,7 +2989,7 @@ static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spd
 	_ac97.private_data = trident;
 	trident->ac97_detect = 1;
 
-      __again:
+__again:
 	if ((err = snd_ac97_mixer(trident->ac97_bus, &_ac97, &trident->ac97)) < 0) {
 		if (trident->device == TRIDENT_DEVICE_ID_SI7018) {
 			if ((err = snd_trident_sis_reset(trident)) < 0)
@@ -3000,7 +3000,7 @@ static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spd
 		}
 		goto __out;
 	}
-	
+
 	/* secondary codec? */
 	if (trident->device == TRIDENT_DEVICE_ID_SI7018 &&
 	    (inl(TRID_REG(trident, SI_SERIAL_INTF_CTRL)) & SI_AC97_PRIMARY_READY) != 0) {
@@ -3008,7 +3008,7 @@ static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spd
 		err = snd_ac97_mixer(trident->ac97_bus, &_ac97, &trident->ac97_sec);
 		if (err < 0)
 			snd_printk(KERN_ERR "SI7018: the secondary codec - invalid access\n");
-#if 0	// only for my testing purpose --jk
+#if 0	/* only for my testing purpose --jk */
 		{
 			struct snd_ac97 *mc97;
 			err = snd_ac97_modem(trident->card, &_ac97, &mc97);
@@ -3017,7 +3017,7 @@ static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spd
 		}
 #endif
 	}
-	
+
 	trident->ac97_detect = 0;
 
 	if (trident->device != TRIDENT_DEVICE_ID_SI7018) {
@@ -3034,7 +3034,7 @@ static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spd
 
 	for (idx = 0; idx < 32; idx++) {
 		struct snd_trident_pcm_mixer *tmix;
-		
+
 		tmix = &trident->pcm_mixer[idx];
 		tmix->voice = NULL;
 	}
@@ -3042,7 +3042,7 @@ static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spd
 		goto __nomem;
 	if ((err = snd_ctl_add(card, trident->ctl_vol)))
 		goto __out;
-		
+
 	if ((trident->ctl_pan = snd_ctl_new1(&snd_trident_pcm_pan_control, trident)) == NULL)
 		goto __nomem;
 	if ((err = snd_ctl_add(card, trident->ctl_pan)))
@@ -3114,10 +3114,10 @@ static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spd
 	err = 0;
 	goto __out;
 
- __nomem:
+__nomem:
 	err = -ENOMEM;
 
- __out:
+__out:
 	kfree(uctl);
 
 	return err;
@@ -3161,7 +3161,7 @@ static int snd_trident_gameport_cooked_read(struct gameport *gameport, int *axes
 		axes[i] = inw(TRID_REG(chip, GAMEPORT_AXES + i * 2));
 		if (axes[i] == 0xffff) axes[i] = -1;
 	}
-        
+
         return 0;
 }
 
@@ -3284,11 +3284,11 @@ static int snd_trident_sis_reset(struct snd_trident *trident)
 	return 0;
 }
 
-/*  
+/*
  *  /proc interface
  */
 
-static void snd_trident_proc_read(struct snd_info_entry *entry, 
+static void snd_trident_proc_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct snd_trident *trident = entry->private_data;
@@ -3327,10 +3327,10 @@ static void __devinit snd_trident_proc_init(struct snd_trident * trident)
 {
 	struct snd_info_entry *entry;
 	const char *s = "trident";
-	
+
 	if (trident->device == TRIDENT_DEVICE_ID_SI7018)
 		s = "sis7018";
-	if (! snd_card_proc_new(trident->card, s, &entry))
+	if (!snd_card_proc_new(trident->card, s, &entry))
 		snd_info_set_text_ops(entry, trident, snd_trident_proc_read);
 }
 
@@ -3342,14 +3342,14 @@ static int snd_trident_dev_free(struct snd_device *device)
 
 /*---------------------------------------------------------------------------
    snd_trident_tlb_alloc
-  
+
    Description: Allocate and set up the TLB page table on 4D NX.
 		Each entry has 4 bytes (physical PCI address).
-                
+
    Parameters:  trident - pointer to target device class for 4DWave.
 
    Returns:     0 or negative error code
-  
+
   ---------------------------------------------------------------------------*/
 
 static int __devinit snd_trident_tlb_alloc(struct snd_trident *trident)
@@ -3418,7 +3418,7 @@ static int snd_trident_4d_dx_init(struct snd_trident *trident)
 	udelay(100);
 	pci_write_config_byte(pci, 0x46, 0); /* release reset */
 	udelay(100);
-	
+
 	/* warm reset of the AC'97 codec */
 	outl(0x00000001, TRID_REG(trident, DX_ACR2_AC97_COM_STAT));
 	udelay(100);
@@ -3436,7 +3436,7 @@ static int snd_trident_4d_dx_init(struct snd_trident *trident)
 	snd_printk(KERN_ERR "AC'97 codec ready error\n");
 	return -EIO;
 
- __dx_ok:
+__dx_ok:
 	snd_trident_stop_all_voices(trident);
 
 	return 0;
@@ -3474,7 +3474,7 @@ static int snd_trident_4d_nx_init(struct snd_trident *trident)
 	snd_printk(KERN_ERR "AC'97 codec ready error [0x%x]\n", inl(TRID_REG(trident, NX_ACR0_AC97_COM_STAT)));
 	return -EIO;
 
- __nx_ok:
+__nx_ok:
 	/* DAC on */
 	trident->ac97_ctrl = 0x00000002;
 	outl(trident->ac97_ctrl, TRID_REG(trident, NX_ACR0_AC97_COM_STAT));
@@ -3519,10 +3519,10 @@ static int snd_trident_sis_init(struct snd_trident *trident)
 
 /*---------------------------------------------------------------------------
    snd_trident_create
-  
+
    Description: This routine will create the device specific class for
                 the 4DWave card. It will also perform basic initialization.
-                
+
    Parameters:  card  - which card to create
                 pci   - interface to PCI bus resource info
                 dma1ptr - playback dma buffer
@@ -3530,7 +3530,7 @@ static int snd_trident_sis_init(struct snd_trident *trident)
                 irqptr  -  interrupt resource info
 
    Returns:     4DWave device class private data
-  
+
   ---------------------------------------------------------------------------*/
 
 int __devinit snd_trident_create(struct snd_card *card,
@@ -3560,7 +3560,7 @@ int __devinit snd_trident_create(struct snd_card *card,
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
-	
+
 	trident = kzalloc(sizeof(*trident), GFP_KERNEL);
 	if (trident == NULL) {
 		pci_disable_device(pci);
@@ -3577,7 +3577,7 @@ int __devinit snd_trident_create(struct snd_card *card,
 	if (pcm_streams > 32)
 		pcm_streams = 32;
 	trident->ChanPCM = pcm_streams;
-	if (max_wavetable_size < 0 )
+	if (max_wavetable_size < 0)
 		max_wavetable_size = 0;
 	trident->synth.max_size = max_wavetable_size * 1024;
 	trident->irq = -1;
@@ -3639,7 +3639,7 @@ int __devinit snd_trident_create(struct snd_card *card,
 
 	if ((err = snd_trident_mixer(trident, pcm_spdif_device)) < 0)
 		return err;
-	
+
 	/* initialise synth voices */
 	for (i = 0; i < 64; i++) {
 		voice = &trident->synth.voices[i];
@@ -3665,21 +3665,21 @@ int __devinit snd_trident_create(struct snd_card *card,
 
 /*---------------------------------------------------------------------------
    snd_trident_free
-  
+
    Description: This routine will free the device specific class for
-                the 4DWave card. 
-                
+                the 4DWave card.
+
    Parameters:  trident  - device specific private data for 4DWave card
 
    Returns:     None.
-  
+
   ---------------------------------------------------------------------------*/
 
 static int snd_trident_free(struct snd_trident *trident)
 {
 	snd_trident_free_gameport(trident);
 	snd_trident_disable_eso(trident);
-	// Disable S/PDIF out
+	/* Disable S/PDIF out */
 	if (trident->device == TRIDENT_DEVICE_ID_NX)
 		outb(0x00, TRID_REG(trident, NX_SPCTRL_SPCSO + 3));
 	else if (trident->device == TRIDENT_DEVICE_ID_SI7018) {
@@ -3704,9 +3704,9 @@ static int snd_trident_free(struct snd_trident *trident)
 
 /*---------------------------------------------------------------------------
    snd_trident_interrupt
-  
+
    Description: ISR for Trident 4DWave device
-                
+
    Parameters:  trident  - device specific private data for 4DWave card
 
    Problems:    It seems that Trident chips generates interrupts more than
@@ -3717,7 +3717,7 @@ static int snd_trident_free(struct snd_trident *trident)
                 work on all computers. [jaroslav]
 
    Returns:     None.
-  
+
   ---------------------------------------------------------------------------*/
 
 static irqreturn_t snd_trident_interrupt(int irq, void *dev_id)
@@ -3731,7 +3731,7 @@ static irqreturn_t snd_trident_interrupt(int irq, void *dev_id)
 	if ((audio_int & (ADDRESS_IRQ|MPU401_IRQ)) == 0)
 		return IRQ_NONE;
 	if (audio_int & ADDRESS_IRQ) {
-		// get interrupt status for all channels
+		/* get interrupt status for all channels */
 		spin_lock(&trident->reg_lock);
 		stimer = inl(TRID_REG(trident, T4D_STIMER)) & 0x00ffffff;
 		chn_int = inl(TRID_REG(trident, T4D_AINT_A));
@@ -3813,7 +3813,7 @@ static irqreturn_t snd_trident_interrupt(int irq, void *dev_id)
 			inb(TRID_REG(trident, T4D_MPUR0));
 		}
 	}
-	// outl((ST_TARGET_REACHED | MIXER_OVERFLOW | MIXER_UNDERFLOW), TRID_REG(trident, T4D_MISCINT));
+	/* outl((ST_TARGET_REACHED | MIXER_OVERFLOW | MIXER_UNDERFLOW), TRID_REG(trident, T4D_MISCINT)); */
 	return IRQ_HANDLED;
 }
 
@@ -3826,7 +3826,7 @@ struct snd_trident_voice *snd_trident_alloc_voice(struct snd_trident * trident,
 	spin_lock_irqsave(&trident->voice_alloc, flags);
 	if (type == SNDRV_TRIDENT_VOICE_TYPE_PCM) {
 		idx = snd_trident_allocate_pcm_channel(trident);
-		if(idx < 0) {
+		if (idx < 0) {
 			spin_unlock_irqrestore(&trident->voice_alloc, flags);
 			return NULL;
 		}
@@ -3842,7 +3842,7 @@ struct snd_trident_voice *snd_trident_alloc_voice(struct snd_trident * trident,
 	}
 	if (type == SNDRV_TRIDENT_VOICE_TYPE_SYNTH) {
 		idx = snd_trident_allocate_synth_channel(trident);
-		if(idx < 0) {
+		if (idx < 0) {
 			spin_unlock_irqrestore(&trident->voice_alloc, flags);
 			return NULL;
 		}
diff --git a/sound/pci/trident/trident_memory.c b/sound/pci/trident/trident_memory.c
index f9779e2..4bf4bbb 100644
--- a/sound/pci/trident/trident_memory.c
+++ b/sound/pci/trident/trident_memory.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/pci.h>
 #include <linux/time.h>
 #include <linux/mutex.h>
@@ -203,7 +203,7 @@ snd_trident_alloc_sg_pages(struct snd_trident *trident,
 	if (snd_BUG_ON(!hdr))
 		return NULL;
 
-	
+
 
 	mutex_lock(&hdr->block_mutex);
 	blk = search_empty(hdr, runtime->dma_bytes);
@@ -211,7 +211,7 @@ snd_trident_alloc_sg_pages(struct snd_trident *trident,
 		mutex_unlock(&hdr->block_mutex);
 		return NULL;
 	}
-			   
+
 	/* set TLB entries */
 	idx = 0;
 	for (page = firstpg(blk); page <= lastpg(blk); page++, idx++) {
@@ -219,7 +219,7 @@ snd_trident_alloc_sg_pages(struct snd_trident *trident,
 		dma_addr_t addr = snd_pcm_sgbuf_get_addr(substream, ofs);
 		unsigned long ptr = (unsigned long)
 			snd_pcm_sgbuf_get_ptr(substream, ofs);
-		if (! is_valid_page(addr)) {
+		if (!is_valid_page(addr)) {
 			__snd_util_mem_free(hdr, blk);
 			mutex_unlock(&hdr->block_mutex);
 			return NULL;
@@ -258,13 +258,13 @@ snd_trident_alloc_cont_pages(struct snd_trident *trident,
 		mutex_unlock(&hdr->block_mutex);
 		return NULL;
 	}
-			   
+
 	/* set TLB entries */
 	addr = runtime->dma_addr;
 	ptr = (unsigned long)runtime->dma_area;
 	for (page = firstpg(blk); page <= lastpg(blk); page++,
 	     ptr += SNDRV_TRIDENT_PAGE_SIZE, addr += SNDRV_TRIDENT_PAGE_SIZE) {
-		if (! is_valid_page(addr)) {
+		if (!is_valid_page(addr)) {
 			__snd_util_mem_free(hdr, blk);
 			mutex_unlock(&hdr->block_mutex);
 			return NULL;
