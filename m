From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Only enable with common
	clock" to the asoc tree
Date: Tue, 26 Mar 2019 14:42:50 +0000 (GMT)
Message-ID: <20190326144250.9CA611121B57@debutante.sirena.org.uk>
References: <20190326131835.8925-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBA24F89723
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 15:42:57 +0100 (CET)
In-Reply-To: <20190326131835.8925-1-broonie@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Only enable with common clock

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 64f01d2b5ccc621c3aa66b82daf9154f5581f36a Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Tue, 26 Mar 2019 13:10:13 +0000
Subject: [PATCH] ASoC: tlv320aic32x4: Only enable with common clock

Some architectures do not yet support the common clock API at all but
the tlv320aic32x4 driver now requires it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6e99320c79b8..419142111b6d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -180,8 +180,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC23_SPI if SPI_MASTER
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC31XX if I2C
-	select SND_SOC_TLV320AIC32X4_I2C if I2C
-	select SND_SOC_TLV320AIC32X4_SPI if SPI_MASTER
+	select SND_SOC_TLV320AIC32X4_I2C if I2C && COMMON_CLK
+	select SND_SOC_TLV320AIC32X4_SPI if SPI_MASTER && COMMON_CLK
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
@@ -1110,11 +1110,13 @@ config SND_SOC_TLV320AIC32X4
 config SND_SOC_TLV320AIC32X4_I2C
 	tristate "Texas Instruments TLV320AIC32x4 audio CODECs - I2C"
 	depends on I2C
+	depends on COMMON_CLK
 	select SND_SOC_TLV320AIC32X4
 
 config SND_SOC_TLV320AIC32X4_SPI
 	tristate "Texas Instruments TLV320AIC32x4 audio CODECs - SPI"
 	depends on SPI_MASTER
+	depends on COMMON_CLK
 	select SND_SOC_TLV320AIC32X4
 
 config SND_SOC_TLV320AIC3X
-- 
2.20.1
