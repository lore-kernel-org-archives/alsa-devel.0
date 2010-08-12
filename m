From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Automatically determine control_data
	for soc-cache users
Date: Thu, 12 Aug 2010 10:59:15 +0100
Message-ID: <1281607156-12991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41F8A103815
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 11:59:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since the provision of a struct device for the CODEC is now mandatory
we can use container_of() to locate the struct i2c_client and struct
spi_device for relevant devices, removing the need to manually set it
in each driver.

A further patch will automate selection of the control type based on
the bus_type of the struct device, further reducing the amount of
driver code required.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 83cd8ed..b856177 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -584,11 +584,19 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 #endif
 		if (io_types[i].i2c_read)
 			codec->hw_read = io_types[i].i2c_read;
+
+		codec->control_data = container_of(codec->dev,
+						   struct i2c_client,
+						   dev);
 		break;
 
 	case SND_SOC_SPI:
 		if (io_types[i].spi_write)
 			codec->hw_write = io_types[i].spi_write;
+
+		codec->control_data = container_of(codec->dev,
+						   struct spi_device,
+						   dev);
 		break;
 	}
 
-- 
1.7.1
