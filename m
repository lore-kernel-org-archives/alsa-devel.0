From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: Remove needless bits_per_word and
	speed_hz tests" to the asoc tree
Date: Thu, 17 Sep 2015 18:36:39 +0100
Message-ID: <E1Zcd6t-0006J1-P7@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 094A2262618
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 19:36:55 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   spi: atmel: Remove needless bits_per_word and speed_hz tests

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3f8958cf9aaaac8a2bfc7417cb87db757eeb4465 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Tue, 15 Sep 2015 16:26:22 +0300
Subject: [PATCH] spi: atmel: Remove needless bits_per_word and speed_hz tests

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set. This makes possible to remove two if
statements and remove one code block that is never executed.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index bf9ed38..1cc1f1e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -871,14 +871,7 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 	 * Calculate the lowest divider that satisfies the
 	 * constraint, assuming div32/fdiv/mbz == 0.
 	 */
-	if (xfer->speed_hz)
-		scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
-	else
-		/*
-		 * This can happend if max_speed is null.
-		 * In this case, we set the lowest possible speed
-		 */
-		scbr = 0xff;
+	scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
 
 	/*
 	 * If the resulting divider doesn't fit into the
@@ -1300,14 +1293,12 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		return -EINVAL;
 	}
 
-	if (xfer->bits_per_word) {
-		asd = spi->controller_state;
-		bits = (asd->csr >> 4) & 0xf;
-		if (bits != xfer->bits_per_word - 8) {
-			dev_dbg(&spi->dev,
+	asd = spi->controller_state;
+	bits = (asd->csr >> 4) & 0xf;
+	if (bits != xfer->bits_per_word - 8) {
+		dev_dbg(&spi->dev,
 			"you can't yet change bits_per_word in transfers\n");
-			return -ENOPROTOOPT;
-		}
+		return -ENOPROTOOPT;
 	}
 
 	/*
-- 
2.5.0
