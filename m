From: Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] ASoC: tfa9879: Export OF device ID as module alias
Date: Thu, 30 Nov 2017 18:56:16 +0100
Message-ID: <20171130175616.29073-1-javierm@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Javier Martinez Canillas <javierm@redhat.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

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
2.14.3
