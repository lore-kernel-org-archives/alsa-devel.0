From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx: variable period size support, Santa Cruz rear output
 fixes
Date: Sun, 03 Nov 2002 23:11:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC59F11.6070607@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010701020604030102060306"
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
--------------010701020604030102060306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

A new bunch of changes on cs46xx driver. This patch should fix
the problems with the Santa Cruz rear output, and the DSP hang
(8 khz tone) related to the SPDIF output.

New is that now the cs46xx driver supports variable
period byte sizes on playback and capture,
supported period sizes are 32, 64, 128, 256, 512, 1024 ,2048.

I've tested play around with alsaplayer, arecord, things seems to work
as expected. But jackd got a inifinite amount of xruns,
and wont start with 1024 and 2048 period sizes with
"ALSA lib pcm_mmap.c:350:(snd_pcm_mmap) mmap failed: Invalid argument"
error message. I hope some of you can find a explication to that.
About the xruns I dont known if it's just that my Dual PIII is
not fast enough to serve jack ...

About the AC3 stuff, I've been doing some experiments
with xine trying to pass AC3 through the IEC958 port with
no success yet. My receiver dont wont to interpret it
as other thing that PCM, wich just results in a lot of
unpleasant noise. Something is left to setup in the
DSP SPDIF controller, I dont known exaclty what. You
are welcome to experiment with this.

Summary of changes:
 - DSP is started after initializing AC97 codecs, to fix
   the Santa Cruz problem.
- Rewrite SPDIF output stuff, to prevent the DSP hang
  and make it possible to live together with the
  IEC958 PCM channel.
- Variable period size support on playback and capture
- some minor procfs bug fixes
- code cleanup.

/Benny

PS. I've fixed my emacs settings, this patch should not contain any 
blank space -:)

--------------010701020604030102060306
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=CVS -Naur alsa-kernel/include/cs46xx.h ../cvs/alsa-kernel/include/cs46xx.h
--- alsa-kernel/include/cs46xx.h	Sat Nov  2 00:00:15 2002
+++ ../cvs/alsa-kernel/include/cs46xx.h	Sun Nov  3 21:03:28 2002
@@ -1766,6 +1766,7 @@
 int snd_cs46xx_pcm_iec958(cs46xx_t *chip, int device, snd_pcm_t **rpcm);
 int snd_cs46xx_mixer(cs46xx_t *chip);
 int snd_cs46xx_midi(cs46xx_t *chip, int device, snd_rawmidi_t **rmidi);
+int snd_cs46xx_start_dsp(cs46xx_t *chip);
 void snd_cs46xx_gameport(cs46xx_t *chip);
 
 #ifdef CONFIG_PM
diff --exclude=CVS -Naur alsa-kernel/include/cs46xx_dsp_spos.h ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h
--- alsa-kernel/include/cs46xx_dsp_spos.h	Sat Nov  2 00:00:15 2002
+++ ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h	Sun Nov  3 20:12:31 2002
@@ -36,20 +36,20 @@
 #define SEGTYPE_SP_COEFFICIENT          0x00000004
 
 #define DSP_SPOS_UU      0x0deadul     /* unused */
-#define DSP_SPOS_DC      0x0badul     /* dont care */
-#define DSP_SPOS_DC_DC   0x0bad0badul     /* dont care */
+#define DSP_SPOS_DC      0x0badul      /* dont care */
+#define DSP_SPOS_DC_DC   0x0bad0badul  /* dont care */
 #define DSP_SPOS_UUUU    0xdeadc0edul  /* unused */
 #define DSP_SPOS_UUHI    0xdeadul
 #define DSP_SPOS_UULO    0xc0edul
-#define DSP_SPOS_DCDC    0x0badf1d0ul /* dont care */
+#define DSP_SPOS_DCDC    0x0badf1d0ul  /* dont care */
 #define DSP_SPOS_DCDCHI  0x0badul
 #define DSP_SPOS_DCDCLO  0xf1d0ul
 
-#define DSP_MAX_TASK_NAME 60
+#define DSP_MAX_TASK_NAME   60
 #define DSP_MAX_SYMBOL_NAME 100
-#define DSP_MAX_SCB_NAME  60
-#define DSP_MAX_SCB_DESC  200
-#define DSP_MAX_TASK_DESC 50
+#define DSP_MAX_SCB_NAME    60
+#define DSP_MAX_SCB_DESC    200
+#define DSP_MAX_TASK_DESC   50
 
 #define DSP_MAX_PCM_CHANNELS 32
 #define DSP_MAX_SRC_NR       6
@@ -59,6 +59,10 @@
 #define DSP_PCM_CENTER_CHANNEL  3
 #define DSP_PCM_LFE_CHANNEL     4
 #define DSP_IEC958_CHANNEL      5
+
+#define DSP_SDPIF_STATUS_OUTPUT_ENABLED 1
+#define DSP_SDPIF_STATUS_PLAYBACK_OPEN  2
+#define DSP_SDPIF_STATUS_HW_ENABLED     4
 
 struct _dsp_module_desc_t;
 
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx.c
--- alsa-kernel/pci/cs46xx/cs46xx.c	Sat Nov  2 00:00:21 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx.c	Sun Nov  3 21:09:14 2002
@@ -110,14 +110,16 @@
 		snd_card_free(card);
 		return err;
 	}
