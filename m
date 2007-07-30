From: Tobin Davis <tdavis@dsl-only.net>
Subject: Patch: HDA-Codec: Add support for the ASRock
	K8NF6G-VSTA	motherboard.
Date: Mon, 30 Jul 2007 10:36:40 -0700
Message-ID: <1185817000.21191.48.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WCF9q7k8RE6P+sv3zPUq"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id CF7441038BA
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jul 2007 19:36:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-WCF9q7k8RE6P+sv3zPUq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds ALC861VD support for the ASRock K8NF6G-VSTA motherboard.

Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-WCF9q7k8RE6P+sv3zPUq
Content-Disposition: attachment; filename=ASRock.patch
Content-Type: text/x-patch; name=ASRock.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 7077ed777d22 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon Jul 30 15:40:43 2007 +0200
+++ b/pci/hda/patch_realtek.c	Mon Jul 30 10:31:09 2007 -0700
@@ -10336,6 +10336,7 @@ static struct snd_pci_quirk alc861vd_cfg
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo 3000 C200", ALC861VD_LENOVO),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo", ALC861VD_LENOVO),
 	SND_PCI_QUIRK(0x1179, 0xff00, "Toshiba A135", ALC861VD_LENOVO),
+	SND_PCI_QUIRK(0x1849, 0x0862, "ASRock K8NF6G-VSTA", ALC861VD_6ST_DIG),
 	{}
 };
 

--=-WCF9q7k8RE6P+sv3zPUq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-WCF9q7k8RE6P+sv3zPUq--
