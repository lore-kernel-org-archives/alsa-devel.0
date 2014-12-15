From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2 1/2] ASoC: rt5670: Add runtime PM support
Date: Mon, 15 Dec 2014 15:42:33 +0800
Message-ID: <1418629354-26948-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9686B260573
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 08:43:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch adds runtime PM support on rt5670 codec.

Signed-off-by: Lin Mengdong <mengdong.lin@intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
* Remove the unused runtime suspend/resume code. We will switch
  the sysclk source on another patch.
---
 sound/soc/codecs/rt5670.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 09cf100..a8a471b 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
@@ -2734,18 +2735,26 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 
 	}
 
+	pm_runtime_enable(&i2c->dev);
+	pm_request_idle(&i2c->dev);
+
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5670,
 			rt5670_dai, ARRAY_SIZE(rt5670_dai));
 	if (ret < 0)
 		goto err;
 
+	pm_runtime_put(&i2c->dev);
+
 	return 0;
 err:
+	pm_runtime_disable(&i2c->dev);
+
 	return ret;
 }
 
 static int rt5670_i2c_remove(struct i2c_client *i2c)
 {
+	pm_runtime_disable(&i2c->dev);
 	snd_soc_unregister_codec(&i2c->dev);
 
 	return 0;
-- 
1.8.1.1.439.g50a6b54
