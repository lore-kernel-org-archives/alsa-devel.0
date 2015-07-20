From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Subject: [PATCH] ALSA: hda: add new AMD PCI IDs with proper
	driver caps
Date: Mon, 20 Jul 2015 19:56:18 +0530
Message-ID: <1437402378-13272-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B7C0260A59
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 15:26:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, woodrow.shen@canonical.com, stable@vger.kernel.org, Alexander.Deucher@amd.com, chih.ho@canonical.com, Murali-krishna.Vemuri@amd.com
List-Id: alsa-devel@alsa-project.org

Fixes audio problems on newer asics

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Cc: stable@vger.kernel.org
---
 sound/pci/hda/hda_intel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ca151b4..cb7e8f8 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2182,6 +2182,8 @@ static const struct pci_device_id azx_ids[] = {
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x1308),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+	{ PCI_DEVICE(0x1002, 0x157a),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0x793b),
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
 	{ PCI_DEVICE(0x1002, 0x7919),
@@ -2236,8 +2238,14 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0xaab0),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+	{ PCI_DEVICE(0x1002, 0xaac0),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0xaac8),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+	{ PCI_DEVICE(0x1002, 0xaad8),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+	{ PCI_DEVICE(0x1002, 0xaae8),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	/* VIA VT8251/VT8237A */
 	{ PCI_DEVICE(0x1106, 0x3288),
 	  .driver_data = AZX_DRIVER_VIA | AZX_DCAPS_POSFIX_VIA },
-- 
1.9.1
