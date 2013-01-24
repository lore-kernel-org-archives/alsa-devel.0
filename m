From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/13] ALSA: hda - Add auto-mute support to PB
	desktop
Date: Thu, 24 Jan 2013 18:37:55 +0100
Message-ID: <1359049082-5880-7-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B1E5D2616F9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E7084A50DE
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:14 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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

Using the new chained_before flag, we can correct the headphone jack
detection capability easily over the existing ALC880 6stack model
(which disables the jack detection intentionally for compatibility
reason).

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=901846

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 446ed11..dc75607 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1034,6 +1034,7 @@ enum {
 	ALC880_FIXUP_6ST_BASE,
 	ALC880_FIXUP_6ST,
 	ALC880_FIXUP_6ST_DIG,
+	ALC880_FIXUP_6ST_AUTOMUTE,
 };
 
 /* enable the volume-knob widget support on NID 0x21 */
@@ -1294,6 +1295,15 @@ static const struct hda_fixup alc880_fixups[] = {
 		.chained = true,
 		.chain_id = ALC880_FIXUP_6ST_BASE,
 	},
+	[ALC880_FIXUP_6ST_AUTOMUTE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x0121401f }, /* HP with jack detect */
+			{ }
+		},
+		.chained_before = true,
+		.chain_id = ALC880_FIXUP_6ST_BASE,
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
@@ -1308,7 +1318,7 @@ static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1584, 0x9077, "Uniwill P53", ALC880_FIXUP_VOL_KNOB),
 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK(0x161f, 0x205d, "Medion Rim 2150", ALC880_FIXUP_MEDION_RIM),
-	SND_PCI_QUIRK(0x1631, 0xe011, "PB 13201056", ALC880_FIXUP_6ST),
+	SND_PCI_QUIRK(0x1631, 0xe011, "PB 13201056", ALC880_FIXUP_6ST_AUTOMUTE),
 	SND_PCI_QUIRK(0x1734, 0x107c, "FSC F1734", ALC880_FIXUP_F1734),
 	SND_PCI_QUIRK(0x1734, 0x1094, "FSC Amilo M1451G", ALC880_FIXUP_FUJITSU),
 	SND_PCI_QUIRK(0x1734, 0x10ac, "FSC AMILO Xi 1526", ALC880_FIXUP_F1734),
@@ -1371,6 +1381,7 @@ static const struct hda_model_fixup alc880_fixup_models[] = {
 	{.id = ALC880_FIXUP_5ST_DIG, .name = "5stack-digout"},
 	{.id = ALC880_FIXUP_6ST, .name = "6stack"},
 	{.id = ALC880_FIXUP_6ST_DIG, .name = "6stack-digout"},
+	{.id = ALC880_FIXUP_6ST_AUTOMUTE, .name = "6stack-automute"},
 	{}
 };
 
-- 
1.8.1.1
