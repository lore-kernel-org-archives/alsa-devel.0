From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/10] ALSA: hda - Power down codec
	automatically at registration
Date: Thu, 26 Feb 2015 18:00:22 +0100
Message-ID: <1424970025-8082-8-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D8C13262600
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7C545ADD3
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
In-Reply-To: <1424970025-8082-1-git-send-email-tiwai@suse.de>
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

So far, we let the controller driver power down the all codecs at the
end of probe.  But this can be done better in the codec's dev_register
callback.  This results in the reduction of duplicated codes in each
control driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |  5 +++--
 sound/pci/hda/hda_intel.c | 14 --------------
 sound/pci/hda/hda_tegra.c | 12 ------------
 3 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 33b8b71f8eaf..6580a367023e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1163,6 +1163,8 @@ static int snd_hda_codec_dev_register(struct snd_device *device)
 	snd_hda_register_beep_device(codec);
 	if (device_is_registered(hda_codec_dev(codec)))
 		pm_runtime_enable(hda_codec_dev(codec));
+	/* it was powered up in snd_hda_codec_new(), now all done */
+	snd_hda_power_down(codec);
 	return 0;
 }
 
@@ -1260,8 +1262,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 
 #ifdef CONFIG_PM
 	/* snd_hda_codec_new() marks the codec as power-up, and leave it as is.
-	 * the caller has to power down appropriatley after initialization
-	 * phase.
+	 * it's powered down later in snd_hda_codec_dev_register().
 	 */
 	set_bit(codec->addr, &bus->codec_powered);
 	pm_runtime_set_active(hda_codec_dev(codec));
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 738d332351d5..e75e8137e296 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1604,19 +1604,6 @@ static int azx_first_init(struct azx *chip)
 	return 0;
 }
 
-static void power_down_all_codecs(struct azx *chip)
-{
-#ifdef CONFIG_PM
-	/* The codecs were powered up in snd_hda_codec_new().
-	 * Now all initialization done, so turn them down if possible
-	 */
-	struct hda_codec *codec;
-	list_for_each_entry(codec, &chip->bus->codec_list, list) {
-		snd_hda_power_down(codec);
-	}
-#endif
-}
-
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 /* callback from request_firmware_nowait() */
 static void azx_firmware_cb(const struct firmware *fw, void *context)
@@ -1926,7 +1913,6 @@ static int azx_probe_continue(struct azx *chip)
 		goto out_free;
 
 	chip->running = 1;
-	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	azx_add_card_list(chip);
 	snd_hda_set_power_save(chip->bus, power_save * 1000);
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 42bc17655df0..1359fdd20f02 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -337,17 +337,6 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * The codecs were powered up in snd_hda_codec_new().
- * Now all initialization done, so turn them down if possible
- */
-static void power_down_all_codecs(struct azx *chip)
-{
-	struct hda_codec *codec;
-	list_for_each_entry(codec, &chip->bus->codec_list, list)
-		snd_hda_power_down(codec);
-}
-
 static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 {
 	struct snd_card *card = chip->card;
@@ -523,7 +512,6 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		goto out_free;
 
 	chip->running = 1;
-	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	snd_hda_set_power_save(chip->bus, power_save * 1000);
 
-- 
2.3.0
