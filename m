From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/11] ALSA: hda/conexant - Use generic parser
	for Toshiba P105
Date: Tue, 28 Jan 2014 11:06:35 +0100
Message-ID: <1390903600-22772-7-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 263232651A2
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:43 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 09534AC84
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 10:06:43 +0000 (UTC)
In-Reply-To: <1390903600-22772-1-git-send-email-tiwai@suse.de>
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

We need to fix bogus pincfgs on this machine, but it works well else.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a595746225cb..3fdb04f0bbaf 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1011,7 +1011,6 @@ static const char * const cxt5045_models[CXT5045_MODELS] = {
 
 static const struct snd_pci_quirk cxt5045_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x30d5, "HP 530", CXT5045_LAPTOP_HP530),
-	SND_PCI_QUIRK(0x1179, 0xff31, "Toshiba P105", CXT5045_LAPTOP_MICSENSE),
 	SND_PCI_QUIRK(0x152d, 0x0753, "Benq R55E", CXT5045_BENQ),
 	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_LAPTOP_MICSENSE),
 	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_LAPTOP_HPMICSENSE),
@@ -2873,6 +2872,7 @@ enum {
 	CXT_FIXUP_THINKPAD_ACPI,
 	CXT_FIXUP_OLPC_XO,
 	CXT_FIXUP_CAP_MIX_AMP,
+	CXT_FIXUP_TOSHIBA_P105,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -3311,9 +3311,19 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_cap_mix_amp,
 	},
+	[CXT_FIXUP_TOSHIBA_P105] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x10, 0x961701f0 }, /* speaker/hp */
+			{ 0x12, 0x02a1901e }, /* ext mic */
+			{ 0x14, 0x95a70110 }, /* int mic */
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
+	SND_PCI_QUIRK(0x1179, 0xff31, "Toshiba P105", CXT_FIXUP_TOSHIBA_P105),
 	/* HP, Packard Bell, Fujitsu-Siemens & Lenovo laptops have
 	 * really bad sound over 0dB on NID 0x17.
 	 */
@@ -3326,6 +3336,7 @@ static const struct snd_pci_quirk cxt5045_fixups[] = {
 
 static const struct hda_model_fixup cxt5045_fixup_models[] = {
 	{ .id = CXT_FIXUP_CAP_MIX_AMP, .name = "cap-mix-amp" },
+	{ .id = CXT_FIXUP_TOSHIBA_P105, .name = "toshiba-p105" },
 	{}
 };
 
-- 
1.8.5.2
