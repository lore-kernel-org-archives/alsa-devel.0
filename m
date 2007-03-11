From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: [RFC][RFT] Adding support for Jazz16 based sound cards
Date: Mon, 12 Mar 2007 00:24:36 +0100
Message-ID: <20070311232436.GB9778@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Adam Belay <ambx1@neo.rr.com>
List-Id: alsa-devel@alsa-project.org

   Below is a patch against linux-2.6.20 to add support for Jazz16 sound
cards. It consists of changes to ALSA's SoundBlaster support and a new PnP
protocol for detecting the card, setting resources and such. Before
submitting a patch for inclusion into Linux, I would like to have a few
comments and perhaps a test report from someone else.

   The Jazz16 is an SB Pro clone with higher stereo sample rates of upto
45454 Hz and 16-bit sound. As such, I have modified the SoundBlaster code to
make use of the features of the Jazz16.

   In stereo mode, the denominator used for setting the sample rate must be
even. Some silly(?) apps like timidity++ set the playback rate before
seeting the number of channels, which causes needless rounding of the mono
playback rate. E.g. "timidity -s 40000 -osM" results in a playback rate of
38461 Hz (a denominator of 26) even though 40000 Hz (a denominator of 25) is
fine in mono mode. This is not a big problem, but is there an easy way of
fixing it?

   I tried to include u-law support, but it doesn't sound right and playback
speed is about one third of what it should be. I could really use some
documentation here. I'll remove it before submitting a final patch if I
don't get it to work.

   Setting the irq of the MPU-401 port requires the SB part to be active and
even worse, DSP commands need to be sent. Would it be better to just use the
MPU-401 port without an irq and avoid the complexity?

-- 
Rask Ingemann Lambertsen

--- linux-2.6.20/sound/isa/sb/Makefile.orig	2007-02-19 21:00:09.000000000 +0100
+++ linux-2.6.20/sound/isa/sb/Makefile	2007-03-02 20:14:48.000000000 +0100
@@ -12,6 +12,7 @@ snd-sb16-objs := sb16.o
 snd-sbawe-objs := sbawe.o emu8000.o
 snd-emu8000-synth-objs := emu8000_synth.o emu8000_callback.o emu8000_patch.o emu8000_pcm.o
 snd-es968-objs := es968.o
+snd-jazz16-objs := jazz16.o
 
 #
 # this function returns:
@@ -30,6 +31,7 @@ obj-$(CONFIG_SND_SB16) += snd-sb16.o snd
 obj-$(CONFIG_SND_SBAWE) += snd-sbawe.o snd-sb16-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_ES968) += snd-es968.o snd-sb8-dsp.o snd-sb-common.o
 obj-$(CONFIG_SND_ALS4000) += snd-sb-common.o
+obj-$(CONFIG_SND_JAZZ16) += snd-jazz16.o snd-sb8-dsp.o snd-sb-common.o
 ifeq ($(CONFIG_SND_SB16_CSP),y)
   obj-$(CONFIG_SND_SB16) += snd-sb16-csp.o
   obj-$(CONFIG_SND_SBAWE) += snd-sb16-csp.o
