From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/6] ASoC: sta529: Add OF device ID table
Date: Tue,  4 Apr 2017 15:26:27 -0400
Message-ID: <20170404192630.11408-4-javier@osg.samsung.com>
References: <20170404192630.11408-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CE84266F16
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 21:26:58 +0200 (CEST)
In-Reply-To: <20170404192630.11408-1-javier@osg.samsung.com>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-sta529.ko | grep alias
alias:          i2c:sta529

After this patch:

$ modinfo sound/soc/codecs/snd-soc-sta529.ko | grep alias
alias:          of:N*T*Cst,sta529C*
alias:          of:N*T*Cst,sta529
alias:          i2c:sta529

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 sound/soc/codecs/sta529.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index d4b384e4b266..660734359bf3 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -375,9 +375,16 @@ static const struct i2c_device_id sta529_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, sta529_i2c_id);
 
+static const struct of_device_id sta529_of_match[] = {
+	{ .compatible = "st,sta529", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sta529_of_match);
+
 static struct i2c_driver sta529_i2c_driver = {
 	.driver = {
 		.name = "sta529",
+		.of_match_table = sta529_of_match,
 	},
 	.probe		= sta529_i2c_probe,
 	.remove		= sta529_i2c_remove,
-- 
2.9.3
