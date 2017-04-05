From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uda1380: Add OF device ID table" to the
	asoc tree
Date: Wed, 05 Apr 2017 18:30:39 +0100
Message-ID: <E1cvolT-0000fa-1v@debutante>
References: <20170404192630.11408-5-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80ABE26717C
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 19:30:54 +0200 (CEST)
In-Reply-To: <20170404192630.11408-5-javier@osg.samsung.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uda1380: Add OF device ID table

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

>From ea22a26e676ebc39a2ba7836e814864bf85324e7 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 4 Apr 2017 15:26:28 -0400
Subject: [PATCH] ASoC: uda1380: Add OF device ID table

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-uda1380.ko | grep alias
alias:          i2c:uda1380

After this patch:

$ modinfo sound/soc/codecs/snd-soc-uda1380.ko | grep alias
alias:          of:N*T*Cnxp,uda1380C*
alias:          of:N*T*Cnxp,uda1380
alias:          i2c:uda1380

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/uda1380.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 2918fdb95e58..61cdc79840e7 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -791,9 +791,16 @@ static const struct i2c_device_id uda1380_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, uda1380_i2c_id);
 
+static const struct of_device_id uda1380_of_match[] = {
+	{ .compatible = "nxp,uda1380", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, uda1380_of_match);
+
 static struct i2c_driver uda1380_i2c_driver = {
 	.driver = {
 		.name =  "uda1380-codec",
+		.of_match_table = uda1380_of_match,
 	},
 	.probe =    uda1380_i2c_probe,
 	.remove =   uda1380_i2c_remove,
-- 
2.11.0
