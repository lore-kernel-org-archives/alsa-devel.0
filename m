From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] ALSA: hda - Add mic fixup for Gigabyte
	BXBT-2807
Date: Tue, 22 Jul 2014 10:58:29 +0100
Message-ID: <1406023109-30864-1-git-send-email-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id A97AC2654E4
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 11:58:44 +0200 (CEST)
Received: by mail-we0-f173.google.com with SMTP id q58so8856280wes.18
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 02:58:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Gigabyte BRIX BXBT-2707 is a mini-PC with Realtek ALC283 HDA,
exposing a single headset jack.

However, the default pin config information only suggests
that one pin is connected: a HP out jack (pin 0x21, default
config 0x04211010).

The microphone input is behind pin 0x19, which has default
config 0x411111f0 (i.e. unused), so it does not show up in
userspace, and no microphone input is possible via the headset.

Override the pin config so that the headset mic can be used.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 512582b..10f1848 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4358,6 +4358,7 @@ enum {
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC292_FIXUP_TPT440_DOCK,
+	ALC283_FIXUP_BXBT2807_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -4792,6 +4793,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
 	},
+	[ALC283_FIXUP_BXBT2807_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x04a110f0 },
+			{ },
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -5013,6 +5021,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", ALC269_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
+	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_BXBT2807_MIC),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
1.9.1
