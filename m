From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: cs46xx: fix typo "seconadry" -> "secondary"
Date: Thu,  1 Sep 2016 11:15:44 +0100
Message-ID: <20160901101544.24833-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ondrej Zary <linux@rainbow-software.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to typos dev_dbg messages and comment.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/cs46xx/cs46xx_lib.c | 4 ++--
 sound/pci/cs46xx/dsp_spos.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 2706f27..528102cc 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2460,7 +2460,7 @@ static int cs46xx_detect_codec(struct snd_cs46xx *chip, int codec)
 		udelay(10);
 		if (snd_cs46xx_codec_read(chip, AC97_RESET, codec) & 0x8000) {
 			dev_dbg(chip->card->dev,
-				"seconadry codec not present\n");
+				"secondary codec not present\n");
 			return -ENXIO;
 		}
 	}
@@ -2503,7 +2503,7 @@ int snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device)
 	chip->nr_ac97_codecs = 1;
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	dev_dbg(chip->card->dev, "detecting seconadry codec\n");
+	dev_dbg(chip->card->dev, "detecting secondary codec\n");
 	/* try detect a secondary codec */
 	if (! cs46xx_detect_codec(chip, CS46XX_SECONDARY_CODEC_INDEX))
 		chip->nr_ac97_codecs = 2;
diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index d2951ed..4a0cbd2 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -1441,7 +1441,7 @@ int cs46xx_dsp_scb_and_task_init (struct snd_cs46xx *chip)
 	
 	if (chip->nr_ac97_codecs == 2) {
 		/* create CODEC tasklet for rear Center/LFE output 
-		   slot 6 and 9 on seconadry CODEC */
+		   slot 6 and 9 on secondary CODEC */
 		clfe_codec_out_scb = cs46xx_dsp_create_codec_out_scb(chip,"CodecOutSCB_CLFE",0x0030,0x0030,
 								     CLFE_MIXER_SCB_ADDR,
 								     CLFE_CODEC_SCB_ADDR,
-- 
2.9.3
