From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 19/24] sound/pci: coding style fixes:
	sound/pci/r*
Date: Tue, 9 Sep 2008 06:00:18 +0400
Message-ID: <20080909020018.GV6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 4487910383C
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 04:00:24 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1537270fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 19:00:24 -0700 (PDT)
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

 sound/pci/riptide/riptide.c |   22 +++---
 sound/pci/rme32.c           |  128 +++++++++++++-------------
 sound/pci/rme96.c           |  210 +++++++++++++++++++++---------------------
 3 files changed, 180 insertions(+), 180 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index e9f0706..04b21de 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -21,29 +21,29 @@
 /*
   History:
    - 02/15/2004 first release
-   
+
   This Driver is based on the OSS Driver version from Linuxant (riptide-0.6lnxtbeta03111100)
   credits from the original files:
-  
-  MODULE NAME:        cnxt_rt.h                       
+
+  MODULE NAME:        cnxt_rt.h
   AUTHOR:             K. Lazarev  (Transcribed by KNL)
   HISTORY:         Major Revision               Date        By
             -----------------------------     --------     -----
             Created                           02/1/2000     KNL
 
-  MODULE NAME:     int_mdl.c                       
+  MODULE NAME:     int_mdl.c
   AUTHOR:          Konstantin Lazarev    (Transcribed by KNL)
   HISTORY:         Major Revision               Date        By
             -----------------------------     --------     -----
             Created                           10/01/99      KNL
-	    
-  MODULE NAME:        riptide.h                       
+
+  MODULE NAME:        riptide.h
   AUTHOR:             O. Druzhinin  (Transcribed by OLD)
   HISTORY:         Major Revision               Date        By
             -----------------------------     --------     -----
             Created                           10/16/97      OLD
 
-  MODULE NAME:        Rp_Cmdif.cpp                       
+  MODULE NAME:        Rp_Cmdif.cpp
   AUTHOR:             O. Druzhinin  (Transcribed by OLD)
                       K. Lazarev    (Transcribed by KNL)
   HISTORY:         Major Revision               Date        By
@@ -51,7 +51,7 @@
             Adopted from NT4 driver            6/22/99      OLD
             Ported to Linux                    9/01/99      KNL
 
-  MODULE NAME:        rt_hw.c                       
+  MODULE NAME:        rt_hw.c
   AUTHOR:             O. Druzhinin  (Transcribed by OLD)
                       C. Lazarev    (Transcribed by CNL)
   HISTORY:         Major Revision               Date        By
@@ -73,13 +73,13 @@
             -----------------------------     --------     -----
             Created                           11/18/97      CNL
 
-  MODULE NAME:     rt_mdl.c                       
+  MODULE NAME:     rt_mdl.c
   AUTHOR:          Konstantin Lazarev    (Transcribed by KNL)
   HISTORY:         Major Revision               Date        By
             -----------------------------     --------     -----
             Created                           10/01/99      KNL
 
-  MODULE NAME:        mixer.h                        
+  MODULE NAME:        mixer.h
   AUTHOR:             K. Kenney
   HISTORY:         Major Revision                   Date          By
             -----------------------------          --------     -----
@@ -97,7 +97,7 @@
 #include <linux/gameport.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index e7ef3a1..21ec1e2 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -6,7 +6,7 @@
  *
  *      Thanks to :        Anders Torger <torger@ludd.luth.se>,
  *                         Henk Hesselink <henk@anda.nl>
- *                         for writing the digi96-driver 
+ *                         for writing the digi96-driver
  *                         and RME for all informations.
  *
  *   This program is free software; you can redistribute it and/or modify
@@ -22,36 +22,36 @@
  *   You should have received a copy of the GNU General Public License
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- * 
- * 
+ *
+ *
  * ****************************************************************************
- * 
+ *
  * Note #1 "Sek'd models" ................................... martin 2002-12-07
- * 
+ *
  * Identical soundcards by Sek'd were labeled:
  * RME Digi 32     = Sek'd Prodif 32
  * RME Digi 32 Pro = Sek'd Prodif 96
  * RME Digi 32/8   = Sek'd Prodif Gold
- * 
+ *
  * ****************************************************************************
- * 
+ *
  * Note #2 "full duplex mode" ............................... martin 2002-12-07
- * 
+ *
  * Full duplex doesn't work. All cards (32, 32/8, 32Pro) are working identical
  * in this mode. Rec data and play data are using the same buffer therefore. At
  * first you have got the playing bits in the buffer and then (after playing
- * them) they were overwitten by the captured sound of the CS8412/14. Both 
+ * them) they were overwitten by the captured sound of the CS8412/14. Both
  * modes (play/record) are running harmonically hand in hand in the same buffer
- * and you have only one start bit plus one interrupt bit to control this 
+ * and you have only one start bit plus one interrupt bit to control this
  * paired action.
  * This is opposite to the latter rme96 where playing and capturing is totally
- * separated and so their full duplex mode is supported by alsa (using two 
- * start bits and two interrupts for two different buffers). 
+ * separated and so their full duplex mode is supported by alsa (using two
+ * start bits and two interrupts for two different buffers).
  * But due to the wrong sequence of playing and capturing ALSA shows no solved
  * full duplex support for the rme32 at the moment. That's bad, but I'm not
  * able to solve it. Are you motivated enough to solve this problem now? Your
  * patch would be welcome!
- * 
+ *
  * ****************************************************************************
  *
  * "The story after the long seeking" -- tiwai
@@ -85,12 +85,12 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
-static int fullduplex[SNDRV_CARDS]; // = {[0 ... (SNDRV_CARDS - 1)] = 1};
+static int fullduplex[SNDRV_CARDS]; /* = {[0 ... (SNDRV_CARDS - 1)] = 1}; */
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for RME Digi32 soundcard.");
@@ -126,10 +126,10 @@ MODULE_SUPPORTED_DEVICE("{{RME,Digi32}," "{RME,Digi32/8}," "{RME,Digi32 PRO}}");
 #define RME32_WCR_MONO      (1 << 1)    /* 0=stereo, 1=mono
                                            Setting the whole card to mono
                                            doesn't seem to be very useful.
-                                           A software-solution can handle 
+                                           A software-solution can handle
                                            full-duplex with one direction in
