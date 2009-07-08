From: Andiry Brienza <andiry.xu@amd.com>
Subject: [PATCH]HDA: Disable AMD SB600 64bit address support
	only
Date: Wed, 8 Jul 2009 13:55:31 +0800
Message-ID: <1247032531.3802.14.camel@brienza-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SG2EHSOBE002.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) by alsa0.perex.cz (Postfix) with ESMTP id C3B8D10381A
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 07:55:59 +0200 (CEST)
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
Cc: tiwai@suse.de, libin.yang@amd.com, shane.huang@amd.com
List-Id: alsa-devel@alsa-project.org

HDA driver disabled HD audio 64bit address support for all AMD SB600/SB700/SB800
platforms with commit 09240cf429505891d6123ce14a29f58f2a60121e due to one SB600
issue reported by community, but we do not see the similar issue on SB700/SB800
platforms. This patch is to refine the workaround for SB600 only.

Signed-off-by: Andiry Xu <andiry.xu@amd.com>

diff -ruN a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
--- a/sound/pci/hda/hda_intel.c	2009-07-01 17:14:23.000000000 +0800
+++ b/sound/pci/hda/hda_intel.c	2009-07-08 10:24:35.000000000 +0800
@@ -2322,9 +2322,19 @@
 	gcap = azx_readw(chip, GCAP);
 	snd_printdd(SFX "chipset global capabilities = 0x%x\n", gcap);
 
-	/* ATI chips seems buggy about 64bit DMA addresses */
-	if (chip->driver_type == AZX_DRIVER_ATI)
-		gcap &= ~ICH6_GCAP_64OK;
+	/* disable SB600 64bit support for safety */
+	if ((chip->driver_type == AZX_DRIVER_ATI) ||
+	    (chip->driver_type == AZX_DRIVER_ATIHDMI)) {
+		struct pci_dev *p_smbus;
+		p_smbus = pci_get_device(PCI_VENDOR_ID_ATI,
+					 PCI_DEVICE_ID_ATI_SBX00_SMBUS,
+					 NULL);
+		if (p_smbus) {
+			if (p_smbus->revision < 0x30)
+				gcap &= ~ICH6_GCAP_64OK;
+			pci_dev_put(p_smbus);
+		}
+	}
 
 	/* allow 64bit DMA address if supported by H/W */
 	if ((gcap & ICH6_GCAP_64OK) && !pci_set_dma_mask(pci, DMA_BIT_MASK(64)))
