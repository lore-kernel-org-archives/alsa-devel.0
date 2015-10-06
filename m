From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: ad193x-spi: Fixup ad193x_spi_id table
Date: Tue, 06 Oct 2015 17:26:36 +0800
Message-ID: <1444123596.7405.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 64F6A260663
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 11:26:41 +0200 (CEST)
Received: by padhy16 with SMTP id hy16so65092039pad.1
 for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2015 02:26:40 -0700 (PDT)
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
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AD1939 is missed from the table, so add it.
AD1936 and AD1937 are controlled by I2C interface, so remove them.

Fixes: e5224f58e3ef ("ASoC: ad193x: add support to ad1934")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ad193x-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x-spi.c b/sound/soc/codecs/ad193x-spi.c
index 364e8211..b55055a 100644
--- a/sound/soc/codecs/ad193x-spi.c
+++ b/sound/soc/codecs/ad193x-spi.c
@@ -39,9 +39,8 @@ static const struct spi_device_id ad193x_spi_id[] = {
 	{ "ad193x", AD193X },
 	{ "ad1933", AD1933 },
 	{ "ad1934", AD1934 },
-	{ "ad1936", AD193X },
-	{ "ad1937", AD193X },
 	{ "ad1938", AD193X },
+	{ "ad1939", AD193X },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad193x_spi_id);
-- 
2.1.4
