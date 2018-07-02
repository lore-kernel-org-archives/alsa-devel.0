From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: select SND_PXA2XX_LIB for drivers
	that depend on it" to the asoc tree
Date: Mon, 02 Jul 2018 11:10:06 +0100
Message-ID: <E1fZvmY-0006PN-8Z@debutante>
References: <20180630202433.8615-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E8CB5267795
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:08 +0200 (CEST)
In-Reply-To: <20180630202433.8615-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, lkp@intel.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, broonie@kernel.org, robert.jarzmik@free.fr
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: select SND_PXA2XX_LIB for drivers that depend on it

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

>From 1581250119daa9426c359d059e2dc14ec04bcc0c Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Sat, 30 Jun 2018 22:24:33 +0200
Subject: [PATCH] ASoC: pxa: select SND_PXA2XX_LIB for drivers that depend on
 it

Commit d767d3ce5c48b ("ASoC: pxa: provide PCM ops for ssp, i2s and ac97
components") created a build-time dependency to SND_PXA2XX_LIB but
missed to reflect that in Kconfig.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 95dcf97a6271..2fc02c227f69 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -24,15 +24,18 @@ config SND_PXA2XX_AC97
 config SND_PXA2XX_SOC_AC97
 	tristate
 	select AC97_BUS
+	select SND_PXA2XX_LIB
 	select SND_PXA2XX_LIB_AC97
 	select SND_SOC_AC97_BUS
 
 config SND_PXA2XX_SOC_I2S
+	select SND_PXA2XX_LIB
 	tristate
 
 config SND_PXA_SOC_SSP
 	tristate "Soc Audio via PXA2xx/PXA3xx SSP ports"
 	select PXA_SSP
+	select SND_PXA2XX_LIB
 
 config SND_MMP_SOC_SSPA
 	tristate
-- 
2.18.0.rc2
