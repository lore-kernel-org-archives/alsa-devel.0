From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Simplify pri_dai,
	sec_dai pointers usage" to the asoc tree
Date: Thu, 14 Feb 2019 14:51:18 +0000 (GMT)
Message-ID: <20190214145118.2FACF1126F78@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EBF0B2673E2
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 15:51:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Simplify pri_dai, sec_dai pointers usage

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

>From eb540d3988d93d2b0231a5b36012aa0b3abaec81 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 10:37:44 +0100
Subject: [PATCH] ASoC: samsung: i2s: Simplify pri_dai, sec_dai pointers usage

If the probe call is on the primary DAI we can use 'other' in place of
i2s->sec_dai, if the probe call is on the secondary DAI we can use 'i2s'
in place of other->sec_dai.

While at it fix one whitespace issue.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 6ab99e38e6dd..967c1b22ac35 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1057,18 +1057,17 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	pm_runtime_get_sync(dai->dev);
 
 	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
-		snd_soc_dai_init_dma_data(dai, &other->sec_dai->dma_playback,
-					   NULL);
+		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, NULL);
 	} else {
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback,
-					   &i2s->dma_capture);
+					  &i2s->dma_capture);
 
 		if (priv->quirks & QUIRK_NEED_RSTCLR)
 			writel(CON_RSTCLR, priv->addr + I2SCON);
 
 		if (priv->quirks & QUIRK_SUPPORTS_IDMA)
 			idma_reg_addr_init(priv->addr,
-					i2s->sec_dai->idma_playback.addr);
+					   other->idma_playback.addr);
 	}
 
 	/* Reset any constraint on RFS and BFS */
-- 
2.20.1
