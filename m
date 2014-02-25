From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: sst-acpi: Fix Oops in case of
	missing firmware
Date: Tue, 25 Feb 2014 16:37:47 +0200
Message-ID: <1393339067-10307-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F1ED52655DE
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 15:38:15 +0100 (CET)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

I swear I tested missing firmware in commit e5161d7987f1 ("ASoC: Intel:
sst-acpi: Request firmware before SST platform driver probing").

Unfortunately same wasn't done in commit 6dda27cbbd1d ("ASoC: Intel:
sst-acpi: Add support for multiple machine drivers per platform") which
will cause NULL pointer dereference in sst_acpi_fw_cb() when printing the
error since sst_acpi->mach is not set.

Fix this obvious error by setting the sst_acpi->mach in sst_acpi_probe().

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/sst-acpi.c b/sound/soc/intel/sst-acpi.c
index 0bb43169e146..5d06eecb6198 100644
--- a/sound/soc/intel/sst-acpi.c
+++ b/sound/soc/intel/sst-acpi.c
@@ -139,6 +139,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	sst_pdata = &sst_acpi->sst_pdata;
 	sst_pdata->id = desc->sst_id;
 	sst_acpi->desc = desc;
+	sst_acpi->mach = mach;
 
 	if (desc->resindex_dma_base >= 0) {
 		sst_pdata->dma_engine = desc->dma_engine;
-- 
1.8.5.3
