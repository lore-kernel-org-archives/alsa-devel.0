From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx fix problem when playbacking mono and 8 bit PCM
Date: Sun, 05 Jan 2003 01:05:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E1776C4.2000200@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030904060901020600070701"
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
--------------030904060901020600070701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The current cs46xx driver set's a incorrect DMA buffer size when 
playbacking, 8bit and mono pcm, that should be fixed by this patch.

(I'm still a newbie when it's about ALSA API stuffs, as I recently 
discovered the existence of SNDRV_PCM_HW_PARAM_PERIOD_BYTES and 
SNDRV_PCM_HW_PARAM_PERIOD_SIZE parameters ...)

/Benny


--------------030904060901020600070701
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sat Jan  4 23:46:27 2003
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Jan  5 00:48:56 2003
@@ -26,7 +26,7 @@
  *           at Cirrus for have helping me out with the DSP, however we
  *           still dont have sufficient documentation and technical
  *           references to be able to implement all fancy feutures
- *           supported by the cs46xx DPS's. 
+ *           supported by the cs46xx DSP's. 
  *           Benny <benny@hostmobility.com>
  *                
  *   This program is free software; you can redistribute it and/or modify
@@ -57,6 +57,8 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/cs46xx.h>
 
 #include <asm/io.h>
@@ -730,10 +732,12 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_sframes_t diff;
 	cs46xx_pcm_t * cpcm;
-	int buffer_size = runtime->period_size * CS46XX_FRAGS * 4;
+	int buffer_size;
 
 	cpcm = snd_magic_cast(cs46xx_pcm_t, substream->runtime->private_data, return -ENXIO);
 
+	buffer_size = runtime->period_size * CS46XX_FRAGS << cpcm->shift;
+
 	diff = runtime->control->appl_ptr - cpcm->appl_ptr;
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
@@ -774,7 +778,7 @@
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_sframes_t diff = runtime->control->appl_ptr - chip->capt.appl_ptr;
-	int buffer_size = runtime->period_size * CS46XX_FRAGS * 4;
+	int buffer_size = runtime->period_size * CS46XX_FRAGS << chip->capt.shift;
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
@@ -830,7 +834,7 @@
 	size_t ptr;
 	cs46xx_pcm_t *cpcm = snd_magic_cast(cs46xx_pcm_t, substream->runtime->private_data, return -ENXIO);
 	ssize_t bytes;
-	int buffer_size = substream->runtime->period_size * CS46XX_FRAGS * 4;
+	int buffer_size = substream->runtime->period_size * CS46XX_FRAGS << cpcm->shift;
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	snd_assert (cpcm->pcm_channel,return -ENXIO);
@@ -865,7 +869,7 @@
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	size_t ptr = snd_cs46xx_peek(chip, BA1_CBA) - chip->capt.hw_addr;
 	ssize_t bytes = ptr - chip->capt.hw_io;
-	int buffer_size = substream->runtime->period_size * CS46XX_FRAGS * 4;
+	int buffer_size = substream->runtime->period_size * CS46XX_FRAGS << chip->capt.shift;
 
 	if (bytes < 0)
 		bytes += buffer_size;
@@ -1071,7 +1075,7 @@
 	int err;
 	cs46xx_t *chip = snd_pcm_substream_chip(substream);
 	int sample_rate = params_rate(hw_params);
-	int period_size = params_period_size(hw_params);
+	int period_size = params_period_bytes(hw_params);
 	cpcm = snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -ENXIO);
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
@@ -1090,12 +1094,15 @@
 		return -ENXIO;
 	}
 
-	if (cs46xx_dsp_pcm_channel_set_period (chip,cpcm->pcm_channel,period_size * 4)) {
+
+	if (cs46xx_dsp_pcm_channel_set_period (chip,cpcm->pcm_channel,period_size)) {
 		 up (&chip->spos_mutex);
 		 return -EINVAL;
 	 }
-	snd_printdd ("period_size (%d), periods (%d)\n",
-		     period_size, params_periods(hw_params));
+
+	snd_printdd ("period_size (%d), periods (%d) buffer_size(%d)\n",
+		     period_size, params_periods(hw_params),
+		     params_buffer_bytes(hw_params));
 #endif
 
 	if (params_periods(hw_params) == CS46XX_FRAGS) {
@@ -1256,11 +1263,14 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 	int period_size = params_period_size(hw_params);
+	int factor;
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	snd_printdd ("capture period size (%d)\n",period_size);
+	
+	factor = (runtime->periods == CS46XX_FRAGS) ? CS46XX_FRAGS : (CS46XX_FRAGS * 2);
 
-	cs46xx_dsp_pcm_ostream_set_period (chip,period_size * 4);
+	cs46xx_dsp_pcm_ostream_set_period (chip,period_size * factor);
 #endif
 	if (runtime->periods == CS46XX_FRAGS) {
 		if (runtime->dma_area != chip->capt.hw_area)
@@ -1445,7 +1455,7 @@
 	.fifo_size =		0,
 };
 
-static unsigned int period_sizes[] = { 8, 16, 32, 64, 128, 256, 512 };
+static unsigned int period_sizes[] = { 32, 64, 128, 256, 512, 1024, 2048 };
 
 #define PERIOD_SIZES sizeof(period_sizes) / sizeof(period_sizes[0])
 
@@ -1488,8 +1498,11 @@
 	cpcm->pcm_channel = NULL; 
 	cpcm->pcm_channel_id = pcm_channel_id;
 
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 
 				   &hw_constraints_period_sizes);
+
 	up (&chip->spos_mutex);
 #else
 	chip->playback_pcm = cpcm; /* HACK */
@@ -1565,7 +1578,8 @@
 	chip->amplifier_ctrl(chip, 1);
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	snd_pcm_hw_constraint_list(substream->runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 
 				   &hw_constraints_period_sizes);
 #endif
 	return 0;

--------------030904060901020600070701--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
