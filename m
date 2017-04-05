From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: export OF device ID as module aliases" to the asoc tree
Date: Wed, 05 Apr 2017 18:30:57 +0100
Message-ID: <E1cvoll-0000nn-3P@debutante>
References: <20170404171939.3950-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404171939.3950-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: export OF device ID as module aliases

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

>From 56af0e4cd27c402691d0da8aa4a5233944085b44 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 4 Apr 2017 13:19:39 -0400
Subject: [PATCH] ASoC: max9867: export OF device ID as module aliases

The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
device was registered via OF, this means that exporting the OF device ID
table device aliases in the module is not needed. But in order to change
how the core reports modaliases to user-space, it's better to export it.

While there, move the MODULE_DEVICE_TABLE(i2c, max9867_i2c_id) just next
to the I2C device table declaration, for consistency with other drivers.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-max9867.ko | grep alias
alias:          i2c:max9867

After this patch:

$ modinfo sound/soc/codecs/snd-soc-max9867.ko | grep alias
alias:          i2c:max9867
alias:          of:N*T*Cmaxim,max9867C*
alias:          of:N*T*Cmaxim,max9867

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 42e2e407e287..3a3d5bebc24e 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -517,13 +517,13 @@ static const struct i2c_device_id max9867_i2c_id[] = {
 	{ "max9867", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, max9867_i2c_id);
 
 static const struct of_device_id max9867_of_match[] = {
 	{ .compatible = "maxim,max9867", },
 	{ }
 };
-
-MODULE_DEVICE_TABLE(i2c, max9867_i2c_id);
+MODULE_DEVICE_TABLE(of, max9867_of_match);
 
 static const struct dev_pm_ops max9867_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(max9867_suspend, max9867_resume)
-- 
2.11.0
