From: Jeremy Soller <jeremy@system76.com>
Subject: [PATCH] Headset microphone and internal speaker
 support for System76 oryp5
Date: Wed, 13 Feb 2019 10:56:19 -0700
Message-ID: <1550080579.2205619.1657354816.556FBDA9@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id AF435267917
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 18:56:21 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 670DB21BC4
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 12:56:20 -0500 (EST)
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

On the System76 Oryx Pro (oryp5), there is a headset microphone input attached to 0x19 that does not have a jack detect. In order to get it working, the pin configuration needs to be set correctly, and the ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC fixup needs to be applied. This is similar to the MIC_NO_PRESENCE fixups for some Dell laptops, except we have a separate microphone jack that is already configured correctly. Since the ALC1220 does not have a fixup similar to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC, I have exposed the fixup from the ALC269 in a way that it can be accessed from the alc1220_fixup_system76_oryp5 function. In addition, the alc1220_fixup_clevo_p950 needs to be applied to gain speaker output.

Signed-off-by: Jeremy Soller <jeremy@system76.com>

---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2df7c380765b..496bcd153a24 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1855,6 +1855,8 @@ enum {
 	ALC887_FIXUP_BASS_CHMAP,
 	ALC1220_FIXUP_GB_DUAL_CODECS,
 	ALC1220_FIXUP_CLEVO_P950,
+	ALC1220_FIXUP_SYSTEM76_ORYP5,
+	ALC1220_FIXUP_SYSTEM76_ORYP5_PINS,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2056,6 +2058,17 @@ static void alc1220_fixup_clevo_p950(struct hda_codec *codec,
 	snd_hda_override_conn_list(codec, 0x1b, 1, conn1);
 }
 
+static void alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action);
+
+static void alc1220_fixup_system76_oryp5(struct hda_codec *codec,
+				     const struct hda_fixup *fix,
+				     int action)
+{
+	alc1220_fixup_clevo_p950(codec, fix, action);
+	alc_fixup_headset_mode_no_hp_mic(codec, fix, action);
+}
+
 static const struct hda_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
 		.type = HDA_FIXUP_PINS,
@@ -2300,6 +2313,19 @@ static const struct hda_fixup alc882_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc1220_fixup_clevo_p950,
 	},
+	[ALC1220_FIXUP_SYSTEM76_ORYP5] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc1220_fixup_system76_oryp5,
+	},
+	[ALC1220_FIXUP_SYSTEM76_ORYP5_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC1220_FIXUP_SYSTEM76_ORYP5,
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2376,6 +2402,8 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x9501, "Clevo P950HR", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1558, 0x95e1, "Clevo P95xER", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1558, 0x95e2, "Clevo P950ER", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1558, 0x96e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_SYSTEM76_ORYP5_PINS),
+	SND_PCI_QUIRK(0x1558, 0x97e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_SYSTEM76_ORYP5_PINS),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo laptop", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Y530", ALC882_FIXUP_LENOVO_Y530),
