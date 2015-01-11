From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] ALSA: lola: lola_mixer: Remove some unused
	functions
Date: Sun, 11 Jan 2015 15:24:02 +0100
Message-ID: <1420986242-18502-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 963D42604ED
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 15:20:56 +0100 (CET)
Received: by mail-wi0-f173.google.com with SMTP id r20so10069064wiv.0
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 06:20:56 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: alsa-devel@alsa-project.org

Removes some functions that are not used anywhere:
lola_restore_mixer() lola_save_mixer()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/pci/lola/lola.h       |    2 --
 sound/pci/lola/lola_mixer.c |   43 -------------------------------------------
 2 files changed, 45 deletions(-)

diff --git a/sound/pci/lola/lola.h b/sound/pci/lola/lola.h
index f0b1000..9125916 100644
--- a/sound/pci/lola/lola.h
+++ b/sound/pci/lola/lola.h
@@ -513,8 +513,6 @@ int lola_init_mixer_widget(struct lola *chip, int nid);
 void lola_free_mixer(struct lola *chip);
 int lola_create_mixer(struct lola *chip);
 int lola_setup_all_analog_gains(struct lola *chip, int dir, bool mute);
-void lola_save_mixer(struct lola *chip);
-void lola_restore_mixer(struct lola *chip);
 int lola_set_src_config(struct lola *chip, unsigned int src_mask, bool update);
 
 /* proc */
diff --git a/sound/pci/lola/lola_mixer.c b/sound/pci/lola/lola_mixer.c
index 782f4d8..47ac93a 100644
--- a/sound/pci/lola/lola_mixer.c
+++ b/sound/pci/lola/lola_mixer.c
@@ -348,49 +348,6 @@ int lola_setup_all_analog_gains(struct lola *chip, int dir, bool mute)
 	return lola_codec_flush(chip);
 }
 
-void lola_save_mixer(struct lola *chip)
-{
-	/* mute analog output */
-	if (chip->mixer.array_saved) {
-		/* store contents of mixer array */
-		memcpy_fromio(chip->mixer.array_saved, chip->mixer.array,
-			      sizeof(*chip->mixer.array));
-	}
-	lola_setup_all_analog_gains(chip, PLAY, true); /* output mute */
-}
-
-void lola_restore_mixer(struct lola *chip)
-{
-	int i;
-
-	/*lola_reset_setups(chip);*/
-	if (chip->mixer.array_saved) {
-		/* restore contents of mixer array */
-		memcpy_toio(chip->mixer.array, chip->mixer.array_saved,
-			    sizeof(*chip->mixer.array));
-		/* inform micro-controller about all restored values
-		 * and ignore return values
-		 */
-		for (i = 0; i < chip->mixer.src_phys_ins; i++)
-			lola_codec_write(chip, chip->mixer.nid,
-					 LOLA_VERB_SET_SOURCE_GAIN,
-					 i, 0);
-		for (i = 0; i < chip->mixer.src_stream_outs; i++)
-			lola_codec_write(chip, chip->mixer.nid,
-					 LOLA_VERB_SET_SOURCE_GAIN,
-					 chip->mixer.src_stream_out_ofs + i, 0);
-		for (i = 0; i < chip->mixer.dest_stream_ins; i++)
-			lola_codec_write(chip, chip->mixer.nid,
-					 LOLA_VERB_SET_DESTINATION_GAIN,
-					 i, 0);
-		for (i = 0; i < chip->mixer.dest_phys_outs; i++)
-			lola_codec_write(chip, chip->mixer.nid,
-					 LOLA_VERB_SET_DESTINATION_GAIN,
-					 chip->mixer.dest_phys_out_ofs + i, 0);
-		lola_codec_flush(chip);
-	}
-}
-
 /*
  */
 
-- 
1.7.10.4
