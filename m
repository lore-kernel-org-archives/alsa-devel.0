From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD
	Raven Ridge
Date: Thu, 28 Jun 2018 15:28:24 +0800
Message-ID: <20180628072824.12507-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 569A326799F
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 09:28:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-kernel@vger.kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

This patch can make audio controller in AMD Raven Ridge gets runtime
suspended to D3, to save ~1W power when it's not in use.

Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1ae1850b3bfd..a9b55d65f2bd 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2535,7 +2535,8 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* AMD Raven */
 	{ PCI_DEVICE(0x1022, 0x15e3),
-	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |
+			 AZX_DCAPS_PM_RUNTIME },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x0002),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
-- 
2.17.1
