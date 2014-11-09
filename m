From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] ASoC: wm8962: Move DSP enable lock to the
	driver level
Date: Sun,  9 Nov 2014 17:01:03 +0100
Message-ID: <1415548864-27203-8-git-send-email-lars@metafoo.de>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D82F260563
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 17:01:10 +0100 (CET)
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

The wm8962 uses the snd_soc_codec mutex to protect the wm8962_dsp2_ena_put()
function from concurrent execution. This patch moves that lock to the driver
level. This will allow us to eventually remove the snd_soc_codec mutex.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8962.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 9077411..61ca4a7 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -26,6 +26,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/mutex.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -67,6 +68,7 @@ struct wm8962_priv {
 	int fll_fref;
 	int fll_fout;
 
+	struct mutex dsp2_ena_lock;
 	u16 dsp2_ena;
 
 	struct delayed_work mic_work;
@@ -1570,7 +1572,7 @@ static int wm8962_dsp2_ena_put(struct snd_kcontrol *kcontrol,
 	int dsp2_running = snd_soc_read(codec, WM8962_DSP2_POWER_MANAGEMENT) &
 		WM8962_DSP2_ENA;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock(&wm8962->dsp2_ena_lock);
 
 	if (ucontrol->value.integer.value[0])
 		wm8962->dsp2_ena |= 1 << shift;
@@ -1590,7 +1592,7 @@ static int wm8962_dsp2_ena_put(struct snd_kcontrol *kcontrol,
 	}
 
 out:
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&wm8962->dsp2_ena_lock);
 
 	return ret;
 }
@@ -3557,6 +3559,8 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	if (wm8962 == NULL)
 		return -ENOMEM;
 
+	mutex_init(&wm8962->dsp2_ena_lock);
+
 	i2c_set_clientdata(i2c, wm8962);
 
 	INIT_DELAYED_WORK(&wm8962->mic_work, wm8962_mic_work);
-- 
1.8.0
