From: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 2/3] ASoC: Intel: sst: Fallback to BYT-CR if
	IRQ 5 is missing
Date: Wed,  2 Jan 2019 20:39:06 +0100
Message-ID: <20190102193904.50123-2-stephan@gerhold.net>
References: <20190102193904.50123-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 06B27267B31
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 20:41:57 +0100 (CET)
In-Reply-To: <20190102193904.50123-1-stephan@gerhold.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Stephan Gerhold <stephan@gerhold.net>
List-Id: alsa-devel@alsa-project.org

Some devices detected as BYT-T by the PMIC-type based detection
have only a single IRQ listed in the 80860F28 ACPI device. This
causes -ENXIO later when attempting to get the IRQ at index 5.
It turns out these devices behave more like BYT-CR devices,
and using the IRQ at index 0 makes sound work correctly.

This patch adds a fallback for these devices to is_byt_cr():
If there is no IRQ resource at index 5, treating the device
as BYT-T is guaranteed to fail later, so we can safely treat
these devices as BYT-CR without breaking any working device.

Link: http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143176.html
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2: Always run pmic-based detection, apply
fallback last (if it wasn't positive).

 sound/soc/intel/atom/sst/sst_acpi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 9eaac450f864..ae17ce4677a5 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -255,8 +255,9 @@ static int is_byt(void)
 	return status;
 }
 
-static bool is_byt_cr(struct device *dev)
+static bool is_byt_cr(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int status = 0;
 
 	if (!is_byt())
@@ -285,6 +286,17 @@ static bool is_byt_cr(struct device *dev)
 	} else {
 		dev_info(dev, "IOSF_MBI not available, no BYT-CR detection\n");
 	}
+
+	if (platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL) {
+		/*
+		 * Some devices detected as BYT-T have only a single IRQ listed,
+		 * causing platform_get_irq with index 5 to return -ENXIO.
+		 * The correct IRQ in this case is at index 0, as on BYT-CR.
+		 */
+		dev_info(dev, "Falling back to Baytrail-CR platform\n");
+		return true;
+	}
+
 	return false;
 }
 
@@ -331,7 +343,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	if (is_byt_cr(dev)) {
+	if (is_byt_cr(pdev)) {
 		/* override resource info */
 		byt_rvp_platform_data.res_info = &bytcr_res_info;
 	}
-- 
2.20.1
