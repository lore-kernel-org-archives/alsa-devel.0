From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: ad193x-spi: Add adau1328 to
	ad193x_spi_id table
Date: Sun, 18 Oct 2015 10:06:11 +0800
Message-ID: <1445133971.9933.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id CAB7D260635
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 04:06:18 +0200 (CEST)
Received: by pacfa8 with SMTP id fa8so3269847pac.1
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 19:06:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This driver also supports adau1328, thus add adau1328 to ad193x_spi_id.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ad193x-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ad193x-spi.c b/sound/soc/codecs/ad193x-spi.c
index b55055a..431f95d 100644
--- a/sound/soc/codecs/ad193x-spi.c
+++ b/sound/soc/codecs/ad193x-spi.c
@@ -41,6 +41,7 @@ static const struct spi_device_id ad193x_spi_id[] = {
 	{ "ad1934", AD1934 },
 	{ "ad1938", AD193X },
 	{ "ad1939", AD193X },
+	{ "adau1328", AD193X },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad193x_spi_id);
-- 
2.1.4
