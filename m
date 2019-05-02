From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_esai: Fix missing break in switch statement" to
 the asoc tree
Date: Thu,  2 May 2019 03:18:00 +0100 (BST)
Message-ID: <20190502021800.2B82D441D3B@finisterre.ee.mobilebroadband>
References: <1556418264-17810-1-git-send-email-shengjiu.wang@nxp.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1556418264-17810-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_esai: Fix missing break in switch statement

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 903c220b1ece12f17c868e43f2243b8f81ff2d4c Mon Sep 17 00:00:00 2001
From: "S.j. Wang" <shengjiu.wang@nxp.com>
Date: Sun, 28 Apr 2019 02:24:27 +0000
Subject: [PATCH] ASoC: fsl_esai: Fix missing break in switch statement

case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be
independent of each other, so replace fall-through with break.

Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c7410bbfd2af..bad0dfed6b68 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 		break;
 	case ESAI_HCKT_EXTAL:
 		ecr |= ESAI_ECR_ETI;
-		/* fall through */
+		break;
 	case ESAI_HCKR_EXTAL:
 		ecr |= esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
 		break;
-- 
2.20.1
