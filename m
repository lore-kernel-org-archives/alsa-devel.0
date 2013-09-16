From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: ak4104: provide a module device table
Date: Mon, 16 Sep 2013 18:14:20 +0200
Message-ID: <1379348060-20556-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id B3694264F1A
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 18:14:28 +0200 (CEST)
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
Cc: broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Provide a module device table for the SPI subsystem, so the driver can
be autoloaded by the SPI core.

While at it, get rid of an unnecessary #define.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/ak4104.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 71059c0..b4819dc 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -45,8 +45,6 @@
 #define AK4104_TX_TXE			(1 << 0)
 #define AK4104_TX_V			(1 << 1)
 
-#define DRV_NAME "ak4104-codec"
-
 struct ak4104_private {
 	struct regmap *regmap;
 };
@@ -291,12 +289,19 @@ static const struct of_device_id ak4104_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ak4104_of_match);
 
+static const struct spi_device_id ak4104_id_table[] = {
+	{ "ak4104", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ak4104_id_table);
+
 static struct spi_driver ak4104_spi_driver = {
 	.driver  = {
-		.name   = DRV_NAME,
+		.name   = "ak4104",
 		.owner  = THIS_MODULE,
 		.of_match_table = ak4104_of_match,
 	},
+	.id_table = ak4104_id_table,
 	.probe  = ak4104_spi_probe,
 	.remove = ak4104_spi_remove,
 };
-- 
1.8.3.1
