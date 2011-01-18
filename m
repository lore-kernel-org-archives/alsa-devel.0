From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Remove quirk for Acer Aspire 4930G
Date: Tue, 18 Jan 2011 13:49:07 +0100
Message-ID: <4D358C43.3030608@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060800040608070500030208"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 89E6810382A
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 13:49:10 +0100 (CET)
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
--------------060800040608070500030208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BugLink: http://bugs.launchpad.net/bugs/647970

According to the reporter, model=auto works better than
the current quirk for Acer Aspire 4930G.

Cc: stable@kernel.org (2.6.35+)
Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------060800040608070500030208
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Remove-quirk-for-Acer-Aspire-4930G.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Remove-quirk-for-Acer-Aspire-4930G.patch"

>From 0c0ec949889bbaab4fd093144ba8be483f64fc32 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 18 Jan 2011 13:29:53 +0100
Subject: [PATCH] ALSA: HDA: Remove quirk for Acer Aspire 4930G

BugLink: http://bugs.launchpad.net/bugs/647970

According to the reporter, model=auto works better than
the current quirk for Acer Aspire 4930G.

Cc: stable@kernel.org (2.6.35+)
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f006ee..9c123d0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9842,8 +9842,6 @@ static struct snd_pci_quirk alc882_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0110, "Acer Aspire", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0112, "Acer Aspire 9303", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x0121, "Acer Aspire 5920G", ALC883_ACER_ASPIRE),
-	SND_PCI_QUIRK(0x1025, 0x013e, "Acer Aspire 4930G",
-		ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0x013f, "Acer Aspire 5930G",
 		ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0x0145, "Acer Aspire 8930G",
-- 
1.7.1


--------------060800040608070500030208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060800040608070500030208--
