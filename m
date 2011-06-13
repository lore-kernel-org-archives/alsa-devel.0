From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Don't use codec->control_data in bulk
	write
Date: Mon, 13 Jun 2011 18:54:19 +0100
Message-ID: <1307987659-2823-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA1492438B
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 19:54:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

In order to facilitate merging with the register map I/O replace the use
of control_data for the bulk writes with direct lookup of the client data
from the device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index fbea6c9..cca490c 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -269,12 +269,12 @@ static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int r
 	switch (codec->control_type) {
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 	case SND_SOC_I2C:
-		ret = i2c_master_send(codec->control_data, data, len);
+		ret = i2c_master_send(to_i2c_client(codec->dev), data, len);
 		break;
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	case SND_SOC_SPI:
-		ret = spi_write(codec->control_data, data, len);
+		ret = spi_write(to_spi_device(codec->dev), data, len);
 		break;
 #endif
 	default:
-- 
1.7.5.4
