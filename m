From: Daniel Gomez <dagmcr@gmail.com>
Subject: [PATCH] spi: AD ASoC: declare missing of table
Date: Mon, 22 Apr 2019 21:12:33 +0200
Message-ID: <1555960353-8836-1-git-send-email-dagmcr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0ACF8F80730
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2019 21:13:15 +0200 (CEST)
Received: by mail-lf1-x143.google.com with SMTP id h5so9783034lfm.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2019 12:13:15 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, javier@dowhile0.org, tiwai@suse.com, dagmcr@gmail.com
List-Id: alsa-devel@alsa-project.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo sound/soc/codecs/snd-soc-adau1977-spi.ko | grep alias
alias:          spi:adau1979
alias:          spi:adau1978
alias:          spi:adau1977

After this patch:
modinfo sound/soc/codecs/snd-soc-adau1977-spi.ko | grep alias
alias:          of:N*T*Cadi,adau1979C*
alias:          of:N*T*Cadi,adau1979
alias:          of:N*T*Cadi,adau1978C*
alias:          of:N*T*Cadi,adau1978
alias:          of:N*T*Cadi,adau1977C*
alias:          of:N*T*Cadi,adau1977
alias:          spi:adau1979
alias:          spi:adau1978
alias:          spi:adau1977

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 sound/soc/codecs/adau1977-spi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/adau1977-spi.c b/sound/soc/codecs/adau1977-spi.c
index 84ffbde..2baf615 100644
--- a/sound/soc/codecs/adau1977-spi.c
+++ b/sound/soc/codecs/adau1977-spi.c
@@ -10,6 +10,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <sound/soc.h>
 
@@ -54,9 +56,18 @@ static const struct spi_device_id adau1977_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, adau1977_spi_ids);
 
+static const struct of_device_id adau1977_spi_of_match[] = {
+        { .compatible = "adi,adau1977" },
+        { .compatible = "adi,adau1978" },
+        { .compatible = "adi,adau1979" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, adau1977_spi_of_match);
+
 static struct spi_driver adau1977_spi_driver = {
 	.driver = {
 		.name = "adau1977",
+		.of_match_table = of_match_ptr(adau1977_spi_of_match),
 	},
 	.probe = adau1977_spi_probe,
 	.id_table = adau1977_spi_ids,
-- 
2.7.4
