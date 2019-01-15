From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/14] ALSA: pci: Remove superfluous
	snd_pcm_suspend*() calls
Date: Tue, 15 Jan 2019 17:21:46 +0100
Message-ID: <20190115162155.6308-6-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AB0B267440
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:58 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The call of snd_pcm_suspend_all() & co became superfluous since we
call it in the PCM PM ops.  Let's remove them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ali5451/ali5451.c            | 4 +---
 sound/pci/als300.c                     | 1 -
 sound/pci/als4000.c                    | 1 -
 sound/pci/atiixp_modem.c               | 2 --
 sound/pci/azt3328.c                    | 4 ----
 sound/pci/ca0106/ca0106_main.c         | 3 ---
 sound/pci/cmipci.c                     | 4 ----
 sound/pci/cs4281.c                     | 2 --
 sound/pci/cs46xx/cs46xx_lib.c          | 6 ------
 sound/pci/cs5535audio/cs5535audio_pm.c | 1 -
 sound/pci/ctxfi/ctatc.c                | 8 --------
 sound/pci/echoaudio/echoaudio.c        | 3 ---
 sound/pci/emu10k1/emu10k1.c            | 6 ------
 sound/pci/ens1370.c                    | 3 ---
 sound/pci/es1938.c                     | 1 -
 sound/pci/es1968.c                     | 1 -
 sound/pci/fm801.c                      | 1 -
 sound/pci/hda/hda_codec.c              | 2 --
 sound/pci/ice1712/ice1712.c            | 3 ---
 sound/pci/ice1712/ice1724.c            | 3 ---
 sound/pci/intel8x0.c                   | 2 --
 sound/pci/intel8x0m.c                  | 3 ---
 sound/pci/maestro3.c                   | 1 -
 sound/pci/nm256/nm256.c                | 1 -
 sound/pci/oxygen/oxygen_lib.c          | 5 +----
 sound/pci/riptide/riptide.c            | 1 -
 sound/pci/rme96.c                      | 2 --
 sound/pci/sis7019.c                    | 1 -
 sound/pci/trident/trident_main.c       | 4 ----
 sound/pci/via82xx.c                    | 2 --
 sound/pci/via82xx_modem.c              | 2 --
 sound/pci/ymfpci/ymfpci_main.c         | 4 ----
 32 files changed, 2 insertions(+), 85 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 9f569379b77e..e781ccca1793 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1882,10 +1882,8 @@ static int ali_suspend(struct device *dev)
 		return 0;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	for (i = 0; i < chip->num_of_codecs; i++) {
-		snd_pcm_suspend_all(chip->pcm[i]);
+	for (i = 0; i < chip->num_of_codecs; i++)
 		snd_ac97_suspend(chip->ac97[i]);
-	}
 
 	spin_lock_irq(&chip->reg_lock);
 	
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index eaa2d853d922..516b3d9cbfdf 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -731,7 +731,6 @@ static int snd_als300_suspend(struct device *dev)
 	struct snd_als300 *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 	return 0;
 }
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 26b097edec8c..45fa38382e79 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -994,7 +994,6 @@ static int snd_als4000_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	
-	snd_pcm_suspend_all(chip->pcm);
 	snd_sbmixer_suspend(chip);
 	return 0;
 }
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index dc1de860cedf..a357a8e2e73d 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1125,8 +1125,6 @@ static int snd_atiixp_suspend(struct device *dev)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	for (i = 0; i < NUM_ATI_PCMDEVS; i++)
-		snd_pcm_suspend_all(chip->pcmdevs[i]);
 	for (i = 0; i < NUM_ATI_CODECS; i++)
 		snd_ac97_suspend(chip->ac97[i]);
 	snd_atiixp_aclink_down(chip);
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index fc18c29a8173..90348817f096 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2699,10 +2699,6 @@ snd_azf3328_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
-	/* same pcm object for playback/capture */
-	snd_pcm_suspend_all(chip->pcm[AZF_CODEC_PLAYBACK]);
-	snd_pcm_suspend_all(chip->pcm[AZF_CODEC_I2S_OUT]);
-
 	snd_azf3328_suspend_ac97(chip);
 
 	snd_azf3328_suspend_regs(chip, chip->ctrl_io,
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index cd27b5536654..3d1b0bbff33b 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1910,11 +1910,8 @@ static int snd_ca0106_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_ca0106 *chip = card->private_data;
-	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	for (i = 0; i < 4; i++)
-		snd_pcm_suspend_all(chip->pcm[i]);
 	if (chip->details->ac97)
 		snd_ac97_suspend(chip->ac97);
 	snd_ca0106_mixer_suspend(chip);
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 452cc79b44af..5bbf31c1695c 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3351,10 +3351,6 @@ static int snd_cmipci_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	
-	snd_pcm_suspend_all(cm->pcm);
-	snd_pcm_suspend_all(cm->pcm2);
-	snd_pcm_suspend_all(cm->pcm_spdif);
-
 	/* save registers */
 	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
 		cm->saved_regs[i] = snd_cmipci_read(cm, saved_regs[i]);
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index ec4247638fa1..a9fb819cad1d 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -2002,8 +2002,6 @@ static int cs4281_suspend(struct device *dev)
 	unsigned int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
-
 	snd_ac97_suspend(chip->ac97);
 	snd_ac97_suspend(chip->ac97_secondary);
 
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 750eec437a79..a77d4cc44028 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -3781,12 +3781,6 @@ static int snd_cs46xx_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	chip->in_suspend = 1;
-	snd_pcm_suspend_all(chip->pcm);
-#ifdef CONFIG_SND_CS46XX_NEW_DSP
-	snd_pcm_suspend_all(chip->pcm_rear);
-	snd_pcm_suspend_all(chip->pcm_center_lfe);
-	snd_pcm_suspend_all(chip->pcm_iec958);
-#endif
 	// chip->ac97_powerdown = snd_cs46xx_codec_read(chip, AC97_POWER_CONTROL);
 	// chip->ac97_general_purpose = snd_cs46xx_codec_read(chip, BA0_AC97_GENERAL_PURPOSE);
 
diff --git a/sound/pci/cs5535audio/cs5535audio_pm.c b/sound/pci/cs5535audio/cs5535audio_pm.c
index 82bd10b68a77..446ef1f1b45a 100644
--- a/sound/pci/cs5535audio/cs5535audio_pm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pm.c
@@ -62,7 +62,6 @@ static int __maybe_unused snd_cs5535audio_suspend(struct device *dev)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(cs5535au->pcm);
 	snd_ac97_suspend(cs5535au->ac97);
 	for (i = 0; i < NUM_CS5535AUDIO_DMAS; i++) {
 		struct cs5535audio_dma *dma = &cs5535au->dmas[i];
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index 2ada8444abd9..e622613ea947 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -1548,18 +1548,10 @@ static void atc_connect_resources(struct ct_atc *atc)
 #ifdef CONFIG_PM_SLEEP
 static int atc_suspend(struct ct_atc *atc)
 {
-	int i;
 	struct hw *hw = atc->hw;
 
 	snd_power_change_state(atc->card, SNDRV_CTL_POWER_D3hot);
 
-	for (i = FRONT; i < NUM_PCMS; i++) {
-		if (!atc->pcms[i])
-			continue;
-
-		snd_pcm_suspend_all(atc->pcms[i]);
-	}
-
 	atc_release_resources(atc);
 
 	hw->suspend(hw);
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 907cf1a46712..18d30d479b6b 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2165,9 +2165,6 @@ static int snd_echo_suspend(struct device *dev)
 {
 	struct echoaudio *chip = dev_get_drvdata(dev);
 
-	snd_pcm_suspend_all(chip->analog_pcm);
-	snd_pcm_suspend_all(chip->digital_pcm);
-
 #ifdef ECHOCARD_HAS_MIDI
 	/* This call can sleep */
 	if (chip->midi_out)
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index d3203df50a1a..3c41a0edcfb0 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -224,12 +224,6 @@ static int snd_emu10k1_suspend(struct device *dev)
 
 	cancel_delayed_work_sync(&emu->emu1010.firmware_work);
 
-	snd_pcm_suspend_all(emu->pcm);
-	snd_pcm_suspend_all(emu->pcm_mic);
-	snd_pcm_suspend_all(emu->pcm_efx);
-	snd_pcm_suspend_all(emu->pcm_multi);
-	snd_pcm_suspend_all(emu->pcm_p16v);
-
 	snd_ac97_suspend(emu->ac97);
 
 	snd_emu10k1_efx_suspend(emu);
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 727eb3da1fda..1f2960ecc57e 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2037,9 +2037,6 @@ static int snd_ensoniq_suspend(struct device *dev)
 	
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
-	snd_pcm_suspend_all(ensoniq->pcm1);
-	snd_pcm_suspend_all(ensoniq->pcm2);
-	
 #ifdef CHIP1371	
 	snd_ac97_suspend(ensoniq->u.es1371.ac97);
 #else
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 9d248eb2e26c..84d07bce581c 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1475,7 +1475,6 @@ static int es1938_suspend(struct device *dev)
 	unsigned char *s, *d;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 
 	/* save mixer-related registers */
 	for (s = saved_regs, d = chip->saved_regs; *s; s++, d++)
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 0b1845ca6005..9dcb698fc8c7 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2392,7 +2392,6 @@ static int es1968_suspend(struct device *dev)
 	chip->in_suspend = 1;
 	cancel_work_sync(&chip->hwvol_work);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 	snd_es1968_bob_stop(chip);
 	return 0;
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index e3fb9c61017c..1317f3183eb1 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1408,7 +1408,6 @@ static int snd_fm801_suspend(struct device *dev)
 	if (chip->tea575x_tuner & TUNER_ONLY) {
 		/* FIXME: tea575x suspend */
 	} else {
-		snd_pcm_suspend_all(chip->pcm);
 		snd_ac97_suspend(chip->ac97);
 		snd_ac97_suspend(chip->ac97_sec);
 	}
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9f8d59e7e89f..ff6dbed4d3cd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2927,8 +2927,6 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	unsigned int state;
 
 	cancel_delayed_work_sync(&codec->jackpoll_work);
-	list_for_each_entry(pcm, &codec->pcm_list_head, list)
-		snd_pcm_suspend_all(pcm->pcm);
 	state = hda_call_codec_suspend(codec);
 	if (codec->link_down_at_suspend ||
 	    (codec_has_clkstop(codec) && codec_has_epss(codec) &&
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index f1fe497c2f9d..dda9b26192cb 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2792,9 +2792,6 @@ static int snd_ice1712_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
-	snd_pcm_suspend_all(ice->pcm);
-	snd_pcm_suspend_all(ice->pcm_pro);
-	snd_pcm_suspend_all(ice->pcm_ds);
 	snd_ac97_suspend(ice->ac97);
 
 	spin_lock_irq(&ice->reg_lock);
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 057c2f394ea7..42994cf36156 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2804,9 +2804,6 @@ static int snd_vt1724_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
-	snd_pcm_suspend_all(ice->pcm);
-	snd_pcm_suspend_all(ice->pcm_pro);
-	snd_pcm_suspend_all(ice->pcm_ds);
 	snd_ac97_suspend(ice->ac97);
 
 	spin_lock_irq(&ice->reg_lock);
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index ffddcdfe0c66..885e1d488ed6 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2614,8 +2614,6 @@ static int intel8x0_suspend(struct device *dev)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	for (i = 0; i < chip->pcm_devs; i++)
-		snd_pcm_suspend_all(chip->pcm[i]);
 	for (i = 0; i < chip->ncodecs; i++)
 		snd_ac97_suspend(chip->ac97[i]);
 	if (chip->device_type == DEVICE_INTEL_ICH4)
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index c84629190cba..44eb9e28a1eb 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1025,11 +1025,8 @@ static int intel8x0m_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct intel8x0m *chip = card->private_data;
-	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	for (i = 0; i < chip->pcm_devs; i++)
-		snd_pcm_suspend_all(chip->pcm[i]);
 	snd_ac97_suspend(chip->ac97);
 	if (chip->irq >= 0) {
 		free_irq(chip->irq, chip);
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 62962178a9d7..1a9468c14aaf 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2422,7 +2422,6 @@ static int m3_suspend(struct device *dev)
 	chip->in_suspend = 1;
 	cancel_work_sync(&chip->hwvol_work);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 
 	msleep(10); /* give the assp a chance to idle.. */
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index b97f4ea6b56c..85e46ff44ac3 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1413,7 +1413,6 @@ static int nm256_suspend(struct device *dev)
 	struct nm256 *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 	chip->coeffs_current = 0;
 	return 0;
diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index b4ef5804212d..6dce56c209aa 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -744,13 +744,10 @@ static int oxygen_pci_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct oxygen *chip = card->private_data;
-	unsigned int i, saved_interrupt_mask;
+	unsigned int saved_interrupt_mask;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
-	for (i = 0; i < PCM_COUNT; ++i)
-		snd_pcm_suspend(chip->streams[i]);
-
 	if (chip->model.suspend)
 		chip->model.suspend(chip);
 
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 23017e3bc76c..1d431c8052d6 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1158,7 +1158,6 @@ static int riptide_suspend(struct device *dev)
 
 	chip->in_suspend = 1;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 	return 0;
 }
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index dcfa4d7a73e2..c56702e6cb60 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -2388,8 +2388,6 @@ static int rme96_suspend(struct device *dev)
 	struct rme96 *rme96 = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend(rme96->playback_substream);
-	snd_pcm_suspend(rme96->capture_substream);
 
 	/* save capture & playback pointers */
 	rme96->playback_pointer = readl(rme96->iobase + RME96_IO_GET_PLAY_POS)
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 964acf302479..6b27980d77a8 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1214,7 +1214,6 @@ static int sis_suspend(struct device *dev)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(sis->pcm);
 	if (sis->codecs_present & SIS_PRIMARY_CODEC_PRESENT)
 		snd_ac97_suspend(sis->ac97[0]);
 	if (sis->codecs_present & SIS_SECONDARY_CODEC_PRESENT)
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 5523e193d556..f271ea436cff 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3915,10 +3915,6 @@ static int snd_trident_suspend(struct device *dev)
 
 	trident->in_suspend = 1;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(trident->pcm);
-	snd_pcm_suspend_all(trident->foldback);
-	snd_pcm_suspend_all(trident->spdif);
-
 	snd_ac97_suspend(trident->ac97);
 	snd_ac97_suspend(trident->ac97_sec);
 	return 0;
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index c488c5afa195..736ac79901b3 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -2278,8 +2278,6 @@ static int snd_via82xx_suspend(struct device *dev)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	for (i = 0; i < 2; i++)
-		snd_pcm_suspend_all(chip->pcms[i]);
 	for (i = 0; i < chip->num_devs; i++)
 		snd_via82xx_channel_reset(chip, &chip->devs[i]);
 	synchronize_irq(chip->irq);
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index b13c8688cc8d..3f59e0279058 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -1038,8 +1038,6 @@ static int snd_via82xx_suspend(struct device *dev)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	for (i = 0; i < 2; i++)
-		snd_pcm_suspend_all(chip->pcms[i]);
 	for (i = 0; i < chip->num_devs; i++)
 		snd_via82xx_channel_reset(chip, &chip->devs[i]);
 	synchronize_irq(chip->irq);
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index a4926fb03991..c688b7f481da 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -2304,10 +2304,6 @@ static int snd_ymfpci_suspend(struct device *dev)
 	unsigned int i;
 	
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
-	snd_pcm_suspend_all(chip->pcm2);
-	snd_pcm_suspend_all(chip->pcm_spdif);
-	snd_pcm_suspend_all(chip->pcm_4ch);
 	snd_ac97_suspend(chip->ac97);
 	for (i = 0; i < YDSXGR_NUM_SAVED_REGS; i++)
 		chip->saved_regs[i] = snd_ymfpci_readl(chip, saved_regs_index[i]);
-- 
2.20.1
