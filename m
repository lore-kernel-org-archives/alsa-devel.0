From: Jerone Young <jerone.young@canonical.com>
Subject: [PATCH] Add conexant quirk for AMD based Lenovo G
	series machines
Date: Mon, 19 Jul 2010 08:30:58 -0500
Message-ID: <1279546258.1719.1636.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 99543103889
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 15:31:03 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OaqQu-00051h-Vh
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 14:31:01 +0100
Received: from adsl-71-145-145-48.dsl.austtx.sbcglobal.net ([71.145.145.48]
	helo=[192.168.1.6]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <jerone.young@canonical.com>) id 1OaqQu-0002al-Kn
	for alsa-devel@alsa-project.org; Mon, 19 Jul 2010 14:31:00 +0100
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

This is a follow on patch adds support for AMD based Lenovo G series
machines, such as the Lenovo G555.

Signed-off-by: Jerone Young <jerone.young@canonical.com>

diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
index c49030b..774edb9 100644
--- a/pci/hda/patch_conexant.c
+++ b/pci/hda/patch_conexant.c
@@ -3000,6 +3000,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "ideapad", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G series", CXT5066_IDEAPAD),
+	SND_PCI_QUIRK(0x17aa, 0x3938, "Lenovo G series (AMD)", CXT5066_IDEAPAD),
 	{}
 };
