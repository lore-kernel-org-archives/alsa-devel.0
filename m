From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/3] ALSA: hda - add PCI identifier for Intel 5
	Series/3400
Date: Fri, 21 Sep 2012 18:39:07 -0500
Message-ID: <1348270747-4083-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1348270747-4083-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 24116265DF8
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 01:39:16 +0200 (CEST)
In-Reply-To: <1348270747-4083-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Tested with LPIB delay without any issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index acd6756..b682442 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3301,6 +3301,10 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	{ PCI_DEVICE(0x8086, 0x0c0c),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
 	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY },
+	/* 5 Series/3400 */
+	{ PCI_DEVICE(0x8086, 0x3b56),
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY },
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-- 
1.7.9.5
