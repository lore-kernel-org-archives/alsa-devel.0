From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/13] ALSA: hda - Add fixup for HP TouchSmart
	with AD1984A codec
Date: Fri, 19 Jul 2013 17:12:12 +0200
Message-ID: <1374246742-14373-4-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E19E265759
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4D0D2A538A
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
In-Reply-To: <1374246742-14373-1-git-send-email-tiwai@suse.de>
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

Ported from the static quirk.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 0262ffb..a667256 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -3648,6 +3648,7 @@ enum {
 	AD1884_FIXUP_AMP_OVERRIDE,
 	AD1884_FIXUP_HP_EAPD,
 	AD1884_FIXUP_DMIC_COEF,
+	AD1884_FIXUP_HP_TOUCHSMART,
 };
 
 static const struct hda_fixup ad1884_fixups[] = {
@@ -3665,9 +3666,16 @@ static const struct hda_fixup ad1884_fixups[] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = ad1884_dmic_init_verbs,
 	},
+	[AD1884_FIXUP_HP_TOUCHSMART] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = ad1884_dmic_init_verbs,
+		.chained = true,
+		.chain_id = AD1884_FIXUP_HP_EAPD,
+	},
 };
 
 static const struct snd_pci_quirk ad1884_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x103c, 0x2a82, "HP Touchsmart", AD1884_FIXUP_HP_TOUCHSMART),
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", AD1884_FIXUP_HP_EAPD),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo Thinkpad", AD1884_FIXUP_DMIC_COEF),
 	{}
-- 
1.8.3.1
