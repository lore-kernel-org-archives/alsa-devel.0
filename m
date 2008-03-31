From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH]PCI quirk for laptop LG which use CMI9880
Date: Mon, 31 Mar 2008 15:44:23 +0800
Message-ID: <1206949463.13847.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6EJYngHwkDU3yATMQGrj"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 175BB24727
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Mar 2008 09:42:25 +0200 (CEST)
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
Cc: tiwai@suse.de, zhe.jiang@intel.com
List-Id: alsa-devel@alsa-project.org


--=-6EJYngHwkDU3yATMQGrj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Please refer to [0003874] on the alsa mantis.
This patch added the pci quirk.

Thanks!

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>

--=-6EJYngHwkDU3yATMQGrj
Content-Disposition: attachment; filename=pci_quirk_for_LG_laptop_CMI9880.patch
Content-Type: text/x-patch; name=pci_quirk_for_LG_laptop_CMI9880.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-driver-hg20080323/alsa-kernel/pci/hda/patch_cmedia.c	2008-03-19 09:00:09.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_cmedia.c	2008-03-31 15:37:43.000000000 +0800
@@ -611,6 +611,7 @@ static const char *cmi9880_models[CMI_MO
 
 static struct snd_pci_quirk cmi9880_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x813d, "ASUS P5AD2", CMI_FULL_DIG),
+	SND_PCI_QUIRK(0x1854, 0x0032, "LG", CMI_FULL_DIG),
 	{} /* terminator */
 };
 

--=-6EJYngHwkDU3yATMQGrj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-6EJYngHwkDU3yATMQGrj--