-                                           stereo and the other way in mono. 
-                                           So, the hardware should work all 
+                                           stereo and the other way in mono.
+                                           So, the hardware should work all
                                            the time in stereo! */
 #define RME32_WCR_MODE24    (1 << 2)    /* 0=16bit, 1=32bit */
 #define RME32_WCR_SEL       (1 << 3)    /* 0=input on output, 1=normal playback/capture */
@@ -304,13 +304,13 @@ static int snd_rme32_capture_copy(struct snd_pcm_substream *substream, int chann
 static struct snd_pcm_hardware snd_rme32_spdif_info = {
 	.info =		(SNDRV_PCM_INFO_MMAP_IOMEM |
 			 SNDRV_PCM_INFO_MMAP_VALID |
-			 SNDRV_PCM_INFO_INTERLEAVED | 
+			 SNDRV_PCM_INFO_INTERLEAVED |
 			 SNDRV_PCM_INFO_PAUSE |
 			 SNDRV_PCM_INFO_SYNC_START),
-	.formats =	(SNDRV_PCM_FMTBIT_S16_LE | 
+	.formats =	(SNDRV_PCM_FMTBIT_S16_LE |
 			 SNDRV_PCM_FMTBIT_S32_LE),
 	.rates =	(SNDRV_PCM_RATE_32000 |
-			 SNDRV_PCM_RATE_44100 | 
+			 SNDRV_PCM_RATE_44100 |
 			 SNDRV_PCM_RATE_48000),
 	.rate_min =	32000,
 	.rate_max =	48000,
@@ -335,7 +335,7 @@ static struct snd_pcm_hardware snd_rme32_adat_info =
 			      SNDRV_PCM_INFO_PAUSE |
 			      SNDRV_PCM_INFO_SYNC_START),
 	.formats=            SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =             (SNDRV_PCM_RATE_44100 | 
+	.rates =             (SNDRV_PCM_RATE_44100 |
 			      SNDRV_PCM_RATE_48000),
 	.rate_min =          44100,
 	.rate_max =          48000,
@@ -355,13 +355,13 @@ static struct snd_pcm_hardware snd_rme32_adat_info =
 static struct snd_pcm_hardware snd_rme32_spdif_fd_info = {
 	.info =		(SNDRV_PCM_INFO_MMAP |
 			 SNDRV_PCM_INFO_MMAP_VALID |
-			 SNDRV_PCM_INFO_INTERLEAVED | 
+			 SNDRV_PCM_INFO_INTERLEAVED |
 			 SNDRV_PCM_INFO_PAUSE |
 			 SNDRV_PCM_INFO_SYNC_START),
-	.formats =	(SNDRV_PCM_FMTBIT_S16_LE | 
+	.formats =	(SNDRV_PCM_FMTBIT_S16_LE |
 			 SNDRV_PCM_FMTBIT_S32_LE),
 	.rates =	(SNDRV_PCM_RATE_32000 |
-			 SNDRV_PCM_RATE_44100 | 
+			 SNDRV_PCM_RATE_44100 |
 			 SNDRV_PCM_RATE_48000),
 	.rate_min =	32000,
 	.rate_max =	48000,
@@ -386,7 +386,7 @@ static struct snd_pcm_hardware snd_rme32_adat_fd_info =
 			      SNDRV_PCM_INFO_PAUSE |
 			      SNDRV_PCM_INFO_SYNC_START),
 	.formats=            SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =             (SNDRV_PCM_RATE_44100 | 
+	.rates =             (SNDRV_PCM_RATE_44100 |
 			      SNDRV_PCM_RATE_48000),
 	.rate_min =          44100,
 	.rate_max =          48000,
@@ -434,7 +434,7 @@ static int snd_rme32_capture_getrate(struct rme32 * rme32, int *is_adat)
 	int n;
 
 	*is_adat = 0;
-	if (rme32->rcreg & RME32_RCR_LOCK) { 
+	if (rme32->rcreg & RME32_RCR_LOCK) {
                 /* ADAT rate */
                 *is_adat = 1;
 	}
@@ -466,7 +466,7 @@ static int snd_rme32_capture_getrate(struct rme32 * rme32, int *is_adat)
 		default:
 			return -1;
 			break;
-		} 
+		}
 	else
 		switch (n) {	/* supporting the CS8412 */
 		case 0:
@@ -499,38 +499,38 @@ static int snd_rme32_playback_setrate(struct rme32 * rme32, int rate)
 	switch (rate) {
 	case 32000:
 		rme32->wcreg &= ~RME32_WCR_DS_BM;
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) & 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) &
 			~RME32_WCR_FREQ_1;
 		break;
 	case 44100:
 		rme32->wcreg &= ~RME32_WCR_DS_BM;
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_1) & 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_1) &
 			~RME32_WCR_FREQ_0;
 		break;
 	case 48000:
 		rme32->wcreg &= ~RME32_WCR_DS_BM;
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) | 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) |
 			RME32_WCR_FREQ_1;
 		break;
 	case 64000:
 		if (rme32->pci->device != PCI_DEVICE_ID_RME_DIGI32_PRO)
 			return -EINVAL;
 		rme32->wcreg |= RME32_WCR_DS_BM;
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) & 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) &
 			~RME32_WCR_FREQ_1;
 		break;
 	case 88200:
 		if (rme32->pci->device != PCI_DEVICE_ID_RME_DIGI32_PRO)
 			return -EINVAL;
 		rme32->wcreg |= RME32_WCR_DS_BM;
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_1) & 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_1) &
 			~RME32_WCR_FREQ_0;
 		break;
 	case 96000:
 		if (rme32->pci->device != PCI_DEVICE_ID_RME_DIGI32_PRO)
 			return -EINVAL;
 		rme32->wcreg |= RME32_WCR_DS_BM;
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) | 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) |
 			RME32_WCR_FREQ_1;
 		break;
 	default:
@@ -552,22 +552,22 @@ static int snd_rme32_setclockmode(struct rme32 * rme32, int mode)
 	switch (mode) {
 	case RME32_CLOCKMODE_SLAVE:
 		/* AutoSync */
-		rme32->wcreg = (rme32->wcreg & ~RME32_WCR_FREQ_0) & 
+		rme32->wcreg = (rme32->wcreg & ~RME32_WCR_FREQ_0) &
 			~RME32_WCR_FREQ_1;
 		break;
 	case RME32_CLOCKMODE_MASTER_32:
 		/* Internal 32.0kHz */
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) & 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) &
 			~RME32_WCR_FREQ_1;
 		break;
 	case RME32_CLOCKMODE_MASTER_44:
 		/* Internal 44.1kHz */
