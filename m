From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Constify i2c_device_id table
Date: Fri, 04 Mar 2011 15:22:03 +0800
Message-ID: <1299223323.20907.4.camel@mola>
References: <1299223098.20907.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299223098.20907.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <subaparts@yandex.ru>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |    2 +-
 sound/soc/codecs/cs4271.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 65f578f..0206a17 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -719,7 +719,7 @@ static int cs4270_i2c_remove(struct i2c_client *i2c_client)
 /*
  * cs4270_id - I2C device IDs supported by this driver
  */
-static struct i2c_device_id cs4270_id[] = {
+static const struct i2c_device_id cs4270_id[] = {
 	{"cs4270", 0},
 	{}
 };
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 1791796..41a3ee6 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -555,7 +555,7 @@ static struct spi_driver cs4271_spi_driver = {
 #endif /* defined(CONFIG_SPI_MASTER) */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static struct i2c_device_id cs4271_i2c_id[] = {
+static const struct i2c_device_id cs4271_i2c_id[] = {
 	{"cs4271", 0},
 	{}
 };
-- 
1.7.2
