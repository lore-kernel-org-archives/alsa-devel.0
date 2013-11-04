From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Enable SPDIF for Acer TravelMate
	6293
Date: Mon,  4 Nov 2013 21:10:37 +0100
Message-ID: <1383595837-18166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C70F62619E0
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 21:10:37 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 96D2DA5E71
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 21:10:37 +0100 (CET)
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

BIOS on Acer TravelMate 6293 doesn't set up the SPDIF output pin
correctly as default, so enable it via a fixup entry.

Reported-and-tested-by: Hagen Heiduck <heiduck.suse@fmail.postpro.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2d7c86d81196..01bf812455a2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2386,6 +2386,7 @@ static const struct hda_verb alc268_beep_init_verbs[] = {
 enum {
 	ALC268_FIXUP_INV_DMIC,
 	ALC268_FIXUP_HP_EAPD,
+	ALC268_FIXUP_SPDIF,
 };
 
 static const struct hda_fixup alc268_fixups[] = {
@@ -2400,6 +2401,13 @@ static const struct hda_fixup alc268_fixups[] = {
 			{}
 		}
 	},
+	[ALC268_FIXUP_SPDIF] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1e, 0x014b1180 }, /* enable SPDIF out */
+			{}
+		}
+	},
 };
 
 static const struct hda_model_fixup alc268_fixup_models[] = {
@@ -2409,6 +2417,7 @@ static const struct hda_model_fixup alc268_fixup_models[] = {
 };
 
 static const struct snd_pci_quirk alc268_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x1025, 0x0139, "Acer TravelMate 6293", ALC268_FIXUP_SPDIF),
 	SND_PCI_QUIRK(0x1025, 0x015b, "Acer AOA 150 (ZG5)", ALC268_FIXUP_INV_DMIC),
 	/* below is codec SSID since multiple Toshiba laptops have the
 	 * same PCI SSID 1179:ff00
-- 
1.8.4.2