-    if ((err = snd_cs46xx_pcm_rear(chip,1, NULL)) < 0) {
-        snd_card_free(card);
-        return err;
-    }
-    if ((err = snd_cs46xx_pcm_iec958(chip,2,NULL)) < 0) {
-        snd_card_free(card);
-        return err;
-    }
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+	if ((err = snd_cs46xx_pcm_rear(chip,1, NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	if ((err = snd_cs46xx_pcm_iec958(chip,2,NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+#endif
 	if ((err = snd_cs46xx_mixer(chip)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -126,6 +128,12 @@
 		snd_card_free(card);
 		return err;
 	}
+	if ((err = snd_cs46xx_start_dsp(chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+
 	snd_cs46xx_gameport(chip);
 
 	strcpy(card->driver, "CS46xx");
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Nov  2 00:00:23 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Nov  3 21:22:38 2002
@@ -445,19 +445,19 @@
 	snd_cs46xx_poke(chip, BA1_FRMT, 0xadf);
 }
 
-static int cs46xx_wait_for_fifo(cs46xx_t * chip) 
+static int cs46xx_wait_for_fifo(cs46xx_t * chip,int retry_timeout) 
 {
 	u32 i, status;
 	/*
 	 * Make sure the previous FIFO write operation has completed.
 	 */
-	for(i = 0; i < 20; i++){
+	for(i = 0; i < 50; i++){
 		status = snd_cs46xx_peekBA0(chip, BA0_SERBST);
     
 		if( !(status & SERBST_WBSY) )
 			break;
 
-		udelay(50);
+		mdelay(retry_timeout);
 	}
   
 	if(status & SERBST_WBSY) {
@@ -498,7 +498,7 @@
 		/*
 		 *  Make sure the previous FIFO write operation has completed.
 		 */
-		if (cs46xx_wait_for_fifo(chip)) {
+		if (cs46xx_wait_for_fifo(chip,1)) {
 			snd_printdd ("failed waiting for FIFO at addr (%02X)\n",idx);
 
 			if (powerdown)
@@ -728,6 +728,8 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_sframes_t diff;
 	cs46xx_pcm_t * cpcm;
+	int buffer_size = runtime->period_size * CS46XX_FRAGS;
+
 	cpcm = snd_magic_cast(cs46xx_pcm_t, substream->runtime->private_data, return -ENXIO);
 
 	diff = runtime->control->appl_ptr - cpcm->appl_ptr;
@@ -738,11 +740,11 @@
 	}
 	cpcm->sw_ready += frames << cpcm->shift;
 	cpcm->appl_ptr = runtime->control->appl_ptr + frames;
-	while (cpcm->hw_ready < CS46XX_BUFFER_SIZE && 
+	while (cpcm->hw_ready < buffer_size && 
 	       cpcm->sw_ready > 0) {
-		size_t hw_to_end = CS46XX_BUFFER_SIZE - cpcm->hw_data;
+		size_t hw_to_end = buffer_size - cpcm->hw_data;
 		size_t sw_to_end = cpcm->sw_bufsize - cpcm->sw_data;
-		size_t bytes = CS46XX_BUFFER_SIZE - cpcm->hw_ready;
+		size_t bytes = buffer_size - cpcm->hw_ready;
 		if (cpcm->sw_ready < bytes)
 			bytes = cpcm->sw_ready;
 		if (hw_to_end < bytes)
@@ -753,7 +755,7 @@
 		       runtime->dma_area + cpcm->sw_data,
 		       bytes);
 		cpcm->hw_data += bytes;
-		if (cpcm->hw_data == CS46XX_BUFFER_SIZE)
+		if (cpcm->hw_data == buffer_size)
 			cpcm->hw_data = 0;
 		cpcm->sw_data += bytes;
 		if (cpcm->sw_data == cpcm->sw_bufsize)
@@ -770,6 +772,7 @@
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_sframes_t diff = runtime->control->appl_ptr - chip->capt.appl_ptr;
+	int buffer_size = runtime->period_size * CS46XX_FRAGS;
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
@@ -779,7 +782,7 @@
 	chip->capt.appl_ptr = runtime->control->appl_ptr + frames;
 	while (chip->capt.hw_ready > 0 && 
 	       chip->capt.sw_ready < chip->capt.sw_bufsize) {
-		size_t hw_to_end = CS46XX_BUFFER_SIZE - chip->capt.hw_data;
+		size_t hw_to_end = buffer_size - chip->capt.hw_data;
 		size_t sw_to_end = chip->capt.sw_bufsize - chip->capt.sw_data;
 		size_t bytes = chip->capt.sw_bufsize - chip->capt.sw_ready;
 		if (chip->capt.hw_ready < bytes)
@@ -792,7 +795,7 @@
 		       chip->capt.hw_area + chip->capt.hw_data,
 		       bytes);
 		chip->capt.hw_data += bytes;
-		if (chip->capt.hw_data == CS46XX_BUFFER_SIZE)
+		if (chip->capt.hw_data == buffer_size)
 			chip->capt.hw_data = 0;
 		chip->capt.sw_data += bytes;
 		if (chip->capt.sw_data == chip->capt.sw_bufsize)
@@ -825,6 +828,7 @@
 	size_t ptr;
 	cs46xx_pcm_t *cpcm = snd_magic_cast(cs46xx_pcm_t, substream->runtime->private_data, return -ENXIO);
 	ssize_t bytes;
+	int buffer_size = substream->runtime->period_size * CS46XX_FRAGS;
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	snd_assert (cpcm->pcm_channel,return -ENXIO);
@@ -837,7 +841,7 @@
 	bytes = ptr - cpcm->hw_io;
 
 	if (bytes < 0)
-		bytes += CS46XX_BUFFER_SIZE;
+		bytes += buffer_size;
 	cpcm->hw_io = ptr;
 	cpcm->hw_ready -= bytes;
 	cpcm->sw_io += bytes;
@@ -859,8 +863,10 @@
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	size_t ptr = snd_cs46xx_peek(chip, BA1_CBA) - chip->capt.hw_addr;
 	ssize_t bytes = ptr - chip->capt.hw_io;
+	int buffer_size = substream->runtime->period_size * CS46XX_FRAGS;
+
 	if (bytes < 0)
-		bytes += CS46XX_BUFFER_SIZE;
+		bytes += buffer_size;
 	chip->capt.hw_io = ptr;
 	chip->capt.hw_ready += bytes;
 	chip->capt.sw_io += bytes;
@@ -1023,6 +1029,7 @@
 	int err;
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	int sample_rate = params_rate(hw_params);
+	int period_size = params_period_size(hw_params);
 	cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -ENXIO);
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
@@ -1047,8 +1054,8 @@
 		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
 
 		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, sample_rate, cpcm, 
-                                                                 cpcm->hw_addr,
-                                                                 cpcm->pcm_channel->pcm_channel_id)) == NULL) {
+									 cpcm->hw_addr,
+									 cpcm->pcm_channel->pcm_channel_id)) == NULL) {
 			snd_printk(KERN_ERR "cs46xx: failed to re-create virtual PCM channel\n");
 			up (&chip->spos_mutex);
 			return -ENXIO;
@@ -1058,6 +1065,10 @@
 		cpcm->pcm_channel->sample_rate = sample_rate;
 	}
 
+	if (cs46xx_dsp_pcm_channel_set_period (chip,cpcm->pcm_channel,period_size)) {
+		up (&chip->spos_mutex);
+		return -EINVAL;
+	}
 #endif
 
 	if (params_periods(hw_params) == CS46XX_FRAGS) {
@@ -1089,7 +1100,9 @@
 			runtime->dma_bytes = 0;
 		}
 		if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0) {
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
 			up (&chip->spos_mutex);
+#endif
 			return err;
 		}
 
@@ -1211,7 +1224,13 @@
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
+	int period_size = params_period_size(hw_params);
 
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+	snd_printdd ("capture period size (%d)\n",period_size);
+
+	cs46xx_dsp_pcm_ostream_set_period (chip,period_size);
+#endif
 	if (runtime->periods == CS46XX_FRAGS) {
 		if (runtime->dma_area != chip->capt.hw_area)
 			snd_pcm_lib_free_pages(substream);
@@ -1368,8 +1387,8 @@
 	.channels_min =		1,
 	.channels_max =		2,
 	.buffer_bytes_max =	(256 * 1024),
-	.period_bytes_min =	CS46XX_PERIOD_SIZE,
-	.period_bytes_max =	CS46XX_PERIOD_SIZE,
+	.period_bytes_min =	CS46XX_MIN_PERIOD_SIZE,
+	.period_bytes_max =	CS46XX_MAX_PERIOD_SIZE,
 	.periods_min =		CS46XX_FRAGS,
 	.periods_max =		1024,
 	.fifo_size =		0,
@@ -1388,13 +1407,23 @@
 	.channels_min =		2,
 	.channels_max =		2,
 	.buffer_bytes_max =	(256 * 1024),
-	.period_bytes_min =	CS46XX_PERIOD_SIZE,
-	.period_bytes_max =	CS46XX_PERIOD_SIZE,
+	.period_bytes_min =	CS46XX_MIN_PERIOD_SIZE,
+	.period_bytes_max =	CS46XX_MAX_PERIOD_SIZE,
 	.periods_min =		CS46XX_FRAGS,
 	.periods_max =		1024,
 	.fifo_size =		0,
 };
 
+static unsigned int period_sizes[] = { 32, 64, 128, 256, 512, 1024, 2048 };
+
+#define PERIOD_SIZES sizeof(period_sizes) / sizeof(period_sizes[0])
+
+static snd_pcm_hw_constraint_list_t hw_constraints_period_sizes = {
+	.count = PERIOD_SIZES,
+	.list = period_sizes,
+	.mask = 0
+};
+
 static void snd_cs46xx_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
 	cs46xx_pcm_t * cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return);
@@ -1435,6 +1464,8 @@
 		return -ENOMEM;
 	}
 
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+				   &hw_constraints_period_sizes);
 	up (&chip->spos_mutex);
 #else
 	chip->playback_pcm = cpcm; /* HACK */
@@ -1467,7 +1498,10 @@
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 
 	snd_printdd("open raw iec958 channel\n");
+
+	down (&chip->spos_mutex);
 	cs46xx_iec958_pre_open (chip);
+	up (&chip->spos_mutex);
 
 	return _cs46xx_playback_open_channel(substream,DSP_IEC958_CHANNEL);
 }
@@ -1479,8 +1513,13 @@
 	int err;
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
   
+	snd_printdd("close raw iec958 channel\n");
+
 	err = snd_cs46xx_playback_close(substream);
+
+	down (&chip->spos_mutex);
 	cs46xx_iec958_post_close (chip);
+	up (&chip->spos_mutex);
 
 	return err;
 }
@@ -1501,6 +1540,10 @@
 	chip->active_ctrl(chip, 1);
 	chip->amplifier_ctrl(chip, 1);
 
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+	snd_pcm_hw_constraint_list(substream->runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+				   &hw_constraints_period_sizes);
+#endif
 	return 0;
 }
 
@@ -1645,6 +1688,7 @@
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
 static void snd_cs46xx_pcm_rear_free(snd_pcm_t *pcm)
 {
 	cs46xx_t *chip = snd_magic_cast(cs46xx_t, pcm->private_data, return);
@@ -1659,7 +1703,6 @@
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
-#ifdef CONFIG_SND_CS46XX_NEW_DSP
 #define MAX_PLAYBACK_CHANNELS	(DSP_MAX_PCM_CHANNELS - 1)
 #else
 #define MAX_PLAYBACK_CHANNELS	1
@@ -1846,7 +1889,7 @@
 	int reg = kcontrol->private_value;
 
 	if (reg == CS46XX_MIXER_SPDIF_OUTPUT_ELEMENT)
-		ucontrol->value.integer.value[0] = chip->dsp_spos_instance->spdif_status_out;
+		ucontrol->value.integer.value[0] = (chip->dsp_spos_instance->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED);
 	else
 		ucontrol->value.integer.value[0] = chip->dsp_spos_instance->spdif_status_in;
 
@@ -1861,13 +1904,15 @@
 
 	switch (kcontrol->private_value) {
 	case CS46XX_MIXER_SPDIF_OUTPUT_ELEMENT:
-		change = chip->dsp_spos_instance->spdif_status_out;
+		down (&chip->spos_mutex);
+		change = (chip->dsp_spos_instance->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED);
 		if (ucontrol->value.integer.value[0] && !change) 
 			cs46xx_dsp_enable_spdif_out(chip);
 		else if (change && !ucontrol->value.integer.value[0])
 			cs46xx_dsp_disable_spdif_out(chip);
 
-		res = (change != chip->dsp_spos_instance->spdif_status_out);
+		res = (change != (chip->dsp_spos_instance->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED));
+		up (&chip->spos_mutex);
 		break;
 	case CS46XX_MIXER_SPDIF_INPUT_ELEMENT:
 		change = chip->dsp_spos_instance->spdif_status_in;
@@ -2785,10 +2830,8 @@
 /*
  *  initialize chip
  */
-
 static int snd_cs46xx_chip_init(cs46xx_t *chip, int busywait)
 {
-	unsigned int tmp;
 	int timeout;
 
 	/* 
@@ -2897,6 +2940,7 @@
 	snd_cs46xx_pokeBA0(chip, BA0_SERC2, SERC2_SI1F_AC97 | SERC1_SO1EN);
 	snd_cs46xx_pokeBA0(chip, BA0_SERMC1, SERMC1_PTC_AC97 | SERMC1_MSPE);
 
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	snd_cs46xx_pokeBA0(chip, BA0_SERC7, SERC7_ASDI2EN);
 	snd_cs46xx_pokeBA0(chip, BA0_SERC3, 0);
@@ -2907,6 +2951,7 @@
 
 	mdelay(5);
 
+
 	/*
 	 * Wait for the codec ready signal from the AC97 codec.
 	 */
@@ -2959,6 +3004,7 @@
 	snd_cs46xx_pokeBA0(chip, BA0_ACCTL2, ACCTL_VFRM | ACCTL_ESYN | ACCTL_RSTN);
 #endif
 
+
 	/*
 	 *  Wait until we've sampled input slots 3 and 4 as valid, meaning that
 	 *  the codec is pumping ADC data across the AC-link.
@@ -2987,7 +3033,10 @@
 	 *  Now, assert valid frame and the slot 3 and 4 valid bits.  This will
 	 *  commense the transfer of digital audio data to the AC97 codec.
 	 */
-	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, ACOSV_SLV3 | ACOSV_SLV4 | ACOSV_SLV7 | ACOSV_SLV8);
+
+	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, ACOSV_SLV3 | ACOSV_SLV4 | 
+			   ACOSV_SLV7 | ACOSV_SLV8);
+
 
 	/*
 	 *  Power down the DAC and ADC.  We will power them up (if) when we need
@@ -3002,13 +3051,21 @@
 	/* tmp = snd_cs46xx_peekBA0(chip, BA0_CLKCR1) & ~CLKCR1_SWCE; */
 	/* snd_cs46xx_pokeBA0(chip, BA0_CLKCR1, tmp); */
 
+	return 0;
+}
+
+/*
+ *  start and load DSP 
+ */
+int __devinit snd_cs46xx_start_dsp(cs46xx_t *chip)
+{	
+	unsigned int tmp;
 	/*
-         *  Reset the processor.
-         */
+	 *  Reset the processor.
+	 */
 	snd_cs46xx_reset(chip);
-
 	/*
-         *  Download the image to the processor.
+	 *  Download the image to the processor.
 	 */
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 #if 0
@@ -3040,7 +3097,6 @@
 
 	if (cs46xx_dsp_scb_and_task_init(chip) < 0)
 		return -EIO;
-	snd_printdd("[get here]\n");
 #else
 	/* old image */
 	if (snd_cs46xx_download_image(chip) < 0) {
@@ -3074,7 +3130,7 @@
 	 *  Enable interrupts on the part.
 	 */
 	snd_cs46xx_pokeBA0(chip, BA0_HICR, HICR_IEV | HICR_CHGM);
-
+        
 	tmp = snd_cs46xx_peek(chip, BA1_PFIE);
 	tmp &= ~0x0000f03f;
 	snd_cs46xx_poke(chip, BA1_PFIE, tmp);	/* playback interrupt enable */
@@ -3084,19 +3140,24 @@
 	tmp |=  0x00000001;
 	snd_cs46xx_poke(chip, BA1_CIE, tmp);	/* capture interrupt enable */
 	
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
 	/* set the attenuation to 0dB */ 
-	snd_cs46xx_poke(chip, BA1_PVOL, 0x80008000);
-	snd_cs46xx_poke(chip, BA1_CVOL, 0x80008000);
+	snd_cs46xx_poke(chip, (MASTERMIX_SCB_ADDR + 0xE) << 2, 0x80008000); 
+	snd_cs46xx_poke(chip, (VARIDECIMATE_SCB_ADDR + 0xE) << 2, 0x80008000);
+
+	/*
+	 * Initialize cs46xx SPDIF controller
+	 */
 
-#ifdef CONFIG_SND_CS46XX_NEW_DSP
 	/* time countdown enable */
 	cs46xx_poke_via_dsp (chip,SP_ASER_COUNTDOWN, 0x80000000);
-        
+
 	/* SPDIF input MASTER ENABLE */
 	cs46xx_poke_via_dsp (chip,SP_SPDIN_CONTROL, 0x800003ff);
-
-	/* mute spdif out */
-	cs46xx_dsp_disable_spdif_out(chip);
+#else
+	/* set the attenuation to 0dB */ 
+	snd_cs46xx_poke(chip, BA1_PVOL, 0x80008000);
+	snd_cs46xx_poke(chip, BA1_CVOL, 0x80008000);
 #endif
 
 	return 0;
@@ -3175,21 +3236,16 @@
 	valid_slots |= 0x200;
 	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, valid_slots);
 
-	valid_slots = snd_cs46xx_peekBA0(chip, BA0_ACOSV2);
-	valid_slots |= 0x200;
-	snd_cs46xx_pokeBA0(chip, BA0_ACOSV2, valid_slots);
+	if ( cs46xx_wait_for_fifo(chip,1) ) {
+	  snd_printdd("FIFO is busy\n");
+	  
+	  return -EINVAL;
+	}
 
 	/*
 	 * Fill slots 12 with the correct value for the GPIO pins. 
 	 */
 	for(idx = 0x90; idx <= 0x9F; idx++) {
-
-		if ( cs46xx_wait_for_fifo(chip) ) {
-			snd_printdd("failed waiting for FIFO at addr (%02X)\n",idx);
-
-			return -EINVAL;
-		}
-
 		/*
 		 * Initialize the fifo so that bits 7 and 8 are on.
 		 *
@@ -3197,6 +3253,15 @@
 		 * the left.  0x1800 corresponds to bits 7 and 8.
 		 */
 		snd_cs46xx_pokeBA0(chip, BA0_SERBWP, 0x1800);
+
+		/*
+		 * Wait for command to complete
+		 */
+		if ( cs46xx_wait_for_fifo(chip,200) ) {
+			snd_printdd("failed waiting for FIFO at addr (%02X)\n",idx);
+
+			return -EINVAL;
+		}
             
 		/*
 		 * Write the serial port FIFO index.
@@ -3207,14 +3272,10 @@
 		 * Tell the serial port to load the new value into the FIFO location.
 		 */
 		snd_cs46xx_pokeBA0(chip, BA0_SERBCM, SERBCM_WRC);
-
-		/*
-		 * Wait for command to complete
-		 */
 	}
 
 	/* wait for last command to complete */
-	cs46xx_wait_for_fifo(chip);
+	cs46xx_wait_for_fifo(chip,200);
 
 	/*
 	 *  Now, if we powered up the devices, then power them back down again.
@@ -3690,7 +3751,7 @@
 		snd_cs46xx_free(chip);
 		return err;
 	}
-
+	
 	chip->active_ctrl(chip, -1);
 
 	*rchip = chip;
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.h ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h
--- alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sat Nov  2 00:00:23 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sun Nov  3 20:17:40 2002
@@ -35,9 +35,17 @@
 #define CS46XX_BA1_REG_SIZE	  0x0100
 
 
-#define CS46XX_PERIOD_SIZE 2048
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+#define CS46XX_MIN_PERIOD_SIZE 1
+#define CS46XX_MAX_PERIOD_SIZE 1024*1024
+#else
+#define CS46XX_MIN_PERIOD_SIZE 2048
+#define CS46XX_MAX_PERIOD_SIZE 2048
+#endif
+
 #define CS46XX_FRAGS 2
-#define CS46XX_BUFFER_SIZE CS46XX_PERIOD_SIZE * CS46XX_FRAGS
+/* #define CS46XX_BUFFER_SIZE CS46XX_MAX_PERIOD_SIZE * CS46XX_FRAGS */
 
 #define SCB_NO_PARENT             0
 #define SCB_ON_PARENT_NEXT_SCB    1
@@ -100,6 +108,7 @@
                                             unsigned long len);
 int                    snd_cs46xx_clear_BA1(cs46xx_t *chip,unsigned long offset,unsigned long len);
 int                    cs46xx_dsp_enable_spdif_out (cs46xx_t *chip);
+int                    cs46xx_dsp_enable_spdif_hw (cs46xx_t *chip);
 int                    cs46xx_dsp_disable_spdif_out (cs46xx_t *chip);
 int                    cs46xx_dsp_enable_spdif_in (cs46xx_t *chip);
 int                    cs46xx_dsp_disable_spdif_in (cs46xx_t *chip);
@@ -199,8 +208,13 @@
 int                        cs46xx_dsp_pcm_link (cs46xx_t * chip,pcm_channel_descriptor_t * pcm_channel);
 dsp_scb_descriptor_t *     cs46xx_add_record_source (cs46xx_t *chip,dsp_scb_descriptor_t * source,
                                                      u16 addr,char * scb_name);
-int                         cs46xx_src_unlink(cs46xx_t *chip,dsp_scb_descriptor_t * src);
-int                         cs46xx_src_link(cs46xx_t *chip,dsp_scb_descriptor_t * src);
-int                         cs46xx_iec958_pre_open (cs46xx_t *chip);
-int                         cs46xx_iec958_post_close (cs46xx_t *chip);
+int                        cs46xx_src_unlink(cs46xx_t *chip,dsp_scb_descriptor_t * src);
+int                        cs46xx_src_link(cs46xx_t *chip,dsp_scb_descriptor_t * src);
+int                        cs46xx_iec958_pre_open (cs46xx_t *chip);
+int                        cs46xx_iec958_post_close (cs46xx_t *chip);
+int                        cs46xx_dsp_pcm_channel_set_period (cs46xx_t * chip,
+							       pcm_channel_descriptor_t * pcm_channel,
+							       int period_size);
+int                        cs46xx_dsp_pcm_ostream_set_period (cs46xx_t * chip,
+							      int period_size);
 #endif /* __CS46XX_LIB_H__ */
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Sat Nov  2 00:00:23 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Sun Nov  3 21:10:49 2002
@@ -1021,8 +1021,6 @@
 	dsp_scb_descriptor_t * record_mix_scb;
 	dsp_scb_descriptor_t * write_back_scb;
 	dsp_scb_descriptor_t * vari_decimate_scb;
-	dsp_scb_descriptor_t * pcm_serial_input_task;
-	dsp_scb_descriptor_t * asynch_tx_scb;
 	dsp_scb_descriptor_t * sec_codec_out_scb;
 	dsp_scb_descriptor_t * magic_snoop_scb;
 
@@ -1096,6 +1094,7 @@
 		ins->the_null_scb->sub_list_ptr = ins->the_null_scb;
 		ins->the_null_scb->next_scb_ptr = ins->the_null_scb;
 		ins->the_null_scb->parent_scb_ptr = NULL;
+		cs46xx_dsp_proc_register_scb_desc (chip,ins->the_null_scb);
 	}
 
 	{
@@ -1265,9 +1264,9 @@
 
 	/* create codec in */
 	codec_in_scb = cs46xx_dsp_create_codec_in_scb(chip,"CodecInSCB",0x0010,0x00A0,
-                                                  CODEC_INPUT_BUF1,
-                                                  CODECIN_SCB_ADDR,codec_out_scb,
-                                                  SCB_ON_PARENT_NEXT_SCB);
+						      CODEC_INPUT_BUF1,
+						      CODECIN_SCB_ADDR,codec_out_scb,
+						      SCB_ON_PARENT_NEXT_SCB);
 	if (!codec_in_scb) goto _fail_end;
 	ins->codec_in_scb = codec_in_scb;
 
