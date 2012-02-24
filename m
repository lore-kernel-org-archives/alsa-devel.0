From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/38] ALSA: hda/realtek - Drop ALC880
	model=clevo
Date: Fri, 24 Feb 2012 17:36:12 +0100
Message-ID: <1330101391-8788-20-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F65F104323
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A51D492558
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

Clevo machines with ALC880 are all well with proper BIOS setup.
It seems still requiring the additional COEF setup for the EAPD.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a0df05d..4f8c362 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4406,6 +4406,7 @@ enum {
 	ALC880_FIXUP_MEDION_RIM,
 	ALC880_FIXUP_LG,
 	ALC880_FIXUP_W810,
+	ALC880_FIXUP_EAPD_COEF,
 };
 
 static const struct alc_fixup alc880_fixups[] = {
@@ -4443,10 +4444,20 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chained = true,
 		.chain_id = ALC880_FIXUP_GPIO2,
 	},
+	[ALC880_FIXUP_EAPD_COEF] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* change to EAPD mode */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
+			{ 0x20, AC_VERB_SET_PROC_COEF,  0x3060 },
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P", ALC880_FIXUP_W810),
+	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo", ALC880_FIXUP_EAPD_COEF),
 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK(0x161f, 0x205d, "Medion Rim 2150", ALC880_FIXUP_MEDION_RIM),
 	SND_PCI_QUIRK(0x1854, 0x003b, "LG", ALC880_FIXUP_LG),
-- 
1.7.9
