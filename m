From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: fix ak4104 register array access
Date: Fri, 26 Feb 2010 14:36:54 +0800
Message-ID: <1267166214-1977-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FFE9103806
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 15:23:23 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Don't touch the variable 'reg' to construct the value for the actual SPI
transport. This variable is again used to access the driver's register
cache, and so random memory is overwritten.
Compute the value in-place instead.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: stable@kernel.org
---
 sound/soc/codecs/ak4104.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index b9ef7e4..b68d99f 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -90,12 +90,10 @@ static int ak4104_spi_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (reg >= codec->reg_cache_size)
 		return -EINVAL;
 
-	reg &= AK4104_REG_MASK;
-	reg |= AK4104_WRITE;
-
 	/* only write to the hardware if value has changed */
 	if (cache[reg] != value) {
-		u8 tmp[2] = { reg, value };
+		u8 tmp[2] = { (reg & AK4104_REG_MASK) | AK4104_WRITE, value };
+
 		if (spi_write(spi, tmp, sizeof(tmp))) {
 			dev_err(&spi->dev, "SPI write failed\n");
 			return -EIO;
-- 
1.6.3.3
