From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: fix typos in Kconfig" to the asoc tree
Date: Mon, 09 Oct 2017 09:49:37 +0100
Message-ID: <E1e1Tkn-0006Jj-6U@debutante>
References: <20171007222610.17743-1-nikolas@gnu.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171007222610.17743-1-nikolas@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nik Nyby <nikolas@gnu.org>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, trivial@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: fix typos in Kconfig

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

>From 44860b96e68351e4c4c419df10e6534ca4c09fdd Mon Sep 17 00:00:00 2001
From: Nik Nyby <nikolas@gnu.org>
Date: Sat, 7 Oct 2017 18:26:10 -0400
Subject: [PATCH] ASoC: dwc: fix typos in Kconfig

This fixes a few typos in the snd_designware description.

Signed-off-by: Nik Nyby <nikolas@gnu.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
index c6fd95fa5ca6..aa0c6ec4d93c 100644
--- a/sound/soc/dwc/Kconfig
+++ b/sound/soc/dwc/Kconfig
@@ -4,8 +4,8 @@ config SND_DESIGNWARE_I2S
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	 Say Y or M if you want to add support for I2S driver for
-	 Synopsys desigwnware I2S device. The device supports upto
-	 maximum of 8 channels each for play and record.
+	 Synopsys designware I2S device. The device supports up to
+	 a maximum of 8 channels each for play and record.
 
 config SND_DESIGNWARE_PCM
 	bool "PCM PIO extension for I2S driver"
-- 
2.14.1
