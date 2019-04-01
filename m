From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677-spi: Add ACPI ID" to the asoc
	tree
Date: Mon,  1 Apr 2019 09:53:20 +0100 (BST)
Message-ID: <20190401085320.6D2F5440082@finisterre.ee.mobilebroadband>
References: <20190328022700.14344-1-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42A8FF89739
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 10:53:25 +0200 (CEST)
In-Reply-To: <20190328022700.14344-1-oder_chiou@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, cujomalainey@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677-spi: Add ACPI ID

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

>From 2b070f6739025ecbf2ccb55daf9e19d3fb343c7e Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Thu, 28 Mar 2019 10:27:00 +0800
Subject: [PATCH] ASoC: rt5677-spi: Add ACPI ID

Add the ACPI ID for the product "chromebook pixel 2015" to match the
coreboot settings.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677-spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 84501c2020c7..167a02773a0b 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -25,6 +25,7 @@
 #include <linux/sysfs.h>
 #include <linux/clk.h>
 #include <linux/firmware.h>
+#include <linux/acpi.h>
 
 #include "rt5677-spi.h"
 
@@ -226,9 +227,16 @@ static int rt5677_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct acpi_device_id rt5677_spi_acpi_id[] = {
+	{ "RT5677AA", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rt5677_spi_acpi_id);
+
 static struct spi_driver rt5677_spi_driver = {
 	.driver = {
 		.name = "rt5677",
+		.acpi_match_table = ACPI_PTR(rt5677_spi_acpi_id),
 	},
 	.probe = rt5677_spi_probe,
 };
-- 
2.20.1
