From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tfa9879: Export OF device ID as module alias" to the asoc tree
Date: Fri, 01 Dec 2017 13:44:16 +0000
Message-ID: <E1eKlc0-0001MT-Ia@debutante>
References: <20171130175616.29073-1-javierm@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130175616.29073-1-javierm@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Peter Rosin <peda@axentia.se>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tfa9879: Export OF device ID as module alias

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

>From 56ae83f11db58a3a62d0d309efb84544f2c02e3b Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 30 Nov 2017 18:56:16 +0100
Subject: [PATCH] ASoC: tfa9879: Export OF device ID as module alias

The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
device was registered via OF, this means that exporting the OF device ID
table device aliases in the module is not needed. But in order to change
how the core reports modaliases to user-space, it's better to export it.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-tfa9879.ko  | grep alias
alias:          i2c:tfa9879

After this patch:

$ modinfo sound/soc/codecs/snd-soc-tfa9879.ko  | grep alias
alias:          i2c:tfa9879
alias:          of:N*T*Cnxp,tfa9879C*
alias:          of:N*T*Cnxp,tfa9879

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tfa9879.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index f8dd67ca0744..e7ca764b5729 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -316,6 +316,7 @@ static const struct of_device_id tfa9879_of_match[] = {
 	{ .compatible = "nxp,tfa9879", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, tfa9879_of_match);
 
 static struct i2c_driver tfa9879_i2c_driver = {
 	.driver = {
-- 
2.15.0
