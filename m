From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: hda - Drop azx_mixer_create()
Date: Fri, 20 Feb 2015 08:08:26 +0100
Message-ID: <1424416107-32470-6-git-send-email-tiwai@suse.de>
References: <1424416107-32470-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B6F2605E8
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 08:08:30 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 610C3ACEA
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 07:08:30 +0000 (UTC)
In-Reply-To: <1424416107-32470-1-git-send-email-tiwai@suse.de>
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

It's just an indirection, so let the caller directly calling
snd_hda_build_controls().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 7 -------
 sound/pci/hda/hda_controller.h | 1 -
 sound/pci/hda/hda_intel.c      | 2 +-
 sound/pci/hda/hda_tegra.c      | 2 +-
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 6b3254d479e1..6fab39133051 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1923,13 +1923,6 @@ int azx_codec_configure(struct azx *chip)
 }
 EXPORT_SYMBOL_GPL(azx_codec_configure);
 
-/* mixer creation - all stuff is implemented in hda module */
-int azx_mixer_create(struct azx *chip)
-{
-	return snd_hda_build_controls(chip->bus);
-}
-EXPORT_SYMBOL_GPL(azx_mixer_create);
-
 
 static bool is_input_stream(struct azx *chip, unsigned char index)
 {
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index bd50b49cdd0d..79808e1a79ac 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -436,7 +436,6 @@ int azx_codec_create(struct azx *chip, const char *model,
 		     unsigned int max_slots,
 		     int *power_save_to);
 int azx_codec_configure(struct azx *chip);
-int azx_mixer_create(struct azx *chip);
 int azx_init_stream(struct azx *chip);
 
 void azx_notifier_register(struct azx *chip);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ced44a75f8ea..b0a05691abe7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1923,7 +1923,7 @@ static int azx_probe_continue(struct azx *chip)
 		goto out_free;
 
 	/* create mixer controls */
-	err = azx_mixer_create(chip);
+	err = snd_hda_build_controls(chip->bus);
 	if (err < 0)
 		goto out_free;
 
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 7d0d04480f48..f305c2a99206 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -516,7 +516,7 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		goto out_free;
 
 	/* create mixer controls */
-	err = azx_mixer_create(chip);
+	err = snd_hda_build_controls(chip->bus);
 	if (err < 0)
 		goto out_free;
 
-- 
2.3.0
