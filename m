From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/13] ALSA: hda - Add fixup for Lenovo
	Thinkpad with AD1984 codec
Date: Fri, 19 Jul 2013 17:12:11 +0200
Message-ID: <1374246742-14373-3-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C1F7265730
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 39F6AA5387
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

Ported from the static quirk (model=thinkpad).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 2ae7dc5..0262ffb 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -3637,9 +3637,17 @@ static void ad1884_fixup_hp_eapd(struct hda_codec *codec,
 	}
 }
 
+/* set magic COEFs for dmic */
+static const struct hda_verb ad1884_dmic_init_verbs[] = {
+	{0x01, AC_VERB_SET_COEF_INDEX, 0x13f7},
+	{0x01, AC_VERB_SET_PROC_COEF, 0x08},
+	{}
+};
+
 enum {
 	AD1884_FIXUP_AMP_OVERRIDE,
 	AD1884_FIXUP_HP_EAPD,
+	AD1884_FIXUP_DMIC_COEF,
 };
 
 static const struct hda_fixup ad1884_fixups[] = {
@@ -3653,10 +3661,15 @@ static const struct hda_fixup ad1884_fixups[] = {
 		.chained = true,
 		.chain_id = AD1884_FIXUP_AMP_OVERRIDE,
 	},
+	[AD1884_FIXUP_DMIC_COEF] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = ad1884_dmic_init_verbs,
+	},
 };
 
 static const struct snd_pci_quirk ad1884_fixup_tbl[] = {
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", AD1884_FIXUP_HP_EAPD),
+	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo Thinkpad", AD1884_FIXUP_DMIC_COEF),
 	{}
 };
 
-- 
1.8.3.1