@@ -1318,10 +1317,10 @@
 
 	/* create the rear PCM channel  mixer SCB */
 	rear_mix_scb = cs46xx_dsp_create_mix_only_scb(chip,"RearMixerSCB",
-                                                  MIX_SAMPLE_BUF3,
-                                                  REAR_MIXER_SCB_ADDR,
-                                                  sec_codec_out_scb,
-                                                  SCB_ON_PARENT_SUBLIST_SCB);
+						      MIX_SAMPLE_BUF3,
+						      REAR_MIXER_SCB_ADDR,
+						      sec_codec_out_scb,
+						      SCB_ON_PARENT_SUBLIST_SCB);
 	ins->rear_mix_scb = rear_mix_scb;
 	if (!rear_mix_scb) goto _fail_end;
 
@@ -1336,29 +1335,9 @@
 	if (!magic_snoop_scb) goto _fail_end;
 	ins->ref_snoop_scb = magic_snoop_scb;
 
-
-	/* The asynch. transfer task */
-	asynch_tx_scb = cs46xx_dsp_create_asynch_fg_tx_scb(chip,"AsynchFGTxSCB",ASYNCTX_SCB_ADDR,
-							   SPDIFO_SCB_INST,
-							   SPDIFO_IP_OUTPUT_BUFFER1,
-							   master_mix_scb,
-							   SCB_ON_PARENT_NEXT_SCB);
-
-	if (!asynch_tx_scb) goto _fail_end;
-	ins->asynch_tx_scb = asynch_tx_scb;
-
-	/* pcm input */
-	pcm_serial_input_task = cs46xx_dsp_create_pcm_serial_input_scb(chip,"PCMSerialInput_II",
-								       PCMSERIALINII_SCB_ADDR,
-								       magic_snoop_scb,asynch_tx_scb,
-								       SCB_ON_PARENT_SUBLIST_SCB);
-  
-	if (!pcm_serial_input_task) goto _fail_end;
-	ins->spdif_pcm_input_scb = pcm_serial_input_task; 
-
 	/* SP IO access */
 	if (!cs46xx_dsp_create_spio_write_scb(chip,"SPIOWriteSCB",SPIOWRITE_SCB_ADDR,
-					      asynch_tx_scb,
+					      magic_snoop_scb,
 					      SCB_ON_PARENT_NEXT_SCB))
 		goto _fail_end;
 
