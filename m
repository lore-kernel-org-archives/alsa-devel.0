From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 5/5] ASoC: SOF: Force polling mode on CFL and
	CNL
Date: Mon, 27 May 2019 00:58:36 +0800
Message-ID: <20190526165836.10867-5-yung-chuan.liao@linux.intel.com>
References: <20190526165836.10867-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 624A9F896F7
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2019 06:57:34 +0200 (CEST)
In-Reply-To: <20190526165836.10867-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, tiwai@suse.de
Cc: liam.r.girdwood@linux.intel.com, libin.yang@intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

There is a workaround in legacy HDA codec for too long time respone
with CFL machine. We need the same workaround on SOF driver. The same
issue is also seen on CNL machine.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 5c78f4dde6f5..b9f3c802924b 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -32,6 +32,9 @@
 /* platform specific devices */
 #include "shim.h"
 
+#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
+#define IS_CNL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9dc8)
+
 /*
  * Debug
  */
@@ -217,6 +220,11 @@ static int hda_init(struct snd_sof_dev *sdev)
 	ext_ops = snd_soc_hdac_hda_get_ops();
 #endif
 	sof_hda_bus_init(bus, &pci->dev, ext_ops);
+
+	/* Workaround for a communication error on CFL (bko#199007) and CNL */
+	if (IS_CFL(pci) || IS_CNL(pci))
+		bus->polling_mode = 1;
+
 	bus->use_posbuf = 1;
 	bus->bdl_pos_adj = 0;
 
-- 
2.17.1
