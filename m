From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: tlv320aic32x4: Only enable with common
	clock
Date: Tue, 26 Mar 2019 13:18:35 +0000
Message-ID: <20190326131835.8925-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48427F801D9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 14:18:42 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

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
