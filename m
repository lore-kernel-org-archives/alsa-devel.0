From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677-spi: Add ACPI ID
Date: Thu, 28 Mar 2019 10:27:00 +0800
Message-ID: <20190328022700.14344-1-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DBBEF801D8
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 03:27:20 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, cujomalainey@google.com, albertchen@realtek.com, derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add the ACPI ID for the product "chromebook pixel 2015" to match the 
coreboot settings.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
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
2.21.0
