From: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Subject: [PATCH] ALSA: hda: remove unused quirk for inverted
	mute led
Date: Sun, 04 Dec 2011 15:14:10 -0200
Message-ID: <1323018850.3883.3.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from horatio.sagui.org (horatio.sagui.org [173.230.138.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 116EE103835
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 18:14:13 +0100 (CET)
Received: from oberon.sagui.org (unknown [189.101.188.123])
	by horatio.sagui.org (Postfix) with ESMTPSA id EBF31A08
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Dec 2011 15:14:10 -0200 (BRST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit b99a776d0b17ae0f3a54e86009887a00ac4889d0 removed all effects of
the STAC92HD83* model quirk "hp". However, it left the model selection
and documentation behind, confusing users with inverted mute
leds. Completely remove this quirk and its documentation.

Signed-off-by: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 -
 sound/pci/hda/patch_sigmatel.c               |    4 ----
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index bda5469..c8c5454 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -338,7 +338,6 @@ STAC92HD83*
   mic-ref	Reference board with power management for ports
   dell-s14	Dell laptop
   dell-vostro-3500	Dell Vostro 3500 laptop
-  hp		HP laptops with (inverted) mute-LED
   hp-dv7-4000	HP dv-7 4000
   auto		BIOS setup (default)
 
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d8d2f9d..2034f33 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -96,7 +96,6 @@ enum {
 	STAC_92HD83XXX_PWR_REF,
 	STAC_DELL_S14,
 	STAC_DELL_VOSTRO_3500,
-	STAC_92HD83XXX_HP,
 	STAC_92HD83XXX_HP_cNB11_INTQUAD,
 	STAC_HP_DV7_4000,
 	STAC_92HD83XXX_MODELS
@@ -1691,7 +1690,6 @@ static const char * const stac92hd83xxx_models[STAC_92HD83XXX_MODELS] = {
 	[STAC_92HD83XXX_PWR_REF] = "mic-ref",
 	[STAC_DELL_S14] = "dell-s14",
 	[STAC_DELL_VOSTRO_3500] = "dell-vostro-3500",
-	[STAC_92HD83XXX_HP] = "hp",
 	[STAC_92HD83XXX_HP_cNB11_INTQUAD] = "hp_cNB11_intquad",
 	[STAC_HP_DV7_4000] = "hp-dv7-4000",
 };
@@ -1706,8 +1704,6 @@ static const struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 		      "unknown Dell", STAC_DELL_S14),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x1028,
 		      "Dell Vostro 3500", STAC_DELL_VOSTRO_3500),
-	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x3600,
-			  "HP", STAC_92HD83XXX_HP),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1656,
 			  "HP", STAC_92HD83XXX_HP_cNB11_INTQUAD),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1657,
-- 
1.7.7.3
