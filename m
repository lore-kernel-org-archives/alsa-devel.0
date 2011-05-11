From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Reintroduce do_spi_write()
Date: Wed, 11 May 2011 19:25:52 +0200
Message-ID: <1305134752-20571-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1FA9103972
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 19:36:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There is an unfortunate difference in return values between spi_write()
and i2c_master_send() so we need an adaptor function to translate.

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 04861c4..dee86fc 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -20,6 +20,20 @@
 
 #include <trace/events/asoc.h>
 
+#ifdef CONFIG_SPI_MASTER
+static int do_spi_write(void *control, const char *data, int len)
+{
+	struct spi_device *spi = control;
+	int ret;
+
+	ret = spi_write(spi, data, len);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+#endif
+
 static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		       unsigned int value, const void *data, int len)
 {
@@ -409,7 +423,7 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 
 	case SND_SOC_SPI:
 #ifdef CONFIG_SPI_MASTER
-		codec->hw_write = (hw_write_t)spi_write;
+		codec->hw_write = do_spi_write;
 #endif
 
 		codec->control_data = container_of(codec->dev,
-- 
1.7.5.1
