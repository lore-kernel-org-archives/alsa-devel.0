From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH 5/9] ASoC: Only compile adav80x codec when a
	bus is defined
Date: Sun, 4 Nov 2012 11:31:13 +0100
Message-ID: <20121104103113.GB27124@gmail.com>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
 <1351980150-24145-6-git-send-email-lee.jones@linaro.org>
 <509623B0.2020605@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <509623B0.2020605@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Thanks for reviewing Lars. Here's the result:

commit c4f60d00d04abfb730a54a97204873dafc6473ae
Author: Lee Jones <lee.jones@linaro.org>
Date:   Sat Nov 3 22:54:23 2012 +0100

    ASoC: Only compile adav80x codec when a bus is defined
   =20
    If !CONFIG_SPI and !CONFIG_I2C* then there is no point adding suppo=
rt
    for the adav80x codec as it relies on a bus to operate. This patch
    fixes the build warnings below when SPI and I2C are not specified i=
n
    the configuration.
   =20
    sound/soc/codecs/adav80x.c:842:22: warning: =E2=80=98adav80x_bus_pr=
obe=E2=80=99 defined but not used [-Wunused-function]
    sound/soc/codecs/adav80x.c:863:22: warning: =E2=80=98adav80x_bus_re=
move=E2=80=99 defined but not used [-Wunused-function]
   =20
    Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Cc: alsa-devel@alsa-project.org
    Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b92759a..3ae3a4b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -19,7 +19,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
 	select SND_SOC_AD73311
 	select SND_SOC_ADAU1373 if I2C
-	select SND_SOC_ADAV80X
+	select SND_SOC_ADAV80X if SND_SOC_I2C_AND_SPI
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
