From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 4/6] ASoC: uda1380: Add OF device ID table
Date: Tue,  4 Apr 2017 15:26:28 -0400
Message-ID: <20170404192630.11408-5-javier@osg.samsung.com>
References: <20170404192630.11408-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404192630.11408-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

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
2.9.3
