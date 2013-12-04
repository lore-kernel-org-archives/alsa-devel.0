From: Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH] ALSA: hda - fix mic issues on Acer Aspire E-572
Date: Wed,  4 Dec 2013 20:50:53 +0100
Message-ID: <1386186653-11372-1-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 60A572619F4
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 20:51:09 +0100 (CET)
Received: from ultralex.lan ([93.218.116.213]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MN0jA-1Vhitw3yDQ-006hjv for
 <alsa-devel@alsa-project.org>; Wed, 04 Dec 2013 20:51:09 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Oleksij Rempel <linux@rempel-privat.de>
List-Id: alsa-devel@alsa-project.org

This patch add quirk for Acer Aspire E-572:
- fix external mic
- limit mic boost for internal mic with maximal noise level of -24dB

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 59c36de..f3041a0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3902,6 +3902,7 @@ enum {
 	ALC269_FIXUP_ASUS_X101,
 	ALC271_FIXUP_AMIC_MIC2,
 	ALC271_FIXUP_HP_GATE_MIC_JACK,
+	ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572,
 	ALC269_FIXUP_ACER_AC700,
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST,
 	ALC269VB_FIXUP_ASUS_ZENBOOK,
@@ -4164,6 +4165,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC271_FIXUP_AMIC_MIC2,
 	},
+	[ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC271_FIXUP_HP_GATE_MIC_JACK,
+	},
 	[ALC269_FIXUP_ACER_AC700] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -4261,6 +4268,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0740, "Acer AO725", ALC271_FIXUP_HP_GATE_MIC_JACK),
 	SND_PCI_QUIRK(0x1025, 0x0742, "Acer AO756", ALC271_FIXUP_HP_GATE_MIC_JACK),
 	SND_PCI_QUIRK_VENDOR(0x1025, "Acer Aspire", ALC271_FIXUP_DMIC),
+	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05be, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
-- 
1.8.3.2