-		rme32->wcreg = (rme32->wcreg & ~RME32_WCR_FREQ_0) | 
+		rme32->wcreg = (rme32->wcreg & ~RME32_WCR_FREQ_0) |
 			RME32_WCR_FREQ_1;
 		break;
 	case RME32_CLOCKMODE_MASTER_48:
 		/* Internal 48.0kHz */
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) | 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) |
 			RME32_WCR_FREQ_1;
 		break;
 	default:
@@ -587,19 +587,19 @@ static int snd_rme32_setinputtype(struct rme32 * rme32, int type)
 {
 	switch (type) {
 	case RME32_INPUT_OPTICAL:
-		rme32->wcreg = (rme32->wcreg & ~RME32_WCR_INP_0) & 
+		rme32->wcreg = (rme32->wcreg & ~RME32_WCR_INP_0) &
 			~RME32_WCR_INP_1;
 		break;
 	case RME32_INPUT_COAXIAL:
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_INP_0) & 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_INP_0) &
 			~RME32_WCR_INP_1;
 		break;
 	case RME32_INPUT_INTERNAL:
-		rme32->wcreg = (rme32->wcreg & ~RME32_WCR_INP_0) | 
+		rme32->wcreg = (rme32->wcreg & ~RME32_WCR_INP_0) |
 			RME32_WCR_INP_1;
 		break;
 	case RME32_INPUT_XLR:
-		rme32->wcreg = (rme32->wcreg | RME32_WCR_INP_0) | 
+		rme32->wcreg = (rme32->wcreg | RME32_WCR_INP_0) |
 			RME32_WCR_INP_1;
 		break;
 	default:
@@ -741,7 +741,7 @@ snd_rme32_capture_hw_params(struct snd_pcm_substream *substream,
 	if ((rate = snd_rme32_capture_getrate(rme32, &isadat)) > 0) {
                 if ((int)params_rate(params) != rate) {
 			spin_unlock_irq(&rme32->lock);
-                        return -EIO;                    
+                        return -EIO;
                 }
                 if ((isadat && runtime->hw.channels_min == 2) ||
                     (!isadat && runtime->hw.channels_min == 8)) {
@@ -771,7 +771,7 @@ snd_rme32_capture_hw_params(struct snd_pcm_substream *substream,
 static int snd_rme32_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct rme32 *rme32 = snd_pcm_substream_chip(substream);
-	if (! rme32->fullduplex_mode)
+	if (!rme32->fullduplex_mode)
 		return 0;
 	return snd_pcm_lib_free_pages(substream);
 }
@@ -800,7 +800,7 @@ static void snd_rme32_pcm_stop(struct rme32 * rme32, int to_pause)
 	if (rme32->wcreg & RME32_WCR_SEL)
 		rme32->wcreg |= RME32_WCR_MUTE;
 	writel(rme32->wcreg, rme32->iobase + RME32_IO_CONTROL_REGISTER);
-	if (! to_pause)
+	if (!to_pause)
 		writel(0, rme32->iobase + RME32_IO_RESET_POS);
 }
 
@@ -834,7 +834,7 @@ static struct snd_pcm_hw_constraint_list hw_constraints_period_bytes = {
 
 static void snd_rme32_set_buffer_constraint(struct rme32 *rme32, struct snd_pcm_runtime *runtime)
 {
-	if (! rme32->fullduplex_mode) {
+	if (!rme32->fullduplex_mode) {
 		snd_pcm_hw_constraint_minmax(runtime,
 					     SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 					     RME32_BUFFER_SIZE, RME32_BUFFER_SIZE);
@@ -876,7 +876,7 @@ static int snd_rme32_playback_spdif_open(struct snd_pcm_substream *substream)
 		runtime->hw.rates = snd_pcm_rate_to_rate_bit(rate);
 		runtime->hw.rate_min = rate;
 		runtime->hw.rate_max = rate;
-	}       
+	}
 
 	snd_rme32_set_buffer_constraint(rme32, runtime);
 
@@ -931,10 +931,10 @@ snd_rme32_playback_adat_open(struct snd_pcm_substream *substream)
 	int rate, dummy;
 	struct rme32 *rme32 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	
+
 	snd_pcm_set_sync(substream);
 
-	spin_lock_irq(&rme32->lock);	
+	spin_lock_irq(&rme32->lock);
         if (rme32->playback_substream != NULL) {
 		spin_unlock_irq(&rme32->lock);
                 return -EBUSY;
@@ -943,7 +943,7 @@ snd_rme32_playback_adat_open(struct snd_pcm_substream *substream)
 	writel(rme32->wcreg, rme32->iobase + RME32_IO_CONTROL_REGISTER);
 	rme32->playback_substream = substream;
 	spin_unlock_irq(&rme32->lock);
-	
+
 	if (rme32->fullduplex_mode)
 		runtime->hw = snd_rme32_adat_fd_info;
 	else
@@ -954,7 +954,7 @@ snd_rme32_playback_adat_open(struct snd_pcm_substream *substream)
                 runtime->hw.rates = snd_pcm_rate_to_rate_bit(rate);
                 runtime->hw.rate_min = rate;
                 runtime->hw.rate_max = rate;
-	}        
+	}
 
 	snd_rme32_set_buffer_constraint(rme32, runtime);
 	return 0;
@@ -981,8 +981,8 @@ snd_rme32_capture_adat_open(struct snd_pcm_substream *substream)
         }
 
 	snd_pcm_set_sync(substream);
-        
-	spin_lock_irq(&rme32->lock);	
+
+	spin_lock_irq(&rme32->lock);
 	if (rme32->capture_substream != NULL) {
 		spin_unlock_irq(&rme32->lock);
 		return -EBUSY;
@@ -1091,7 +1091,7 @@ snd_rme32_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		}
 		snd_pcm_trigger_done(s, substream);
 	}
-	
+
 	/* prefill playback buffer */
 	if (cmd == SNDRV_PCM_TRIGGER_START && rme32->fullduplex_mode) {
 		snd_pcm_group_for_each_entry(s, substream) {
@@ -1108,7 +1108,7 @@ snd_rme32_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			snd_rme32_pcm_start(rme32, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		if (! rme32->running && RME32_ISWORKING(rme32))
+		if (!rme32->running && RME32_ISWORKING(rme32))
 			snd_rme32_pcm_stop(rme32, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -1402,23 +1402,23 @@ static int __devinit snd_rme32_create(struct rme32 * rme32)
 				       1, 1, &rme32->adat_pcm)) < 0)
 		{
 			return err;
-		}		
+		}
 		rme32->adat_pcm->private_data = rme32;
 		rme32->adat_pcm->private_free = snd_rme32_free_adat_pcm;
 		strcpy(rme32->adat_pcm->name, "Digi32 ADAT");
 		if (rme32->fullduplex_mode) {
-			snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_PLAYBACK, 
+			snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_PLAYBACK,
 					&snd_rme32_playback_adat_fd_ops);
-			snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_CAPTURE, 
+			snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_CAPTURE,
 					&snd_rme32_capture_adat_fd_ops);
 			snd_pcm_lib_preallocate_pages_for_all(rme32->adat_pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 							      snd_dma_continuous_data(GFP_KERNEL),
 							      0, RME32_MID_BUFFER_SIZE);
 			rme32->adat_pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX;
 		} else {
-			snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_PLAYBACK, 
+			snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_PLAYBACK,
 					&snd_rme32_playback_adat_ops);
