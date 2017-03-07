From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bdw-rt5677: Use
	devm_gpiod_get()" to the asoc tree
Date: Tue, 07 Mar 2017 13:57:22 +0100
Message-ID: <E1clEg6-0004eO-Fc@finisterre>
References: <20170220174610.47314-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40D04266E52
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:57:32 +0100 (CET)
In-Reply-To: <20170220174610.47314-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bdw-rt5677: Use devm_gpiod_get()

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

>From b3ec72ace939b0abd75d5d875e77cf0b777debb7 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 20 Feb 2017 19:46:10 +0200
Subject: [PATCH] ASoC: Intel: bdw-rt5677: Use devm_gpiod_get()

Since index is always 0 replace devm_gpiod_get_index() by devm_gpiod_get()
and apply proper flags.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bdw-rt5677.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 53c6b4cbb1e1..14d9693c1641 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -193,13 +193,12 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 			RT5677_CLK_SEL_I2S1_ASRC);
 
 	/* Request rt5677 GPIO for headphone amp control */
-	bdw_rt5677->gpio_hp_en = devm_gpiod_get_index(codec->dev,
-			"headphone-enable", 0, 0);
+	bdw_rt5677->gpio_hp_en = devm_gpiod_get(codec->dev, "headphone-enable",
+						GPIOD_OUT_LOW);
 	if (IS_ERR(bdw_rt5677->gpio_hp_en)) {
 		dev_err(codec->dev, "Can't find HP_AMP_SHDN_L gpio\n");
 		return PTR_ERR(bdw_rt5677->gpio_hp_en);
 	}
-	gpiod_direction_output(bdw_rt5677->gpio_hp_en, 0);
 
 	/* Create and initialize headphone jack */
 	if (!snd_soc_card_jack_new(rtd->card, "Headphone Jack",
-- 
2.11.0
