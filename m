From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH RFC 2/7] ASoC: tlv320aic26: Fix module autoload
Date: Fri, 18 Sep 2015 16:11:11 -0400
Message-ID: <1442607076-26681-3-git-send-email-jcormier@criticallink.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id DF4F1265DFD
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 22:12:32 +0200 (CEST)
Received: by qkap81 with SMTP id p81so24175017qka.2
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 13:12:32 -0700 (PDT)
In-Reply-To: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: "Cormier, Jonathan" <jcormier@criticallink.com>, alsa-devel@alsa-project.org, Bob Duke <bduke@criticallink.com>, Mark Brown <broonie@linaro.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Add the missing MODULE_DEVICE_TABLE() for OF and SPI to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519
https://lkml.org/lkml/2014/9/11/458

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 91fdd96648bd..91347727cfae 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -370,11 +370,18 @@ static int aic26_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id tlv320aic26_id_table[] = {
+	{ "tlv320aic26" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, tlv320aic26_id_table);
+
 #if defined(CONFIG_OF)
 static const struct of_device_id tlv320aic26_of_match[] = {
 	{ .compatible = "ti,tlv320aic26", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, tlv320aic26_of_match);
 #endif
 
 static struct spi_driver aic26_spi = {
@@ -387,6 +394,7 @@ static struct spi_driver aic26_spi = {
 	},
 	.probe = aic26_spi_probe,
 	.remove = aic26_spi_remove,
+	.id_table = tlv320aic26_id_table,
 };
 
 module_spi_driver(aic26_spi);
-- 
1.9.1
