From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: adjust set DAI format in AC'97
	mode" to the asoc tree
Date: Fri, 14 Aug 2015 19:13:26 -0700
Message-ID: <E1ZQQyM-0004Ik-BI@finisterre>
References: <55BE9D3B.3090303@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B3D62665DE
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:13:34 +0200 (CEST)
In-Reply-To: <55BE9D3B.3090303@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maciej Szmigiero <mail@maciej.szmigiero.name>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: adjust set DAI format in AC'97 mode

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

>From dce0332c85c4d9eb5d96182c56f63cd20566f073 Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Wed, 5 Aug 2015 17:29:02 +0200
Subject: [PATCH] ASoC: fsl_ssi: adjust set DAI format in AC'97 mode

Adjust set DAI format function in fsl_ssi driver
so it doesn't fail and clears RXDIR in AC'97 mode.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e79dc16..f03d57e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -900,14 +900,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
-		return -EINVAL;
+		if (!fsl_ssi_is_ac97(ssi_private))
+			return -EINVAL;
 	}
 
 	stcr |= strcr;
 	srcr |= strcr;
 
-	if (ssi_private->cpu_dai_drv.symmetric_rates) {
-		/* Need to clear RXDIR when using SYNC mode */
+	if (ssi_private->cpu_dai_drv.symmetric_rates
+			|| fsl_ssi_is_ac97(ssi_private)) {
+		/* Need to clear RXDIR when using SYNC or AC97 mode */
 		srcr &= ~CCSR_SSI_SRCR_RXDIR;
 		scr |= CCSR_SSI_SCR_SYN;
 	}
-- 
2.5.0
