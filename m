From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add quirk for Lenovo U350
Date: Mon, 23 May 2011 08:38:42 +0200
Message-ID: <4DDA00F2.4070704@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090201020202020607060101"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 752DE1037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 08:38:45 +0200 (CEST)
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
--------------090201020202020607060101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Since the auto-parser for Conexant 5066 is yet not activated, I guess it 
makes sense to keep adding quirks?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090201020202020607060101
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-quirk-for-Lenovo-U350.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Add-quirk-for-Lenovo-U350.patch"

>From 27f5c5a12bf4b7339eaa5990e0626268cdc0836b Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 23 May 2011 08:26:16 +0200
Subject: [PATCH] ALSA: HDA: Add quirk for Lenovo U350

Add model=asus quirk for Lenovo Ideapad U350 to make internal mic
work correctly.

Cc: stable@kernel.org (2.6.38+)
BugLink: http://bugs.launchpad.net/bugs/751681
Reported-by: Kent Baxley <kent.baxley@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 4f37477..e8725d2 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3098,6 +3098,7 @@ static const struct snd_pci_quirk cxt5066_cfg_tbl[] = {
  	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT5066_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo U350", CXT5066_ASUS),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G560", CXT5066_ASUS),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo", CXT5066_IDEAPAD), /* Fallback for Lenovos without dock mic */
 	{}
-- 
1.7.4.1


--------------090201020202020607060101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090201020202020607060101--
