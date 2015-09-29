From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: fix error message output for MicBias voltage" to the asoc tree
Date: Tue, 29 Sep 2015 19:04:59 +0100
Message-ID: <E1ZgzGt-0003Zf-Mb@finisterre>
References: <1443209622-7716-2-git-send-email-gianlucarenzi@eurekelettronica.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443209622-7716-2-git-send-email-gianlucarenzi@eurekelettronica.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-kernel@vger.kernel.org, Gianluca Renzi <gianlucarenzi@eurekelettronica.it>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: fix error message output for MicBias voltage

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

>From fb97d75b038659998257f7dd767d8229dce50b74 Mon Sep 17 00:00:00 2001
From: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
Date: Fri, 25 Sep 2015 21:33:42 +0200
Subject: [PATCH] ASoC: sgtl5000: fix error message output for MicBias voltage

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index bfda25e..6e7843e 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1549,7 +1549,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 			else {
 				sgtl5000->micbias_voltage = 0;
 				dev_err(&client->dev,
-					"Unsuitable MicBias resistor\n");
+					"Unsuitable MicBias voltage\n");
 			}
 		} else {
 			sgtl5000->micbias_voltage = 0;
-- 
2.5.0