@@ -1518,6 +1497,7 @@
 		};
 
 		spdifo_scb_desc = cs46xx_dsp_create_scb(chip,"SPDIFOSCB",(u32 *)&spdifo_scb,SPDIFO_SCB_INST);
+
 		snd_assert(spdifo_scb_desc, return -EIO);
 		spdifi_scb_desc = cs46xx_dsp_create_scb(chip,"SPDIFISCB",(u32 *)&spdifi_scb,SPDIFI_SCB_INST);
 		snd_assert(spdifi_scb_desc, return -EIO);
@@ -1543,6 +1523,11 @@
 		   is the FG task tree */
 		fg_entry->parent_scb_ptr = spdifo_scb_desc;
 
+		/* for proc fs */
+		cs46xx_dsp_proc_register_scb_desc (chip,spdifo_scb_desc);
+		cs46xx_dsp_proc_register_scb_desc (chip,spdifi_scb_desc);
+		cs46xx_dsp_proc_register_scb_desc (chip,async_codec_scb_desc);
+
 		/* Async MASTER ENABLE, affects both SPDIF input and output */
 		snd_cs46xx_pokeBA0(chip, BA0_ASER_MASTER, 0x1 );
 	}
@@ -1550,7 +1535,7 @@
 	return 0;
 }
 
