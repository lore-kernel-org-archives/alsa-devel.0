From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - move DELL_WMI_MIC_MUTE_LED to
	the tail in the quirk chain
Date: Tue, 18 Nov 2014 17:57:40 +0800
Message-ID: <1416304661-13243-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EA7F265074
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 10:59:51 +0100 (CET)
Received: by mail-pa0-f43.google.com with SMTP id kx10so4021799pab.30
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 01:59:49 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, po-hsu.lin@canonical.com
List-Id: alsa-devel@alsa-project.org

We have one more Dell machine needs DELL_WMI_MIC_MUTE_LED quirk, but
the machine uses alc293 instead of alc255. So if
DELL_WMI_MIC_MUTE_LED still chain ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
the machine can't use this quirk.

To change this situation, let the DELL_WMI_MIC_MUTE_LED to be a
standalone quirk, and let other quirks chain it.

After this change, this quirk can be chained to any existing quirks,
and as a result, it is possible that this quirk is applied to
a non-Dell machine or a Dell machine without mic mute led on it, but
it is still safe since alc_fixup_dell_wmi() will return an error in
these situations.

And remove the quirk for machine with subsystem id 0x6010 and 0x601f,
these two machines will fall back to the quirk
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE-->ALC255_FIXUP_HEADSET_MODE-->
ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED through pin_fixup_tbl[].

BugLink: https://bugs.launchpad.net/bugs/1381856
Reported-and-Tested-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1723954..9da5798 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4709,6 +4709,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC255_FIXUP_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mode_alc255,
+		.chained = true,
+		.chain_id = ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED
 	},
 	[ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC] = {
 		.type = HDA_FIXUP_FUNC,
@@ -4744,8 +4746,6 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_dell_wmi,
-		.chained_before = true,
-		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
 	[ALC282_FIXUP_ASPIRE_V5_PINS] = {
 		.type = HDA_FIXUP_PINS,
@@ -4783,10 +4783,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x05f4, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05f5, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05f6, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0610, "Dell", ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED),
 	SND_PCI_QUIRK(0x1028, 0x0615, "Dell Vostro 5470", ALC290_FIXUP_SUBWOOFER_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x0616, "Dell Vostro 5470", ALC290_FIXUP_SUBWOOFER_HSJACK),
-	SND_PCI_QUIRK(0x1028, 0x061f, "Dell", ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED),
 	SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439", ALC290_FIXUP_MONO_SPEAKERS_HSJACK),
 	SND_PCI_QUIRK(0x1028, 0x064a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
-- 
1.9.1
