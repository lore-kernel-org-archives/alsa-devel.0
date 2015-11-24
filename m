From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: fsl: clarify ac97 dependency
Date: Tue, 24 Nov 2015 23:21:10 +0100
Message-ID: <2830784.Nrm81IgjTt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
List-Id: alsa-devel@alsa-project.org

A new randconfig build failure shows that the fsl-asoc-card module
must not be built-in when the AC97 driver is a loadable module:

sound/built-in.o: In function `fsl_asoc_card_late_probe':
:(.text+0x571d8): undefined reference to `snd_ac97_update_bits'

I couldn't come up with a nice solution, so this adds another dependency
on "X || !X", which is the Kconfig way of saying that we have an
optional dependency on something that might be a loadable module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 50760cad9de9 ("ASoC: fsl-asoc-card: add AC'97 support")
---
The commit that introduced this was merged for 4.4-rc1, so we might
want the fix to go into 4.4 as well.

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 19c302b0d763..14dfdee05fd5 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -283,6 +283,8 @@ config SND_SOC_IMX_MC13783
 config SND_SOC_FSL_ASOC_CARD
 	tristate "Generic ASoC Sound Card with ASRC support"
 	depends on OF && I2C
+	# enforce SND_SOC_FSL_ASOC_CARD=m if SND_AC97_CODEC=m:
+	depends on SND_AC97_CODEC || SND_AC97_CODEC=n
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_ESAI
