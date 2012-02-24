From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 25/38] ALSA: hda/realtek - Rewrite ALC880
	model=uniwill with auto-parser
Date: Fri, 24 Feb 2012 17:36:18 +0100
Message-ID: <1330101391-8788-26-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C87410B8BF
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A093592325
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

The model=uniwill would work almost as is, but a couple of adjustments
are needed to make the mutli-io working correctly.  The headphone and
speaker pins have to be marked properly in pin configs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3c0a46e..ff4410c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4447,6 +4447,7 @@ enum {
 	ALC880_FIXUP_VOL_KNOB,
 	ALC880_FIXUP_FUJITSU,
 	ALC880_FIXUP_F1734,
+	ALC880_FIXUP_UNIWILL,
 };
 
 /* enable the volume-knob widget support on NID 0x21 */
@@ -4556,12 +4557,23 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chained = true,
 		.chain_id = ALC880_FIXUP_VOL_KNOB,
 	},
+	[ALC880_FIXUP_UNIWILL] = {
+		/* need to fix HP and speaker pins to be parsed correctly */
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x14, 0x0121411f }, /* HP */
+			{ 0x15, 0x99030120 }, /* speaker */
+			{ 0x16, 0x99030130 }, /* bass speaker */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo", ALC880_FIXUP_EAPD_COEF),
 	SND_PCI_QUIRK(0x1584, 0x9054, "Uniwill", ALC880_FIXUP_F1734),
+	SND_PCI_QUIRK(0x1584, 0x9070, "Uniwill", ALC880_FIXUP_UNIWILL),
 	SND_PCI_QUIRK(0x1584, 0x9077, "Uniwill P53", ALC880_FIXUP_VOL_KNOB),
 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK(0x161f, 0x205d, "Medion Rim 2150", ALC880_FIXUP_MEDION_RIM),
-- 
1.7.9
