From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ASoC: max9867: export OF device ID as module
	aliases
Date: Tue,  4 Apr 2017 13:19:39 -0400
Message-ID: <20170404171939.3950-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 96536266834
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 19:19:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

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
---

 sound/soc/codecs/max9867.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 6cdf15ab46de..0247edc9c84e 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -516,13 +516,13 @@ static const struct i2c_device_id max9867_i2c_id[] = {
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
2.9.3
