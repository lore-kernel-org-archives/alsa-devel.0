From: Jeremy Soller <jeremy@system76.com>
Subject: [PATCH] Headset microphone support for System76 darp5
Date: Tue, 29 Jan 2019 12:52:01 -0700
Message-ID: <1548791521.3450804.1646371736.7EA213CA@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 629702674A3
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 20:52:03 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 71FAE23324
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 14:52:02 -0500 (EST)
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

Headset microphone support for System76 darp5

Signed-off-by: Jeremy Soller <jeremy@system76.com>

---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b4f472157ebd..15fedb0eeae1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5591,6 +5591,7 @@ enum {
        ALC294_FIXUP_ASUS_HEADSET_MIC,
        ALC294_FIXUP_ASUS_SPK,
        ALC225_FIXUP_HEADSET_JACK,
+       ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6537,6 +6538,15 @@ static const struct hda_fixup alc269_fixups[] = {
                .type = HDA_FIXUP_FUNC,
                .v.func = alc_fixup_headset_jack,
        },
+       [ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE] = {
+               .type = HDA_FIXUP_PINS,
+               .v.pins = (const struct hda_pintbl[]) {
+                       { 0x1a, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+                       { }
+               },
+               .chained = true,
+               .chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+       },
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6606,6 +6616,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
        SND_PCI_QUIRK(0x103c, 0x18e6, "HP", ALC269_FIXUP_HP_GPIO_LED),
        SND_PCI_QUIRK(0x103c, 0x218b, "HP", ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED),
        SND_PCI_QUIRK(0x103c, 0x225f, "HP", ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY),
+       SND_PCI_QUIRK(0x1558, 0x1325, "System76", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
        /* ALC282 */
        SND_PCI_QUIRK(0x103c, 0x21f9, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
        SND_PCI_QUIRK(0x103c, 0x2210, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
