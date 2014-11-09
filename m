From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] ASoC: wm8958: Move DSP firmware lock to
	driver level
Date: Sun,  9 Nov 2014 17:01:02 +0100
Message-ID: <1415548864-27203-7-git-send-email-lars@metafoo.de>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EAFB260560
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 17:01:09 +0100 (CET)
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

The wm8958 driver uses the snd_soc_codec mutex to protect the various
firmware pointers from concurrent assignment. This patch moves this lock to
the driver level. This will allow us to eventually remove the snd_soc_codec
mutex.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
To be honest I'm not sure what this lock actually protects against. The
assignments should be atomic already.
---
 sound/soc/codecs/wm8958-dsp2.c | 12 ++++++------
 sound/soc/codecs/wm8994.c      |  2 ++
 sound/soc/codecs/wm8994.h      |  2 ++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 0dada7f..3cbc82b 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -867,9 +867,9 @@ static void wm8958_enh_eq_loaded(const struct firmware *fw, void *context)
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (fw && (wm8958_dsp2_fw(codec, "ENH_EQ", fw, true) == 0)) {
-		mutex_lock(&codec->mutex);
+		mutex_lock(&wm8994->fw_lock);
 		wm8994->enh_eq = fw;
-		mutex_unlock(&codec->mutex);
+		mutex_unlock(&wm8994->fw_lock);
 	}
 }
 
@@ -879,9 +879,9 @@ static void wm8958_mbc_vss_loaded(const struct firmware *fw, void *context)
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (fw && (wm8958_dsp2_fw(codec, "MBC+VSS", fw, true) == 0)) {
-		mutex_lock(&codec->mutex);
+		mutex_lock(&wm8994->fw_lock);
 		wm8994->mbc_vss = fw;
-		mutex_unlock(&codec->mutex);
+		mutex_unlock(&wm8994->fw_lock);
 	}
 }
 
@@ -891,9 +891,9 @@ static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (fw && (wm8958_dsp2_fw(codec, "MBC", fw, true) == 0)) {
-		mutex_lock(&codec->mutex);
+		mutex_lock(&wm8994->fw_lock);
 		wm8994->mbc = fw;
-		mutex_unlock(&codec->mutex);
+		mutex_unlock(&wm8994->fw_lock);
 	}
 }
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1fcb9f3..dbca6e0 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4457,6 +4457,8 @@ static int wm8994_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, wm8994);
 
+	mutex_init(&wm8994->fw_lock);
+
 	wm8994->wm8994 = dev_get_drvdata(pdev->dev.parent);
 
 	pm_runtime_enable(&pdev->dev);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 6536f8d..dd73387 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -13,6 +13,7 @@
 #include <linux/firmware.h>
 #include <linux/completion.h>
 #include <linux/workqueue.h>
+#include <linux/mutex.h>
 
 #include "wm_hubs.h"
 
@@ -156,6 +157,7 @@ struct wm8994_priv {
 	unsigned int aif1clk_disable:1;
 	unsigned int aif2clk_disable:1;
 
+	struct mutex fw_lock;
 	int dsp_active;
 	const struct firmware *cur_fw;
 	const struct firmware *mbc;
-- 
1.8.0
