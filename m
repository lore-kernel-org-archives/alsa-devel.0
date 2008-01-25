From: Andy Shevchenko <andy@smile.org.ua>
Subject: [PATCH] Add model for Acer Aspire 5310
Date: Fri, 25 Jan 2008 12:48:29 +0200
Message-ID: <20080125104829.GK1177@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C3E8A24833
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 11:48:31 +0100 (CET)
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

Simplify usage of the Acer Aspire 5310 laptop with the ALC268 based codec
sound card via add correct PCI SSID.

Signed-off-by: Andy Shevchenko <andy@smile.org.ua>

--- alsa-driver-hg20080125/alsa-kernel/pci/hda/patch_realtek.c.acer5310	2008-01-25 03:00:07.000000000 +0200
+++ alsa-driver-hg20080125/alsa-kernel/pci/hda/patch_realtek.c	2008-01-25 13:05:39.000000000 +0200
@@ -9925,6 +9925,7 @@ static const char *alc268_models[ALC268_
 
 static struct snd_pci_quirk alc268_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0126, "Acer", ALC268_ACER),
+	SND_PCI_QUIRK(0x1025, 0x012e, "Acer Aspire 5310", ALC268_ACER),
 	SND_PCI_QUIRK(0x1025, 0x0130, "Acer Extensa 5210", ALC268_ACER),
 	SND_PCI_QUIRK(0x1025, 0x0136, "Acer Aspire 5315", ALC268_ACER),
 	SND_PCI_QUIRK(0x1028, 0x0253, "Dell OEM", ALC268_DELL),


P.S. Sorry for separate patch. I've been noticed today about this one.

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
