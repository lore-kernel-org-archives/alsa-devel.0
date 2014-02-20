From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Enable front audio jacks on one HP desktop model
Date: Thu, 20 Feb 2014 11:47:21 +0800
Message-ID: <1392868041-21319-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: david.henningsson@canonical.com, stable@vger.kernel.org, hui.wang@canonical.com, gerald.yang@canonical.com
List-Id: alsa-devel@alsa-project.org

The front headphone and mic jackes on a HP desktop model (Vendor Id:
0x111d76c7 Subsystem Id: 0x103c2b17) can not work, the codec on this
machine has 8 physical ports, 6 of them are routed to rear jackes
and all of them work very well, while the remaining 2 ports are
routed to front headphone and mic jackes, but the corresponding
pin complex node are not defined correctly.

After apply this fix, the front audio jackes can work very well.

BugLink: https://bugs.launchpad.net/bugs/1282369
Cc: David Henningsson <david.henningsson@canonical.com>
Tested-by: Gerald Yang <gerald.yang@canonical.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 7311bad..d75f90a 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -83,7 +83,8 @@ enum {
 	STAC_DELL_M6_BOTH,
 	STAC_DELL_EQ,
 	STAC_ALIENWARE_M17X,
-	STAC_92HD73XX_MODELS
+	STAC_92HD73XX_MODELS,
+	STAC_92HD89XX_HP_FRONT_JACK
 };
 
 enum {
@@ -1795,6 +1796,12 @@ static const struct hda_pintbl intel_dg45id_pin_configs[] = {
 	{}
 };
 
+static const struct hda_pintbl stac92hd89xx_hp_front_jack_pin_configs[] = {
+	{ 0x0a, 0x02214030 },
+	{ 0x0b, 0x02A19010 },
+	{}
+};
+
 static void stac92hd73xx_fixup_ref(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
@@ -1913,6 +1920,10 @@ static const struct hda_fixup stac92hd73xx_fixups[] = {
 	[STAC_92HD73XX_NO_JD] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = stac92hd73xx_fixup_no_jd,
+	},
+	[STAC_92HD89XX_HP_FRONT_JACK] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac92hd89xx_hp_front_jack_pin_configs,
 	}
 };
 
@@ -1973,6 +1984,8 @@ static const struct snd_pci_quirk stac92hd73xx_fixup_tbl[] = {
 		      "Alienware M17x", STAC_ALIENWARE_M17X),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0490,
 		      "Alienware M17x R3", STAC_DELL_EQ),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x2b17,
+				"unknown HP", STAC_92HD89XX_HP_FRONT_JACK),
 	{} /* terminator */
 };
 
-- 
1.8.1.2