-			snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_CAPTURE, 
+			snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_CAPTURE,
 					&snd_rme32_capture_adat_ops);
 			rme32->adat_pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
 		}
@@ -1561,7 +1561,7 @@ static void __devinit snd_rme32_proc_init(struct rme32 * rme32)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(rme32->card, "rme32", &entry))
+	if (!snd_card_proc_new(rme32->card, "rme32", &entry))
 		snd_info_set_text_ops(entry, rme32, snd_rme32_proc_read);
 }
 
@@ -1697,9 +1697,9 @@ static int
 snd_rme32_info_clockmode_control(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = { "AutoSync", 
-				  "Internal 32.0kHz", 
-				  "Internal 44.1kHz", 
+	static char *texts[4] = { "AutoSync",
+				  "Internal 32.0kHz",
+				  "Internal 44.1kHz",
 				  "Internal 48.0kHz" };
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 3fdd488..fb8767e 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1,9 +1,9 @@
 /*
  *   ALSA driver for RME Digi96, Digi96/8 and Digi96/8 PRO/PAD/PST audio
- *   interfaces 
+ *   interfaces
  *
  *	Copyright (c) 2000, 2001 Anders Torger <torger@ludd.luth.se>
- *    
+ *
  *      Thanks to Henk Hesselink <henk@anda.nl> for the analog volume control
  *      code.
  *
@@ -21,7 +21,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -38,7 +38,7 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 
 /* note, two last pcis should be equal, it is not a bug */
 
@@ -205,7 +205,7 @@ struct rme96 {
 	int irq;
 	unsigned long port;
 	void __iomem *iobase;
-	
+
 	u32 wcreg;    /* cached write control register value */
 	u32 wcreg_spdif;		/* S/PDIF setup */
 	u32 wcreg_spdif_stream;		/* S/PDIF setup (temporary) */
@@ -220,13 +220,13 @@ struct rme96 {
 
 	int playback_frlog; /* log2 of framesize */
 	int capture_frlog;
-	
+
         size_t playback_periodsize; /* in bytes, zero if not used */
 	size_t capture_periodsize; /* in bytes, zero if not used */
 
 	struct snd_card *card;
 	struct snd_pcm *spdif_pcm;
-	struct snd_pcm *adat_pcm; 
+	struct snd_pcm *adat_pcm;
 	struct pci_dev     *pci;
 	struct snd_kcontrol   *spdif_ctl;
 };
@@ -239,7 +239,7 @@ static struct pci_device_id snd_rme96_ids[] = {
 	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_RME_DIGI96_8_PRO,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
 	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, 
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
 	{ 0, }
 };
 
@@ -262,11 +262,11 @@ static int
 snd_rme96_capture_prepare(struct snd_pcm_substream *substream);
 
 static int
-snd_rme96_playback_trigger(struct snd_pcm_substream *substream, 
+snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 			   int cmd);
 
 static int
-snd_rme96_capture_trigger(struct snd_pcm_substream *substream, 
+snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 			  int cmd);
 
 static snd_pcm_uframes_t
@@ -275,7 +275,7 @@ snd_rme96_playback_pointer(struct snd_pcm_substream *substream);
 static snd_pcm_uframes_t
 snd_rme96_capture_pointer(struct snd_pcm_substream *substream);
 
-static void __devinit 
+static void __devinit
 snd_rme96_proc_init(struct rme96 *rme96);
 
 static int
@@ -355,10 +355,10 @@ static struct snd_pcm_hardware snd_rme96_playback_spdif_info =
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
 			      SNDRV_PCM_FMTBIT_S32_LE),
 	.rates =	     (SNDRV_PCM_RATE_32000 |
-			      SNDRV_PCM_RATE_44100 | 
-			      SNDRV_PCM_RATE_48000 | 
+			      SNDRV_PCM_RATE_44100 |
+			      SNDRV_PCM_RATE_48000 |
 			      SNDRV_PCM_RATE_64000 |
-			      SNDRV_PCM_RATE_88200 | 
+			      SNDRV_PCM_RATE_88200 |
 			      SNDRV_PCM_RATE_96000),
 	.rate_min =	     32000,
 	.rate_max =	     96000,
@@ -384,10 +384,10 @@ static struct snd_pcm_hardware snd_rme96_capture_spdif_info =
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
 			      SNDRV_PCM_FMTBIT_S32_LE),
 	.rates =	     (SNDRV_PCM_RATE_32000 |
-			      SNDRV_PCM_RATE_44100 | 
-			      SNDRV_PCM_RATE_48000 | 
+			      SNDRV_PCM_RATE_44100 |
+			      SNDRV_PCM_RATE_48000 |
 			      SNDRV_PCM_RATE_64000 |
-			      SNDRV_PCM_RATE_88200 | 
+			      SNDRV_PCM_RATE_88200 |
 			      SNDRV_PCM_RATE_96000),
 	.rate_min =	     32000,
 	.rate_max =	     96000,
@@ -412,7 +412,7 @@ static struct snd_pcm_hardware snd_rme96_playback_adat_info =
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
 			      SNDRV_PCM_FMTBIT_S32_LE),
