From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix mute LED on HP laptops in
	runtime suspend
Date: Thu, 24 Oct 2013 11:32:55 +0200
Message-ID: <1382607175-9031-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 494892608D8
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 11:30:01 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 28986A57B7
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 11:30:01 +0200 (CEST)
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

When HP laptops with mute and mic-record LEDs go to runtime suspend,
these LEDs are turned on forcibly no matter whether GPIO pis are on or
off.  This strange behavior seems triggered by resetting the HD-audio
bus link at azx_rutime_suspend().  So, just add a new hda_bus flag to
avoid the link reset at runtime suspend and set it for these HP
machines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h      | 1 +
 sound/pci/hda/hda_intel.c      | 3 ++-
 sound/pci/hda/patch_sigmatel.c | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 7aa9870..77db694 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -698,6 +698,7 @@ struct hda_bus {
 	unsigned int in_reset:1;	/* during reset operation */
 	unsigned int power_keep_link_on:1; /* don't power off HDA link */
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
+	unsigned int avoid_link_reset:1; /* don't reset link at runtime PM */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
 };
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 6e61a01..a0a06f7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2986,7 +2986,8 @@ static int azx_runtime_suspend(struct device *dev)
 		  STATESTS_INT_MASK);
 
 	azx_stop_chip(chip);
-	azx_enter_link_reset(chip);
+	if (!chip->bus->avoid_link_reset)
+		azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
 		hda_display_power(false);
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index fba0cef..69a549a 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2091,8 +2091,10 @@ static void stac92hd83xxx_fixup_hp_mic_led(struct hda_codec *codec,
 {
 	struct sigmatel_spec *spec = codec->spec;
 
-	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->mic_mute_led_gpio = 0x08; /* GPIO3 */
+		codec->bus->avoid_link_reset = 1;
+	}
 }
 
 static void stac92hd83xxx_fixup_headset_jack(struct hda_codec *codec,
-- 
1.8.4
