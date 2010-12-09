From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Quirk for Dell Vostro 320 to make
	microphone work
Date: Thu, 09 Dec 2010 07:36:58 +0100
Message-ID: <4D00790A.4000701@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070307010403030000030409"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E52F51037EC
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 07:36:59 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1PQa7f-0006mJ-5G
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 06:36:59 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1PQa7f-0002eq-28
	for alsa-devel@alsa-project.org; Thu, 09 Dec 2010 06:36:59 +0000
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
--------------070307010403030000030409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BugLink: http://launchpad.net/497546

Confirmed that the ideapad model works better than the current
quirk for Dell Vostro 320.

With this patch, there is noone left using the DELL_LAPTOP model, should 
we remove it completely?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------070307010403030000030409
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Quirk-for-Dell-Vostro-320-to-make-microphon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Quirk-for-Dell-Vostro-320-to-make-microphon.pa";
 filename*1="tch"

>From a4c20fbb1657680d8d68b12f373d1af6d8e1576b Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 9 Dec 2010 07:17:27 +0100
Subject: [PATCH] ALSA: HDA: Quirk for Dell Vostro 320 to make microphone work

BugLink: http://launchpad.net/497546

Confirmed that the ideapad model works better than the current
quirk for Dell Vostro 320.

Cc: stable@kernel.org (2.6.35+)
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 46bbf14..ee9c3ed 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3097,8 +3097,7 @@ static const char *cxt5066_models[CXT5066_MODELS] = {
 static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK_MASK(0x1025, 0xff00, 0x0400, "Acer", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1028, 0x02d8, "Dell Vostro", CXT5066_DELL_VOSTRO),
-	SND_PCI_QUIRK(0x1028, 0x02f5, "Dell",
-		      CXT5066_DELL_LAPTOP),
+	SND_PCI_QUIRK(0x1028, 0x02f5, "Dell Vostro 320", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x103c, 0x360b, "HP G60", CXT5066_HP_LAPTOP),
-- 
1.7.1


--------------070307010403030000030409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070307010403030000030409--