-	.rates =             (SNDRV_PCM_RATE_44100 | 
+	.rates =             (SNDRV_PCM_RATE_44100 |
 			      SNDRV_PCM_RATE_48000),
 	.rate_min =          44100,
 	.rate_max =          48000,
@@ -437,7 +437,7 @@ static struct snd_pcm_hardware snd_rme96_capture_adat_info =
 			      SNDRV_PCM_INFO_PAUSE),
 	.formats =	     (SNDRV_PCM_FMTBIT_S16_LE |
 			      SNDRV_PCM_FMTBIT_S32_LE),
-	.rates =	     (SNDRV_PCM_RATE_44100 | 
+	.rates =	     (SNDRV_PCM_RATE_44100 |
 			      SNDRV_PCM_RATE_48000),
 	.rate_min =          44100,
 	.rate_max =          48000,
@@ -573,7 +573,7 @@ snd_rme96_setattenuation(struct rme96 *rme96,
 static int
 snd_rme96_capture_getrate(struct rme96 *rme96,
 			  int *is_adat)
-{	
+{
 	int n, rate;
 
 	*is_adat = 0;
@@ -610,14 +610,14 @@ snd_rme96_capture_getrate(struct rme96 *rme96,
 	if (rme96->rcreg & RME96_RCR_VERF) {
 		return -1;
 	}
-	
+
 	/* S/PDIF rate */
 	n = ((rme96->rcreg >> RME96_RCR_BITPOS_F0) & 1) +
 		(((rme96->rcreg >> RME96_RCR_BITPOS_F1) & 1) << 1) +
 		(((rme96->rcreg >> RME96_RCR_BITPOS_F2) & 1) << 2);
-	
+
 	switch (n) {
-	case 0:		
+	case 0:
 		if (rme96->rcreg & RME96_RCR_T_OUT) {
 			return 64000;
 		}
@@ -763,7 +763,7 @@ snd_rme96_setclockmode(struct rme96 *rme96,
 {
 	switch (mode) {
 	case RME96_CLOCKMODE_SLAVE:
-	        /* AutoSync */ 
+	        /* AutoSync */
 		rme96->wcreg &= ~RME96_WCR_MASTER;
 		rme96->areg &= ~RME96_AR_WSEL;
 		break;
@@ -774,7 +774,7 @@ snd_rme96_setclockmode(struct rme96 *rme96,
 		break;
 	case RME96_CLOCKMODE_WORDCLOCK:
 		/* Word clock is a master mode */
-		rme96->wcreg |= RME96_WCR_MASTER; 
+		rme96->wcreg |= RME96_WCR_MASTER;
 		rme96->areg |= RME96_AR_WSEL;
 		break;
 	default:
@@ -872,7 +872,7 @@ snd_rme96_setframelog(struct rme96 *rme96,
 		      int is_playback)
 {
 	int frlog;
-	
+
 	if (n_channels == 2) {
 		frlog = 1;
 	} else {
@@ -964,7 +964,7 @@ snd_rme96_playback_hw_params(struct snd_pcm_substream *substream,
                 /* slave clock */
                 if ((int)params_rate(params) != rate) {
 			spin_unlock_irq(&rme96->lock);
-			return -EIO;                    
+			return -EIO;
                 }
 	} else if ((err = snd_rme96_playback_setrate(rme96, params_rate(params))) < 0) {
 		spin_unlock_irq(&rme96->lock);
@@ -992,7 +992,7 @@ snd_rme96_playback_hw_params(struct snd_pcm_substream *substream,
 		writel(rme96->wcreg |= rme96->wcreg_spdif_stream, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	}
 	spin_unlock_irq(&rme96->lock);
-		
+
 	return 0;
 }
 
@@ -1003,7 +1003,7 @@ snd_rme96_capture_hw_params(struct snd_pcm_substream *substream,
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err, isadat, rate;
-	
+
 	runtime->dma_area = (void __force *)(rme96->iobase +
 					     RME96_IO_REC_BUFFER);
 	runtime->dma_addr = rme96->port + RME96_IO_REC_BUFFER;
@@ -1024,7 +1024,7 @@ snd_rme96_capture_hw_params(struct snd_pcm_substream *substream,
 	} else if ((rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0) {
                 if ((int)params_rate(params) != rate) {
 			spin_unlock_irq(&rme96->lock);
-			return -EIO;                    
+			return -EIO;
                 }
                 if ((isadat && runtime->hw.channels_min == 2) ||
                     (!isadat && runtime->hw.channels_min == 8))
@@ -1084,7 +1084,7 @@ snd_rme96_playback_stop(struct rme96 *rme96)
 	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	if (rme96->rcreg & RME96_RCR_IRQ) {
 		writel(0, rme96->iobase + RME96_IO_CONFIRM_PLAY_IRQ);
-	}	
+	}
 	rme96->wcreg &= ~RME96_WCR_START;
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 }
@@ -1095,7 +1095,7 @@ snd_rme96_capture_stop(struct rme96 *rme96)
 	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	if (rme96->rcreg & RME96_RCR_IRQ_2) {
 		writel(0, rme96->iobase + RME96_IO_CONFIRM_REC_IRQ);
-	}	
+	}
 	rme96->wcreg &= ~RME96_WCR_START_2;
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 }
@@ -1113,7 +1113,7 @@ snd_rme96_interrupt(int irq,
 	{
 		return IRQ_NONE;
 	}
-	
+
 	if (rme96->rcreg & RME96_RCR_IRQ) {
 		/* playback */
                 snd_pcm_period_elapsed(rme96->playback_substream);
@@ -1121,7 +1121,7 @@ snd_rme96_interrupt(int irq,
 	}
 	if (rme96->rcreg & RME96_RCR_IRQ_2) {
 		/* capture */
-		snd_pcm_period_elapsed(rme96->capture_substream);		
+		snd_pcm_period_elapsed(rme96->capture_substream);
 		writel(0, rme96->iobase + RME96_IO_CONFIRM_REC_IRQ);
 	}
 	return IRQ_HANDLED;
@@ -1161,7 +1161,7 @@ snd_rme96_playback_spdif_open(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	spin_lock_irq(&rme96->lock);	
+	spin_lock_irq(&rme96->lock);
         if (rme96->playback_substream != NULL) {
 		spin_unlock_irq(&rme96->lock);
                 return -EBUSY;
@@ -1180,7 +1180,7 @@ snd_rme96_playback_spdif_open(struct snd_pcm_substream *substream)
                 runtime->hw.rates = snd_pcm_rate_to_rate_bit(rate);
                 runtime->hw.rate_min = rate;
                 runtime->hw.rate_max = rate;
-	}        
+	}
 	rme96_set_buffer_size_constraint(rme96, runtime);
 
 	rme96->wcreg_spdif_stream = rme96->wcreg_spdif;
@@ -1208,7 +1208,7 @@ snd_rme96_capture_spdif_open(struct snd_pcm_substream *substream)
                 runtime->hw.rate_min = rate;
                 runtime->hw.rate_max = rate;
         }
-        
+
 	spin_lock_irq(&rme96->lock);
         if (rme96->capture_substream != NULL) {
 		spin_unlock_irq(&rme96->lock);
@@ -1216,7 +1216,7 @@ snd_rme96_capture_spdif_open(struct snd_pcm_substream *substream)
         }
 	rme96->capture_substream = substream;
 	spin_unlock_irq(&rme96->lock);
-	
+
 	rme96_set_buffer_size_constraint(rme96, runtime);
 	return 0;
 }
@@ -1226,9 +1226,9 @@ snd_rme96_playback_adat_open(struct snd_pcm_substream *substream)
 {
         int rate, dummy;
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;        
-	
-	spin_lock_irq(&rme96->lock);	
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	spin_lock_irq(&rme96->lock);
         if (rme96->playback_substream != NULL) {
 		spin_unlock_irq(&rme96->lock);
                 return -EBUSY;
@@ -1237,7 +1237,7 @@ snd_rme96_playback_adat_open(struct snd_pcm_substream *substream)
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	rme96->playback_substream = substream;
 	spin_unlock_irq(&rme96->lock);
-	
+
 	runtime->hw = snd_rme96_playback_adat_info;
 	if (!(rme96->wcreg & RME96_WCR_MASTER) &&
             snd_rme96_getinputtype(rme96) != RME96_INPUT_ANALOG &&
@@ -1247,7 +1247,7 @@ snd_rme96_playback_adat_open(struct snd_pcm_substream *substream)
                 runtime->hw.rates = snd_pcm_rate_to_rate_bit(rate);
                 runtime->hw.rate_min = rate;
                 runtime->hw.rate_max = rate;
-	}        
+	}
 	rme96_set_buffer_size_constraint(rme96, runtime);
 	return 0;
 }
@@ -1273,8 +1273,8 @@ snd_rme96_capture_adat_open(struct snd_pcm_substream *substream)
                 runtime->hw.rate_min = rate;
                 runtime->hw.rate_max = rate;
         }
-        
-	spin_lock_irq(&rme96->lock);	
+
+	spin_lock_irq(&rme96->lock);
         if (rme96->capture_substream != NULL) {
 		spin_unlock_irq(&rme96->lock);
                 return -EBUSY;
@@ -1292,7 +1292,7 @@ snd_rme96_playback_close(struct snd_pcm_substream *substream)
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	int spdif = 0;
 
-	spin_lock_irq(&rme96->lock);	
+	spin_lock_irq(&rme96->lock);
 	if (RME96_ISPLAYING(rme96)) {
 		snd_rme96_playback_stop(rme96);
 	}
@@ -1312,8 +1312,8 @@ static int
 snd_rme96_capture_close(struct snd_pcm_substream *substream)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-	
-	spin_lock_irq(&rme96->lock);	
+
+	spin_lock_irq(&rme96->lock);
 	if (RME96_ISRECORDING(rme96)) {
 		snd_rme96_capture_stop(rme96);
 	}
@@ -1327,8 +1327,8 @@ static int
 snd_rme96_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-	
-	spin_lock_irq(&rme96->lock);	
+
+	spin_lock_irq(&rme96->lock);
 	if (RME96_ISPLAYING(rme96)) {
 		snd_rme96_playback_stop(rme96);
 	}
@@ -1341,8 +1341,8 @@ static int
 snd_rme96_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-	
-	spin_lock_irq(&rme96->lock);	
+
+	spin_lock_irq(&rme96->lock);
 	if (RME96_ISRECORDING(rme96)) {
 		snd_rme96_capture_stop(rme96);
 	}
@@ -1352,7 +1352,7 @@ snd_rme96_capture_prepare(struct snd_pcm_substream *substream)
 }
 
 static int
-snd_rme96_playback_trigger(struct snd_pcm_substream *substream, 
+snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 			   int cmd)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
@@ -1387,7 +1387,7 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 			snd_rme96_playback_start(rme96, 1);
 		}
 		break;
-		
+
 	default:
 		return -EINVAL;
 	}
@@ -1395,7 +1395,7 @@ snd_rme96_playback_trigger(struct snd_pcm_substream *substream,
 }
 
 static int
-snd_rme96_capture_trigger(struct snd_pcm_substream *substream, 
+snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 			  int cmd)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
@@ -1430,7 +1430,7 @@ snd_rme96_capture_trigger(struct snd_pcm_substream *substream,
 			snd_rme96_capture_start(rme96, 1);
 		}
 		break;
-		
+
 	default:
 		return -EINVAL;
 	}
@@ -1573,8 +1573,8 @@ snd_rme96_create(struct rme96 *rme96)
 	rme96->irq = pci->irq;
 
 	/* read the card's revision number */
-	pci_read_config_byte(pci, 8, &rme96->rev);	
-	
+	pci_read_config_byte(pci, 8, &rme96->rev);
+
 	/* set up ALSA pcm device for S/PDIF */
 	if ((err = snd_pcm_new(rme96->card, "Digi96 IEC958", 0,
 			       1, 1, &rme96->spdif_pcm)) < 0)
@@ -1598,23 +1598,23 @@ snd_rme96_create(struct rme96 *rme96)
 				       1, 1, &rme96->adat_pcm)) < 0)
 		{
 			return err;
-		}		
+		}
 		rme96->adat_pcm->private_data = rme96;
 		rme96->adat_pcm->private_free = snd_rme96_free_adat_pcm;
 		strcpy(rme96->adat_pcm->name, "Digi96 ADAT");
 		snd_pcm_set_ops(rme96->adat_pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_rme96_playback_adat_ops);
 		snd_pcm_set_ops(rme96->adat_pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_rme96_capture_adat_ops);
-		
+
 		rme96->adat_pcm->info_flags = 0;
 	}
 
 	rme96->playback_periodsize = 0;
 	rme96->capture_periodsize = 0;
-	
+
 	/* make sure playback/capture is stopped, if by some reason active */
 	snd_rme96_playback_stop(rme96);
 	snd_rme96_capture_stop(rme96);
-	
+
 	/* set default values in registers */
 	rme96->wcreg =
 		RME96_WCR_FREQ_1 | /* set 44.1 kHz playback */
@@ -1626,11 +1626,11 @@ snd_rme96_create(struct rme96 *rme96)
 
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
-	
+
 	/* reset the ADC */
 	writel(rme96->areg | RME96_AR_PD2,
 	       rme96->iobase + RME96_IO_ADDITIONAL_REG);
-	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);	
+	writel(rme96->areg, rme96->iobase + RME96_IO_ADDITIONAL_REG);
 
 	/* reset and enable the DAC (order is important). */
 	snd_rme96_reset_dac(rme96);
@@ -1646,7 +1646,7 @@ snd_rme96_create(struct rme96 *rme96)
 	if (RME96_HAS_ANALOG_OUT(rme96)) {
 		snd_rme96_apply_dac_volume(rme96);
 	}
-	
+
 	/* init switch interface */
 	if ((err = snd_rme96_create_switches(rme96->card, rme96)) < 0) {
 		return err;
@@ -1654,7 +1654,7 @@ snd_rme96_create(struct rme96 *rme96)
 
         /* init proc interface */
 	snd_rme96_proc_init(rme96);
-	
+
 	return 0;
 }
 
@@ -1662,12 +1662,12 @@ snd_rme96_create(struct rme96 *rme96)
  * proc interface
  */
 
-static void 
+static void
 snd_rme96_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 {
 	int n;
 	struct rme96 *rme96 = (struct rme96 *)entry->private_data;
-	
+
 	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
 
 	snd_iprintf(buffer, rme96->card->longname);
@@ -1681,7 +1681,7 @@ snd_rme96_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer
 		snd_iprintf(buffer, "  period size: 2048 bytes\n");
 	} else {
 		snd_iprintf(buffer, "  period size: 8192 bytes\n");
-	}	
+	}
 	snd_iprintf(buffer, "\nInput settings\n");
 	switch (snd_rme96_getinputtype(rme96)) {
 	case RME96_INPUT_OPTICAL:
@@ -1716,7 +1716,7 @@ snd_rme96_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer
 	} else {
 		snd_iprintf(buffer, "  sample format: 16 bit\n");
 	}
-	
+
 	snd_iprintf(buffer, "\nOutput settings\n");
 	if (rme96->wcreg & RME96_WCR_SEL) {
 		snd_iprintf(buffer, "  output signal: normal playback\n");
@@ -1791,12 +1791,12 @@ snd_rme96_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer
 	}
 }
 
