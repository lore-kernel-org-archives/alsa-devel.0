From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 27/38] ALSA: hda/realtek - Rewrite ALC880
	model=z71v with auto-parser
Date: Fri, 24 Feb 2012 17:36:20 +0100
Message-ID: <1330101391-8788-28-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id AE3901042FA
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BD1789312E
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

ASUS Z71V has a totally broken BIOS setup (at least the info I got),
thus we need to override the whole pin-config table to make the
auto-parser working correctly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e88c753..71acd9b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4449,6 +4449,7 @@ enum {
 	ALC880_FIXUP_F1734,
 	ALC880_FIXUP_UNIWILL,
 	ALC880_FIXUP_UNIWILL_DIG,
+	ALC880_FIXUP_Z71V,
 };
 
 /* enable the volume-knob widget support on NID 0x21 */
@@ -4579,10 +4580,29 @@ static const struct alc_fixup alc880_fixups[] = {
 			{ }
 		}
 	},
+	[ALC880_FIXUP_Z71V] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			/* set up the whole pins as BIOS is utterly broken */
+			{ 0x14, 0x99030120 }, /* speaker */
+			{ 0x15, 0x0121411f }, /* HP */
+			{ 0x16, 0x411111f0 }, /* N/A */
+			{ 0x17, 0x411111f0 }, /* N/A */
+			{ 0x18, 0x01a19950 }, /* mic-in */
+			{ 0x19, 0x411111f0 }, /* N/A */
+			{ 0x1a, 0x01813031 }, /* line-in */
+			{ 0x1b, 0x411111f0 }, /* N/A */
+			{ 0x1c, 0x411111f0 }, /* N/A */
+			{ 0x1d, 0x411111f0 }, /* N/A */
+			{ 0x1e, 0x0144111e }, /* SPDIF */
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P", ALC880_FIXUP_W810),
+	SND_PCI_QUIRK(0x1043, 0x1964, "ASUS Z71V", ALC880_FIXUP_Z71V),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo", ALC880_FIXUP_EAPD_COEF),
 	SND_PCI_QUIRK(0x1584, 0x9050, "Uniwill", ALC880_FIXUP_UNIWILL_DIG),
 	SND_PCI_QUIRK(0x1584, 0x9054, "Uniwill", ALC880_FIXUP_F1734),
-- 
1.7.9
