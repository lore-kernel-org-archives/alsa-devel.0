From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: clarify ac97 dependency" to the
	asoc tree
Date: Wed, 25 Nov 2015 12:11:13 +0000
Message-ID: <E1a1Yun-0001py-9M@debutante>
References: <2830784.Nrm81IgjTt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F5452606CD
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 13:11:25 +0100 (CET)
In-Reply-To: <2830784.Nrm81IgjTt@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: clarify ac97 dependency

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

>From ab07eaedb7ada83cc6341894dff9cd54f1af7f8b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Nov 2015 23:21:10 +0100
Subject: [PATCH] ASoC: fsl: clarify ac97 dependency

A new randconfig build failure shows that the fsl-asoc-card module
must not be built-in when the AC97 driver is a loadable module:

sound/built-in.o: In function `fsl_asoc_card_late_probe':
:(.text+0x571d8): undefined reference to `snd_ac97_update_bits'

I couldn't come up with a nice solution, so this adds another dependency
on "X || !X", which is the Kconfig way of saying that we have an
optional dependency on something that might be a loadable module.

Fixes: 50760cad9de9 ("ASoC: fsl-asoc-card: add AC'97 support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.6.2
