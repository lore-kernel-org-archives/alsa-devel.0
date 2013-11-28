From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Initialize missing bass
	speaker pin for ASUS AIO ET2700
Date: Thu, 28 Nov 2013 15:26:38 +0100
Message-ID: <1385648799-9212-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 474A6265263
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 15:26:41 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 40918A7D9E
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 15:26:40 +0100 (CET)
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

Add a fixup entry for the missing bass speaker pin 0x16 on ASUS ET2700
AiO desktop.  The channel map will be added in the next patch, so that
this can be backported easily to stable kernels.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=65961
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3a9a1b0c1dbe..fd835c52618e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1782,6 +1782,7 @@ enum {
 	ALC889_FIXUP_IMAC91_VREF,
 	ALC882_FIXUP_INV_DMIC,
 	ALC882_FIXUP_NO_PRIMARY_HP,
+	ALC887_FIXUP_ASUS_BASS,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2105,6 +2106,13 @@ static const struct hda_fixup alc882_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc882_fixup_no_primary_hp,
 	},
+	[ALC887_FIXUP_ASUS_BASS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{0x16, 0x99130130}, /* bass speaker */
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2138,6 +2146,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1873, "ASUS W90V", ALC882_FIXUP_ASUS_W90V),
 	SND_PCI_QUIRK(0x1043, 0x1971, "Asus W2JC", ALC882_FIXUP_ASUS_W2JC),
 	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_FIXUP_EEE1601),
+	SND_PCI_QUIRK(0x1043, 0x84bc, "ASUS ET2700", ALC887_FIXUP_ASUS_BASS),
 	SND_PCI_QUIRK(0x104d, 0x9047, "Sony Vaio TT", ALC889_FIXUP_VAIO_TT),
 	SND_PCI_QUIRK(0x104d, 0x905a, "Sony Vaio Z", ALC882_FIXUP_NO_PRIMARY_HP),
 	SND_PCI_QUIRK(0x104d, 0x9043, "Sony Vaio VGC-LN51JGB", ALC882_FIXUP_NO_PRIMARY_HP),
-- 
1.8.4.4
