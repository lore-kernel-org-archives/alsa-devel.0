From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 5/6] ASoC: wm8978: Add OF device ID table
Date: Tue,  4 Apr 2017 15:26:29 -0400
Message-ID: <20170404192630.11408-6-javier@osg.samsung.com>
References: <20170404192630.11408-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404192630.11408-1-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

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
2.9.3
