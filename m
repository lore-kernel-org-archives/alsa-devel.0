From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/38] ALSA: hda/realtek - Rewrite ALC880
	model=w810 with auto-parser
Date: Fri, 24 Feb 2012 17:36:10 +0100
Message-ID: <1330101391-8788-18-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A2E9104321
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 98671920F7
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

The Medion W810 with ALC880 has a typical BIOS bug, copying the
pin-defaults without disabling the unused pins.  At least, the pin
0x17 must be disabled.  Also, it requires GPIO-2 setup.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a391465..1cad674 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4405,6 +4405,7 @@ enum {
 	ALC880_FIXUP_GPIO2,
 	ALC880_FIXUP_MEDION_RIM,
 	ALC880_FIXUP_LG,
+	ALC880_FIXUP_W810,
 };
 
 static const struct alc_fixup alc880_fixups[] = {
@@ -4432,9 +4433,21 @@ static const struct alc_fixup alc880_fixups[] = {
 			{ }
 		}
 	},
+	[ALC880_FIXUP_W810] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			/* disable bogus unused pins */
+			{ 0x17, 0x411111f0 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_GPIO2,
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P", ALC880_FIXUP_W810),
+	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK(0x161f, 0x205d, "Medion Rim 2150", ALC880_FIXUP_MEDION_RIM),
 	SND_PCI_QUIRK(0x1854, 0x003b, "LG", ALC880_FIXUP_LG),
 	SND_PCI_QUIRK(0x1854, 0x005f, "LG P1 Express", ALC880_FIXUP_LG),
-- 
1.7.9
