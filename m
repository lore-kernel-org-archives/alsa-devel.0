From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Use u32 variable type when
	using regmap_read()" to the asoc tree
Date: Thu, 26 Apr 2018 15:18:57 +0100
Message-ID: <E1fBhjd-0003xH-8L@debutante>
References: <1524696832-7684-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1249526779A
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 16:19:01 +0200 (CEST)
In-Reply-To: <1524696832-7684-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Use u32 variable type when using regmap_read()

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

>From 671f8204b12fae98dcc6fc5a5703a5c62cbea187 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 25 Apr 2018 19:53:52 -0300
Subject: [PATCH] ASoC: fsl_ssi: Use u32 variable type when using regmap_read()

Convert the sisr and sisr2 variable types to u32 to avoid the following
sparse warnings:

sound/soc/fsl/fsl_ssi.c:391:42: warning: incorrect type in argument 3 (different base types)
sound/soc/fsl/fsl_ssi.c:391:42:    expected unsigned int *val
sound/soc/fsl/fsl_ssi.c:391:42:    got restricted __be32 *<noident>
sound/soc/fsl/fsl_ssi.c:393:17: warning: restricted __be32 degrades to integer
sound/soc/fsl/fsl_ssi.c:393:15: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl_ssi.c:393:15:    expected restricted __be32 [usertype] sisr2
sound/soc/fsl/fsl_ssi.c:393:15:    got unsigned int
sound/soc/fsl/fsl_ssi.c:396:50: warning: incorrect type in argument 3 (different base types)
sound/soc/fsl/fsl_ssi.c:396:50:    expected unsigned int [unsigned] val
sound/soc/fsl/fsl_ssi.c:396:50:    got restricted __be32 [usertype] sisr2
sound/soc/fsl/fsl_ssi.c:398:42: warning: incorrect type in argument 2 (different base types)
sound/soc/fsl/fsl_ssi.c:398:42:    expected unsigned int [unsigned] [usertype] sisr
sound/soc/fsl/fsl_ssi.c:398:42:    got restricted __be32 [addressable] [usertype] sisr

In other places where regmap_read() is used a u32 variable is passed
to store the register read value, so do the same here as well.

regmap API already takes care of endianness, so the usage of u32 is safe.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 89df2d9f63d7..1544166631e3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -385,8 +385,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 {
 	struct fsl_ssi *ssi = dev_id;
 	struct regmap *regs = ssi->regs;
-	__be32 sisr;
-	__be32 sisr2;
+	u32 sisr, sisr2;
 
 	regmap_read(regs, REG_SSI_SISR, &sisr);
 
-- 
2.17.0
