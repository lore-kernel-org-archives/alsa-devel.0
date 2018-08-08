From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 06/11] ALSA: hda/ca0132 - Add bool variable to enable/disable pci region2 mmio
Date: Wed,  8 Aug 2018 13:34:17 -0400
Message-ID: <1533749663-8200-7-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds the ability to choose whether or not to map the pci
region2, which is used for things such as GPIO on the Recon3D and Sound
Blaster Z.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2ee9549..b35b179 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -965,9 +965,11 @@ struct ca0132_spec {
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
 #endif
 	/*
-	 * Sound Blaster Z PCI region 2 iomem, used for input and output
-	 * switching, and other unknown commands.
+	 * The Recon3D, Sound Blaster Z, Sound Blaster ZxR, and Sound Blaster
+	 * AE-5 all use PCI region 2 to toggle GPIO and other currently unknown
+	 * things.
 	 */
+	bool use_pci_mmio;
 	void __iomem *mem_base;
 
 	/*
@@ -7563,16 +7565,6 @@ static int patch_ca0132(struct hda_codec *codec)
 	else
 		spec->quirk = QUIRK_NONE;
 
-	/* Setup BAR Region 2 for Sound Blaster Z */
-	if (spec->quirk == QUIRK_SBZ) {
-		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
-		if (spec->mem_base == NULL) {
-			codec_warn(codec, "pci_iomap failed!");
-			codec_info(codec, "perhaps this is not an SBZ?");
-			spec->quirk = QUIRK_NONE;
-		}
-	}
-
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 
@@ -7591,19 +7583,33 @@ static int patch_ca0132(struct hda_codec *codec)
 		break;
 	}
 
-	/* Setup whether or not to use alt functions/controls */
+	/* Setup whether or not to use alt functions/controls/pci_mmio */
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
+		spec->use_alt_controls = true;
+		spec->use_alt_functions = true;
+		spec->use_pci_mmio = true;
+		break;
 	case QUIRK_R3DI:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
+		spec->use_pci_mmio = false;
 		break;
 	default:
 		spec->use_alt_controls = false;
 		spec->use_alt_functions = false;
+		spec->use_pci_mmio = false;
 		break;
 	}
 
+	if (spec->use_pci_mmio) {
+		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
+		if (spec->mem_base == NULL) {
+			codec_warn(codec, "pci_iomap failed! Setting quirk to QUIRK_NONE.");
+			spec->quirk = QUIRK_NONE;
+		}
+	}
+
 	spec->base_init_verbs = ca0132_base_init_verbs;
 	spec->base_exit_verbs = ca0132_base_exit_verbs;
 
-- 
2.7.4
