From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Pinfix quirk for HP Z200 Workstation
Date: Wed, 22 Jun 2011 22:31:07 +0200
Message-ID: <4E02510B.5090404@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050602020501040407030505"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id B284124159
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 22:31:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050602020501040407030505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BIOS lists the internal speaker as an internal line-out. Change to
internal speaker + model=auto for better auto-mute capabilities.

Relevant alsa-info is here: 
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/754964/+attachment/2002204/+files/alsa-info.txt

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------050602020501040407030505
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Pinfix-quirk-for-HP-Z200-Workstation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Pinfix-quirk-for-HP-Z200-Workstation.patch"

>From 86033a5031f8dffdb72bbdfac2286063ad5cd72d Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 22 Jun 2011 09:58:37 +0200
Subject: [PATCH] ALSA: HDA: Pinfix quirk for HP Z200 Workstation

BIOS lists the internal speaker as an internal line-out. Change to
internal speaker + model=auto for better auto-mute capabilities.

BugLink: http://bugs.launchpad.net/bugs/754964
Reported-by: Marc Legris <marc.legris@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4adf9e2..fe56b2b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -12600,6 +12600,7 @@ static const struct hda_verb alc262_toshiba_rx1_unsol_verbs[] = {
  */
 enum {
 	PINFIX_FSC_H270,
+	PINFIX_HP_Z200,
 };
 
 static const struct alc_fixup alc262_fixups[] = {
@@ -12612,9 +12613,17 @@ static const struct alc_fixup alc262_fixups[] = {
 			{ }
 		}
 	},
+	[PINFIX_HP_Z200] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x16, 0x99130120 }, /* internal speaker */
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc262_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x103c, 0x170b, "HP Z200", PINFIX_HP_Z200),
 	SND_PCI_QUIRK(0x1734, 0x1147, "FSC Celsius H270", PINFIX_FSC_H270),
 	{}
 };
@@ -12731,6 +12740,8 @@ static const struct snd_pci_quirk alc262_cfg_tbl[] = {
 			   ALC262_HP_BPC),
 	SND_PCI_QUIRK_MASK(0x103c, 0xff00, 0x1500, "HP z series",
 			   ALC262_HP_BPC),
+	SND_PCI_QUIRK(0x103c, 0x170b, "HP Z200",
+			   ALC262_AUTO),
 	SND_PCI_QUIRK_MASK(0x103c, 0xff00, 0x1700, "HP xw series",
 			   ALC262_HP_BPC),
 	SND_PCI_QUIRK(0x103c, 0x2800, "HP D7000", ALC262_HP_BPC_D7000_WL),
-- 
1.7.4.1


--------------050602020501040407030505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050602020501040407030505--
