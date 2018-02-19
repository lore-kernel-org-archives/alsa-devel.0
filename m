From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ADAU7002: Adding ACPI id" to the asoc
	tree
Date: Mon, 19 Feb 2018 16:57:16 +0000
Message-ID: <E1enoke-0002Dy-HI@debutante>
References: <1518766875-15164-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63451266E78
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 17:57:20 +0100 (CET)
In-Reply-To: <1518766875-15164-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ADAU7002: Adding ACPI id

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

>From ba7a3a971d2726affba6335496b5452a6e288e61 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Fri, 16 Feb 2018 13:11:12 +0530
Subject: [PATCH] ASoC: ADAU7002: Adding ACPI id

Adding ACPI entry id for probing the driver.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau7002.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/adau7002.c b/sound/soc/codecs/adau7002.c
index 49475e36a4e4..fdff86878287 100644
--- a/sound/soc/codecs/adau7002.c
+++ b/sound/soc/codecs/adau7002.c
@@ -7,6 +7,7 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -69,10 +70,19 @@ static const struct of_device_id adau7002_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, adau7002_dt_ids);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id adau7002_acpi_match[] = {
+	{ "ADAU7002", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, adau7002_acpi_match);
+#endif
+
 static struct platform_driver adau7002_driver = {
 	.driver = {
 		.name = "adau7002",
 		.of_match_table	= of_match_ptr(adau7002_dt_ids),
+		.acpi_match_table = ACPI_PTR(adau7002_acpi_match),
 	},
 	.probe = adau7002_probe,
 	.remove = adau7002_remove,
-- 
2.16.1
