From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix broken PM due to incomplete
	i915 initialization
Date: Tue, 15 Jul 2014 15:25:05 +0200
Message-ID: <1405430705-27859-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B2E9E2619F2
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 15:25:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7478FABA6
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 13:25:05 +0000 (UTC)
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

When the initialization of Intel HDMI controller fails due to missing
i915 kernel symbols (e.g. HD-audio is built in while i915 is module),
the driver discontinues the probe.  However, since the probe was done
asynchronously, the driver object still remains, thus the relevant PM
ops are still called at suspend/resume. This results in the bad access
to the incomplete audio card object, eventually leads to Oops or stall
at PM.

This patch adds the missing checks of chip->init_failed flag at each
PM callback in order to fix the problem above.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=79561
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d690c26a197c..83cd19017cf3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -596,7 +596,7 @@ static int azx_suspend(struct device *dev)
 	struct azx *chip = card->private_data;
 	struct azx_pcm *p;
 
-	if (chip->disabled)
+	if (chip->disabled || chip->init_failed)
 		return 0;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
@@ -628,7 +628,7 @@ static int azx_resume(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 
-	if (chip->disabled)
+	if (chip->disabled || chip->init_failed)
 		return 0;
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
@@ -665,7 +665,7 @@ static int azx_runtime_suspend(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 
-	if (chip->disabled)
+	if (chip->disabled || chip->init_failed)
 		return 0;
 
 	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
@@ -692,7 +692,7 @@ static int azx_runtime_resume(struct device *dev)
 	struct hda_codec *codec;
 	int status;
 
-	if (chip->disabled)
+	if (chip->disabled || chip->init_failed)
 		return 0;
 
 	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
@@ -729,7 +729,7 @@ static int azx_runtime_idle(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 
-	if (chip->disabled)
+	if (chip->disabled || chip->init_failed)
 		return 0;
 
 	if (!power_save_controller ||
-- 
2.0.1
