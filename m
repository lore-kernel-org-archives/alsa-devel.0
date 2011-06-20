From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Remove quirk for an HP device
Date: Mon, 20 Jun 2011 10:43:55 +0200
Message-ID: <4DFF084B.9090802@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080401020001090605070601"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C0F4A2439F
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 10:43:57 +0200 (CEST)
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
--------------080401020001090605070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The reporter, who is running kernel 2.6.38, reports that
he needs to set model=auto for the headphone output to work
correctly.

Relevant codec info is in http://bugs.launchpad.net/bugs/761022

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080401020001090605070601
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Remove-quirk-for-an-HP-device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Remove-quirk-for-an-HP-device.patch"

>From c7ccd75a6d169b1df9cd543486f0b7e572d95a22 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 20 Jun 2011 10:27:07 +0200
Subject: [PATCH] ALSA: HDA: Remove quirk for an HP device

The reporter, who is running kernel 2.6.38, reports that
he needs to set model=auto for the headphone output to work
correctly.

BugLink: http://bugs.launchpad.net/bugs/761022
Cc: stable@kernel.org (v2.6.38+)
Reported-by: Jo
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9b97af9..c174865 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4884,7 +4884,6 @@ static const struct snd_pci_quirk alc880_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0xe309, "ULI", ALC880_3ST_DIG),
 	SND_PCI_QUIRK(0x1025, 0xe310, "ULI", ALC880_3ST),
 	SND_PCI_QUIRK(0x1039, 0x1234, NULL, ALC880_6ST_DIG),
-	SND_PCI_QUIRK(0x103c, 0x2a09, "HP", ALC880_5ST),
 	SND_PCI_QUIRK(0x1043, 0x10b3, "ASUS W1V", ALC880_ASUS_W1V),
 	SND_PCI_QUIRK(0x1043, 0x10c2, "ASUS W6A", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x10c3, "ASUS Wxx", ALC880_ASUS_DIG),
-- 
1.7.4.1


--------------080401020001090605070601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080401020001090605070601--
