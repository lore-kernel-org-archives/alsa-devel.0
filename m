From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: Remove unneeded gpiod NULL
	check" to the asoc tree
Date: Mon, 17 Jul 2017 17:06:07 +0100
Message-ID: <E1dX8X9-00050S-Nw@debutante>
References: <1500239473-14886-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62756267443
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:06:15 +0200 (CEST)
In-Reply-To: <1500239473-14886-1-git-send-email-festevam@gmail.com>
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

   ASoC: sun4i-codec: Remove unneeded gpiod NULL check

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

>From d51579e6effa19c1ca4d6a29c3841cb454d56af6 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 16 Jul 2017 18:11:06 -0300
Subject: [PATCH] ASoC: sun4i-codec: Remove unneeded gpiod NULL check

The gpiod API checks for NULL descriptors, so there is no need to
duplicate the check in the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 150069987c0c..4c37231f254b 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1171,9 +1171,8 @@ static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
 {
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(w->dapm->card);
 
-	if (scodec->gpio_pa)
-		gpiod_set_value_cansleep(scodec->gpio_pa,
-					 !!SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value_cansleep(scodec->gpio_pa,
+				 !!SND_SOC_DAPM_EVENT_ON(event));
 
 	return 0;
 }
-- 
2.13.2
