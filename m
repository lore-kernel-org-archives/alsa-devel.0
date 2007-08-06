From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA:  Add more Dell systems
Date: Mon, 06 Aug 2007 13:25:47 -0700
Message-ID: <1186431947.16153.79.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-B6Uk53H7truYC7ygArDQ"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id B3C3A103836
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Aug 2007 22:25:49 +0200 (CEST)
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


--=-B6Uk53H7truYC7ygArDQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for Dell E520 and a couple of other 965 based
systems.


Signed off by Tobin Davis <tdavis@dsl-only.net>

On a side note, I start back to work tomorrow, getting paid to do these
patches (well, sort of).

--=-B6Uk53H7truYC7ygArDQ
Content-Disposition: attachment; filename=Dell-E520.patch
Content-Type: text/x-patch; name=Dell-E520.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 58f077fecf92 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Mon Aug 06 15:37:58 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Mon Aug 06 13:21:42 2007 -0700
@@ -80,6 +81,7 @@ enum {
 	STAC_D965_REF,
 	STAC_D965_3ST,
 	STAC_D965_5ST,
+	STAC_DELL_3ST,
 	STAC_927X_MODELS
 };
 
@@ -719,16 +732,25 @@ static unsigned int d965_5st_pin_configs
 	0x40000100, 0x40000100
 };
 
+static unsigned int dell_3st_pin_configs[14] = {
+	0x02211230, 0x02a11220, 0x01a19040, 0x01114210,
+	0x01111212, 0x01116211, 0x01813050, 0x01112214,
+	0x403003fa, 0x40000100, 0x40000100, 0x404003fb,
+	0x40c003fc, 0x40000100
+};
+
 static unsigned int *stac927x_brd_tbl[STAC_927X_MODELS] = {
 	[STAC_D965_REF] = ref927x_pin_configs,
 	[STAC_D965_3ST] = d965_3st_pin_configs,
 	[STAC_D965_5ST] = d965_5st_pin_configs,
+	[STAC_DELL_3ST] = dell_3st_pin_configs,
 };
 
 static const char *stac927x_models[STAC_927X_MODELS] = {
 	[STAC_D965_REF]	= "ref",
 	[STAC_D965_3ST]	= "3stack",
 	[STAC_D965_5ST] = "5stack",
+	[STAC_DELL_3ST]	= "dell-3stack",
 };
 
 static struct snd_pci_quirk stac927x_cfg_tbl[] = {
@@ -755,6 +777,10 @@ static struct snd_pci_quirk stac927x_cfg
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2003, "Intel D965", STAC_D965_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2002, "Intel D965", STAC_D965_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2001, "Intel D965", STAC_D965_3ST),
+	/* Dell 3 stack systems */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01dd, "Dell E520", STAC_DELL_3ST),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01ed, "Dell     ", STAC_DELL_3ST),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f4, "Dell     ", STAC_DELL_3ST),
 	/* 965 based 5 stack systems */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2301, "Intel D965", STAC_D965_5ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2302, "Intel D965", STAC_D965_5ST),

--=-B6Uk53H7truYC7ygArDQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-B6Uk53H7truYC7ygArDQ--
