From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/5] mfd: davinci_voicecodec: Provide a regmap
	for register I/O
Date: Sat, 31 Aug 2013 14:08:56 +0100
Message-ID: <1377954539-7532-2-git-send-email-broonie@kernel.org>
References: <20130831130741.GG18608@sirena.org.uk>
 <1377954539-7532-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 481A0261ABD
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 15:09:13 +0200 (CEST)
In-Reply-To: <1377954539-7532-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Miguel Aguilar <miguel.aguilar@ridgerun.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This will be used to support refactoring of the ASoC CODEC driver to use
a regmap.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mfd/davinci_voicecodec.c       | 14 ++++++++++++++
 include/linux/mfd/davinci_voicecodec.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
index a292d71..013ba81 100644
--- a/drivers/mfd/davinci_voicecodec.c
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -27,11 +27,17 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/regmap.h>
 
 #include <sound/pcm.h>
 
 #include <linux/mfd/davinci_voicecodec.h>
 
+static struct regmap_config davinci_vc_regmap = {
+	.reg_bits = 32,
+	.val_bits = 32,
+};
+
 static int __init davinci_vc_probe(struct platform_device *pdev)
 {
 	struct davinci_vc *davinci_vc;
@@ -63,6 +69,14 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
+	davinci_vc->regmap = devm_regmap_init_mmio(&pdev->dev,
+						   davinci_vc->base,
+						   &davinci_vc_regmap);
+	if (IS_ERR(davinci_vc->regmap)) {
+		ret = PTR_ERR(davinci_vc->regmap);
+		goto fail;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
diff --git a/include/linux/mfd/davinci_voicecodec.h b/include/linux/mfd/davinci_voicecodec.h
index 13a1ee9..5166935 100644
--- a/include/linux/mfd/davinci_voicecodec.h
+++ b/include/linux/mfd/davinci_voicecodec.h
@@ -30,6 +30,8 @@
 
 #include <mach/hardware.h>
 
+struct regmap;
+
 /*
  * Register values.
  */
@@ -113,6 +115,7 @@ struct davinci_vc {
 
 	/* Memory resources */
 	void __iomem *base;
+	struct regmap *regmap;
 
 	/* MFD cells */
 	struct mfd_cell cells[DAVINCI_VC_CELLS];
-- 
1.8.4.rc3
