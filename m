From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix headphone mic input on a few
	Dell ALC293 machines
Date: Tue, 15 Dec 2015 14:44:03 +0100
Message-ID: <1450187043-11413-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 123B0261B21
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 14:44:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, woodrow.shen@canonical.com, David Henningsson <david.henningsson@canonical.com>, 1526330@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

These laptops support both headphone, headset and mic modes
for the 3.5mm jack.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1526330
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8dd2ac1..b745a72 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4606,6 +4606,7 @@ enum {
 	ALC288_FIXUP_DISABLE_AAMIX,
 	ALC292_FIXUP_DELL_E7X,
 	ALC292_FIXUP_DISABLE_AAMIX,
+	ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK,
 	ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC275_FIXUP_DELL_XPS,
 	ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE,
@@ -5169,6 +5170,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_DELL2_MIC_NO_PRESENCE
 	},
+	[ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_disable_aamix,
+		.chained = true,
+		.chain_id = ALC293_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 	[ALC292_FIXUP_DELL_E7X] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_dell_xps13,
@@ -5247,11 +5254,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x06c7, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x06d9, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x06da, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x06db, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
-	SND_PCI_QUIRK(0x1028, 0x06dd, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
-	SND_PCI_QUIRK(0x1028, 0x06de, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
-	SND_PCI_QUIRK(0x1028, 0x06df, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
-	SND_PCI_QUIRK(0x1028, 0x06e0, "Dell", ALC292_FIXUP_DISABLE_AAMIX),
+	SND_PCI_QUIRK(0x1028, 0x06db, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
+	SND_PCI_QUIRK(0x1028, 0x06dd, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
+	SND_PCI_QUIRK(0x1028, 0x06de, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
+	SND_PCI_QUIRK(0x1028, 0x06df, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
+	SND_PCI_QUIRK(0x1028, 0x06e0, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
 	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
-- 
1.9.1
