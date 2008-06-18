From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Added model selection for iMac 24"
Date: Thu, 19 Jun 2008 03:29:49 +1000
Message-ID: <1213810189.7775.1.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-089.dial.usertools.net
	[202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 227EC244B3
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 19:29:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Changelog: Added the SSID of a known iMac 24" to automatically use
ALC885_IMAC24 quirk.

--- a/pci/hda/patch_realtek.c
+++ b/pci/hda/patch_realtek.c
@@ -6196,6 +6196,7 @@ static struct snd_pci_quirk alc882_cfg_tbl[] = {
        SND_PCI_QUIRK(0x1462, 0x28fb, "Targa T8", ALC882_TARGA), /*
MSI-1049 T8  */
        SND_PCI_QUIRK(0x1462, 0x6668, "MSI", ALC882_6ST_DIG),
        SND_PCI_QUIRK(0x161f, 0x2054, "Arima W820", ALC882_ARIMA),
+       SND_PCI_QUIRK(0x106b, 0x00a0, "Apple iMac 24''", ALC885_IMAC24),
        {}
 };


Signed-off-by: Travis Place <wishie@wishie.net>
