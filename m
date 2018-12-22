From: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/2] ASoC: Intel: sst: Fallback to BYT-CR if
	IRQ 5 is missing
Date: Sat, 22 Dec 2018 15:47:10 +0100
Message-ID: <20181222144708.121732-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.216])
 by alsa0.perex.cz (Postfix) with ESMTP id B8355267AD1
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2018 15:52:02 +0100 (CET)
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
Moved the "Detected Baytrail-CR platform" message to is_byt_cr()
so we can log a different message if the fallback is used.

Tested this on my device as-is, and simulated a "normal"
BYT-T and BYT-CR device (copied their IRQs to a custom DSDT).

 sound/soc/intel/atom/sst/sst_acpi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 3a95ebbfc45d..755a396121ff 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -255,10 +255,22 @@ static int is_byt(void)
 	return status;
 }
 
-static int is_byt_cr(struct device *dev, bool *bytcr)
+static int is_byt_cr(struct platform_device *pdev, bool *bytcr)
 {
+	struct device *dev = &pdev->dev;
 	int status = 0;
 
+	if (platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL) {
+		/*
+		 * Some devices detected as BYT-T have only a single IRQ listed,
+		 * causing platform_get_irq with index 5 to return -ENXIO.
+		 * The correct IRQ in this case is at index 0, as used on BYT-CR.
+		 */
+		dev_info(dev, "Falling back to Baytrail-CR platform\n");
+		*bytcr = true;
+		return status;
+	}
+
 	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
 		u32 bios_status;
 
@@ -278,10 +290,12 @@ static int is_byt_cr(struct device *dev, bool *bytcr)
 			/* bits 26:27 mirror PMIC options */
 			bios_status = (bios_status >> 26) & 3;
 
-			if ((bios_status == 1) || (bios_status == 3))
+			if ((bios_status == 1) || (bios_status == 3)) {
+				dev_info(dev, "Detected Baytrail-CR platform\n");
 				*bytcr = true;
-			else
+			} else {
 				dev_info(dev, "BYT-CR not detected\n");
+			}
 		}
 	} else {
 		dev_info(dev, "IOSF_MBI not enabled, no BYT-CR detection\n");
@@ -333,10 +347,8 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = is_byt_cr(dev, &bytcr);
+	ret = is_byt_cr(pdev, &bytcr);
 	if (!(ret < 0 || !bytcr)) {
-		dev_info(dev, "Detected Baytrail-CR platform\n");
-
 		/* override resource info */
 		byt_rvp_platform_data.res_info = &bytcr_res_info;
 	}
-- 
2.20.1
