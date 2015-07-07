From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: 88pm860x: Don't change pm860x->dir
	setting if pm860x_set_dai_sysclk fails" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:48 +0100
Message-ID: <E1ZCTNc-0005Wc-Ry@finisterre>
References: <1435547723.6397.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0280A265716
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:07 +0200 (CEST)
In-Reply-To: <1435547723.6397.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: 88pm860x: Don't change pm860x->dir setting if pm860x_set_dai_sysclk fails

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

>From 93ec3a1ad5b86aef8ca90d2b149ded0f6bb689f5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 29 Jun 2015 11:15:23 +0800
Subject: [PATCH] ASoC: 88pm860x: Don't change pm860x->dir setting if
 pm860x_set_dai_sysclk fails

88pm860x does not support slave mode, so it returns -EINVAL for
PM860X_CLK_DIR_IN. Current code changes pm860x->dir setting before
return error, so it has impact on the logic of pm860x_pcm_set_dai_fmt.

This patch adds comment for the reason to return -EINVAL for
PM860X_CLK_DIR_IN, and avoid changing pm860x->dir setting if
pm860x_set_dai_sysclk fails.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/88pm860x-codec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 38b3dad..4d91a6a 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1028,10 +1028,8 @@ static int pm860x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 	if (dir == PM860X_CLK_DIR_OUT)
 		pm860x->dir = PM860X_CLK_DIR_OUT;
-	else {
-		pm860x->dir = PM860X_CLK_DIR_IN;
+	else	/* Slave mode is not supported */
 		return -EINVAL;
-	}
 
 	return 0;
 }
-- 
2.1.4
