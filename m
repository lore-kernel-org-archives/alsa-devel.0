From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ad193x-spi: Fixup ad193x_spi_id table"
	to the asoc tree
Date: Wed, 07 Oct 2015 10:45:38 +0100
Message-ID: <E1ZjlI2-0002Ow-MD@finisterre>
References: <1444123596.7405.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2A2B265A3E
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 11:46:12 +0200 (CEST)
In-Reply-To: <1444123596.7405.2.camel@ingics.com>
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

   ASoC: ad193x-spi: Fixup ad193x_spi_id table

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

>From d46183efe3b57d06461c9bea35e1a0262391fe77 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 6 Oct 2015 17:26:36 +0800
Subject: [PATCH] ASoC: ad193x-spi: Fixup ad193x_spi_id table

AD1939 is missed from the table, so add it.
AD1936 and AD1937 are controlled by I2C interface, so remove them.

Fixes: e5224f58e3ef ("ASoC: ad193x: add support to ad1934")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.5.0
