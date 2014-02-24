From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add a fixup for HP Folio 13 mute
	LED
Date: Mon, 24 Feb 2014 15:31:15 +0100
Message-ID: <1393252275-10976-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F0E2F265324
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 15:31:15 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7C368AC91
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 14:31:15 +0000 (UTC)
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

HP Folio 13 may have a broken BIOS that doesn't set up the mute LED
GPIO properly, and the driver guesses it wrongly, too.  Add a new
fixup entry for setting the GPIO pin statically for this laptop.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=70991
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index a2f11bf8155c..3bc29c9b2529 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -98,6 +98,7 @@ enum {
 	STAC_92HD83XXX_HP_LED,
 	STAC_92HD83XXX_HP_INV_LED,
 	STAC_92HD83XXX_HP_MIC_LED,
+	STAC_HP_LED_GPIO10,
 	STAC_92HD83XXX_HEADSET_JACK,
 	STAC_92HD83XXX_HP,
 	STAC_HP_ENVY_BASS,
@@ -2130,6 +2131,17 @@ static void stac92hd83xxx_fixup_hp_mic_led(struct hda_codec *codec,
 	}
 }
 
+static void stac92hd83xxx_fixup_hp_led_gpio10(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->gpio_led = 0x10; /* GPIO4 */
+		spec->default_polarity = 0;
+	}
+}
+
 static void stac92hd83xxx_fixup_headset_jack(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
@@ -2624,6 +2636,12 @@ static const struct hda_fixup stac92hd83xxx_fixups[] = {
 		.chained = true,
 		.chain_id = STAC_92HD83XXX_HP,
 	},
+	[STAC_HP_LED_GPIO10] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd83xxx_fixup_hp_led_gpio10,
+		.chained = true,
+		.chain_id = STAC_92HD83XXX_HP,
+	},
 	[STAC_92HD83XXX_HEADSET_JACK] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = stac92hd83xxx_fixup_headset_jack,
@@ -2702,6 +2720,8 @@ static const struct snd_pci_quirk stac92hd83xxx_fixup_tbl[] = {
 			  "HP", STAC_92HD83XXX_HP_cNB11_INTQUAD),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1888,
 			  "HP Envy Spectre", STAC_HP_ENVY_BASS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1899,
+			  "HP Folio 13", STAC_HP_LED_GPIO10),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x18df,
 			  "HP Folio", STAC_HP_BNB13_EQ),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x18F8,
-- 
1.9.0
