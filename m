From: han.lu@intel.com
Subject: [PATCH 1/2] ALSA: hda - add PCI IDs for Intel Broxton
Date: Thu, 19 Nov 2015 23:25:12 +0800
Message-ID: <2fcf4a795a07bedc42bdd893494299e36e89a6a7.1447945222.git.han.lu@intel.com>
References: <cover.1447945222.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 73D332614C1
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 16:25:53 +0100 (CET)
In-Reply-To: <cover.1447945222.git.han.lu@intel.com>
In-Reply-To: <cover.1447945222.git.han.lu@intel.com>
References: <cover.1447945222.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, libin.yang@linux.intel.com, mengdong.lin@linux.intel.com, han.lu@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add HD Audio Device PCI ID for the Intel Broxton platform.
It is an HDA Intel PCH controller.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8a7fbdc..963f824 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -312,6 +312,10 @@ enum {
 	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_SEPARATE_STREAM_TAG |\
 	 AZX_DCAPS_I915_POWERWELL)
 
+#define AZX_DCAPS_INTEL_BROXTON \
+	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_SEPARATE_STREAM_TAG |\
+	 AZX_DCAPS_I915_POWERWELL)
+
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
 	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB |\
@@ -2124,6 +2128,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
+	/* Broxton-P(Apollolake) */
+	{ PCI_DEVICE(0x8086, 0x5a98),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BROXTON },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
-- 
2.5.0