-int cs46xx_dsp_enable_spdif_out (cs46xx_t *chip)
+int cs46xx_dsp_enable_spdif_hw (cs46xx_t *chip)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
@@ -1560,29 +1545,11 @@
 	/* SPDIF output MASTER ENABLE */
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CONTROL, 0x80000000);
 
-	/* right and left validate bit 
-	   NOTE: 0x80000000 and enables the SCMC protection on stream 
-	*/
+	/* right and left validate bit */
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12));
 
 	/* monitor state */
-	ins->spdif_status_out = 1;
-
-	return 0;
-}
-
-int  cs46xx_dsp_disable_spdif_out (cs46xx_t *chip)
-{
-	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
-
-	/* disable  SPDIF output FIFO slot */
-	snd_cs46xx_pokeBA0(chip, BA0_ASER_FADDR, 0);
-
-	/* SPDIF output MASTER DISABLE */
-	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CONTROL, 0x0);
-
-	/* monitor state */
-	ins->spdif_status_out = 0;
+	ins->spdif_status_out |= DSP_SDPIF_STATUS_HW_ENABLED;
 
 	return 0;
 }
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.h ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h
--- alsa-kernel/pci/cs46xx/dsp_spos.h	Sat Nov  2 00:00:23 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h	Sat Nov  2 19:27:36 2002
@@ -183,5 +183,14 @@
 #define SP_SPDOUT_CONTROL 0x804D
 #define SP_SPDOUT_CSUV    0x808E
 
