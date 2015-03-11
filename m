From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix built-in mic on Compaq
	Presario CQ60
Date: Wed, 11 Mar 2015 18:08:00 +0100
Message-ID: <1426093680-29643-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AEEE026531A
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 18:08:02 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1E1F2AAC8
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 17:08:02 +0000 (UTC)
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

Compaq Presario CQ60 laptop with CX20561 gives a wrong pin for the
built-in mic NID 0x17 instead of NID 0x1d, and it results in the
non-working mic.  This patch just remaps the pin correctly via fixup.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=920604
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index fd3ed18670e9..da67ea8645a6 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -223,6 +223,7 @@ enum {
 	CXT_PINCFG_LENOVO_TP410,
 	CXT_PINCFG_LEMOTE_A1004,
 	CXT_PINCFG_LEMOTE_A1205,
+	CXT_PINCFG_COMPAQ_CQ60,
 	CXT_FIXUP_STEREO_DMIC,
 	CXT_FIXUP_INC_MIC_BOOST,
 	CXT_FIXUP_HEADPHONE_MIC_PIN,
@@ -660,6 +661,15 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_lemote,
 	},
+	[CXT_PINCFG_COMPAQ_CQ60] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			/* 0x17 was falsely set up as a mic, it should 0x1d */
+			{ 0x17, 0x400001f0 },
+			{ 0x1d, 0x97a70120 },
+			{ }
+		}
+	},
 	[CXT_FIXUP_STEREO_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_stereo_dmic,
@@ -769,6 +779,7 @@ static const struct hda_model_fixup cxt5047_fixup_models[] = {
 };
 
 static const struct snd_pci_quirk cxt5051_fixups[] = {
+	SND_PCI_QUIRK(0x103c, 0x360b, "Compaq CQ60", CXT_PINCFG_COMPAQ_CQ60),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo X200", CXT_PINCFG_LENOVO_X200),
 	{}
 };
-- 
2.3.2
