From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/8] ASoC: wm8903: Move the deemph lock to the
	driver level
Date: Sun,  9 Nov 2014 17:01:01 +0100
Message-ID: <1415548864-27203-6-git-send-email-lars@metafoo.de>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 27E4F26055D
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 17:01:08 +0100 (CET)
In-Reply-To: <1415548864-27203-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org

The wm8903 uses the snd_soc_codec mutex to protect its deemph settings from
concurrent access. This patch moves this lock to the driver level. This will
allow us to eventually remove the snd_soc_codec mutex.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8903.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index c038b3e..ffbe6df 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -26,6 +26,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
+#include <linux/mutex.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -123,6 +124,7 @@ struct wm8903_priv {
 	int sysclk;
 	int irq;
 
+	struct mutex lock;
 	int fs;
 	int deemph;
 
@@ -457,7 +459,7 @@ static int wm8903_put_deemph(struct snd_kcontrol *kcontrol,
 	if (deemph > 1)
 		return -EINVAL;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&wm8903->lock);
 	if (wm8903->deemph != deemph) {
 		wm8903->deemph = deemph;
 
@@ -465,7 +467,7 @@ static int wm8903_put_deemph(struct snd_kcontrol *kcontrol,
 
 		ret = 1;
 	}
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&wm8903->lock);
 
 	return ret;
 }
@@ -2023,6 +2025,8 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 			      GFP_KERNEL);
 	if (wm8903 == NULL)
 		return -ENOMEM;
+
+	mutex_init(&wm8903->lock);
 	wm8903->dev = &i2c->dev;
 
 	wm8903->regmap = devm_regmap_init_i2c(i2c, &wm8903_regmap);
-- 
1.8.0
