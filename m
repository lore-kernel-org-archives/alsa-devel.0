From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Drop bus->avoid_link_reset flag
Date: Tue, 26 Nov 2013 12:01:22 +0100
Message-ID: <1385463682-16558-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A34E726509E
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 12:01:22 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 80F30A7B44
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 12:01:22 +0100 (CET)
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

Use bus->power_keep_link_on instead.  The controller shouldn't go to
D3 when the link isn't reset, so essentially avoiding the link reset
means avoiding the runtime PM.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h      | 1 -
 sound/pci/hda/hda_intel.c      | 3 +--
 sound/pci/hda/patch_sigmatel.c | 3 ++-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 77db69480c19..7aa9870040c1 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -698,7 +698,6 @@ struct hda_bus {
 	unsigned int in_reset:1;	/* during reset operation */
 	unsigned int power_keep_link_on:1; /* don't power off HDA link */
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
-	unsigned int avoid_link_reset:1; /* don't reset link at runtime PM */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
 };
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7a09404579a7..c6d230193da6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2994,8 +2994,7 @@ static int azx_runtime_suspend(struct device *dev)
 		  STATESTS_INT_MASK);
 
 	azx_stop_chip(chip);
-	if (!chip->bus->avoid_link_reset)
-		azx_enter_link_reset(chip);
+	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
 		hda_display_power(false);
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d2cc0041d9d3..088a5afbd1b9 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2094,7 +2094,8 @@ static void stac92hd83xxx_fixup_hp_mic_led(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->mic_mute_led_gpio = 0x08; /* GPIO3 */
-		codec->bus->avoid_link_reset = 1;
+		/* resetting controller clears GPIO, so we need to keep on */
+		codec->bus->power_keep_link_on = 1;
 	}
 }
 
-- 
1.8.4.3