--- linux-2.6.20/sound/isa/sb/jazz16.c-orig	2007-02-17 20:01:40.000000000 +0100
+++ linux-2.6.20/sound/isa/sb/jazz16.c	2007-03-11 19:20:07.000000000 +0100
@@ -0,0 +1,169 @@
+/* Driver for Media Vision Jazz16 based boards.
+ *
+ * Copyright (c) 2007 by Rask Ingemann Lambertsen
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * The Jazz16 is an SB Pro compatible chip with a 16-bit mode and higher
+ * playback and capture rates added to it. It is not SB 16 compatible.
+ * The chip has an MPU-401 interface which is handled by the MPU-401 driver.
+ *
+ * The IBM PPS Model 6015 has a Jazz16 chip on board. Please tell me if it
+ * works with this driver or not.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/pnp.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/sb.h>
+#include <sound/mpu401.h>
+#include <sound/opl3.h>
+#include <sound/initval.h>
+
+MODULE_AUTHOR ("Rask Ingemann Lambertsen <rask@sygehus.dk>");
+MODULE_DESCRIPTION ("Jazz16");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable switches */
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for Jazz16 soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for Jazz16 soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable Jazz16 soundcard.");
+
+#define PFX		"jazz16: "
+#define PFX_DEBUG	KERN_DEBUG PFX
+#define PFX_ERR		KERN_ERR PFX
+
+static struct pnp_driver snd_jazz16_pnp_driver;
+
+static irqreturn_t jazz16_interrupt(int irq, void *dev_id)
+{
+	struct snd_sb *chip = (struct snd_sb *) dev_id;
+	return (snd_sb8dsp_interrupt(chip));
+}
+
+static struct pnp_device_id snd_jazz16_pnpids[] = {
+	{ .id = "PNPb00f" },
+	{ .id = "" }
+};
+MODULE_DEVICE_TABLE(pnp, snd_jazz16_pnpids);
+
+static int __devinit snd_jazz16_pnp_probe(struct pnp_dev *pnp_dev,
+					  const struct pnp_device_id *pnp_id)
+{	struct snd_sb *chip;
+	struct snd_card *card;
+	struct snd_opl3 *opl3;
+	int err;
+	uint sbport, sbirq, sbdma8, sbdma16;
+	static uint dev_num = 0;
+
+	if (enable[dev_num])
+		card = snd_card_new(index[dev_num], id[dev_num], THIS_MODULE, 0);
+	else
+		card = NULL;
+	dev_num ++;
+	if (card == NULL)
+		return -ENOMEM;
+	pnp_set_drvdata (pnp_dev, card);
+	/* FIXME use pnp_port_valid(), pnp_port_flags(), pnp_port_length()... */
+	sbport	 = pnp_port_start (pnp_dev, 0);
+	sbirq	 = pnp_irq (pnp_dev, 0);
+	sbdma8	 = pnp_dma (pnp_dev, 0);
+	sbdma16	 = pnp_dma (pnp_dev, 1);
+	if ((err = snd_sbdsp_create (card, sbport, sbirq, jazz16_interrupt,
+	                             sbdma8, sbdma16, SB_HW_AUTO, &chip)) < 0) {
+		snd_card_free (card);
+		return (err);
+	}
+	/* FIXME length limits - strncpy()/snprintf() and friends. */
+	strcpy (card->driver, "Jazz16");
+	strcpy (card->shortname, "Media Vision Jazz16");
+	sprintf (card->longname, "%s at 0x%x, irq %u, dma8 %u, dma16 %u",
+	         chip->name, sbport, sbirq, sbdma8, sbdma16);
+
+	if (chip->hardware != SB_HW_JAZZ16) {
+		snd_printk (PFX_ERR "Not a Jazz16 chip at 0x%x.\n", sbport);
+		snd_card_free (card);
+		return (-ENODEV);
+	}
+	if ((err = snd_sb8dsp_pcm (chip, 0, NULL)) < 0) {
+		snd_card_free (card);
+		return (err);
+	}
+	if ((err = snd_sbmixer_new (chip)) < 0) {
+		snd_card_free (card);
+		return (err);
+	}
+	if ((err = snd_opl3_create (card, sbport, sbport + 2,
+				    OPL3_HW_AUTO, 1, &opl3)) < 0) {
+		snd_printk (PFX_ERR "No OPL device found, skipping.\n");
+	} else {
+		if ((err = snd_opl3_timer_new (opl3, 1, 2)) < 0) {
+			snd_card_free (card);
+			return (err);
+		}
+		if ((err = snd_opl3_hwdep_new (opl3, 0, 1, NULL)) < 0) {
+			snd_card_free (card);
+			return (err);
+		}
+	}
+	if ((err = snd_card_register (card)) < 0) {
+		snd_card_free (card);
+		return (err);
+	}
+	return (0);
+}
+
+static void __devexit snd_jazz16_pnp_remove(struct pnp_dev *dev)
+{
+	struct snd_card *card = (struct snd_card *) pnp_get_drvdata(dev);
+
+	snd_card_disconnect(card);
+	snd_card_free_when_closed(card);
+}
+
+static struct pnp_driver snd_jazz16_pnp_driver = {
+	.name = "Jazz16",
+	.id_table = snd_jazz16_pnpids,
+	.probe = snd_jazz16_pnp_probe,
+	.remove = __devexit_p(snd_jazz16_pnp_remove),
+};
+
+static int __devinit alsa_card_jazz16_init (void)
+{
+	return (pnp_register_driver(&snd_jazz16_pnp_driver));
+}
+
+static void __devexit alsa_card_jazz16_exit(void)
+{
+	pnp_unregister_driver (&snd_jazz16_pnp_driver);
+}
+
+module_init (alsa_card_jazz16_init);
+module_exit (alsa_card_jazz16_exit);
--- linux-2.6.20/sound/isa/sb/sb_mixer.c.orig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.20/sound/isa/sb/sb_mixer.c	2007-02-25 01:09:05.000000000 +0100
@@ -811,6 +811,7 @@ int snd_sbmixer_new(struct snd_sb *chip)
 			return err;
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		if ((err = snd_sbmixer_init(chip,
 					    snd_sbpro_controls,
 					    ARRAY_SIZE(snd_sbpro_controls),
@@ -946,6 +947,7 @@ void snd_sbmixer_suspend(struct snd_sb *
 		save_mixer(chip, sb20_saved_regs, ARRAY_SIZE(sb20_saved_regs));
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		save_mixer(chip, sbpro_saved_regs, ARRAY_SIZE(sbpro_saved_regs));
 		break;
 	case SB_HW_16:
@@ -971,6 +973,7 @@ void snd_sbmixer_resume(struct snd_sb *c
 		restore_mixer(chip, sb20_saved_regs, ARRAY_SIZE(sb20_saved_regs));
 		break;
 	case SB_HW_PRO:
+	case SB_HW_JAZZ16:
 		restore_mixer(chip, sbpro_saved_regs, ARRAY_SIZE(sbpro_saved_regs));
 		break;
 	case SB_HW_16:
--- linux-2.6.20/sound/isa/sb/sb_common.c.orig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.20/sound/isa/sb/sb_common.c	2007-03-03 12:50:32.000000000 +0100
@@ -146,8 +146,16 @@ static int snd_sbdsp_probe(struct snd_sb
 			}
 			break;
 		case 3:
-			chip->hardware = SB_HW_PRO;
-			str = "Pro";
+			spin_lock_irqsave(&chip->reg_lock, flags);
+			if (snd_sbdsp_command(chip, SB_DSP_GET_JAZZ_VERSION) &&
+			    SB_VERSION_IS_JAZZ16(snd_sbdsp_get_byte (chip))) {
+				chip->hardware = SB_HW_JAZZ16;
+				str = "Pro (Jazz16)";
+			} else {
+				chip->hardware = SB_HW_PRO;
+				str = "Pro";
+			}
+			spin_unlock_irqrestore (&chip->reg_lock, flags);
 			break;
 		case 4:
 			chip->hardware = SB_HW_16;
--- linux-2.6.20/sound/isa/sb/sb8_main.c.orig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.20/sound/isa/sb/sb8_main.c	2007-03-11 19:07:08.000000000 +0100
@@ -28,6 +28,9 @@
  *
  * Wed Jul 12 22:02:55 CEST 2000 Uros Bizjak <uros@kss-loka.si>
  *   Cleaned up and rewrote lowlevel routines.
+ *
+ * Sun Mar 11 18:45:38 CEST 2007 Rask Ingemann Lambertsen <rask@sygehus.dk>
+ *   Added Jazz16 enhancements.
  */
 
 #include <sound/driver.h>
@@ -73,6 +76,15 @@ static struct snd_ratnum stereo_clocks[]
 	}
 };
 
+/* For stereo playback and capture, the denominator is divided by two, so it
+ * must be even to get the intended sample rate. */
+static struct snd_ratnum jazz16_stereo_clock = {
+	.num = SB8_CLOCK,
+	.den_min = 2,
+	.den_max = 512,
+	.den_step = 2,
+};
+
 static int snd_sb8_hw_constraint_rate_channels(struct snd_pcm_hw_params *params,
 					       struct snd_pcm_hw_rule *rule)
 {
@@ -101,14 +113,54 @@ static int snd_sb8_hw_constraint_channel
 	return 0;
 }
 
+static int snd_jazz16_hw_constraint_rate_channels(struct snd_pcm_hw_params *params,
+						  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+  	unsigned int num = 0, den = 0;
+	int err = 0;
+
+	if (c->max > 1)
+		err = snd_interval_ratnum(r, 1, &jazz16_stereo_clock, &num, &den);
+	else
+		err = snd_interval_ratnum(r, 1, &clock, &num, &den);
+	if (err >= 0 && den) {
+		params->rate_num = num;
+		params->rate_den = den;
+	}
+	return err;
+}
+
+static int snd_jazz16_hw_constraint_channels_rate(struct snd_pcm_hw_params *params,
+						  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	int err = 0;
+
+	/* Force mono mode if the sample rate interval doesn't allow stereo. */
+	if (SB8_DEN(r->min) == SB8_DEN(r->max)
+	    && SB8_DEN(r->min) & 1)
+	{
+		struct snd_interval t = { .min = 1, .max = 1 };
+		struct snd_interval *c;
+
+		c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+		err = snd_interval_refine(c, &t);
+	}
+	return err;
+}
+
 static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 {
 	unsigned long flags;
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int mixreg, rate, size, count;
+	unsigned int mixreg, rate, size, count, dma;
+	unsigned char stereo, format;
 
 	rate = runtime->rate;
+	stereo = runtime->channels > 1;
 	switch (chip->hardware) {
 	case SB_HW_PRO:
 		if (runtime->channels > 1) {
@@ -117,6 +168,12 @@ static int snd_sb8_playback_prepare(stru
 			break;
 		}
 		/* fallthru */
+	case SB_HW_JAZZ16:
+		if (runtime->format == SNDRV_PCM_FORMAT_MU_LAW) {
+			chip->playback_format = SB_DSP_ULAW_OUTPUT_AUTO;
+			break;
+		}
+		/* fall through */
 	case SB_HW_201:
 		if (rate > 23000) {
 			chip->playback_format = SB_DSP_HI_OUTPUT_AUTO;
@@ -134,8 +191,26 @@ static int snd_sb8_playback_prepare(stru
 	}
 	size = chip->p_dma_size = snd_pcm_lib_buffer_bytes(substream);
 	count = chip->p_period_size = snd_pcm_lib_period_bytes(substream);
+	switch (runtime->format)
+	{
+		case SNDRV_PCM_FORMAT_U8:
+		case SNDRV_PCM_FORMAT_MU_LAW:
+		dma = chip->dma8;
+		format = stereo ? SB_DSP_STEREO_8BIT : SB_DSP_MONO_8BIT;
+		break;
+
+		case SNDRV_PCM_FORMAT_S16_LE:
+		dma = chip->dma16;
+		format = stereo ? SB_DSP_STEREO_16BIT : SB_DSP_MONO_16BIT;
+		break;
+
+		default:
+		return -EINVAL;
+	}
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_sbdsp_command(chip, SB_DSP_SPEAKER_ON);
+	if (chip->hardware >= SB_HW_PRO)
+		snd_sbdsp_command(chip, format);
 	if (runtime->channels > 1) {
 		/* set playback stereo mode */
 		spin_lock(&chip->mixer_lock);
@@ -173,7 +248,7 @@ static int snd_sb8_playback_prepare(stru
 		snd_sbdsp_command(chip, count >> 8);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_dma_program(chip->dma8, runtime->dma_addr,
+	snd_dma_program(dma, runtime->dma_addr,
 			size, DMA_MODE_WRITE | DMA_AUTOINIT);
 	return 0;
 }
@@ -232,9 +307,11 @@ static int snd_sb8_capture_prepare(struc
 	unsigned long flags;
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int mixreg, rate, size, count;
+	unsigned int mixreg, rate, size, count, dma;
+	unsigned char stereo, format;
 
 	rate = runtime->rate;
+	stereo = runtime->channels > 1;
 	switch (chip->hardware) {
 	case SB_HW_PRO:
 		if (runtime->channels > 1) {
@@ -242,6 +319,12 @@ static int snd_sb8_capture_prepare(struc
 			chip->capture_format = SB_DSP_HI_INPUT_AUTO;
 			break;
 		}
+		/* fall through */
+	case SB_HW_JAZZ16:
+		if (runtime->format == SNDRV_PCM_FORMAT_MU_LAW) {
+			chip->capture_format = SB_DSP_ULAW_OUTPUT_AUTO;
+			break;
+		}
 		chip->capture_format = (rate > 23000) ? SB_DSP_HI_INPUT_AUTO : SB_DSP_LO_INPUT_AUTO;
 		break;
 	case SB_HW_201:
@@ -261,10 +344,26 @@ static int snd_sb8_capture_prepare(struc
 	}
 	size = chip->c_dma_size = snd_pcm_lib_buffer_bytes(substream);
 	count = chip->c_period_size = snd_pcm_lib_period_bytes(substream);
+	switch (runtime->format)
+	{
+		case SNDRV_PCM_FORMAT_U8:
+		case SNDRV_PCM_FORMAT_MU_LAW:
+		dma = chip->dma8;
+		format = stereo ? SB_DSP_STEREO_8BIT : SB_DSP_MONO_8BIT;
+		break;
+
+		case SNDRV_PCM_FORMAT_S16_LE:
+		dma = chip->dma16;
+		format = stereo ? SB_DSP_STEREO_16BIT : SB_DSP_MONO_16BIT;
+		break;
+
+		default:
+		return -EINVAL;
+	}
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_sbdsp_command(chip, SB_DSP_SPEAKER_OFF);
-	if (runtime->channels > 1)
-		snd_sbdsp_command(chip, SB_DSP_STEREO_8BIT);
+	if (chip->hardware >= SB_HW_PRO)
+		snd_sbdsp_command(chip, format);
 	snd_sbdsp_command(chip, SB_DSP_SAMPLE_RATE);
 	if (runtime->channels > 1) {
 		snd_sbdsp_command(chip, 256 - runtime->rate_den / 2);
@@ -278,14 +377,14 @@ static int snd_sb8_capture_prepare(struc
 	} else {
 		snd_sbdsp_command(chip, 256 - runtime->rate_den);
 	}
-	if (chip->capture_format != SB_DSP_OUTPUT) {
+	if (chip->capture_format != SB_DSP_INPUT) {
 		count--;
 		snd_sbdsp_command(chip, SB_DSP_BLOCK_SIZE);
 		snd_sbdsp_command(chip, count & 0xff);
 		snd_sbdsp_command(chip, count >> 8);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-	snd_dma_program(chip->dma8, runtime->dma_addr,
+	snd_dma_program(dma, runtime->dma_addr,
 			size, DMA_MODE_READ | DMA_AUTOINIT);
 	return 0;
 }
@@ -358,10 +457,12 @@ static snd_pcm_uframes_t snd_sb8_playbac
 {
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
+	int dma;
 
 	if (chip->mode != SB_MODE_PLAYBACK_8)
 		return 0;
-	ptr = snd_dma_pointer(chip->dma8, chip->p_dma_size);
+	dma = (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE) ? chip->dma16 : chip->dma8;
+	ptr = snd_dma_pointer(dma, chip->p_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -369,10 +470,12 @@ static snd_pcm_uframes_t snd_sb8_capture
 {
 	struct snd_sb *chip = snd_pcm_substream_chip(substream);
 	size_t ptr;
+	int dma;
 
 	if (chip->mode != SB_MODE_CAPTURE_8)
 		return 0;
-	ptr = snd_dma_pointer(chip->dma8, chip->c_dma_size);
+	dma = (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE) ? chip->dma16 : chip->dma8;
+	ptr = snd_dma_pointer(dma, chip->c_dma_size);
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -443,6 +546,20 @@ static int snd_sb8_open(struct snd_pcm_s
 		runtime->hw = snd_sb8_capture;
 	}
 	switch (chip->hardware) {
+	case SB_HW_JAZZ16:
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE
+				    | SNDRV_PCM_FMTBIT_MU_LAW;
+		runtime->hw.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_44100;
+		runtime->hw.rate_max = 45455;
+		runtime->hw.channels_max = 2;
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				    snd_jazz16_hw_constraint_rate_channels, NULL,
+				    SNDRV_PCM_HW_PARAM_CHANNELS,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				    snd_jazz16_hw_constraint_channels_rate, NULL,
+				    SNDRV_PCM_HW_PARAM_RATE, -1);
+		break;
 	case SB_HW_PRO:
 		runtime->hw.rate_max = 44100;
 		runtime->hw.channels_max = 2;
@@ -463,6 +580,8 @@ static int snd_sb8_open(struct snd_pcm_s
 	default:
 		break;
 	}
+	if (chip->hardware == SB_HW_JAZZ16)
+		return 0;
 	snd_pcm_hw_constraint_ratnums(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				      &hw_constraints_clock);
 	return 0;	
--- linux-2.6.20/include/sound/sb.h.orig	2007-02-19 20:57:51.000000000 +0100
+++ linux-2.6.20/include/sound/sb.h	2007-03-03 12:31:36.000000000 +0100
@@ -38,6 +38,7 @@ enum sb_hw_type {
 	SB_HW_ALS100,		/* Avance Logic ALS100 chip */
 	SB_HW_ALS4000,		/* Avance Logic ALS4000 chip */
 	SB_HW_DT019X,		/* Diamond Tech. DT-019X / Avance Logic ALS-007 */
+	SB_HW_JAZZ16,		/* Media Vision Jazz16 chip */
 };
 
 #define SB_OPEN_PCM			0x01
@@ -140,8 +141,11 @@ struct snd_sb {
 #define SB_DSP_LO_INPUT_AUTO	0x2c
 #define SB_DSP_HI_OUTPUT_AUTO	0x90
 #define SB_DSP_HI_INPUT_AUTO	0x98
+#define SB_DSP_ULAW_OUTPUT_AUTO	0x7f
+#define SB_DSP_ULAW_INPUT_AUTO	0x8f
 #define SB_DSP_IMMED_INT	0xf2
 #define SB_DSP_GET_VERSION	0xe1
+#define SB_DSP_GET_JAZZ_VERSION	0xfa
 #define SB_DSP_SPEAKER_ON	0xd1
 #define SB_DSP_SPEAKER_OFF	0xd3
 #define SB_DSP_DMA8_OFF		0xd0
@@ -265,6 +269,14 @@ struct snd_sb {
 #define SB_DMASETUP_DMA6	0x40
 #define SB_DMASETUP_DMA7	0x80
 
+/* Jazz16 configuration. */
+#define SB_JAZZ16_CONFIG_PORT	0x201
+#define SB_JAZZ16_WAKEUP	0xaf
+#define SB_JAZZ16_SET_PORTS	0x50
+
+/* Check the output of SB_DSP_GET_JAZZ_VERSION. */
+#define SB_VERSION_IS_JAZZ16(x)	((x) == 0x12)
+
 /*
  *
  */
--- linux-2.6.20/sound/isa/Kconfig.orig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.20/sound/isa/Kconfig	2007-03-02 23:12:56.000000000 +0100
@@ -248,6 +248,14 @@ config SND_INTERWAVE_STB
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-interwave-stb.
 
+config SND_JAZZ16
+	tristate "Media Vision Jazz16"
+	depends on SND
+	select SND_OPL3_LIB
+	select SND_PCM
+	help
+	  Say 'Y' or 'M' to include support for Media Vision Jazz16.
+
 config SND_OPL3SA2
 	tristate "Yamaha OPL3-SA2/SA3"
 	depends on SND
--- linux-2.6.20/Documentation/sound/alsa/ALSA-Configuration.txt-orig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.20/Documentation/sound/alsa/ALSA-Configuration.txt	2007-03-11 20:11:08.000000000 +0100
@@ -1120,6 +1120,13 @@ Prior to version 0.9.0rc4 options had a 
 
     This module supports multiple cards, autoprobe and ISA PnP.
 
+  Module snd-jazz16
+  -----------------
+
+    Module for sound cards based Media Vision Jazz16 chip (PnP only)
+
+    This module supports multiple cards and PnP.
+
   Module snd-korg1212
   -------------------
 
--- linux-2.6.20/drivers/pnp/Makefile-orig	2007-02-19 23:24:22.000000000 +0100
+++ linux-2.6.20/drivers/pnp/Makefile	2007-02-19 23:24:22.000000000 +0100
@@ -7,2 +7,3 @@ obj-$(CONFIG_PNPACPI)		+= pnpacpi/
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
+obj-$(CONFIG_JAZZ16PNP)		+= jazz16pnp.o
--- linux-2.6.20/drivers/pnp/Kconfig-orig	2007-02-19 23:23:26.000000000 +0100
+++ linux-2.6.20/drivers/pnp/Kconfig	2007-02-19 23:26:22.000000000 +0100
@@ -37,5 +37,17 @@ source "drivers/pnp/pnpacpi/Kconfig"
 
 source "drivers/pnp/pnpacpi/Kconfig"
 
+#
+# Jazz16 Plug and Play configuration
+#
+config JAZZ16PNP
+	bool "Jazz16 sound card Plug and Play support"
+	depends on PNP && ISA
+	help
+	  Say Y here if you would like support for automatic configuration
+          of I/O ports, DMA channels and IRQ lines of Jazz16 sound cards.
+
+	  If unsure, say N.
+
 endmenu
 
--- linux-2.6.20/drivers/pnp/jazz16pnp.c-orig	2007-03-11 22:11:58.000000000 +0100
+++ linux-2.6.20/drivers/pnp/jazz16pnp.c	2007-03-11 20:21:22.000000000 +0100
@@ -0,0 +1,562 @@
+/*  Media Vision Jazz16 Plug & Play support.
+ *
+ *  Copyright (c) 2007 Rask Ingemann Lambertsen <rask@sygehus.dk>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ *  The Jazz16 detection and setup was ported from the OSS/Free SoundBlaster
+ *  driver. Three devices are added to the PnP layer:
+ *
+ *  Device 0: The game port.
+ *  Device 1: The SoundBlaster look-alike part.
+ *  Device 2: The MPU-401 port.
+ *
+ *  BUGS: Setting the MPU-401 IRQ requires the SB part to be active.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/pnp.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/sb.h>
+
+MODULE_AUTHOR ("Rask Ingemann Lambertsen <rask@sygehus.dk>");
+MODULE_DESCRIPTION ("Jazz16 Plug & Play support");
+MODULE_LICENSE("GPL");
+
+uint jazz16pnp_disable = 0;	/* Disable Jazz16 PnP. */
+module_param_named (disable, jazz16pnp_disable, uint, 0);
+MODULE_PARM_DESC (disable, "Jazz16 Plug & Play disable switch");
+
+uint jazz16pnp_verbose = 0;	/* Verbosity level. */
+module_param_named (verbose, jazz16pnp_verbose, uint, 0);
+MODULE_PARM_DESC (verbose, "Jazz16 Plug & Play verbosity level");
+
+#define PFX		"jazz16pnp: "
+#define PFX_DEBUG	KERN_DEBUG PFX
+#define PFX_INFO	KERN_INFO PFX
+#define PFX_ERR		KERN_ERR PFX
+
+#define JAZZ16_SET_DMAINTR      0xFB
+
+extern void *pnp_alloc(long size);
+
+static struct pnp_dev *jazz16_gameport_dev = NULL;
+static struct pnp_dev *jazz16_sb_dev = NULL;
+static struct pnp_dev *jazz16_mpu401_dev = NULL;
+
+static uint jazz16_sb_port = 0, jazz16_sb_irq = 0;
+static uint jazz16_sb_dma1 = 0, jazz16_sb_dma2 = 0;
+static uint jazz16_mpu401_port = 0, jazz16_mpu401_irq = 0;
+
+static uint jazz16pnp_count = 0;
+
+static struct pnp_protocol jazz16pnp_protocol;
+
+static int __init jazz16pnp_add_gameport (void)
+{
+	struct pnp_dev *dev;
+	struct pnp_id *dev_id;
+	struct pnp_port *port;
+	struct pnp_option *option;
+
+	if (! (dev = pnp_alloc (sizeof (struct pnp_dev))))
+		goto out_no_dev;
+	if (! (dev_id = pnp_alloc (sizeof (struct pnp_id))))
+		goto out_no_id;
+	if (! (port = pnp_alloc (sizeof (struct pnp_port))))
+		goto out_no_port;
+	if (! (option = pnp_register_independent_option (dev)))
+		goto out_no_option;
+
+	dev->protocol = &jazz16pnp_protocol;
+	dev->capabilities = PNP_READ;
+	dev->active = 1;
+	dev->number = 0;
+
+	pnp_init_resource_table (&dev->res);
+	dev->res.port_resource[0].start = SB_JAZZ16_CONFIG_PORT;
+	dev->res.port_resource[0].end   = SB_JAZZ16_CONFIG_PORT;
+	dev->res.port_resource[0].flags	= IORESOURCE_IO;
+
+	port->min = SB_JAZZ16_CONFIG_PORT;
+	port->max = SB_JAZZ16_CONFIG_PORT;
+	port->size = 1;
+	port->align = 0;
+	pnp_register_port_resource (option, port);
+	
+	memcpy (dev_id->id, "PNPb02f", PNP_ID_LEN);
+	pnp_add_id (dev_id, dev);
+
+	jazz16_gameport_dev = dev;
+	pnp_add_device (dev);
+	return (0);
+
+out_no_option:
+	kfree (port);
+out_no_port:
+	kfree (dev_id);
+out_no_id:
+	kfree (dev);
+out_no_dev:
+	return (-ENOMEM);
+};
+
+static int __init jazz16pnp_add_sb (void)
+{
+	struct pnp_dev *sbdev;
+	struct pnp_port *sbport;
+	struct pnp_irq *sbirq;
+	struct pnp_dma *sbdma1;
+	struct pnp_dma *sbdma2;
+	struct pnp_id *sbid;
+	struct pnp_option *sboption;
+	unsigned long irq_map;
+
+	if (! (sbdev = pnp_alloc (sizeof (struct pnp_dev))))
+		goto out_no_sbdev;
+	if (! (sbport = pnp_alloc (sizeof (struct pnp_port))))
+		goto out_no_sbport;
+	if (! (sbirq = pnp_alloc (sizeof (struct pnp_irq))))
+		goto out_no_sbirq;
+	if (! (sbdma1 = pnp_alloc (sizeof (struct pnp_dma))))
+		goto out_no_sbdma1;
+	if (! (sbdma2 = pnp_alloc (sizeof (struct pnp_dma))))
+		goto out_no_sbdma2;
+	if (! (sbid = pnp_alloc (sizeof (struct pnp_id))))
+		goto out_no_sbid;
+	if (! (sboption = pnp_register_independent_option (sbdev)))
+		goto out_no_sboption;
+
+	pnp_init_resource_table (&sbdev->res);
+	sbdev->capabilities = PNP_READ | PNP_WRITE | PNP_CONFIGURABLE | PNP_DISABLE;
+	sbdev->protocol = &jazz16pnp_protocol;
+	sbdev->number = 1;
+
+	sbport->min = 0x220;
+	sbport->max = 0x260;
+	sbport->size = 0x10;
+	sbport->align = 0x20;
+	sbport->flags = PNP_PORT_FLAG_16BITADDR;
+	pnp_register_port_resource (sboption, sbport);
+
+	irq_map = (1 << 3) | (1 << 5) | (1 << 7) |
+		  (1 << 9) | (1 << 10) | (1 << 15);
+	bitmap_copy (sbirq->map, &irq_map, BITS_PER_LONG);
+	sbirq->flags  = IORESOURCE_IRQ_HIGHEDGE;
+	pnp_register_irq_resource (sboption, sbirq);
+
+	sbdma1->map = (1 << 1) | (1 << 3);
+	pnp_register_dma_resource (sboption, sbdma1);
+
+	sbdma2->map = (1 << 5) | (1 << 7);
+	pnp_register_dma_resource (sboption, sbdma2);
+
+	memcpy (sbid->id, "PNPb00f", PNP_ID_LEN);
+	pnp_add_id (sbid, sbdev);
+
+	jazz16_sb_dev = sbdev;
+	pnp_add_device (sbdev);
+	return (0);
+
+out_no_sboption:
+	kfree (sbid);
+out_no_sbid:
+	kfree (sbdma2);
+out_no_sbdma2:
+	kfree (sbdma1);
+out_no_sbdma1:
+	kfree (sbirq);
+out_no_sbirq:
+	kfree (sbport);
+out_no_sbport:
+	kfree (sbdev);
+out_no_sbdev:
+	return (-ENOMEM);
+}
+
+static int __init jazz16pnp_add_mpu401 (void)
+{
+	struct pnp_dev *mpudev;
+	struct pnp_port *mpuport;
+	struct pnp_irq *mpuirq;
+	struct pnp_id *mpuid;
+	struct pnp_option *mpuoption;
+	unsigned long irq_map;
+
+	if (! (mpudev = pnp_alloc (sizeof (struct pnp_dev))))
+		goto out_no_mpudev;
+	if (! (mpuport = pnp_alloc (sizeof (struct pnp_port))))
+		goto out_no_mpuport;
+	if (! (mpuirq = pnp_alloc (sizeof (struct pnp_irq))))
+		goto out_no_mpuirq;
+	if (! (mpuid = pnp_alloc (sizeof (struct pnp_id))))
+		goto out_no_mpuid;
+	if (! (mpuoption = pnp_register_independent_option (mpudev)))
+		goto out_no_mpuoption;
+
+	pnp_init_resource_table (&mpudev->res);
+	mpudev->capabilities = PNP_READ | PNP_WRITE | PNP_CONFIGURABLE | PNP_DISABLE;
+	mpudev->protocol = &jazz16pnp_protocol;
+	mpudev->number = 2;
+
+	mpuport->min = 0x310;
+	mpuport->max = 0x330;
+	mpuport->size = 0x2;
+	mpuport->align = 0x10;
+	mpuport->flags = PNP_PORT_FLAG_16BITADDR;
+	pnp_register_port_resource (mpuoption, mpuport);
+
+	irq_map = (1 << 3) | (1 << 5) | (1 << 7) |
+		  (1 << 9) | (1 << 10) | (1 << 15);
+	bitmap_copy (mpuirq->map, &irq_map, BITS_PER_LONG);
+	mpuirq->flags = IORESOURCE_IRQ_HIGHEDGE;
+	pnp_register_irq_resource (mpuoption, mpuirq);
+
+	memcpy (mpuid->id, "PNPb006", PNP_ID_LEN);
+	pnp_add_id (mpuid, mpudev);
+
+	jazz16_mpu401_dev = mpudev;
+	pnp_add_device (mpudev);
+	return (0);
+
+	kfree (mpuoption);
+out_no_mpuoption:
+	kfree (mpuid);
+out_no_mpuid:
+	kfree (mpuirq);
+out_no_mpuirq:
+	kfree (mpuport);
+out_no_mpuport:
+	kfree (mpudev);
+out_no_mpudev:
+	return (-ENOMEM);
+}
+
+/* Configure the SB and MPU ports. Passing 0 for both disables the Jazz16. */
+static void jazz16_port_setup (const uint sbport, const uint mpuport)
+{
+	u8 config;
+
+	switch (sbport) {
+		case 0x220:
+		case 0x240:
+		case 0x260:
+		config = sbport & 0x70;
+		jazz16_sb_port = sbport;
+		break;
+
+		default:
+		config = 0;
+		jazz16_sb_port = 0;
+		break;
+	}
+	switch (mpuport) {
+		case 0x310:
+		case 0x320:
+		case 0x330:
+		config |= (mpuport >> 4) & 0x07;
+		jazz16_mpu401_port = mpuport;
+		break;
+
+		default:
+		config |= 0;
+		jazz16_mpu401_port = 0;
+		break;
+	}
+	if (jazz16pnp_verbose)
+		printk (PFX_DEBUG "Setting SB port = 0x%x, MPU port = 0x%x.\n",
+			jazz16_sb_port, jazz16_mpu401_port);
+	outb (SB_JAZZ16_WAKEUP,		SB_JAZZ16_CONFIG_PORT);
+	outb (SB_JAZZ16_SET_PORTS,	SB_JAZZ16_CONFIG_PORT);
+	outb (config,			SB_JAZZ16_CONFIG_PORT);
+}
+
+static u8 jazz16_irq_config (uint irq)
+{
+	switch (irq) {
+		case  3: return (3);
+		case  5: return (1);
+		case  7: return (4);
+		case  9: return (2);
+		case 10: return (5);
+		case 15: return (6);
+		default: return (0);
+	}
+}
+
+static u8 jazz16_dma_config (uint dma)
+{
+	switch (dma) {
+		case  1: return (1);
+		case  3: return (2);
+		case  5: return (3);
+		case  7: return (4);
+		default: return (0);
+	}
+}
+
+/* The my_sbdsp_xxx functions were ripped from sound/isa/sb/sb_common.c. */
+#define BUSY_LOOPS 100000
+
+int my_sbdsp_command(unsigned int base, unsigned char val)
+{
+	int i;
+	for (i = BUSY_LOOPS; i; i--)
+		if ((inb(SBP1(base, STATUS)) & 0x80) == 0) {
+			outb(val, SBP1(base, COMMAND));
+			return 1;
+		}
+	return 0;
+}
+
+int my_sbdsp_get_byte(unsigned int base)
+{
+	int val;
+	int i;
+	for (i = BUSY_LOOPS; i; i--) {
+		if (inb(SBP1(base, DATA_AVAIL)) & 0x80) {
+			val = inb(SBP1(base, READ));
+			return val;
+		}
+	}
+	return -ENODEV;
+}
+
+int my_sbdsp_reset (unsigned int base)
+{
+	int i;
+
+	outb(1, SBP1(base, RESET));
+	udelay(10);
+	outb(0, SBP1(base, RESET));
+	udelay(30);
+	for (i = BUSY_LOOPS; i; i--)
+		if (inb(SBP1(base, DATA_AVAIL)) & 0x80) {
+			if (inb(SBP1(base, READ)) == 0xaa)
+				return 0;
+			else
+				break;
+		}
+	return -ENODEV;
+}
+
+static int jazz16_irq_dma_setup (unsigned int base, uint sbirq, uint mpuirq, uint dma8, uint dma16)
+{
+	u8 dma_config, irq_config;
+
+	if (jazz16pnp_verbose)
+		printk (PFX_DEBUG "Setting SB irq %u, dma %u&%u, MPU irq %u.\n",
+			sbirq, dma8, dma16, mpuirq);
+	irq_config = jazz16_irq_config (sbirq) | jazz16_irq_config (mpuirq) << 4;
+	dma_config = jazz16_dma_config (dma8)  | jazz16_dma_config (dma16)  << 4;
+	if (! my_sbdsp_command (base, JAZZ16_SET_DMAINTR))
+		return (0);
+
+	if (! my_sbdsp_command (base, dma_config))
+		return (0);
+	jazz16_sb_dma1 = dma8;
+	jazz16_sb_dma2 = dma16;
+
+	if (! my_sbdsp_command (base, irq_config))
+		return (0);
+	jazz16_sb_irq = sbirq;
+	jazz16_mpu401_irq = mpuirq;
+	return (1);
+}
+
+static int jazz16pnp_get_resources (struct pnp_dev *dev, struct pnp_resource_table *res)
+{
+	pnp_init_resource_table(res);
+	if (dev == jazz16_gameport_dev) {
+		res->port_resource[0].start = res->port_resource[0].end = SB_JAZZ16_CONFIG_PORT;
+		res->port_resource[0].flags = IORESOURCE_IO;
+	}
+	else if (dev == jazz16_sb_dev) {
+		if (!jazz16_sb_port)
+			return (0);
+		res->port_resource[0].start = jazz16_sb_port;
+		res->port_resource[0].end = jazz16_sb_port + 0x10 - 1;
+		res->port_resource[0].flags = IORESOURCE_IO;
+
+		res->irq_resource[0].start = res->irq_resource[0].end = jazz16_sb_irq;
+		res->irq_resource[0].flags = IORESOURCE_IRQ;
+
+		res->dma_resource[0].start = res->dma_resource[0].end = jazz16_sb_dma1;
+		res->dma_resource[0].flags = IORESOURCE_DMA;
+		res->dma_resource[1].start = res->dma_resource[1].end = jazz16_sb_dma2;
+		res->dma_resource[1].flags = IORESOURCE_DMA;
+	}
+	else if (dev == jazz16_mpu401_dev) {
+		if (!jazz16_mpu401_port)
+			return (0);
+		res->port_resource[0].start = jazz16_mpu401_port;
+		res->port_resource[0].end = jazz16_mpu401_port + 2 - 1;
+		res->port_resource[0].flags = IORESOURCE_IO;
+
+		res->irq_resource[0].start = res->irq_resource[0].end = jazz16_mpu401_irq;
+		res->irq_resource[0].flags = IORESOURCE_IRQ;
+	}
+	else
+		return (-EINVAL);
+	return (0);
+}
+
+static int jazz16pnp_set_resources (struct pnp_dev *dev, struct pnp_resource_table *res)
+{
+	unsigned int irq, dma1, dma2;
+
+	if (dev == jazz16_gameport_dev)
+		return (-ENOSYS);
+
+	else if (dev == jazz16_sb_dev) {
+		if ((res->port_resource[0].flags & (IORESOURCE_IO | IORESOURCE_UNSET)) == IORESOURCE_IO)
+			jazz16_port_setup (res->port_resource[0].start, jazz16_mpu401_port);
+		if ((res->dma_resource[0].flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) == IORESOURCE_DMA)
+			dma1 = res->dma_resource[0].start;
+		else
+			dma1 = jazz16_sb_dma1;
+		if ((res->dma_resource[1].flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) == IORESOURCE_DMA)
+			dma2 = res->dma_resource[1].start;
+		else
+			dma2 = jazz16_sb_dma2;
+		if ((res->irq_resource[0].flags & (IORESOURCE_IRQ | IORESOURCE_UNSET)) == IORESOURCE_IRQ)
+			irq = res->irq_resource[0].start;
+		else
+			irq = jazz16_sb_irq;
+		if (jazz16_sb_port)
+			jazz16_irq_dma_setup (jazz16_sb_port, irq, jazz16_mpu401_irq, dma1, dma2);
+		else
+			return (-EBUSY);
+		return (0);
+	}
+	else if (dev == jazz16_mpu401_dev) {
+		if ((res->port_resource[0].flags & (IORESOURCE_IO | IORESOURCE_UNSET)) == IORESOURCE_IO)
+			jazz16_port_setup (jazz16_sb_port, res->port_resource[0].start);
+		if ((res->irq_resource[0].flags & (IORESOURCE_IRQ | IORESOURCE_UNSET)) == IORESOURCE_IRQ)
+			irq = res->irq_resource[0].start;
+		else
+			irq = jazz16_mpu401_irq;
+		if (jazz16_sb_port)
+			jazz16_irq_dma_setup (jazz16_sb_port, jazz16_sb_irq, irq, jazz16_sb_dma1, jazz16_sb_dma2);
+		else
+			return (-EBUSY);
+		return (0);
+	}
+	else
+		return (-EINVAL);
+}
+
+static int jazz16pnp_disable_resources (struct pnp_dev *dev)
+{
+	if (dev == jazz16_gameport_dev) {
+		return (-ENOSYS);
+	}
+	else if (dev == jazz16_sb_dev) {
+		jazz16_port_setup (0, jazz16_mpu401_port);
+		return (0);
+	}
+	else if (dev == jazz16_mpu401_dev) {
+		jazz16_port_setup (jazz16_sb_port, 0);
+		return (0);
+	}
+	else {
+		BUG();
+		return (-EINVAL);
+	}
+}
+
+static struct pnp_protocol jazz16pnp_protocol = {
+	.name	 = "Jazz16 PnP",
+	.get	 = jazz16pnp_get_resources,
+	.set	 = jazz16pnp_set_resources,
+	.disable = jazz16pnp_disable_resources,
+};
+
+static uint __init jazz16_check (unsigned int base)
+{
+	if (my_sbdsp_reset (base))
+		return (0);
+	if (! (my_sbdsp_command (base, SB_DSP_GET_JAZZ_VERSION)))
+ 		return (0);
+	return (SB_VERSION_IS_JAZZ16 (my_sbdsp_get_byte (base)));
+}
+
+static int __init jazz16pnp_init (void)
+{
+	int err = 0;
+	unsigned int base;
+
+	if (jazz16pnp_disable == 1) {
+		printk (PFX_INFO "Jazz16 Plug & Play support disabled.\n");
+		return (0);
+	}
+
+	if (pnp_register_protocol (&jazz16pnp_protocol) < 0)
+		return (-EBUSY);
+
+	if (! request_region (SB_JAZZ16_CONFIG_PORT, 1, "Jazz16 PnP probe")) {
+		pnp_unregister_protocol (&jazz16pnp_protocol);
+		return (-EBUSY);
+	}
+	if (jazz16pnp_verbose)
+		printk (PFX_DEBUG "Scanning for Jazz16 cards...\n");
+
+	for (base = 0x220; base <= 0x260; base += 0x20) {
+		if (! request_region (base, 16, "Jazz16 PnP probe"))
+			continue;
+		if (jazz16pnp_verbose)
+			printk (PFX_DEBUG "Probing at 0x%x.\n", base);
+		jazz16_port_setup (base, 0);
+		if (jazz16_check (base))
+			jazz16pnp_count ++;
+		jazz16_port_setup (0, 0);
+		release_region (base, 16);
+		if (jazz16pnp_count)
+			break;
+	}
+	release_region (SB_JAZZ16_CONFIG_PORT, 1);
+	if (!jazz16pnp_count) {
+		err = -ENODEV;
+	} else {
+		if (!(jazz16pnp_disable & 2))
+			if (jazz16pnp_add_gameport ())
+				printk (PFX_ERR "Failed to add game port.\n");
+		if (!(jazz16pnp_disable & 4))
+			if (jazz16pnp_add_sb ())
+				printk (PFX_ERR "Failed to add SB port.\n");
+		if (!(jazz16pnp_disable & 8))
+			if (jazz16pnp_add_mpu401 ())
+				printk (PFX_ERR "Failed to add MPU-401 port.\n");
+	}
+	printk (PFX_INFO "%u Jazz16 card%s detected.\n", jazz16pnp_count, jazz16pnp_count == 1 ? "" : "s");
+	return (err);
+}
+module_init (jazz16pnp_init);
+
+static void __exit jazz16pnp_exit (void)
+{
+	pnp_unregister_protocol (&jazz16pnp_protocol);
+}
+module_exit (jazz16pnp_exit);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