+static inline void cs46xx_dsp_spos_update_scb (cs46xx_t * chip,dsp_scb_descriptor_t * scb) 
+{
+	/* update nextSCB and subListPtr in SCB */
+	snd_cs46xx_poke(chip,
+			(scb->address + SCBsubListPtr) << 2,
+			(scb->sub_list_ptr->address << 0x10) |
+			(scb->next_scb_ptr->address));	
+}
+
 #endif /* __DSP_SPOS_H__ */
 #endif /* CONFIG_SND_CS46XX_NEW_DSP  */
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sat Nov  2 00:00:23 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sun Nov  3 20:24:26 2002
@@ -150,17 +150,11 @@
 		spin_lock_irqsave(&chip->reg_lock, flags);    
 
 		/* update parent first entry in DSP RAM */
-		snd_cs46xx_poke(chip,
-				(scb->parent_scb_ptr->address + SCBsubListPtr) << 2,
-				(scb->parent_scb_ptr->sub_list_ptr->address << 0x10) |
-				(scb->parent_scb_ptr->next_scb_ptr->address));
+		cs46xx_dsp_spos_update_scb(chip,scb->parent_scb_ptr);
 
 		/* then update entry in DSP RAM */
-		snd_cs46xx_poke(chip,
-				(scb->address + SCBsubListPtr) << 2,
-				(scb->sub_list_ptr->address << 0x10) |
-				(scb->next_scb_ptr->address));
-    
+		cs46xx_dsp_spos_update_scb(chip,scb);
+
 		scb->parent_scb_ptr = NULL;
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	}
@@ -173,6 +167,7 @@
   
 	for (i = 0; i < dword_count ; ++i ) {
 		writel(0, dst);
+		dst += 4;
 	}  
 }
 
