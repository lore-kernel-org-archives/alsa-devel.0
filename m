From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix loud click noise with IdeaPad
	410Y
Date: Fri,  7 Mar 2014 14:53:43 +0100
Message-ID: <1394200423-30506-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3305B2659E8
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 14:53:44 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 93FBCAB9F
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 13:53:43 +0000 (UTC)
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

Lenovo IdeaPad 410Y with ALC282 codec makes loud click noises at boot
and shutdown.  Also, it wrongly misdetects the acpi_thinkpad hook.
This patch adds a device-specific fixup for disabling the shutup
callback that is the cause of the click noise and also avoiding the
thinpad_helper calls.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=71511
Reported-and-tested-by: Guilherme Amadio <guilherme.amadio@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 850296a1e0ff..8d0a84436674 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3616,6 +3616,19 @@ static void alc_fixup_auto_mute_via_amp(struct hda_codec *codec,
 	}
 }
 
+static void alc_no_shutup(struct hda_codec *codec)
+{
+}
+
+static void alc_fixup_no_shutup(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		struct alc_spec *spec = codec->spec;
+		spec->shutup = alc_no_shutup;
+	}
+}
+
 static void alc_fixup_headset_mode_alc668(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -3844,6 +3857,7 @@ enum {
 	ALC269_FIXUP_HP_GPIO_LED,
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
+	ALC269_FIXUP_NO_SHUTUP,
 	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
 	ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -4020,6 +4034,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
+	[ALC269_FIXUP_NO_SHUTUP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_no_shutup,
+	},
 	[ALC269_FIXUP_LENOVO_DOCK] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -4405,6 +4423,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2212, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x5026, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
1.9.0
