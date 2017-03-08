From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: Remove unneeded init of static variable" to the
 asoc tree
Date: Wed, 08 Mar 2017 14:23:26 +0100
Message-ID: <E1clbYs-0000O9-K4@finisterre>
References: <20170225104726.15936-1-alin.grig93@gmail.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20170225104726.15936-1-alin.grig93@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Alin Grigorean <alin.grig93@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, timur@tabi.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, perex@perex.cz, nicoleotsuka@gmail.com, broonie@kernel.org, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: Remove unneeded init of static variable

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

>From cb7d53b499f95febd4b5bc80a473706c717d5d2c Mon Sep 17 00:00:00 2001
From: Alin Grigorean <alin.grig93@gmail.com>
Date: Sat, 25 Feb 2017 12:47:26 +0200
Subject: [PATCH] ASoC: fsl: Remove unneeded init of static variable

This was reported by checkpatch.pl

Signed-off-by: Alin Grigorean <alin.grig93@gmail.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-pcm-fiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index dac6688540dc..92410f7ca1fa 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -282,7 +282,7 @@ static int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int ssi_irq = 0;
+static int ssi_irq;
 
 static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
 {
-- 
2.11.0
