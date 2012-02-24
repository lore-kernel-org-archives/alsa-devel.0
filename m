From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/38] ALSA: hda/realtek - Rewrite ALC880
	model=lg with the auto-parser
Date: Fri, 24 Feb 2012 17:36:09 +0100
Message-ID: <1330101391-8788-17-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 53BDD10431A
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 796D39141C
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

ALC880 model=lg could work fine with the auto-parser due to the recent
rewrite, but it still needs the manual adjustment; namely, the BIOS leaves
unused pins as some real active jacks.  This confuses the parser.
Thus we just cover these pins and override the pin-configs as a fix-up.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d0c71d5..a391465 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4404,6 +4404,7 @@ static const struct hda_amp_list alc880_loopbacks[] = {
 enum {
 	ALC880_FIXUP_GPIO2,
 	ALC880_FIXUP_MEDION_RIM,
+	ALC880_FIXUP_LG,
 };
 
 static const struct alc_fixup alc880_fixups[] = {
@@ -4421,10 +4422,23 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chained = true,
 		.chain_id = ALC880_FIXUP_GPIO2,
 	},
+	[ALC880_FIXUP_LG] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			/* disable bogus unused pins */
+			{ 0x16, 0x411111f0 },
+			{ 0x18, 0x411111f0 },
+			{ 0x1a, 0x411111f0 },
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x161f, 0x205d, "Medion Rim 2150", ALC880_FIXUP_MEDION_RIM),
+	SND_PCI_QUIRK(0x1854, 0x003b, "LG", ALC880_FIXUP_LG),
+	SND_PCI_QUIRK(0x1854, 0x005f, "LG P1 Express", ALC880_FIXUP_LG),
+	SND_PCI_QUIRK(0x1854, 0x0068, "LG w1", ALC880_FIXUP_LG),
 	{}
 };
 
-- 
1.7.9
