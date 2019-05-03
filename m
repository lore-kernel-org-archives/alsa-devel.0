From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: rt5677-spi: Rename driver to
	differentiate from main codec
Date: Fri,  3 May 2019 12:33:42 -0700
Message-ID: <20190503193342.241330-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D941F80720
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 21:34:19 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id w20so3160751plq.3
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2019 12:34:19 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

Currently the SPI driver and the main codec share the same name. This
will become confusing when looking up components when using both
drivers.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/codecs/rt5677-spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 84b6bd8b50e1..871ccb37318d 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -29,6 +29,8 @@
 
 #include "rt5677-spi.h"
 
+#define DRV_NAME "rt5677spi"
+
 #define RT5677_SPI_BURST_LEN	240
 #define RT5677_SPI_HEADER	5
 #define RT5677_SPI_FREQ		6000000
@@ -232,7 +234,7 @@ MODULE_DEVICE_TABLE(acpi, rt5677_spi_acpi_id);
 
 static struct spi_driver rt5677_spi_driver = {
 	.driver = {
-		.name = "rt5677",
+		.name = DRV_NAME,
 		.acpi_match_table = ACPI_PTR(rt5677_spi_acpi_id),
 	},
 	.probe = rt5677_spi_probe,
-- 
2.21.0.1020.gf2820cf01a-goog
