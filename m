From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH]Device ID for Toshiba laptop which uses AD1986A
Date: Thu, 20 Dec 2007 09:44:14 +0800
Message-ID: <1198115054.22122.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id B5AD624692
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 02:48:21 +0100 (CET)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

Please refer to the [0003662].
The model laptop-eapd get rid of the high-pitched noise.

Signed-Off-by: Jiang Zhe <zhe.jiang@intel.com>
--- alsa-driver-hg20071219/alsa-kernel/pci/hda/patch_analog.c	2007-12-20
09:40:37.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_analog.c	2007-12-20 09:23:05.000000000
+0800
@@ -859,6 +859,7 @@ static struct snd_pci_quirk ad1986a_cfg_
 	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_LAPTOP_AUTOMUTE),
 	SND_PCI_QUIRK(0x17c0, 0x2017, "Samsung M50", AD1986A_LAPTOP),
+	SND_PCI_QUIRK(0x1179, 0xff40, "Toshiba", AD1986A_LAPTOP_EAPD),
 	{}
 };
