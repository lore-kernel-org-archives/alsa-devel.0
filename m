From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add dock mic quirk for Lenovo
	Thinkpad X220
Date: Thu, 31 Mar 2011 09:52:38 +0200
Message-ID: <4D9432C6.3060303@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090408050708050906070307"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3576E246FA
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 09:52:41 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1Q5CgJ-0001K8-Kl
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2011 07:52:39 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1Q5CgJ-00050V-8C
	for alsa-devel@alsa-project.org; Thu, 31 Mar 2011 07:52:39 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090408050708050906070307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This quirk is needed for the docking station mic of Lenovo Thinkpad X220 
to function correctly.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090408050708050906070307
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-dock-mic-quirk-for-Lenovo-Thinkpad-X220.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Add-dock-mic-quirk-for-Lenovo-Thinkpad-X220.pa";
 filename*1="tch"

>From d861e5dbc21f8c8d229eb0354fccb2c5738fa00b Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 31 Mar 2011 09:36:19 +0200
Subject: [PATCH] ALSA: HDA: Add dock mic quirk for Lenovo Thinkpad X220

This quirk is needed for the docking station mic of
Lenovo Thinkpad X220 to function correctly.

BugLink: http://bugs.launchpad.net/bugs/746259
Cc: stable@kernel.org
Tested-by: James Ferguson <james.ferguson@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index d08cf31..69e3386 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3034,6 +3034,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21c5, "Thinkpad Edge 13", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21c6, "Thinkpad Edge 13", CXT5066_ASUS),
  	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G560", CXT5066_ASUS),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo", CXT5066_IDEAPAD), /* Fallback for Lenovos without dock mic */
 	{}
-- 
1.7.1


--------------090408050708050906070307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090408050708050906070307--
