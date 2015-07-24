From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm4567: Added ACPI entry for SSM4567
	codec" to the asoc tree
Date: Fri, 24 Jul 2015 12:31:13 +0100
Message-ID: <E1ZIbC5-00032d-G2@debutante>
References: <1437678714-5911-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C79D2605A2
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 13:31:26 +0200 (CEST)
In-Reply-To: <1437678714-5911-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>, M Naveen <naveen.m@intel.com>, M R Sathya Prakash <sathya.prakash.m.r@intel.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm4567: Added ACPI entry for SSM4567 codec

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

>From eeffd4b442eb2aa25257d8c6631b17cba685ccac Mon Sep 17 00:00:00 2001
From: Harsha Priya <harshapriya.n@intel.com>
Date: Thu, 23 Jul 2015 19:11:54 +0000
Subject: [PATCH] ASoC: ssm4567: Added ACPI entry for SSM4567 codec

Added INT343B ACPI ID for the SSM4567 codec

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: M Naveen <naveen.m@intel.com>
Signed-off-by: M R Sathya Prakash <sathya.prakash.m.r@intel.com>
Acked-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm4567.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 938d2cb6d78b..af536ae75df9 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -10,6 +10,7 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
@@ -450,10 +451,21 @@ static const struct i2c_device_id ssm4567_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ssm4567_i2c_ids);
 
+#ifdef CONFIG_ACPI
+
+static const struct acpi_device_id ssm4567_acpi_match[] = {
+	{ "INT343B", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, ssm4567_acpi_match);
+
+#endif
+
 static struct i2c_driver ssm4567_driver = {
 	.driver = {
 		.name = "ssm4567",
 		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(ssm4567_acpi_match),
 	},
 	.probe = ssm4567_i2c_probe,
 	.remove = ssm4567_i2c_remove,
-- 
2.1.4
