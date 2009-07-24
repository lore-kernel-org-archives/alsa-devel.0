From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: ASoC: about the array to cache registers
Date: Fri, 24 Jul 2009 16:06:43 +0900
Message-ID: <4A695D83.8060202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 39F6B103A66
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 09:10:47 +0200 (CEST)
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KN900ATDYF73S@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 24 Jul 2009 16:06:43 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KN900IU5YF7B6@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 24 Jul 2009 16:06:43 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

Many ASoC codec drivers have an array to cache registers.
The array is not used any longer after memcpy to codec->reg_cache.
I think that memcpy is unnecessary, and it a waste of the memory.

How about continue using the array instead of memcpy?

For example, i modified such following patch in wm8731.c


diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 1560028..43f8de3 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -36,7 +36,6 @@ struct snd_soc_codec_device soc_codec_dev_wm8731;
 /* codec private data */
 struct wm8731_priv {
 	struct snd_soc_codec codec;
-	u16 reg_cache[WM8731_CACHEREGNUM];
 	unsigned int sysclk;
 };
 
@@ -50,7 +49,7 @@ static int wm8731_spi_write(struct spi_device *spi, const char *data, int len);
  * using 2 wire for device control, so we cache them instead.
  * There is no point in caching the reset register
  */
-static const u16 wm8731_reg[WM8731_CACHEREGNUM] = {
+static u16 wm8731_reg[WM8731_CACHEREGNUM] = {
     0x0097, 0x0097, 0x0079, 0x0079,
     0x000a, 0x0008, 0x009f, 0x000a,
     0x0000, 0x0000
@@ -586,9 +585,7 @@ static int wm8731_register(struct wm8731_priv *wm8731)
 	codec->dai = &wm8731_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = WM8731_CACHEREGNUM;
-	codec->reg_cache = &wm8731->reg_cache;
-
-	memcpy(codec->reg_cache, wm8731_reg, sizeof(wm8731_reg));
+	codec->reg_cache = &wm8731_reg;
 
 	ret = wm8731_reset(codec);
 	if (ret < 0) {
