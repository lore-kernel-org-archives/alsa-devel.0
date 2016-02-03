From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add fixup for Mac Mini 7,1 model
Date: Wed,  3 Feb 2016 12:35:53 +0100
Message-ID: <1454499353-25732-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A98B260502
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 12:35:55 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 43CB9AC20
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 11:35:55 +0000 (UTC)
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

Mac Mini 7,1 model with CS4208 codec reports the headphone jack
detection wrongly in an inverted way.  Moreover, the advertised pins
for the audio input and SPDIF output have actually no jack detection.

This patch addresses these issues.  The inv_jack_detect flag is set
for fixing the headphone jack detection, and the pin configs for audio
input and SPDIF output are marked as non-detectable.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=105161
Report-and-tested-by: moosotc@gmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_cirrus.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index a12ae8ac0914..c1c855a6c0af 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -614,6 +614,7 @@ enum {
 	CS4208_MAC_AUTO,
 	CS4208_MBA6,
 	CS4208_MBP11,
+	CS4208_MACMINI,
 	CS4208_GPIO0,
 };
 
@@ -621,6 +622,7 @@ static const struct hda_model_fixup cs4208_models[] = {
 	{ .id = CS4208_GPIO0, .name = "gpio0" },
 	{ .id = CS4208_MBA6, .name = "mba6" },
 	{ .id = CS4208_MBP11, .name = "mbp11" },
+	{ .id = CS4208_MACMINI, .name = "macmini" },
 	{}
 };
 
@@ -632,6 +634,7 @@ static const struct snd_pci_quirk cs4208_fixup_tbl[] = {
 /* codec SSID matching */
 static const struct snd_pci_quirk cs4208_mac_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x5e00, "MacBookPro 11,2", CS4208_MBP11),
+	SND_PCI_QUIRK(0x106b, 0x6c00, "MacMini 7,1", CS4208_MACMINI),
 	SND_PCI_QUIRK(0x106b, 0x7100, "MacBookAir 6,1", CS4208_MBA6),
 	SND_PCI_QUIRK(0x106b, 0x7200, "MacBookAir 6,2", CS4208_MBA6),
 	SND_PCI_QUIRK(0x106b, 0x7b00, "MacBookPro 12,1", CS4208_MBP11),
@@ -666,6 +669,24 @@ static void cs4208_fixup_mac(struct hda_codec *codec,
 	snd_hda_apply_fixup(codec, action);
 }
 
+/* MacMini 7,1 has the inverted jack detection */
+static void cs4208_fixup_macmini(struct hda_codec *codec,
+				 const struct hda_fixup *fix, int action)
+{
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x18, 0x00ab9150 }, /* mic (audio-in) jack: disable detect */
+		{ 0x21, 0x004be140 }, /* SPDIF: disable detect */
+		{ }
+	};
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		/* HP pin (0x10) has an inverted detection */
+		codec->inv_jack_detect = 1;
+		/* disable the bogus Mic and SPDIF jack detections */
+		snd_hda_apply_pincfgs(codec, pincfgs);
+	}
+}
+
 static int cs4208_spdif_sw_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
@@ -709,6 +730,12 @@ static const struct hda_fixup cs4208_fixups[] = {
 		.chained = true,
 		.chain_id = CS4208_GPIO0,
 	},
+	[CS4208_MACMINI] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs4208_fixup_macmini,
+		.chained = true,
+		.chain_id = CS4208_GPIO0,
+	},
 	[CS4208_GPIO0] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs4208_fixup_gpio0,
-- 
2.7.0
