From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl6040: Add back missing write
	callback" to the asoc tree
Date: Mon, 12 Mar 2018 16:40:05 +0000 (GMT)
Message-ID: <20180312164005.B384644007A@finisterre.ee.mobilebroadband>
References: <20180312142423.13177-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8411926718B
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 17:40:09 +0100 (CET)
In-Reply-To: <20180312142423.13177-2-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, lars@metafoo.de, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: twl6040: Add back missing write callback

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

>From c9d066650cd5adf4ed4bf5734386699e765222b7 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 12 Mar 2018 16:24:22 +0200
Subject: [PATCH] ASoC: twl6040: Add back missing write callback

We need to have the write callback to use the code.

Fixes: 7480389fb0d8 ("ASoC: twl6040: replace codec to component")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl6040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 9bf23f8e7162..b56a6471f9c4 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1157,6 +1157,7 @@ static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
 	.probe			= twl6040_probe,
 	.remove			= twl6040_remove,
 	.read			= twl6040_read,
+	.write			= twl6040_write,
 	.remove			= twl6040_remove,
 	.set_bias_level		= twl6040_set_bias_level,
 	.controls		= twl6040_snd_controls,
-- 
2.16.2
