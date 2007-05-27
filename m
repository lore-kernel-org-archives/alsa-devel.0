From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA Codec:  Add support for MSI K9N Ultra
Date: Sun, 27 May 2007 00:09:28 -0700
Message-ID: <1180249768.9034.81.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-AP0fFlnkbZjjRjHMCycs"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 823F524604
	for <alsa-devel@alsa-project.org>;
	Sun, 27 May 2007 09:09:30 +0200 (CEST)
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


--=-AP0fFlnkbZjjRjHMCycs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds the MSI K9N Ultra system to the realtek patch.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-AP0fFlnkbZjjRjHMCycs
Content-Disposition: attachment; filename=MSI-K9N.patch
Content-Type: text/x-patch; name=MSI-K9N.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 45179b325c8e pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Wed May 23 16:27:32 2007 +0200
+++ b/pci/hda/patch_realtek.c	Sun May 27 00:05:47 2007 -0700
@@ -6379,6 +6382,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x1458, 0xa002, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x6668, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7187, "MSI", ALC883_6ST_DIG),
+	SND_PCI_QUIRK(0x1462, 0x7250, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x7280, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x0579, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3ef9, "MSI", ALC883_TARGA_DIG),

--=-AP0fFlnkbZjjRjHMCycs
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-AP0fFlnkbZjjRjHMCycs--
