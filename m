From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sta32x: Remove unneeded gpiod NULL
	check" to the asoc tree
Date: Mon, 17 Jul 2017 17:05:45 +0100
Message-ID: <E1dX8Wn-0004tq-Fw@debutante>
References: <1500239473-14886-8-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB6AA267398
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:05:53 +0200 (CEST)
In-Reply-To: <1500239473-14886-8-git-send-email-festevam@gmail.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sta32x: Remove unneeded gpiod NULL check

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

>From c5efe232e09ef29cc2f9e8333a49dd8891366c22 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 16 Jul 2017 18:11:13 -0300
Subject: [PATCH] ASoC: sta32x: Remove unneeded gpiod NULL check

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sta32x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 0790ae8530d9..5b888476d9ff 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -847,8 +847,7 @@ static int sta32x_set_bias_level(struct snd_soc_codec *codec,
 		msleep(300);
 		sta32x_watchdog_stop(sta32x);
 
-		if (sta32x->gpiod_nreset)
-			gpiod_set_value(sta32x->gpiod_nreset, 0);
+		gpiod_set_value(sta32x->gpiod_nreset, 0);
 
 		regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies),
 				       sta32x->supplies);
-- 
2.13.2
