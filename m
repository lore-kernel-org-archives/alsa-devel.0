From: Jeremy Soller <jeremy@system76.com>
Subject: Re: [PATCH] Headset microphone support for System76
	darp5
Date: Wed, 30 Jan 2019 16:12:31 -0700
Message-ID: <1548889951.496664.1647369016.0216CBEF@webmail.messagingengine.com>
References: <1548791521.3450804.1646371736.7EA213CA@webmail.messagingengine.com>
 <s5h1s4ucaml.wl-tiwai@suse.de>
 <1548889673.495532.1647367944.2066425D@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by alsa0.perex.cz (Postfix) with ESMTP id EB33E2673DD
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 00:12:35 +0100 (CET)
In-Reply-To: <1548889673.495532.1647367944.2066425D@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On the System76 Darter Pro (darp5), there is a headset microphone input attached to 0x1a that does not have a jack detect. In order to get it working, the pin configuration needs to be set correctly, and the ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC fixup needs to be applied. This is similar to the MIC_NO_PRESENCE fixups for some Dell laptops, except we have a separate microphone jack that is already configured correctly.

Signed-off-by: Jeremy Soller <jeremy@system76.com>

---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b4f472157ebd..eae02e0469fc 100644
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
@@ -6715,6 +6725,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
        SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
        SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
        SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
+       SND_PCI_QUIRK(0x1558, 0x1325, "System76 Darter Pro (darp5)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
        SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC233_FIXUP_LENOVO_MULTI_CODECS),
        SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
        SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNORE),
