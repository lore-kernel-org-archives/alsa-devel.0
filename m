From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Fallback to BYT-CR if IRQ 5
	is missing" to the asoc tree
Date: Mon,  7 Jan 2019 12:30:37 +0000 (GMT)
Message-ID: <20190107123037.5CFCD1127490@debutante.sirena.org.uk>
References: <20190102193904.50123-2-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 476E7267BA2
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:30:38 +0100 (CET)
In-Reply-To: <20190102193904.50123-2-stephan@gerhold.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephan Gerhold <stephan@gerhold.net>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: Fallback to BYT-CR if IRQ 5 is missing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fee15714552dbf420264da6f88dd813b8502592b Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Wed, 2 Jan 2019 20:39:06 +0100
Subject: [PATCH] ASoC: Intel: sst: Fallback to BYT-CR if IRQ 5 is missing

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
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