@@ -328,11 +323,9 @@
 		}
 
 		spin_lock_irqsave(&chip->reg_lock, flags);
+
 		/* update entry in DSP RAM */
-		snd_cs46xx_poke(chip,
-				(scb->parent_scb_ptr->address + SCBsubListPtr) << 2,
-				(scb->parent_scb_ptr->sub_list_ptr->address << 0x10) |
-				(scb->parent_scb_ptr->next_scb_ptr->address));
+		cs46xx_dsp_spos_update_scb(chip,scb->parent_scb_ptr);
 
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	}
@@ -1242,6 +1235,83 @@
 	return (ins->pcm_channels + pcm_index);
 }
 
+int cs46xx_dsp_pcm_channel_set_period (cs46xx_t * chip,
+				       pcm_channel_descriptor_t * pcm_channel,
+				       int period_size)
+{
+	u32 temp = snd_cs46xx_peek (chip,pcm_channel->pcm_reader_scb->address << 2);
+	temp &= ~DMA_RQ_C1_SOURCE_SIZE_MASK;
+
+	switch (period_size) {
+	case 2048:
+		temp |= DMA_RQ_C1_SOURCE_MOD1024;
+		break;
+	case 1024:
+		temp |= DMA_RQ_C1_SOURCE_MOD512;
+		break;
+	case 512:
+		temp |= DMA_RQ_C1_SOURCE_MOD256;
+		break;
+	case 256:
+		temp |= DMA_RQ_C1_SOURCE_MOD128;
+		break;
+	case 128:
+		temp |= DMA_RQ_C1_SOURCE_MOD64;
+		break;
+	case 64:
+		temp |= DMA_RQ_C1_SOURCE_MOD32;
+		break;		      
+	case 32:
+		temp |= DMA_RQ_C1_SOURCE_MOD16;
+		break; 
+	default:
+		snd_printdd ("period size (%d) not supported by HW\n");
+		return -EINVAL;
+	}
+
+	snd_cs46xx_poke (chip,pcm_channel->pcm_reader_scb->address << 2,temp);
+
+	return 0;
+}
+
+int cs46xx_dsp_pcm_ostream_set_period (cs46xx_t * chip,
+				       int period_size)
+{
+	u32 temp = snd_cs46xx_peek (chip,WRITEBACK_SCB_ADDR << 2);
+	temp &= ~DMA_RQ_C1_DEST_SIZE_MASK;
+
+	switch (period_size) {
+	case 2048:
+		temp |= DMA_RQ_C1_DEST_MOD1024;
+		break;
+	case 1024:
+		temp |= DMA_RQ_C1_DEST_MOD512;
+		break;
+	case 512:
+		temp |= DMA_RQ_C1_DEST_MOD256;
+		break;
+	case 256:
+		temp |= DMA_RQ_C1_DEST_MOD128;
+		break;
+	case 128:
+		temp |= DMA_RQ_C1_DEST_MOD64;
+		break;
+	case 64:
+		temp |= DMA_RQ_C1_DEST_MOD32;
+		break;		      
+	case 32:
+		temp |= DMA_RQ_C1_DEST_MOD16;
+		break; 
+	default:
+		snd_printdd ("period size (%d) not supported by HW\n");
+		return -EINVAL;
+	}
+
+	snd_cs46xx_poke (chip,WRITEBACK_SCB_ADDR << 2,temp);
+
+	return 0;
+}
+
 void cs46xx_dsp_destroy_pcm_channel (cs46xx_t * chip,pcm_channel_descriptor_t * pcm_channel)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
@@ -1323,17 +1393,13 @@
 	snd_assert (pcm_channel->pcm_reader_scb->parent_scb_ptr == NULL, ; );
 	pcm_channel->pcm_reader_scb->parent_scb_ptr = parent_scb;
 
-	/* update entry in DSP RAM */
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	snd_cs46xx_poke(chip,
-			(pcm_channel->pcm_reader_scb->address + SCBsubListPtr) << 2,
-			(pcm_channel->pcm_reader_scb->sub_list_ptr->address << 0x10) |
-			(pcm_channel->pcm_reader_scb->next_scb_ptr->address));
-    
-	snd_cs46xx_poke(chip,
-			(parent_scb->address + SCBsubListPtr) << 2,
-			(parent_scb->sub_list_ptr->address << 0x10) |
-			(parent_scb->next_scb_ptr->address));
+
+	/* update SCB entry in DSP RAM */
+	cs46xx_dsp_spos_update_scb(chip,pcm_channel->pcm_reader_scb);
+
+	/* update parent SCB entry */
+	cs46xx_dsp_spos_update_scb(chip,parent_scb);
 
 	pcm_channel->unlinked = 0;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -1455,47 +1521,136 @@
 	src->parent_scb_ptr = parent_scb;
 
 	/* update entry in DSP RAM */
-	snd_cs46xx_poke(chip,
-			(parent_scb->address + SCBsubListPtr) << 2,
-			(parent_scb->sub_list_ptr->address << 0x10) |
-			(parent_scb->next_scb_ptr->address));
+	cs46xx_dsp_spos_update_scb(chip,parent_scb);
   
 	return 0;
 }
 
