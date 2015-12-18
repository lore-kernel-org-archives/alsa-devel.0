From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98357a: Add ACPI ID for Maxim" to
	the asoc tree
Date: Fri, 18 Dec 2015 12:15:39 +0000
Message-ID: <E1a9twh-0006Bh-4P@debutante>
References: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADAAC266682
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:44 +0100 (CET)
In-Reply-To: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit Ainapure <rohit.m.ainapure@intel.com>, Fang Yang A <yang.a.fang@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98357a: Add ACPI ID for Maxim

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5c27087e4b43e2a5be144afe7250fb2b20bd47c4 Mon Sep 17 00:00:00 2001
From: Rohit Ainapure <rohit.m.ainapure@intel.com>
Date: Fri, 11 Dec 2015 11:29:06 -0800
Subject: [PATCH] ASoC: max98357a: Add ACPI ID for Maxim

Adding ACPI ID "MX98357A" for the MAXIM 98357A amp.

Signed-off-by: Rohit Ainapure <rohit.m.ainapure@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index f5e3dce2633a..5b1dfb1518fb 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -12,6 +12,7 @@
  * max98357a.c -- MAX98357A ALSA SoC Codec driver
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
@@ -123,10 +124,19 @@ static const struct of_device_id max98357a_device_id[] = {
 MODULE_DEVICE_TABLE(of, max98357a_device_id);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id max98357a_acpi_match[] = {
+	{ "MX98357A", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, max98357a_acpi_match);
+#endif
+
 static struct platform_driver max98357a_platform_driver = {
 	.driver = {
 		.name = "max98357a",
 		.of_match_table = of_match_ptr(max98357a_device_id),
+		.acpi_match_table = ACPI_PTR(max98357a_acpi_match),
 	},
 	.probe	= max98357a_platform_probe,
 	.remove = max98357a_platform_remove,
-- 
2.6.2
