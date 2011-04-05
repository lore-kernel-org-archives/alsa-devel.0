From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix dock mic for Lenovo X220-tablet
Date: Tue, 05 Apr 2011 08:53:10 +0200
Message-ID: <4D9ABC56.3040201@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080308050306060702040403"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 80FBC1037EC
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 08:53:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080308050306060702040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080308050306060702040403
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-dock-mic-for-Lenovo-X220-tablet.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-dock-mic-for-Lenovo-X220-tablet.patch"

>From 762a2b9a09ad764caadb1c309cf3a27f429095fa Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 5 Apr 2011 07:55:24 +0200
Subject: [PATCH] ALSA: HDA: Fix dock mic for Lenovo X220-tablet

Without the "thinkpad" quirk, the dock mic in
Lenovo X220 tablet edition won't work.

BugLink: http://bugs.launchpad.net/bugs/751033
Cc: stable@kernel.org
Tested-by: James Ferguson <james.ferguson@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 69e3386..ad97d93 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3035,6 +3035,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21c6, "Thinkpad Edge 13", CXT5066_ASUS),
  	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT5066_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G560", CXT5066_ASUS),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo", CXT5066_IDEAPAD), /* Fallback for Lenovos without dock mic */
 	{}
-- 
1.7.4.1


--------------080308050306060702040403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080308050306060702040403--
