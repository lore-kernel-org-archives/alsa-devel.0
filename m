From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/21] ASoC: sb16: Simplify snd_sb16dsp_pcm()
Date: Fri,  2 Jan 2015 12:24:42 +0100
Message-ID: <1420197895-17696-9-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id C809C2604E0
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:07 +0100 (CET)
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

All callers of snd_sb16dsp_pcm() always pass the pcm field of the first
parameter as the last parameter. Simplify the function by moving this inside
the function itself. This makes the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/sb.h       | 2 +-
 sound/isa/als100.c       | 2 +-
 sound/isa/sb/sb16.c      | 2 +-
 sound/isa/sb/sb16_main.c | 8 ++------
 sound/pci/cs5530.c       | 2 +-
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/sound/sb.h b/include/sound/sb.h
index 13438ff..33e2d11 100644
--- a/include/sound/sb.h
+++ b/include/sound/sb.h
@@ -320,7 +320,7 @@ irqreturn_t snd_sb8dsp_midi_interrupt(struct snd_sb *chip);
 int snd_sb8dsp_midi(struct snd_sb *chip, int device);
 
 /* sb16_init.c */
-int snd_sb16dsp_pcm(struct snd_sb *chip, int device, struct snd_pcm ** rpcm);
+int snd_sb16dsp_pcm(struct snd_sb *chip, int device);
 const struct snd_pcm_ops *snd_sb16dsp_get_pcm_ops(int direction);
 int snd_sb16dsp_configure(struct snd_sb *chip);
 /* sb16.c */
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index 32d0152..bc9ea30 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -233,7 +233,7 @@ static int snd_card_als100_probe(int dev,
 			irq[dev], dma8[dev], dma16[dev]);
 	}
 
-	if ((error = snd_sb16dsp_pcm(chip, 0, &chip->pcm)) < 0) {
+	if ((error = snd_sb16dsp_pcm(chip, 0)) < 0) {
 		snd_card_free(card);
 		return error;
 	}
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index 3f69454..4a7d7c8 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -374,7 +374,7 @@ static int snd_sb16_probe(struct snd_card *card, int dev)
 	if (! is_isapnp_selected(dev) && (err = snd_sb16dsp_configure(chip)) < 0)
 		return err;
 
-	if ((err = snd_sb16dsp_pcm(chip, 0, &chip->pcm)) < 0)
+	if ((err = snd_sb16dsp_pcm(chip, 0)) < 0)
 		return err;
 
 	strcpy(card->driver,
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 72b10f4..63d11b7 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -860,19 +860,18 @@ static struct snd_pcm_ops snd_sb16_capture_ops = {
 	.pointer =	snd_sb16_capture_pointer,
 };
 
-int snd_sb16dsp_pcm(struct snd_sb * chip, int device, struct snd_pcm ** rpcm)
+int snd_sb16dsp_pcm(struct snd_sb *chip, int device)
 {
 	struct snd_card *card = chip->card;
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(card, "SB16 DSP", device, 1, 1, &pcm)) < 0)
 		return err;
 	sprintf(pcm->name, "DSP v%i.%i", chip->version >> 8, chip->version & 0xff);
 	pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX;
 	pcm->private_data = chip;
+	chip->pcm = pcm;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_sb16_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_sb16_capture_ops);
@@ -885,9 +884,6 @@ int snd_sb16dsp_pcm(struct snd_sb * chip, int device, struct snd_pcm ** rpcm)
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_isa_data(),
 					      64*1024, 128*1024);
-
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index b102550..0a8cf94 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -223,7 +223,7 @@ static int snd_cs5530_create(struct snd_card *card,
 		return err;
 	}
 
-	err = snd_sb16dsp_pcm(chip->sb, 0, &chip->sb->pcm);
+	err = snd_sb16dsp_pcm(chip->sb, 0);
 	if (err < 0) {
 		dev_err(card->dev, "Could not create PCM\n");
 		snd_cs5530_free(chip);
-- 
1.8.0
