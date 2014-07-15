From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Add the pin fixup for HP Envy
	TS bass speaker
Date: Tue, 15 Jul 2014 17:01:49 +0200
Message-ID: <1405436510-16848-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F0FBD26166B
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 17:01:50 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B160BAC66
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 15:01:50 +0000 (UTC)
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

NID 0x10 seems corresponding to the bass speaker.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 52bdbdc7786e..946ae4094aa3 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -103,6 +103,7 @@ enum {
 	STAC_92HD83XXX_HP,
 	STAC_HP_ENVY_BASS,
 	STAC_HP_BNB13_EQ,
+	STAC_HP_ENVY_TS_BASS,
 	STAC_92HD83XXX_MODELS
 };
 
@@ -2668,6 +2669,13 @@ static const struct hda_fixup stac92hd83xxx_fixups[] = {
 		.chained = true,
 		.chain_id = STAC_92HD83XXX_HP_MIC_LED,
 	},
+	[STAC_HP_ENVY_TS_BASS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x10, 0x92170111 },
+			{}
+		},
+	},
 };
 
 static const struct hda_model_fixup stac92hd83xxx_models[] = {
@@ -2684,6 +2692,7 @@ static const struct hda_model_fixup stac92hd83xxx_models[] = {
 	{ .id = STAC_92HD83XXX_HEADSET_JACK, .name = "headset-jack" },
 	{ .id = STAC_HP_ENVY_BASS, .name = "hp-envy-bass" },
 	{ .id = STAC_HP_BNB13_EQ, .name = "hp-bnb13-eq" },
+	{ .id = STAC_HP_ENVY_TS_BASS, .name = "hp-envy-ts-bass" },
 	{}
 };
 
@@ -2739,6 +2748,8 @@ static const struct snd_pci_quirk stac92hd83xxx_fixup_tbl[] = {
 			  "HP bNB13", STAC_HP_BNB13_EQ),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x190A,
 			  "HP bNB13", STAC_HP_BNB13_EQ),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x190e,
+			  "HP ENVY TS", STAC_HP_ENVY_TS_BASS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1940,
 			  "HP bNB13", STAC_HP_BNB13_EQ),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1941,
-- 
2.0.1
