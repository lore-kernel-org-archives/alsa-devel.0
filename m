From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa-ssp: simplify
	pxa_ssp_set_dai_sysclk()" to the asoc tree
Date: Tue, 22 May 2018 11:59:07 +0100
Message-ID: <E1fL50V-0000Ta-Mb@debutante>
References: <20180521215017.29095-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C8FA6267680
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 12:59:10 +0200 (CEST)
In-Reply-To: <20180521215017.29095-2-daniel@zonque.org>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, robert.jarzmik@free.fr, lars@metafoo.de, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa-ssp: simplify pxa_ssp_set_dai_sysclk()

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

>From 05f38281c5e5272ff1d350ed8762b08c4f6d10fc Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Mon, 21 May 2018 23:50:17 +0200
Subject: [PATCH] ASoC: pxa-ssp: simplify pxa_ssp_set_dai_sysclk()

There's no need to read the register again prior to writing it, we did
that in the beginning of the function.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/pxa-ssp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index ffddcf117eb8..6fc986080130 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -217,10 +217,9 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 {
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
-	int val;
 
 	u32 sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
-		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+		~(SSCR0_ECS | SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 
 	dev_dbg(&ssp->pdev->dev,
 		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %u\n",
@@ -258,8 +257,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
 	if (ssp->type != PXA3xx_SSP)
 		clk_disable_unprepare(ssp->clk);
-	val = pxa_ssp_read_reg(ssp, SSCR0) | sscr0;
-	pxa_ssp_write_reg(ssp, SSCR0, val);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);
 	if (ssp->type != PXA3xx_SSP)
 		clk_prepare_enable(ssp->clk);
 
-- 
2.17.0
