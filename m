From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH] ALSA: hda - Add DeviceID for Haswell HDA
Date: Wed, 13 Jun 2012 10:23:51 +0800
Message-ID: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 14CAC104404
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 04:28:17 +0200 (CEST)
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
Cc: tiwai@suse.de, fengguang.wu@intel.com, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

this patch add proper id for Haswell HDA Controller.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_intel.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2b6392b..f530c40 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -151,6 +151,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},"
 			 "{Intel, CPT},"
 			 "{Intel, PPT},"
 			 "{Intel, LPT},"
+			 "{Intel, HPT},"
 			 "{Intel, PBG},"
 			 "{Intel, SCH},"
 			 "{ATI, SB450},"
@@ -3253,6 +3254,10 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	{ PCI_DEVICE(0x8086, 0x8c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
 	  AZX_DCAPS_BUFSIZE},
+	/* Haswell */
+	{ PCI_DEVICE(0x8086, 0x0c0c),
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
+	  AZX_DCAPS_BUFSIZE},
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-- 
1.7.9.5
