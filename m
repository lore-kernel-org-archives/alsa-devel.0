From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add subwoofer quirk for Acer Aspire
	8942G
Date: Thu, 10 Feb 2011 15:48:46 +0100
Message-ID: <4D53FACE.70708@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010304080202090108010307"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id D41E524522
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 15:48:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010304080202090108010307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

According to the reporter, node 0x15 needs to be muted for subwoofer
to stop sounding. This pin is marked as unused by BIOS, so fix that.

BugLink: http://bugs.launchpad.net/bugs/715877

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010304080202090108010307
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-subwoofer-quirk-for-Acer-Aspire-8942G.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Add-subwoofer-quirk-for-Acer-Aspire-8942G.patc";
 filename*1="h"

>From 91a920a15021d59cfc9d2ca2ac9602dd90dffc16 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 10 Feb 2011 15:39:19 +0100
Subject: [PATCH] ALSA: HDA: Add subwoofer quirk for Acer Aspire 8942G

According to the reporter, node 0x15 needs to be muted for subwoofer
to stop sounding. This pin is marked as unused by BIOS, so fix that.

BugLink: http://bugs.launchpad.net/bugs/715877

Cc: stable@kernel.org (2.6.37+)
Reported-by: Hans Peter
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2571d97..089a7de 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -19517,6 +19517,7 @@ static const struct alc_fixup alc662_fixups[] = {
 };
 
 static struct snd_pci_quirk alc662_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x1025, 0x0308, "Acer Aspire 8942G", ALC662_FIXUP_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
 	SND_PCI_QUIRK(0x144d, 0xc051, "Samsung R720", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
-- 
1.7.1


--------------010304080202090108010307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010304080202090108010307--