-static void __devinit 
+static void __devinit
 snd_rme96_proc_init(struct rme96 *rme96)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(rme96->card, "rme96", &entry))
+	if (!snd_card_proc_new(rme96->card, "rme96", &entry))
 		snd_info_set_text_ops(entry, rme96, snd_rme96_proc_read);
 }
 
@@ -1810,7 +1810,7 @@ static int
 snd_rme96_get_loopback_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme96->lock);
 	ucontrol->value.integer.value[0] = rme96->wcreg & RME96_WCR_SEL ? 0 : 1;
 	spin_unlock_irq(&rme96->lock);
@@ -1822,7 +1822,7 @@ snd_rme96_put_loopback_control(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
 	int change;
-	
+
 	val = ucontrol->value.integer.value[0] ? 0 : RME96_WCR_SEL;
 	spin_lock_irq(&rme96->lock);
 	val = (rme96->wcreg & ~RME96_WCR_SEL) | val;
@@ -1839,7 +1839,7 @@ snd_rme96_info_inputtype_control(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	static char *_texts[5] = { "Optical", "Coaxial", "Internal", "XLR", "Analog" };
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	char *texts[5] = { _texts[0], _texts[1], _texts[2], _texts[3], _texts[4] };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	switch (rme96->pci->device) {
@@ -1875,10 +1875,10 @@ snd_rme96_get_inputtype_control(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 {
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	unsigned int items = 3;
-	
+
 	spin_lock_irq(&rme96->lock);
 	ucontrol->value.enumerated.item[0] = snd_rme96_getinputtype(rme96);
-	
+
 	switch (rme96->pci->device) {
 	case PCI_DEVICE_ID_RME_DIGI96:
 	case PCI_DEVICE_ID_RME_DIGI96_8:
@@ -1905,7 +1905,7 @@ snd_rme96_get_inputtype_control(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	if (ucontrol->value.enumerated.item[0] >= items) {
 		ucontrol->value.enumerated.item[0] = items - 1;
 	}
-	
+
 	spin_unlock_irq(&rme96->lock);
 	return 0;
 }
@@ -1915,7 +1915,7 @@ snd_rme96_put_inputtype_control(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
 	int change, items = 3;
-	
+
 	switch (rme96->pci->device) {
 	case PCI_DEVICE_ID_RME_DIGI96:
 	case PCI_DEVICE_ID_RME_DIGI96_8:
@@ -1936,14 +1936,14 @@ snd_rme96_put_inputtype_control(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 		break;
 	}
 	val = ucontrol->value.enumerated.item[0] % items;
-	
+
 	/* special case for PST */
 	if (rme96->pci->device == PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST && rme96->rev > 4) {
 		if (val == RME96_INPUT_XLR) {
 			val = RME96_INPUT_ANALOG;
 		}
 	}
-	
+
 	spin_lock_irq(&rme96->lock);
 	change = (int)val != snd_rme96_getinputtype(rme96);
 	snd_rme96_setinputtype(rme96, val);
@@ -1955,7 +1955,7 @@ static int
 snd_rme96_info_clockmode_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[3] = { "AutoSync", "Internal", "Word" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 3;
@@ -1969,7 +1969,7 @@ static int
 snd_rme96_get_clockmode_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme96->lock);
 	ucontrol->value.enumerated.item[0] = snd_rme96_getclockmode(rme96);
 	spin_unlock_irq(&rme96->lock);
@@ -1981,7 +1981,7 @@ snd_rme96_put_clockmode_control(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
 	int change;
-	
+
 	val = ucontrol->value.enumerated.item[0] % 3;
 	spin_lock_irq(&rme96->lock);
 	change = (int)val != snd_rme96_getclockmode(rme96);
@@ -1994,7 +1994,7 @@ static int
 snd_rme96_info_attenuation_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[4] = { "0 dB", "-6 dB", "-12 dB", "-18 dB" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 4;
@@ -2008,7 +2008,7 @@ static int
 snd_rme96_get_attenuation_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme96->lock);
 	ucontrol->value.enumerated.item[0] = snd_rme96_getattenuation(rme96);
 	spin_unlock_irq(&rme96->lock);
@@ -2020,7 +2020,7 @@ snd_rme96_put_attenuation_control(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
 	int change;
-	
+
 	val = ucontrol->value.enumerated.item[0] % 4;
 	spin_lock_irq(&rme96->lock);
 
@@ -2034,7 +2034,7 @@ static int
 snd_rme96_info_montracks_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	static char *texts[4] = { "1+2", "3+4", "5+6", "7+8" };
-	
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = 4;
@@ -2048,7 +2048,7 @@ static int
 snd_rme96_get_montracks_control(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
-	
+
 	spin_lock_irq(&rme96->lock);
 	ucontrol->value.enumerated.item[0] = snd_rme96_getmontracks(rme96);
 	spin_unlock_irq(&rme96->lock);
@@ -2060,7 +2060,7 @@ snd_rme96_put_montracks_control(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
 	int change;
-	
+
 	val = ucontrol->value.enumerated.item[0] % 4;
 	spin_lock_irq(&rme96->lock);
 	change = (int)val != snd_rme96_getmontracks(rme96);
@@ -2101,7 +2101,7 @@ static int snd_rme96_control_spdif_info(struct snd_kcontrol *kcontrol, struct sn
 static int snd_rme96_control_spdif_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_rme96_convert_to_aes(&ucontrol->value.iec958, rme96->wcreg_spdif);
 	return 0;
 }
@@ -2111,7 +2111,7 @@ static int snd_rme96_control_spdif_put(struct snd_kcontrol *kcontrol, struct snd
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_rme96_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&rme96->lock);
 	change = val != rme96->wcreg_spdif;
@@ -2130,7 +2130,7 @@ static int snd_rme96_control_spdif_stream_info(struct snd_kcontrol *kcontrol, st
 static int snd_rme96_control_spdif_stream_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
-	
+
 	snd_rme96_convert_to_aes(&ucontrol->value.iec958, rme96->wcreg_spdif_stream);
 	return 0;
 }
@@ -2140,7 +2140,7 @@ static int snd_rme96_control_spdif_stream_put(struct snd_kcontrol *kcontrol, str
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
 	int change;
 	u32 val;
-	
+
 	val = snd_rme96_convert_from_aes(&ucontrol->value.iec958);
 	spin_lock_irq(&rme96->lock);
 	change = val != rme96->wcreg_spdif_stream;
@@ -2169,7 +2169,7 @@ static int
 snd_rme96_dac_volume_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct rme96 *rme96 = snd_kcontrol_chip(kcontrol);
-	
+
         uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
         uinfo->count = 2;
         uinfo->value.integer.min = 0;
@@ -2258,9 +2258,9 @@ static struct snd_kcontrol_new snd_rme96_controls[] = {
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Input Connector",
-	.info =         snd_rme96_info_inputtype_control, 
+	.info =         snd_rme96_info_inputtype_control,
 	.get =          snd_rme96_get_inputtype_control,
-	.put =          snd_rme96_put_inputtype_control 
+	.put =          snd_rme96_put_inputtype_control
 },
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -2272,21 +2272,21 @@ static struct snd_kcontrol_new snd_rme96_controls[] = {
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Sample Clock Source",
-	.info =         snd_rme96_info_clockmode_control, 
+	.info =         snd_rme96_info_clockmode_control,
 	.get =          snd_rme96_get_clockmode_control,
 	.put =          snd_rme96_put_clockmode_control
 },
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Monitor Tracks",
-	.info =         snd_rme96_info_montracks_control, 
+	.info =         snd_rme96_info_montracks_control,
 	.get =          snd_rme96_get_montracks_control,
 	.put =          snd_rme96_put_montracks_control
 },
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Attenuation",
-	.info =         snd_rme96_info_attenuation_control, 
+	.info =         snd_rme96_info_attenuation_control,
 	.get =          snd_rme96_get_attenuation_control,
 	.put =          snd_rme96_put_attenuation_control
 },
@@ -2318,7 +2318,7 @@ snd_rme96_create_switches(struct snd_card *card,
 			if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_rme96_controls[idx], rme96))) < 0)
 				return err;
 	}
-	
+
 	return 0;
 }
 
@@ -2352,7 +2352,7 @@ snd_rme96_probe(struct pci_dev *pci,
 				 sizeof(struct rme96))) == NULL)
 		return -ENOMEM;
 	card->private_free = snd_rme96_card_free;
-	rme96 = (struct rme96 *)card->private_data;	
+	rme96 = (struct rme96 *)card->private_data;
 	rme96->card = card;
 	rme96->pci = pci;
 	snd_card_set_dev(card, &pci->dev);
@@ -2360,7 +2360,7 @@ snd_rme96_probe(struct pci_dev *pci,
 		snd_card_free(card);
 		return err;
 	}
-	
+
 	strcpy(card->driver, "Digi96");
 	switch (rme96->pci->device) {
 	case PCI_DEVICE_ID_RME_DIGI96:
@@ -2383,10 +2383,10 @@ snd_rme96_probe(struct pci_dev *pci,
 	}
 	sprintf(card->longname, "%s at 0x%lx, irq %d", card->shortname,
 		rme96->port, rme96->irq);
-	
+
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
-		return err;	
+		return err;
 	}
 	pci_set_drvdata(pci, card);
 	dev++;
