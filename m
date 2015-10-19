From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ad193x-spi: Add adau1328 to
	ad193x_spi_id table" to the asoc tree
Date: Mon, 19 Oct 2015 20:43:16 +0100
Message-ID: <E1ZoGKy-0002AP-2R@debutante>
References: <1445133971.9933.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D523D265D6A
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 21:43:27 +0200 (CEST)
In-Reply-To: <1445133971.9933.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ad193x-spi: Add adau1328 to ad193x_spi_id table

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

>From 355b27e181f667dad248a40d3d4d48150e9a593c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 18 Oct 2015 10:06:11 +0800
Subject: [PATCH] ASoC: ad193x-spi: Add adau1328 to ad193x_spi_id table

This driver also supports adau1328, thus add adau1328 to ad193x_spi_id.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ad193x-spi.c b/sound/soc/codecs/ad193x-spi.c
index b55055a6a265..431f95da1de1 100644
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
2.6.1
