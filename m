From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: hda - Drop AZX_DCAPS_POSFIX_VIA bit
Date: Thu, 17 Dec 2015 08:35:45 +0100
Message-ID: <1450337746-4580-4-git-send-email-tiwai@suse.de>
References: <1450337746-4580-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C371E2654B7
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 08:35:46 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 88F2BACA7
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 07:35:44 +0000 (UTC)
In-Reply-To: <1450337746-4580-1-git-send-email-tiwai@suse.de>
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

AZX_DCAPS_POSFIX_VIA is coupled always with AZX_DRIVER_VIA type, so we
don't have to keep this bit in dcaps.  Save one more!

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.h | 2 +-
 sound/pci/hda/hda_intel.c      | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 65401372a7c8..a288ac1b5451 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -36,7 +36,7 @@
 /* 14 unused */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
-#define AZX_DCAPS_POSFIX_VIA	(1 << 17)	/* Use VIACOMBO as default */
+/* 17 unused */
 #define AZX_DCAPS_NO_64BIT	(1 << 18)	/* No 64bit address */
 #define AZX_DCAPS_SYNC_WRITE	(1 << 19)	/* sync each cmd write */
 #define AZX_DCAPS_OLD_SSYNC	(1 << 20)	/* Old SSYNC reg for ICH */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bcb526103ecb..67e672a77576 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1325,7 +1325,7 @@ static int check_position_fix(struct azx *chip, int fix)
 	}
 
 	/* Check VIA/ATI HD Audio Controller exist */
-	if (chip->driver_caps & AZX_DCAPS_POSFIX_VIA) {
+	if (chip->driver_type == AZX_DRIVER_VIA) {
 		dev_dbg(chip->card->dev, "Using VIACOMBO position fix\n");
 		return POS_FIX_VIACOMBO;
 	}
@@ -2284,8 +2284,7 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1002, 0xaae8),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	/* VIA VT8251/VT8237A */
-	{ PCI_DEVICE(0x1106, 0x3288),
-	  .driver_data = AZX_DRIVER_VIA | AZX_DCAPS_POSFIX_VIA },
+	{ PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
 	/* VIA GFX VT7122/VX900 */
 	{ PCI_DEVICE(0x1106, 0x9170), .driver_data = AZX_DRIVER_GENERIC },
 	/* VIA GFX VT6122/VX11 */
-- 
2.6.4
