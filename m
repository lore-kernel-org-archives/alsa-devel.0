From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH v2 4/5] ASoC: add spi hw read function for 16
	addr 8 data mode
Date: Fri, 12 Aug 2011 18:04:13 -0400
Message-ID: <1313186654-22520-4-git-send-email-scott.jiang.linux@gmail.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id DFB421039B1
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 10:57:59 +0200 (CEST)
In-Reply-To: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

some spi registers are 7bits global address + 1 bit r/w + 8 bits
register address. soc cache layer can't support this kind well.
so let codec driver read registers directly.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/soc-io.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index cca490c..a62f7dd 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -205,6 +205,25 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
 #define snd_soc_16_8_read_i2c NULL
 #endif
 
+#if defined(CONFIG_SPI_MASTER)
+static unsigned int snd_soc_16_8_read_spi(struct snd_soc_codec *codec,
+		                          unsigned int r)
+{
+	struct spi_device *spi = codec->control_data;
+
+	const u16 reg = cpu_to_be16(r | 0x100);
+	u8 data;
+	int ret;
+
+	ret = spi_write_then_read(spi, &reg, 2, &data, 1);
+	if (ret < 0)
+		return 0;
+	return data;
+}
+#else
+#define snd_soc_16_8_read_spi NULL
+#endif
+
 static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -295,6 +314,7 @@ static struct {
 	int (*write)(struct snd_soc_codec *codec, unsigned int, unsigned int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
+	unsigned int (*spi_read)(struct snd_soc_codec *, unsigned int);
 } io_types[] = {
 	{
 		.addr_bits = 4, .data_bits = 12,
@@ -318,6 +338,7 @@ static struct {
 		.addr_bits = 16, .data_bits = 8,
 		.write = snd_soc_16_8_write,
 		.i2c_read = snd_soc_16_8_read_i2c,
+		.spi_read = snd_soc_16_8_read_spi,
 	},
 	{
 		.addr_bits = 16, .data_bits = 16,
@@ -383,6 +404,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 #ifdef CONFIG_SPI_MASTER
 		codec->hw_write = do_spi_write;
 #endif
+		if (io_types[i].spi_read)
+			codec->hw_read = io_types[i].spi_read;
 
 		codec->control_data = container_of(codec->dev,
 						   struct spi_device,
-- 
1.7.0.4
