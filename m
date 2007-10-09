From: Tim Gardner <tim.gardner@canonical.com>
Subject: Add quirk support for Dell XPS1330 and Inspiron 1420.
Date: Tue, 09 Oct 2007 11:55:14 -0600
Message-ID: <470BC082.1050900@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080009030006050203010104"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tpi.com (mail.tpi.com [198.107.51.143])
	by alsa0.perex.cz (Postfix) with ESMTP id B8F88243B6
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Oct 2007 19:55:23 +0200 (CEST)
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

This is a multi-part message in MIME format.
--------------080009030006050203010104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


-- 
Tim Gardner tim.gardner@ubuntu.com

--------------080009030006050203010104
Content-Type: message/rfc822;
 name="alsa.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa.eml"


>From e40402cdc1ce5dfa2e8babe949a26283707930ba Mon Sep 17 00:00:00 2001
From: Tim Gardner <tim.gardner@canonical.com>
Date: Tue, 9 Oct 2007 11:34:10 -0600
Subject: [PATCH] UBUNTU: Re-add quirk support for Dell XPS 1330 and Inspiron 1420.

Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 .../alsa-kernel/pci/hda/patch_sigmatel.c           |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/updates/alsa/alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c b/updates/alsa/alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c
index 27360d2..f714de1 100644
--- a/updates/alsa/alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c
+++ b/updates/alsa/alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c
@@ -1097,11 +1097,13 @@ static struct snd_pci_quirk stac927x_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2003, "Intel D965", STAC_D965_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2002, "Intel D965", STAC_D965_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2001, "Intel D965", STAC_D965_3ST),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f3, "Dell Inspiron 1420", STAC_D965_3ST),
 	/* Dell 3 stack systems */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01dd, "Dell Dimension E520", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01ed, "Dell     ", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f4, "Dell     ", STAC_DELL_3ST),
 	/* 965 based 5 stack systems */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0209, "Dell XPS 1330", STAC_D965_5ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2301, "Intel D965", STAC_D965_5ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2302, "Intel D965", STAC_D965_5ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2303, "Intel D965", STAC_D965_5ST),
-- 
1.5.2.5


--------------080009030006050203010104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080009030006050203010104--
