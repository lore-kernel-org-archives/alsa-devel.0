From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH 1/2] ASoC: dmic: Enable ACPI device entry
Date: Tue,  2 Oct 2018 11:27:30 +0530
Message-ID: <1538459851-17066-2-git-send-email-jenny.tc@intel.com>
References: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 828C9267844
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 08:04:15 +0200 (CEST)
In-Reply-To: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harsha Priya <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

Enable ACPI device probing for dmic so that DMIC parameters can be passed
from ACPI.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/codecs/dmic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 8c4926d..ab1aa01 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
@@ -144,15 +145,26 @@ static int dmic_dev_probe(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:dmic-codec");
 
+#ifdef CONFIG_OF
 static const struct of_device_id dmic_dev_match[] = {
 	{.compatible = "dmic-codec"},
 	{}
 };
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id dmic_acpi_match[] = {
+	{ "DMIC", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, dmic_acpi_match);
+#endif
 
 static struct platform_driver dmic_driver = {
 	.driver = {
 		.name = "dmic-codec",
 		.of_match_table = dmic_dev_match,
+		.acpi_match_table = ACPI_PTR(dmic_acpi_match),
 	},
 	.probe = dmic_dev_probe,
 };
-- 
1.9.1
