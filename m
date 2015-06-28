From: Laurence Darby <ldarby@tuffmail.com>
Subject: [PATCH] ALSA: oxygen: Fix S/PDIF muting
Date: Sun, 28 Jun 2015 13:13:37 +0100
Message-ID: <20150628131337.d8077aed73a9851b194bdc30@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout-07.mxes.net (mxout-07.mxes.net [216.86.168.182])
 by alsa0.perex.cz (Postfix) with ESMTP id F20A2264FDF
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 14:13:40 +0200 (CEST)
Received: from home (unknown [81.187.127.120])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by smtp.mxes.net (Postfix) with ESMTPSA id 6305522E200
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 08:13:38 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The S/PDIF output was muted whenever audio wasn't playing which resulted
in a clicking noise from the DAC when resuming (similar to the issue in
3bef1c377d1b (ALSA: hda - stop setup_dig_out_stream() causing clicks)).
Also, the mixer control wasn't actually controlling the S/PDIF output.

 - Fix the initial state of the mixer to match the initial muted state.
 - Mute the output at shutdown.
 - Delete the code that modifies OXYGEN_SPDIF_OUT_ENABLE, and modify it
   only in oxygen_update_spdif_source(), so only the mixer control
   controls it.

Signed-off-by: Laurence Darby <ldarby@tuffmail.com>
---
Patch is against master, tested on 4.0.

 sound/pci/oxygen/oxygen_lib.c   |  5 ++++-
 sound/pci/oxygen/oxygen_mixer.c |  9 +++++----
 sound/pci/oxygen/oxygen_pcm.c   | 15 +--------------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index b4ef580..2cca908 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -373,7 +373,7 @@ static void oxygen_init(struct oxygen *chip)
 	for (i = 0; i < 8; ++i)
 		chip->dac_volume[i] = chip->model.dac_volume_min;
 	chip->dac_mute = 1;
-	chip->spdif_playback_enable = 1;
+	chip->spdif_playback_enable = 0;
 	chip->spdif_bits = OXYGEN_SPDIF_C | OXYGEN_SPDIF_ORIGINAL |
 		(IEC958_AES1_CON_PCM_CODER << OXYGEN_SPDIF_CATEGORY_SHIFT);
 	chip->spdif_pcm_bits = chip->spdif_bits;
@@ -575,6 +575,9 @@ static void oxygen_shutdown(struct oxygen *chip)
 	spin_lock_irq(&chip->reg_lock);
 	chip->interrupt_mask = 0;
 	chip->pcm_running = 0;
+	chip->spdif_playback_enable = 0;
+	oxygen_clear_bits32(chip, OXYGEN_SPDIF_CONTROL,
+			    OXYGEN_SPDIF_OUT_ENABLE);
 	oxygen_write16(chip, OXYGEN_DMA_STATUS, 0);
 	oxygen_write16(chip, OXYGEN_INTERRUPT_MASK, 0);
 	spin_unlock_irq(&chip->reg_lock);
diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 6492bca..20a2781 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -252,7 +252,6 @@ void oxygen_update_spdif_source(struct oxygen *chip)
 	old_control = oxygen_read32(chip, OXYGEN_SPDIF_CONTROL);
 	old_routing = oxygen_read16(chip, OXYGEN_PLAY_ROUTING);
 	if (chip->pcm_active & (1 << PCM_SPDIF)) {
-		new_control = old_control | OXYGEN_SPDIF_OUT_ENABLE;
 		new_routing = (old_routing & ~OXYGEN_PLAY_SPDIF_MASK)
 			| OXYGEN_PLAY_SPDIF_SPDIF;
 		oxygen_rate = (old_control >> OXYGEN_SPDIF_OUT_RATE_SHIFT)
@@ -265,13 +264,15 @@ void oxygen_update_spdif_source(struct oxygen *chip)
 		oxygen_rate = oxygen_read16(chip, OXYGEN_I2S_MULTICH_FORMAT)
 			& OXYGEN_I2S_RATE_MASK;
 		new_control = (old_control & ~OXYGEN_SPDIF_OUT_RATE_MASK) |
-			(oxygen_rate << OXYGEN_SPDIF_OUT_RATE_SHIFT) |
-			OXYGEN_SPDIF_OUT_ENABLE;
+			(oxygen_rate << OXYGEN_SPDIF_OUT_RATE_SHIFT);
 	} else {
-		new_control = old_control & ~OXYGEN_SPDIF_OUT_ENABLE;
 		new_routing = old_routing;
 		oxygen_rate = OXYGEN_RATE_44100;
 	}
+	if (chip->spdif_playback_enable)
+		new_control = old_control | OXYGEN_SPDIF_OUT_ENABLE;
+	else
+		new_control = old_control & ~OXYGEN_SPDIF_OUT_ENABLE;
 	if (old_routing != new_routing) {
 		oxygen_write32(chip, OXYGEN_SPDIF_CONTROL,
 			       new_control & ~OXYGEN_SPDIF_OUT_ENABLE);
diff --git a/sound/pci/oxygen/oxygen_pcm.c b/sound/pci/oxygen/oxygen_pcm.c
index aa2ebd1..f4a4a48 100644
--- a/sound/pci/oxygen/oxygen_pcm.c
+++ b/sound/pci/oxygen/oxygen_pcm.c
@@ -477,8 +477,6 @@ static int oxygen_spdif_hw_params(struct snd_pcm_substream *substream,
 
 	mutex_lock(&chip->mutex);
 	spin_lock_irq(&chip->reg_lock);
-	oxygen_clear_bits32(chip, OXYGEN_SPDIF_CONTROL,
-			    OXYGEN_SPDIF_OUT_ENABLE);
 	oxygen_write8_masked(chip, OXYGEN_PLAY_FORMAT,
 			     oxygen_format(hw_params) << OXYGEN_SPDIF_FORMAT_SHIFT,
 			     OXYGEN_SPDIF_FORMAT_MASK);
@@ -544,17 +542,6 @@ static int oxygen_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static int oxygen_spdif_hw_free(struct snd_pcm_substream *substream)
-{
-	struct oxygen *chip = snd_pcm_substream_chip(substream);
-
-	spin_lock_irq(&chip->reg_lock);
-	oxygen_clear_bits32(chip, OXYGEN_SPDIF_CONTROL,
-			    OXYGEN_SPDIF_OUT_ENABLE);
-	spin_unlock_irq(&chip->reg_lock);
-	return oxygen_hw_free(substream);
-}
-
 static int oxygen_prepare(struct snd_pcm_substream *substream)
 {
 	struct oxygen *chip = snd_pcm_substream_chip(substream);
@@ -669,7 +656,7 @@ static struct snd_pcm_ops oxygen_spdif_ops = {
 	.close     = oxygen_close,
 	.ioctl     = snd_pcm_lib_ioctl,
 	.hw_params = oxygen_spdif_hw_params,
-	.hw_free   = oxygen_spdif_hw_free,
+	.hw_free   = oxygen_hw_free,
 	.prepare   = oxygen_prepare,
 	.trigger   = oxygen_trigger,
 	.pointer   = oxygen_pointer,
-- 
2.3.5
