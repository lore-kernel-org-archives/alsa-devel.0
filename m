From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix digital mic on Acer Aspire
	3830TG
Date: Mon,  1 Sep 2014 14:30:35 +0200
Message-ID: <1409574635-3267-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B788262629
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:30:37 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EEE34AC06
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 12:30:36 +0000 (UTC)
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

Acer Aspire 3830TG with CX20588 codec has a digital built-in mic that
has the same problem like many others, the inverted signal in stereo.
Apply the same fixup to this machine, too.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 6f2fa838b635..6e5d0cb4e3d7 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -217,6 +217,7 @@ enum {
 	CXT_FIXUP_HEADPHONE_MIC_PIN,
 	CXT_FIXUP_HEADPHONE_MIC,
 	CXT_FIXUP_GPIO1,
+	CXT_FIXUP_ASPIRE_DMIC,
 	CXT_FIXUP_THINKPAD_ACPI,
 	CXT_FIXUP_OLPC_XO,
 	CXT_FIXUP_CAP_MIX_AMP,
@@ -664,6 +665,12 @@ static const struct hda_fixup cxt_fixups[] = {
 			{ }
 		},
 	},
+	[CXT_FIXUP_ASPIRE_DMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_stereo_dmic,
+		.chained = true,
+		.chain_id = CXT_FIXUP_GPIO1,
+	},
 	[CXT_FIXUP_THINKPAD_ACPI] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = hda_fixup_thinkpad_acpi,
@@ -744,7 +751,7 @@ static const struct hda_model_fixup cxt5051_fixup_models[] = {
 
 static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x1025, 0x0543, "Acer Aspire One 522", CXT_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_GPIO1),
+	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
-- 
2.1.0