-int cs46xx_iec958_pre_open (cs46xx_t *chip)
+int cs46xx_dsp_enable_spdif_out (cs46xx_t *chip)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
-	snd_assert (ins->spdif_pcm_input_scb != NULL);
-	snd_assert (ins->asynch_tx_scb->sub_list_ptr == ins->spdif_pcm_input_scb);
+	if ( ! (ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) ) {
+		cs46xx_dsp_enable_spdif_hw (chip);
+	}
+
+	/* dont touch anything if SPDIF is open */
+	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) {
+		/* when cs46xx_iec958_post_close(...) is called it
+		   will call this function if necesary depending on
+		   this bit */
+		ins->spdif_status_out |= DSP_SDPIF_STATUS_OUTPUT_ENABLED;
+
+		return -EBUSY;
+	}
+
+	snd_assert (ins->asynch_tx_scb == NULL, return -EINVAL);
+	snd_assert (ins->master_mix_scb->next_scb_ptr == ins->the_null_scb, return -EINVAL);
+
+	/* reset output snooper sample buffer pointer */
+	snd_cs46xx_poke (chip, (ins->ref_snoop_scb->address + 2) << 2,
+			 (OUTPUT_SNOOP_BUFFER + 0x10) << 0x10 );
+	
+	/* The asynch. transfer task */
+	ins->asynch_tx_scb = cs46xx_dsp_create_asynch_fg_tx_scb(chip,"AsynchFGTxSCB",ASYNCTX_SCB_ADDR,
+								SPDIFO_SCB_INST,
+								SPDIFO_IP_OUTPUT_BUFFER1,
+								ins->master_mix_scb,
+								SCB_ON_PARENT_NEXT_SCB);
+	if (!ins->asynch_tx_scb) return -ENOMEM;
+
+	ins->spdif_pcm_input_scb = cs46xx_dsp_create_pcm_serial_input_scb(chip,"PCMSerialInput_II",
+									  PCMSERIALINII_SCB_ADDR,
+									  ins->ref_snoop_scb,
+									  ins->asynch_tx_scb,
+									  SCB_ON_PARENT_SUBLIST_SCB);
+  
+	
+	if (!ins->spdif_pcm_input_scb) return -ENOMEM;
 
-	/*cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12) | (1 << 2)); */
+	/* monitor state */
+	ins->spdif_status_out |= DSP_SDPIF_STATUS_OUTPUT_ENABLED;
 
-	_dsp_unlink_scb (chip,ins->spdif_pcm_input_scb);
 	return 0;
 }
 
-int cs46xx_iec958_post_close (cs46xx_t *chip)
+int  cs46xx_dsp_disable_spdif_out (cs46xx_t *chip)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
-	snd_assert (ins->spdif_pcm_input_scb != NULL);
-	snd_assert (ins->asynch_tx_scb->sub_list_ptr == ins->the_null_scb);
-	snd_assert (ins->spdif_pcm_input_scb->parent_scb_ptr == NULL);
+	/* dont touch anything if SPDIF is open */
+	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) {
+		ins->spdif_status_out &= ~DSP_SDPIF_STATUS_OUTPUT_ENABLED;
+		return -EBUSY;
+	}
+
+	/* check integrety */
+	snd_assert (ins->asynch_tx_scb != NULL, return -EINVAL);
+	snd_assert (ins->spdif_pcm_input_scb != NULL,return -EINVAL);
+	snd_assert (ins->master_mix_scb->next_scb_ptr == ins->asynch_tx_scb, return -EINVAL);
+	snd_assert (ins->asynch_tx_scb->parent_scb_ptr == ins->master_mix_scb, return -EINVAL);
+
+	cs46xx_dsp_remove_scb (chip,ins->spdif_pcm_input_scb);
+	cs46xx_dsp_remove_scb (chip,ins->asynch_tx_scb);
 
-	/* relink the SPDIF output PCM ref */
-	ins->asynch_tx_scb->sub_list_ptr = ins->spdif_pcm_input_scb;
-	ins->spdif_pcm_input_scb->parent_scb_ptr = ins->asynch_tx_scb;
+	ins->spdif_pcm_input_scb = NULL;
+	ins->asynch_tx_scb = NULL;
 
+	/* clear buffer to prevent any undesired noise */
+	_dsp_clear_sample_buffer(chip,SPDIFO_IP_OUTPUT_BUFFER1,256);
 
-	/* cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12)); */
+	/* monitor state */
+	ins->spdif_status_out  &= ~DSP_SDPIF_STATUS_OUTPUT_ENABLED;
 
-	/* update entry in DSP RAM */
-	snd_cs46xx_poke(chip,
-			(ins->asynch_tx_scb->address + SCBsubListPtr) << 2,
-			(ins->asynch_tx_scb->sub_list_ptr->address << 0x10) |
-			(ins->asynch_tx_scb->next_scb_ptr->address));
 
+	return 0;
+}
+
+int cs46xx_iec958_pre_open (cs46xx_t *chip)
+{
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED ) {
+		/* remove AsynchFGTxSCB and and PCMSerialInput_II */
+		cs46xx_dsp_disable_spdif_out (chip);
+
+		/* save state */
+		ins->spdif_status_out |= DSP_SDPIF_STATUS_OUTPUT_ENABLED;
+	}
+
+	/* Create the asynch. transfer task  for playback */
+	ins->asynch_tx_scb = cs46xx_dsp_create_asynch_fg_tx_scb(chip,"AsynchFGTxSCB",ASYNCTX_SCB_ADDR,
+								SPDIFO_SCB_INST,
+								SPDIFO_IP_OUTPUT_BUFFER1,
+								ins->master_mix_scb,
+								SCB_ON_PARENT_NEXT_SCB);
+
+	/* cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 15) | 
+	   (1 << 14) | (1 << 2) | (1 << 3)); */
+
+	ins->spdif_status_out  |= DSP_SDPIF_STATUS_PLAYBACK_OPEN;
+
+	return 0;
+}
+
+int cs46xx_iec958_post_close (cs46xx_t *chip)
+{
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	snd_assert (ins->asynch_tx_scb != NULL, return -EINVAL);
+
+	ins->spdif_status_out  &= ~DSP_SDPIF_STATUS_PLAYBACK_OPEN;
+
+	/*cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12));*/
+	
+	/* deallocate stuff */
+	cs46xx_dsp_remove_scb (chip,ins->asynch_tx_scb);
+	ins->asynch_tx_scb = NULL;
+
+	/* restore state */
+	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED ) {
+		cs46xx_dsp_enable_spdif_out (chip);
+	}
+	
 	return 0;
 }

--------------010701020604030102060306--



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
