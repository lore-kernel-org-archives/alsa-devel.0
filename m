From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda/realtek - Add a quirk for AC700
	Chromebook.
Date: Fri,  5 Apr 2013 14:58:22 -0700
Message-ID: <1365199102-19945-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f201.google.com (mail-ob0-f201.google.com
 [209.85.214.201])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E5026262B
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 23:58:29 +0200 (CEST)
Received: by mail-ob0-f201.google.com with SMTP id uz6so1014361obc.2
 for <alsa-devel@alsa-project.org>; Fri, 05 Apr 2013 14:58:29 -0700 (PDT)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Correct pin configs for the Acer AC700.  Most importantly indicate
that SPDIF is connected, it routes to HDMI out.
Similar to Aspire models, chain in the DMIC fixup and allow it to be
applied to this codec (ALC269VB) as well.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_realtek.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1bd2d49..145d078 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2617,7 +2617,8 @@ static void alc271_fixup_dmic(struct hda_codec *codec,
 	};
 	unsigned int cfg;
 
-	if (strcmp(codec->chip_name, "ALC271X"))
+	if (strcmp(codec->chip_name, "ALC271X") &&
+	    strcmp(codec->chip_name, "ALC269VB"))
 		return;
 	cfg = snd_hda_codec_get_pincfg(codec, 0x12);
 	if (get_defcfg_connect(cfg) == AC_JACK_PORT_FIXED)
@@ -2838,6 +2839,7 @@ enum {
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
 	ALC271_FIXUP_AMIC_MIC2,
 	ALC271_FIXUP_HP_GATE_MIC_JACK,
+	ALC269_FIXUP_ACER_AC700,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -3010,6 +3012,19 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC271_FIXUP_AMIC_MIC2,
 	},
+	[ALC269_FIXUP_ACER_AC700] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x12, 0x99a3092f }, /* int-mic */
+			{ 0x14, 0x99130110 }, /* speaker */
+			{ 0x18, 0x03a11c20 }, /* mic */
+			{ 0x1e, 0x0346101e }, /* SPDIF1 */
+			{ 0x21, 0x0321101f }, /* HP out */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC271_FIXUP_DMIC,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -3034,6 +3049,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
+	SND_PCI_QUIRK(0x1025, 0x047c, "Acer AC700", ALC269_FIXUP_ACER_AC700),
 	SND_PCI_QUIRK(0x1025, 0x0740, "Acer AO725", ALC271_FIXUP_HP_GATE_MIC_JACK),
 	SND_PCI_QUIRK(0x1025, 0x0742, "Acer AO756", ALC271_FIXUP_HP_GATE_MIC_JACK),
 	SND_PCI_QUIRK_VENDOR(0x1025, "Acer Aspire", ALC271_FIXUP_DMIC),
-- 
1.8.1.3.605.g02339dd
