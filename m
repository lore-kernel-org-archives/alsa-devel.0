From: Andy Shevchenko <andy@smile.org.ua>
Subject: [PATCH] Simplify to use Acer Aspire 5315
Date: Thu, 24 Jan 2008 18:21:47 +0200
Message-ID: <20080124162147.GH1177@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CF112433C
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 17:21:49 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Simplify usage of the Acer Aspire 5315 laptop with the ALC268 based codec
sound card via add correct PCI SSID.

Signed-off-by: Andy Shevchenko <andy@smile.org.ua>

--- alsa-driver-hg20080124/alsa-kernel/pci/hda/patch_realtek.c.acer	2008-01-16 03:00:07.000000000 +0200
+++ alsa-driver-hg20080124/alsa-kernel/pci/hda/patch_realtek.c	2008-01-24 18:34:11.000000000 +0200
@@ -9896,6 +9896,7 @@ static const char *alc268_models[ALC268_
 static struct snd_pci_quirk alc268_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0126, "Acer", ALC268_ACER),
 	SND_PCI_QUIRK(0x1025, 0x0130, "Acer Extensa 5210", ALC268_ACER),
+	SND_PCI_QUIRK(0x1025, 0x0136, "Acer Aspire 5315", ALC268_ACER),
 	SND_PCI_QUIRK(0x1028, 0x0253, "Dell OEM", ALC268_DELL),
 	SND_PCI_QUIRK(0x103c, 0x30cc, "TOSHIBA", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x1043, 0x1205, "ASUS W7J", ALC268_3ST),

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
