From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/4] ALSA: oxygen: add XIO2001 initialization
Date: Fri, 16 Jan 2015 22:15:43 +0100
Message-ID: <54B97F7F.6010409@ladisch.de>
References: <54B97EEB.8060108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 06E83265556
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 22:16:33 +0100 (CET)
In-Reply-To: <54B97EEB.8060108@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Configure the XIO2001 bridge on PCI Express cards so that it does less
needless prefetching.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/oxygen/oxygen_lib.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index ab47c1c..ffff3b2 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -319,11 +319,12 @@ static void oxygen_restore_eeprom(struct oxygen *chip,

 static void configure_pcie_bridge(struct pci_dev *pci)
 {
-	enum { PEX811X, PI7C9X110 };
+	enum { PEX811X, PI7C9X110, XIO2001 };
 	static const struct pci_device_id bridge_ids[] = {
 		{ PCI_VDEVICE(PLX, 0x8111), .driver_data = PEX811X },
 		{ PCI_VDEVICE(PLX, 0x8112), .driver_data = PEX811X },
 		{ PCI_DEVICE(0x12d8, 0xe110), .driver_data = PI7C9X110 },
+		{ PCI_VDEVICE(TI, 0x8240), .driver_data = XIO2001 },
 		{ }
 	};
 	struct pci_dev *bridge;
@@ -357,6 +358,14 @@ static void configure_pcie_bridge(struct pci_dev *pci)
 		tmp |= 1;	/* park the PCI arbiter to the sound chip */
 		pci_write_config_dword(bridge, 0x40, tmp);
 		break;
+
+	case XIO2001: /* Texas Instruments XIO2001 PCIe/PCI bridge */
+		pci_read_config_dword(bridge, 0xe8, &tmp);
+		tmp &= ~0xf;	/* request length limit: 64 bytes */
+		tmp &= ~(0xf << 8);
+		tmp |= 1 << 8;	/* request count limit: one buffer */
+		pci_write_config_dword(bridge, 0xe8, tmp);
+		break;
 	}
 }
