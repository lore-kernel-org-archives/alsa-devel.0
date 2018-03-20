From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl6040: remove duplicated remove
	callback" to the asoc tree
Date: Tue, 20 Mar 2018 01:05:49 +0000 (GMT)
Message-ID: <20180320010549.AC2A744007A@finisterre.ee.mobilebroadband>
References: <87d100tsjh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 740BB2672B2
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 02:05:58 +0100 (CET)
In-Reply-To: <87d100tsjh.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Julia Lawall <julia.lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, kbuild test robot <fengguang.wu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: twl6040: remove duplicated remove callback

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

>From 83eca9f5eda6efff71515cb9c1a373b26d2d4c5b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Mar 2018 07:50:48 +0000
Subject: [PATCH] ASoC: twl6040: remove duplicated remove callback

We don't need 2 .remove callback

Fixes: 7480389fb0d8 ("ASoC: twl6040: replace codec to component")
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl6040.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index b56a6471f9c4..bfd1abd72253 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1158,7 +1158,6 @@ static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
 	.remove			= twl6040_remove,
 	.read			= twl6040_read,
 	.write			= twl6040_write,
-	.remove			= twl6040_remove,
 	.set_bias_level		= twl6040_set_bias_level,
 	.controls		= twl6040_snd_controls,
 	.num_controls		= ARRAY_SIZE(twl6040_snd_controls),
-- 
2.16.2
