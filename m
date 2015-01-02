From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/21] ALSA: sb8: Remove always NULL parameters
Date: Fri,  2 Jan 2015 12:24:41 +0100
Message-ID: <1420197895-17696-8-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 576562604DD
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:06 +0100 (CET)
In-Reply-To: <1420197895-17696-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

snd_sb8dsp_pcm() and snd_sb8dsp_midi() take a pointer to a pointer of a
PCM/MIDI where if this parameter is provided the newly allocated object is
stored. All callers pass NULL though, so remove the parameter. This makes
the code a bit cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/sb.h      | 4 ++--
 sound/isa/sb/jazz16.c   | 2 +-
 sound/isa/sb/sb8.c      | 4 ++--
 sound/isa/sb/sb8_main.c | 6 +-----
 sound/isa/sb/sb8_midi.c | 6 +-----
 5 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/sound/sb.h b/include/sound/sb.h
index ba39603..13438ff 100644
--- a/include/sound/sb.h
+++ b/include/sound/sb.h
@@ -308,7 +308,7 @@ void snd_sbmixer_resume(struct snd_sb *chip);
 #endif
 
 /* sb8_init.c */
-int snd_sb8dsp_pcm(struct snd_sb *chip, int device, struct snd_pcm ** rpcm);
+int snd_sb8dsp_pcm(struct snd_sb *chip, int device);
 /* sb8.c */
 irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip);
 int snd_sb8_playback_open(struct snd_pcm_substream *substream);
@@ -317,7 +317,7 @@ int snd_sb8_playback_close(struct snd_pcm_substream *substream);
 int snd_sb8_capture_close(struct snd_pcm_substream *substream);
 /* midi8.c */
 irqreturn_t snd_sb8dsp_midi_interrupt(struct snd_sb *chip);
-int snd_sb8dsp_midi(struct snd_sb *chip, int device, struct snd_rawmidi ** rrawmidi);
+int snd_sb8dsp_midi(struct snd_sb *chip, int device);
 
 /* sb16_init.c */
 int snd_sb16dsp_pcm(struct snd_sb *chip, int device, struct snd_pcm ** rpcm);
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 90d2eba..6b4884d 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -297,7 +297,7 @@ static int snd_jazz16_probe(struct device *devptr, unsigned int dev)
 		"Media Vision Jazz16 at 0x%lx, irq %d, dma8 %d, dma16 %d",
 		port[dev], xirq, xdma8, xdma16);
 
-	err = snd_sb8dsp_pcm(chip, 0, NULL);
+	err = snd_sb8dsp_pcm(chip, 0);
 	if (err < 0)
 		goto err_free;
 	err = snd_sbmixer_new(chip);
diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index 6c32b3a..b8e2391 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -157,7 +157,7 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 		goto _err;
 	}
 
-	if ((err = snd_sb8dsp_pcm(chip, 0, NULL)) < 0)
+	if ((err = snd_sb8dsp_pcm(chip, 0)) < 0)
 		goto _err;
 
 	if ((err = snd_sbmixer_new(chip)) < 0)
@@ -182,7 +182,7 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 			goto _err;
 	}
 
-	if ((err = snd_sb8dsp_midi(chip, 0, NULL)) < 0)
+	if ((err = snd_sb8dsp_midi(chip, 0)) < 0)
 		goto _err;
 
 	strcpy(card->driver, chip->hardware == SB_HW_PRO ? "SB Pro" : "SB8");
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 24d4121..d4d8b0e 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -594,15 +594,13 @@ static struct snd_pcm_ops snd_sb8_capture_ops = {
 	.pointer =		snd_sb8_capture_pointer,
 };
 
-int snd_sb8dsp_pcm(struct snd_sb *chip, int device, struct snd_pcm ** rpcm)
+int snd_sb8dsp_pcm(struct snd_sb *chip, int device)
 {
 	struct snd_card *card = chip->card;
 	struct snd_pcm *pcm;
 	int err;
 	size_t max_prealloc = 64 * 1024;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(card, "SB8 DSP", device, 1, 1, &pcm)) < 0)
 		return err;
 	sprintf(pcm->name, "DSP v%i.%i", chip->version >> 8, chip->version & 0xff);
@@ -618,8 +616,6 @@ int snd_sb8dsp_pcm(struct snd_sb *chip, int device, struct snd_pcm ** rpcm)
 					      snd_dma_isa_data(),
 					      64*1024, max_prealloc);
 
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
diff --git a/sound/isa/sb/sb8_midi.c b/sound/isa/sb/sb8_midi.c
index 988a8b7..ffc71f0 100644
--- a/sound/isa/sb/sb8_midi.c
+++ b/sound/isa/sb/sb8_midi.c
@@ -263,13 +263,11 @@ static struct snd_rawmidi_ops snd_sb8dsp_midi_input =
 	.trigger =	snd_sb8dsp_midi_input_trigger,
 };
 
-int snd_sb8dsp_midi(struct snd_sb *chip, int device, struct snd_rawmidi ** rrawmidi)
+int snd_sb8dsp_midi(struct snd_sb *chip, int device)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
 
-	if (rrawmidi)
-		*rrawmidi = NULL;
 	if ((err = snd_rawmidi_new(chip->card, "SB8 MIDI", device, 1, 1, &rmidi)) < 0)
 		return err;
 	strcpy(rmidi->name, "SB8 MIDI");
@@ -280,7 +278,5 @@ int snd_sb8dsp_midi(struct snd_sb *chip, int device, struct snd_rawmidi ** rrawm
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
 	rmidi->private_data = chip;
 	chip->rmidi = rmidi;
-	if (rrawmidi)
-		*rrawmidi = rmidi;
 	return 0;
 }
-- 
1.8.0
