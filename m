From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 16/24] sound/pci: coding style fixes: nm256
Date: Tue, 9 Sep 2008 05:57:29 +0400
Message-ID: <20080909015729.GS6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 308AB103821
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:57:35 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1536698fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:57:35 -0700 (PDT)
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

 sound/pci/nm256/nm256.c      |   66 +++++++++++++++++++++---------------------
 sound/pci/nm256/nm256_coef.c |    4 +-
 sound/pci/oxygen/oxygen_io.c |    2 +-
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 50c9f8a..b12e322 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1,4 +1,4 @@
-/* 
+/*
  * Driver for NeoMagic 256AV and 256ZX chipsets.
  * Copyright (c) 2000 by Takashi Iwai <tiwai@suse.de>
  *
@@ -23,8 +23,8 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
-  
-#include <asm/io.h>
+
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -190,7 +190,7 @@ struct nm256_stream {
 	struct snd_pcm_substream *substream;
 	int running;
 	int suspended;
-	
+
 	u32 buf;	/* offset from chip->buffer */
 	int bufsize;	/* buffer size in bytes */
 	void __iomem *bufptr;		/* mapped pointer */
@@ -205,7 +205,7 @@ struct nm256_stream {
 };
 
 struct nm256 {
-	
+
 	struct snd_card *card;
 
 	void __iomem *cport;		/* control port */
@@ -375,11 +375,11 @@ snd_nm256_load_coefficient(struct nm256 *chip, int stream, int number)
 	if (stream == SNDRV_PCM_STREAM_CAPTURE)
 		number += 8;
 
-	if (! chip->use_cache) {
+	if (!chip->use_cache) {
 		snd_nm256_load_one_coefficient(chip, stream, addr, number);
 		return;
 	}
-	if (! chip->coeffs_current) {
+	if (!chip->coeffs_current) {
 		snd_nm256_write_buffer(chip, coefficients, chip->all_coeff_buf,
 				       NM_TOTAL_COEFF_COUNT * 4);
 		chip->coeffs_current = 1;
@@ -400,7 +400,7 @@ static unsigned int samplerates[8] = {
 	8000, 11025, 16000, 22050, 24000, 32000, 44100, 48000,
 };
 static struct snd_pcm_hw_constraint_list constraints_rates = {
-	.count = ARRAY_SIZE(samplerates), 
+	.count = ARRAY_SIZE(samplerates),
 	.list = samplerates,
 	.mask = 0,
 };
@@ -571,7 +571,7 @@ snd_nm256_playback_trigger(struct snd_pcm_substream *substream, int cmd)
 		s->suspended = 0;
 		/* fallthru */
 	case SNDRV_PCM_TRIGGER_START:
-		if (! s->running) {
+		if (!s->running) {
 			snd_nm256_playback_start(chip, s, substream);
 			s->running = 1;
 		}
@@ -607,7 +607,7 @@ snd_nm256_capture_trigger(struct snd_pcm_substream *substream, int cmd)
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		if (! s->running) {
+		if (!s->running) {
 			snd_nm256_capture_start(chip, s, substream);
 			s->running = 1;
 		}
@@ -680,7 +680,7 @@ snd_nm256_capture_pointer(struct snd_pcm_substream *substream)
 	if (snd_BUG_ON(!s))
 		return 0;
 	curp = snd_nm256_readl(chip, NM_RBUFFER_CURRP) - (unsigned long)s->buf;
-	curp %= s->dma_size;	
+	curp %= s->dma_size;
 	return bytes_to_frames(substream->runtime, curp);
 }
 
@@ -956,8 +956,8 @@ snd_nm256_pcm(struct nm256 *chip, int device)
 }
 
 
-/* 
- * Initialize the hardware. 
+/*
+ * Initialize the hardware.
  */
 static void
 snd_nm256_init_chip(struct nm256 *chip)
@@ -966,8 +966,8 @@ snd_nm256_init_chip(struct nm256 *chip)
 	snd_nm256_writeb(chip, 0x0, 0x11);
 	snd_nm256_writew(chip, 0x214, 0);
 	/* stop sounds.. */
-	//snd_nm256_playback_stop(chip);
-	//snd_nm256_capture_stop(chip);
+	/* snd_nm256_playback_stop(chip); */
+	/* snd_nm256_capture_stop(chip); */
 }
 
 
@@ -997,8 +997,8 @@ snd_nm256_intr_check(struct nm256 *chip)
 	return IRQ_NONE;
 }
 
-/* 
- * Handle a potential interrupt for the device referred to by DEV_ID. 
+/*
+ * Handle a potential interrupt for the device referred to by DEV_ID.
  *
  * I don't like the cut-n-paste job here either between the two routines,
  * but there are sufficient differences between the two interrupt handlers
@@ -1147,8 +1147,8 @@ snd_nm256_ac97_ready(struct nm256 *chip)
 	testaddr = chip->mixer_status_offset;
 	testb = chip->mixer_status_mask;
 
-	/* 
-	 * Loop around waiting for the mixer to become ready. 
+	/*
+	 * Loop around waiting for the mixer to become ready.
 	 */
 	while (timeout-- > 0) {
 		if ((snd_nm256_readw(chip, testaddr) & testb) == 0)
@@ -1158,7 +1158,7 @@ snd_nm256_ac97_ready(struct nm256 *chip)
 	return 0;
 }
 
-/* 
+/*
  * Initial register values to be written to the AC97 mixer.
  * While most of these are identical to the reset values, we do this
  * so that we have most of the register contents cached--this avoids
@@ -1187,7 +1187,7 @@ static struct initialValues nm256_ac97_init_val[] =
 	{ AC97_REC_SEL,		0x0000 },
 	{ AC97_REC_GAIN,	0x0B0B },
 	{ AC97_GENERAL_PURPOSE,	0x0000 },
-	{ AC97_3D_CONTROL,	0x8000 }, 
+	{ AC97_3D_CONTROL,	0x8000 },
 	{ AC97_VENDOR_ID1, 	0x8384 },
 	{ AC97_VENDOR_ID2,	0x7609 },
 };
@@ -1217,7 +1217,7 @@ snd_nm256_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	return chip->ac97_regs[idx];
 }
 
-/* 
+/*
  */
 static void
 snd_nm256_ac97_write(struct snd_ac97 *ac97,
@@ -1273,16 +1273,16 @@ snd_nm256_ac97_reset(struct snd_ac97 *ac97)
 
 	/* Reset the mixer.  'Tis magic!  */
 	snd_nm256_writeb(chip, 0x6c0, 1);
-	if (! chip->reset_workaround) {
+	if (!chip->reset_workaround) {
 		/* Dell latitude LS will lock up by this */
 		snd_nm256_writeb(chip, 0x6cc, 0x87);
 	}
-	if (! chip->reset_workaround_2) {
+	if (!chip->reset_workaround_2) {
 		/* Dell latitude CSx will lock up by this */
 		snd_nm256_writeb(chip, 0x6cc, 0x80);
 		snd_nm256_writeb(chip, 0x6cc, 0x0);
 	}
-	if (! chip->in_resume) {
+	if (!chip->in_resume) {
 		int i;
 		for (i = 0; i < ARRAY_SIZE(nm256_ac97_init_val); i++) {
 			/* preload the cache, so as to avoid even a single
@@ -1309,7 +1309,7 @@ snd_nm256_mixer(struct nm256 *chip)
 
 	chip->ac97_regs = kcalloc(ARRAY_SIZE(nm256_ac97_init_val),
 				  sizeof(short), GFP_KERNEL);
-	if (! chip->ac97_regs)
+	if (!chip->ac97_regs)
 		return -ENOMEM;
 
 	if ((err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus)) < 0)
@@ -1323,14 +1323,14 @@ snd_nm256_mixer(struct nm256 *chip)
 	err = snd_ac97_mixer(pbus, &ac97, &chip->ac97);
 	if (err < 0)
 		return err;
-	if (! (chip->ac97->id & (0xf0000000))) {
+	if (!(chip->ac97->id & (0xf0000000))) {
 		/* looks like an invalid id */
 		sprintf(chip->card->mixername, "%s AC97", chip->card->driver);
 	}
 	return 0;
 }
 
-/* 
+/*
  * See if the signature left by the NM256 BIOS is intact; if so, we use
  * the associated address as the end of our audio buffer in the video
  * RAM.
@@ -1498,7 +1498,7 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 	chip->streams[SNDRV_PCM_STREAM_PLAYBACK].bufsize = playback_bufsize * 1024;
 	chip->streams[SNDRV_PCM_STREAM_CAPTURE].bufsize = capture_bufsize * 1024;
 
-	/* 
+	/*
 	 * The NM256 has two memory ports.  The first port is nothing
 	 * more than a chunk of video RAM, which is used as the I/O ring
 	 * buffer.  The second port has the actual juicy stuff (like the
@@ -1529,7 +1529,7 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 		/* Ok, try to see if this is a non-AC97 version of the hardware. */
 		pval = snd_nm256_readw(chip, NM_MIXER_PRESENCE);
 		if ((pval & NM_PRESENCE_MASK) != NM_PRESENCE_VALUE) {
-			if (! force_ac97) {
+			if (!force_ac97) {
 				printk(KERN_ERR "nm256: no ac97 is found!\n");
 				printk(KERN_ERR "  force the driver to load by "
 				       "passing in the module parameter\n");
@@ -1555,7 +1555,7 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 		chip->mixer_status_offset = NM2_MIXER_STATUS_OFFSET;
 		chip->mixer_status_mask = NM2_MIXER_READY_MASK;
 	}
-	
+
 	chip->buffer_size = chip->streams[SNDRV_PCM_STREAM_PLAYBACK].bufsize +
 		chip->streams[SNDRV_PCM_STREAM_CAPTURE].bufsize;
 	if (chip->use_cache)
@@ -1614,8 +1614,8 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 
 	snd_nm256_init_chip(chip);
 
-	// pci_set_master(pci); /* needed? */
-	
+	/* pci_set_master(pci); needed? */
+
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
 		goto __error;
 
diff --git a/sound/pci/nm256/nm256_coef.c b/sound/pci/nm256/nm256_coef.c
index 747d5d6..a75e037 100644
--- a/sound/pci/nm256/nm256_coef.c
+++ b/sound/pci/nm256/nm256_coef.c
@@ -1,6 +1,6 @@
 #define NM_TOTAL_COEFF_COUNT 0x3158
 
-static char coefficients[NM_TOTAL_COEFF_COUNT * 4] = { 
+static char coefficients[NM_TOTAL_COEFF_COUNT * 4] = {
 	0xFF, 0xFF, 0x2F, 0x00, 0x4B, 0xFF, 0xA5, 0x01, 0xEF, 0xFC, 0x21,
 	0x05, 0x87, 0xF7, 0x62, 0x11, 0xE9, 0x45, 0x5E, 0xF9, 0xB5, 0x01,
 	0xDE, 0xFF, 0xA4, 0xFF, 0x60, 0x00, 0xCA, 0xFF, 0x0D, 0x00, 0xFD,
@@ -4594,7 +4594,7 @@ static char coefficients[NM_TOTAL_COEFF_COUNT * 4] = {
 	0x9A, 0xFF, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0xAD,
 	0xFF, 0x48, 0x01, 0xE2, 0xFC, 0xDA, 0x05, 0x97, 0xF6, 0x0B, 0x0F,
 	0x79, 0x42, 0xC7, 0x03, 0x9E, 0xFA, 0x71, 0x04, 0x28, 0xFD, 0x63,
-	0x01, 0x8D, 0xFF, 0x0F, 0x00 
+	0x01, 0x8D, 0xFF, 0x0F, 0x00
 };
 
 static u16
diff --git a/sound/pci/oxygen/oxygen_io.c b/sound/pci/oxygen/oxygen_io.c
index 83f135f..17618c1 100644
--- a/sound/pci/oxygen/oxygen_io.c
+++ b/sound/pci/oxygen/oxygen_io.c
@@ -20,7 +20,7 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <sound/core.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include "oxygen.h"
 
 u8 oxygen_read8(struct oxygen *chip, unsigned int reg)
