From: mengdong.lin@intel.com
Subject: [PATCH 1/3] ALSA: hda - add device ID for Broadwell
	display audio controller
Date: Wed,  8 Jan 2014 15:55:14 -0500
Message-ID: <778f51fa9db246dcc5161a15ac943b1ad8db84f0.1389214150.git.mengdong.lin@intel.com>
References: <cover.1389214150.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BA1E12651FE
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 04:50:52 +0100 (CET)
In-Reply-To: <cover.1389214150.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch adds the device ID for Intel Broadwell display HD-Audio controller,
and applies Haswell properties to this device.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 53937de..fa2879a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -4009,6 +4009,9 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
 	{ PCI_DEVICE(0x8086, 0x0d0c),
 	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
+	/* Broadwell */
+	{ PCI_DEVICE(0x8086, 0x160c),
+	  .driver_data = AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL },
 	/* 5 Series/3400 */
 	{ PCI_DEVICE(0x8086, 0x3b56),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
-- 
1.8.1.2
