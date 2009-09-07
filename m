From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: Factor out I2C 8 bit address 8 bit data
	I/O
Date: Mon, 07 Sep 2009 12:04:37 +0900
Message-ID: <4AA47845.8070403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 0194224390
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 05:06:41 +0200 (CEST)
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KPK0072DZ7PK1@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 07 Sep 2009 12:04:38 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KPK002IWZ7Q2L@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 07 Sep 2009 12:04:38 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

This patch is for the AK4671 codec driver using this format.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/soc-cache.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index c8ceddc..404231e 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -77,6 +77,35 @@ static int snd_soc_7_9_spi_write(void *control_data, const char *data,
 #define snd_soc_7_9_spi_write NULL
 #endif
 
+static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int value)
+{
+	u8 *cache = codec->reg_cache;
+	u8 data[2];
+
+	BUG_ON(codec->volatile_register);
+
+	data[0] = reg & 0xff;
+	data[1] = value & 0xff;
+
+	if (reg < codec->reg_cache_size)
+		cache[reg] = value;
+
+	if (codec->hw_write(codec->control_data, data, 2) == 2)
+		return 0;
+	else
+		return -EIO;
+}
+
+static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	u8 *cache = codec->reg_cache;
+	if (reg >= codec->reg_cache_size)
+		return -1;
+	return cache[reg];
+}
+
 static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 			      unsigned int value)
 {
@@ -151,6 +180,7 @@ static struct {
 	unsigned int (*i2c_read)(struct snd_soc_codec *, unsigned int);
 } io_types[] = {
 	{ 7, 9, snd_soc_7_9_write, snd_soc_7_9_spi_write, snd_soc_7_9_read },
+	{ 8, 8, snd_soc_8_8_write, NULL, snd_soc_8_8_read, NULL },
 	{ 8, 16, snd_soc_8_16_write, NULL, snd_soc_8_16_read,
 	  snd_soc_8_16_read_i2c },
 };
-- 
1.6.0.4
