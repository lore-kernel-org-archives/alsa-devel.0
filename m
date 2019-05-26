From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 2/5] ALSA: hda: assign polling_mode after
	azx_bus_init
Date: Mon, 27 May 2019 00:58:33 +0800
Message-ID: <20190526165836.10867-2-yung-chuan.liao@linux.intel.com>
References: <20190526165836.10867-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE006F8072E
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2019 06:57:30 +0200 (CEST)
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

We will move the polling_mode flag from struct azx to struct hdac_bus,
and the flag should be assigned after bus init.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a93468ffb85c..a3c190f2e17a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1701,10 +1701,6 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	else
 		chip->bdl_pos_adj = bdl_pos_adj[dev];
 
-	/* Workaround for a communication error on CFL (bko#199007) and CNL */
-	if (IS_CFL(pci) || IS_CNL(pci))
-		chip->polling_mode = 1;
-
 	err = azx_bus_init(chip, model[dev], &pci_hda_io_ops);
 	if (err < 0) {
 		kfree(hda);
@@ -1712,6 +1708,10 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 		return err;
 	}
 
+	/* Workaround for a communication error on CFL (bko#199007) and CNL */
+	if (IS_CFL(pci) || IS_CNL(pci))
+		chip->polling_mode = 1;
+
 	if (chip->driver_type == AZX_DRIVER_NVIDIA) {
 		dev_dbg(chip->card->dev, "Enable delay in RIRB handling\n");
 		chip->bus.needs_damn_long_delay = 1;
-- 
2.17.1
