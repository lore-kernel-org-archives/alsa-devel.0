From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: tlv320aic23: Remove spurious bits per
	word setting
Date: Wed, 12 Mar 2014 13:33:15 +0000
Message-ID: <1394631195-10480-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F9D6262626
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 14:33:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Max Filippov <jcmvbkbc@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

regmap should handle any byte ordering issues required, it is looking for
a byte stream from the bus, so don't set 16 bits per word. This is likely
to have tested out OK due to use of an unmerged SPI controller driver.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic23-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic23-spi.c b/sound/soc/codecs/tlv320aic23-spi.c
index 585aea436c6a..3b387e41d75d 100644
--- a/sound/soc/codecs/tlv320aic23-spi.c
+++ b/sound/soc/codecs/tlv320aic23-spi.c
@@ -25,7 +25,6 @@ static int aic23_spi_probe(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "probing tlv320aic23 spi device\n");
 
-	spi->bits_per_word = 16;
 	spi->mode = SPI_MODE_0;
 	ret = spi_setup(spi);
 	if (ret < 0)
-- 
1.9.0
