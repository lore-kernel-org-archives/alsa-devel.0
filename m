From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 23/38] ALSA: hda/realtek - Rewrite ALC880
	model=F1734 with auto-parser
Date: Fri, 24 Feb 2012 17:36:16 +0100
Message-ID: <1330101391-8788-24-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BA84104322
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 93A9D92004
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Similar as the previous patch for model=fujitsu, we can now move the
static quirk for F1734 to the auto-parser.  The only difference is the
default pin configurations: F1734 has less pins than Amilo's.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6a6436a..2d102f7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4446,6 +4446,7 @@ enum {
 	ALC880_FIXUP_TCL_S700,
 	ALC880_FIXUP_VOL_KNOB,
 	ALC880_FIXUP_FUJITSU,
+	ALC880_FIXUP_F1734,
 };
 
 /* enable the volume-knob widget support on NID 0x21 */
@@ -4535,14 +4536,37 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chained = true,
 		.chain_id = ALC880_FIXUP_VOL_KNOB,
 	},
+	[ALC880_FIXUP_F1734] = {
+		/* almost compatible with FUJITSU, but no bass and SPDIF */
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x14, 0x0121411f }, /* HP */
+			{ 0x15, 0x99030120 }, /* speaker */
+			{ 0x16, 0x411111f0 }, /* N/A */
+			{ 0x17, 0x411111f0 }, /* N/A */
+			{ 0x18, 0x411111f0 }, /* N/A */
+			{ 0x19, 0x01a19950 }, /* mic-in */
+			{ 0x1a, 0x411111f0 }, /* N/A */
+			{ 0x1b, 0x411111f0 }, /* N/A */
+			{ 0x1c, 0x411111f0 }, /* N/A */
+			{ 0x1d, 0x411111f0 }, /* N/A */
+			{ 0x1e, 0x411111f0 }, /* N/A */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_VOL_KNOB,
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo", ALC880_FIXUP_EAPD_COEF),
+	SND_PCI_QUIRK(0x1584, 0x9054, "Uniwill", ALC880_FIXUP_F1734),
 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK(0x161f, 0x205d, "Medion Rim 2150", ALC880_FIXUP_MEDION_RIM),
+	SND_PCI_QUIRK(0x1734, 0x107c, "FSC F1734", ALC880_FIXUP_F1734),
 	SND_PCI_QUIRK(0x1734, 0x1094, "FSC Amilo M1451G", ALC880_FIXUP_FUJITSU),
+	SND_PCI_QUIRK(0x1734, 0x10ac, "FSC AMILO Xi 1526", ALC880_FIXUP_F1734),
 	SND_PCI_QUIRK(0x1734, 0x10b0, "FSC Amilo Pi1556", ALC880_FIXUP_FUJITSU),
 	SND_PCI_QUIRK(0x1854, 0x003b, "LG", ALC880_FIXUP_LG),
 	SND_PCI_QUIRK(0x1854, 0x005f, "LG P1 Express", ALC880_FIXUP_LG),
-- 
1.7.9
