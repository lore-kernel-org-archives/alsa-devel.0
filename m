From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/38] ALSA: hda/realtek - Add the fixup codes
	for ALC260 model=will
Date: Fri, 24 Feb 2012 17:35:57 +0100
Message-ID: <1330101391-8788-5-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id C565A10430A
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5AE9E90B1D
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

The model=will for ALC260 requires the pin 0x0f to be a headphone and
some special verbs for the COEF to turn on the amp.  Now added these as
fixup entries and removed the static model quirk.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 30ef877..f5f3710 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4207,21 +4207,42 @@ static const struct hda_amp_list alc260_loopbacks[] = {
  * Pin config fixes
  */
 enum {
-	PINFIX_HP_DC5750,
+	ALC260_FIXUP_HP_DC5750,
+	ALC260_FIXUP_HP_PIN_0F,
+	ALC260_FIXUP_COEF,
 };
 
 static const struct alc_fixup alc260_fixups[] = {
-	[PINFIX_HP_DC5750] = {
+	[ALC260_FIXUP_HP_DC5750] = {
 		.type = ALC_FIXUP_PINS,
 		.v.pins = (const struct alc_pincfg[]) {
 			{ 0x11, 0x90130110 }, /* speaker */
 			{ }
 		}
 	},
+	[ALC260_FIXUP_HP_PIN_0F] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x0f, 0x01214000 }, /* HP */
+			{ }
+		}
+	},
+	[ALC260_FIXUP_COEF] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
+			{ 0x20, AC_VERB_SET_PROC_COEF,  0x3040 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC260_FIXUP_HP_PIN_0F,
+	},
 };
 
 static const struct snd_pci_quirk alc260_fixup_tbl[] = {
-	SND_PCI_QUIRK(0x103c, 0x280a, "HP dc5750", PINFIX_HP_DC5750),
+	SND_PCI_QUIRK(0x1025, 0x007f, "Acer Aspire 9500", ALC260_FIXUP_COEF),
+	SND_PCI_QUIRK(0x103c, 0x280a, "HP dc5750", ALC260_FIXUP_HP_DC5750),
+	SND_PCI_QUIRK(0x1631, 0xc017, "PB V7900", ALC260_FIXUP_COEF),
 	{}
 };
 
-- 
1.7.9
