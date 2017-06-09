From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] ASoC: Intel: bdw-rt5677: Switch to
	devm_acpi_dev_add_driver_gpios()
Date: Fri,  9 Jun 2017 23:49:54 +0300
Message-ID: <20170609204954.40310-3-andriy.shevchenko@linux.intel.com>
References: <20170609204954.40310-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C229F2676D7
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 22:49:59 +0200 (CEST)
In-Reply-To: <20170609204954.40310-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, John Keeping <john@metanate.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Switch to use managed variant of acpi_dev_add_driver_gpios() to simplify
error path and fix potentially wrong assingment if ->probe() fails.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index e3aa32c2546b..dc8d18837109 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -347,8 +347,7 @@ static int bdw_rt5677_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
-			bdw_rt5677_gpios);
+	ret = devm_acpi_dev_add_driver_gpios(&pdev->dev, bdw_rt5677_gpios);
 	if (ret)
 		dev_warn(&pdev->dev, "Failed to add driver gpios\n");
 
-- 
2.11.0
