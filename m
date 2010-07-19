From: Jerone Young <jerone.young@canonical.com>
Subject: [PATCH] Add conexant quirk for Lenovo G series support
Date: Sun, 18 Jul 2010 20:44:08 -0500
Message-ID: <1279503848.1719.887.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 097772464E
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 03:44:11 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OafOt-000605-Bg
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 02:44:11 +0100
Received: from adsl-71-145-129-122.dsl.austtx.sbcglobal.net ([71.145.129.122]
	helo=[192.168.1.6]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <jerone.young@canonical.com>) id 1OafOt-00077Z-2A
	for alsa-devel@alsa-project.org; Mon, 19 Jul 2010 02:44:11 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch adds quirk add support for Lenovo G series laptops.

Launchpad bug can be found here:
https://bugs.launchpad.net/ubuntu/+source/linux-backports-modules-2.6.32/+bug/590756


Signed-off-by: Jerone Young <jerone.young@canonical.com>

diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
index 54f7419..c49030b 100644
--- a/pci/hda/patch_conexant.c
+++ b/pci/hda/patch_conexant.c
@@ -2999,6 +2999,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "ideapad", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G series", CXT5066_IDEAPAD),
 	{}
 };
