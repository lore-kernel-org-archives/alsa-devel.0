From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Add missing of_device_id
	for dac3100" to the asoc tree
Date: Thu, 10 Nov 2016 18:33:55 +0000
Message-ID: <E1c4uAd-0007IV-Ax@finisterre>
References: <20161110075555.7878-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DCE2526686A
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 19:34:14 +0100 (CET)
In-Reply-To: <20161110075555.7878-2-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nikita.yoush@cogentembedded.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Add missing of_device_id for dac3100

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

>From a4a1d79ea75eec48e086648678b62a8220fe3723 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 10 Nov 2016 09:55:54 +0200
Subject: [PATCH] ASoC: tlv320aic31xx: Add missing of_device_id for dac3100

The compatible table was not updated when the support for DAC3100 was added.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index be1a64bfd320..8880f6be3336 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1253,6 +1253,7 @@ static const struct of_device_id tlv320aic31xx_of_match[] = {
 	{ .compatible = "ti,tlv320aic3110" },
 	{ .compatible = "ti,tlv320aic3120" },
 	{ .compatible = "ti,tlv320aic3111" },
+	{ .compatible = "ti,tlv320dac3100" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tlv320aic31xx_of_match);
-- 
2.10.2
