From: Jerone Young <jerone.young@canonical.com>
Subject: [PATCH] Add support for Lenovo S10-3t
Date: Fri, 20 Aug 2010 16:16:02 -0500
Message-ID: <1282338962.1630.130.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 25082244AD
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 23:16:09 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OmYwY-0007LS-7j
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 22:16:06 +0100
Received: from rrcs-24-227-244-55.sw.biz.rr.com ([24.227.244.55]
	helo=[192.168.1.230]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <jerone.young@canonical.com>) id 1OmYwX-0000gl-SB
	for alsa-devel@alsa-project.org; Fri, 20 Aug 2010 22:16:06 +0100
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

This patch adds quirk for the Lenovo S10-3t so the headphone &
microphone jacks will now work.

Signed-off-by: Jerone Young <jerone.young@canonical.com>

diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
index c424952..6bee4fc 100644
--- a/pci/hda/patch_conexant.c
+++ b/pci/hda/patch_conexant.c
@@ -3061,6 +3061,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
  	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G series", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3938, "Lenovo G series (AMD)", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "ideapad", CXT5066_IDEAPAD),
+	SND_PCI_QUIRK(0x17aa, 0x390a, "Lenovo S10-3t", CXT5066_IDEAPAD),
 	{}
 };
