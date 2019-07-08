From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [RFC PATCH] ASoC: max98357a: use mdelay for
	sdmode-delay
Date: Mon,  8 Jul 2019 22:19:01 +0800
Message-ID: <20190708141901.68797-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC0D0F801A4
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2019 16:19:23 +0200 (CEST)
Received: by mail-qt1-x849.google.com with SMTP id l9so9763920qtu.12
 for <alsa-devel@alsa-project.org>; Mon, 08 Jul 2019 07:19:23 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

max98357a_daiops_trigger() is possible to be called in atomic context if
the .nonatomic flag is equal to 0 in the DAI links.

When cancel_delayed_work_sync() in max98357a_daiops_trigger() is called
in atomic context, kernel emits the following message: "BUG: sleeping
function called from invalid context".

According to the DT binding document, value less than or equal to 5ms of
sdmod-delay should be sufficient to avoid the pop noise.  Use mdelay
(i.e. busy loop) for such low delay should be acceptable.

Fixes: cec5b01f8f1c ("ASoC: max98357a: avoid speaker pop when playback
startup")

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Hi,

Not sure whether this fix is acceptable or not.  Because in the document
"timers-howto.txt", it states "In general, use of mdelay is discouraged
and code should be refactored to allow for the use of msleep."

 sound/soc/codecs/max98357a.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 6f0e28f903bf..16313b973eaa 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -20,20 +20,10 @@
 #include <sound/soc-dapm.h>
 
 struct max98357a_priv {
-	struct delayed_work enable_sdmode_work;
 	struct gpio_desc *sdmode;
 	unsigned int sdmode_delay;
 };
 
-static void max98357a_enable_sdmode_work(struct work_struct *work)
-{
-	struct max98357a_priv *max98357a =
-	container_of(work, struct max98357a_priv,
-			enable_sdmode_work.work);
-
-	gpiod_set_value(max98357a->sdmode, 1);
-}
-
 static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
 {
@@ -46,14 +36,12 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		queue_delayed_work(system_power_efficient_wq,
-				&max98357a->enable_sdmode_work,
-				msecs_to_jiffies(max98357a->sdmode_delay));
+		mdelay(max98357a->sdmode_delay);
+		gpiod_set_value(max98357a->sdmode, 1);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		cancel_delayed_work_sync(&max98357a->enable_sdmode_work);
 		gpiod_set_value(max98357a->sdmode, 0);
 		break;
 	}
@@ -112,30 +100,25 @@ static int max98357a_platform_probe(struct platform_device *pdev)
 	int ret;
 
 	max98357a = devm_kzalloc(&pdev->dev, sizeof(*max98357a), GFP_KERNEL);
-
 	if (!max98357a)
 		return -ENOMEM;
 
 	max98357a->sdmode = devm_gpiod_get_optional(&pdev->dev,
 				"sdmode", GPIOD_OUT_LOW);
-
 	if (IS_ERR(max98357a->sdmode))
 		return PTR_ERR(max98357a->sdmode);
 
 	ret = device_property_read_u32(&pdev->dev, "sdmode-delay",
 					&max98357a->sdmode_delay);
-
 	if (ret) {
 		max98357a->sdmode_delay = 0;
 		dev_dbg(&pdev->dev,
-			"no optional property 'sdmode-delay' found, default: no delay\n");
+			"no optional property 'sdmode-delay' found, "
+			"default: no delay\n");
 	}
 
 	dev_set_drvdata(&pdev->dev, max98357a);
 
-	INIT_DELAYED_WORK(&max98357a->enable_sdmode_work,
-				max98357a_enable_sdmode_work);
-
 	return devm_snd_soc_register_component(&pdev->dev,
 			&max98357a_component_driver,
 			&max98357a_dai_driver, 1);
-- 
2.22.0.410.gd8fdbe21b5-goog
