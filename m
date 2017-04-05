From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8978: Add OF device ID table" to the
	asoc tree
Date: Wed, 05 Apr 2017 18:30:36 +0100
Message-ID: <E1cvolQ-0000ed-2N@debutante>
References: <20170404192630.11408-6-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DB3267198
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 19:30:59 +0200 (CEST)
In-Reply-To: <20170404192630.11408-6-javier@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8978: Add OF device ID table

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

>From 5cf015d9cb02c360582b624497b0a1716881cf28 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 4 Apr 2017 15:26:29 -0400
Subject: [PATCH] ASoC: wm8978: Add OF device ID table

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-wm8978.ko | grep alias
alias:          i2c:wm8978

After this patch:

$ modinfo sound/soc/codecs/snd-soc-wm8978.ko | grep alias
alias:          i2c:wm8978
alias:          of:N*T*Cwlf,wm8978C*
alias:          of:N*T*Cwlf,wm8978

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8978.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 90b2d418ef60..cf761e2d7546 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1071,9 +1071,16 @@ static const struct i2c_device_id wm8978_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8978_i2c_id);
 
+static const struct of_device_id wm8978_of_match[] = {
+	{ .compatible = "wlf,wm8978", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8978_of_match);
+
 static struct i2c_driver wm8978_i2c_driver = {
 	.driver = {
 		.name = "wm8978",
+		.of_match_table = wm8978_of_match,
 	},
 	.probe =    wm8978_i2c_probe,
 	.remove =   wm8978_i2c_remove,
-- 
2.11.0
