From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: add acpi match ID" to the asoc
	tree
Date: Fri, 09 Oct 2015 12:21:38 +0100
Message-ID: <E1ZkVk2-0006dR-D7@finisterre>
References: <1444253637-65908-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5731526516B
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 13:21:49 +0200 (CEST)
In-Reply-To: <1444253637-65908-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fang Yang A <yang.a.fang@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: add acpi match ID

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

>From b3681308cc7162fb08249589b5bb1b2d42e00f4b Mon Sep 17 00:00:00 2001
From: "Fang, Yang A" <yang.a.fang@intel.com>
Date: Wed, 7 Oct 2015 14:33:57 -0700
Subject: [PATCH] ASoC: nau8825: add acpi match ID

This patch adds the acpi match ID for nau8825 codec

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index c44a7a1..5c1badf 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -16,6 +16,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/acpi.h>
 
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -1090,10 +1091,19 @@ static const struct of_device_id nau8825_of_ids[] = {
 MODULE_DEVICE_TABLE(of, nau8825_of_ids);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id nau8825_acpi_match[] = {
+	{ "10508825", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, nau8825_acpi_match);
+#endif
+
 static struct i2c_driver nau8825_driver = {
 	.driver = {
 		.name = "nau8825",
 		.of_match_table = of_match_ptr(nau8825_of_ids),
+		.acpi_match_table = ACPI_PTR(nau8825_acpi_match),
 	},
 	.probe = nau8825_i2c_probe,
 	.remove = nau8825_i2c_remove,
-- 
2.5.0
