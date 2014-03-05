From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] ASoC: Add component pointer to the DAI
	struct
Date: Wed,  5 Mar 2014 13:17:46 +0100
Message-ID: <1394021868-11860-5-git-send-email-lars@metafoo.de>
References: <1394021868-11860-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 3826E2650AE
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 13:17:22 +0100 (CET)
In-Reply-To: <1394021868-11860-1-git-send-email-lars@metafoo.de>
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Keep track of which component registered a DAI. We'll need this as
componentization progresses.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h |  1 +
 sound/soc/soc-core.c    | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 71f27c4..8763e53 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -270,6 +270,7 @@ struct snd_soc_dai {
 	/* parent platform/codec */
 	struct snd_soc_platform *platform;
 	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 
 	struct snd_soc_card *card;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fe1df50..6401e97 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3884,11 +3884,13 @@ static inline char *fmt_multiple_name(struct device *dev,
 /**
  * snd_soc_register_dai - Register a DAI with the ASoC core
  *
- * @dai: DAI to register
+ * @component: The component the DAIs are registered for
+ * @dai_drv: DAI driver to use for the DAIs
  */
-static int snd_soc_register_dai(struct device *dev,
+static int snd_soc_register_dai(struct snd_soc_component *component,
 		struct snd_soc_dai_driver *dai_drv)
 {
+	struct device *dev = component->dev;
 	struct snd_soc_codec *codec;
 	struct snd_soc_dai *dai;
 
@@ -3905,6 +3907,7 @@ static int snd_soc_register_dai(struct device *dev,
 		return -ENOMEM;
 	}
 
+	dai->component = component;
 	dai->dev = dev;
 	dai->driver = dai_drv;
 	dai->dapm.dev = dev;
@@ -3962,12 +3965,14 @@ found:
 /**
  * snd_soc_register_dais - Register multiple DAIs with the ASoC core
  *
- * @dai: Array of DAIs to register
+ * @component: The component the DAIs are registered for
+ * @dai_drv: DAI driver to use for the DAIs
  * @count: Number of DAIs
  */
-static int snd_soc_register_dais(struct device *dev,
+static int snd_soc_register_dais(struct snd_soc_component *component,
 		struct snd_soc_dai_driver *dai_drv, size_t count)
 {
+	struct device *dev = component->dev;
 	struct snd_soc_codec *codec;
 	struct snd_soc_dai *dai;
 	int i, ret = 0;
@@ -3990,6 +3995,7 @@ static int snd_soc_register_dais(struct device *dev,
 			goto err;
 		}
 
+		dai->component = component;
 		dai->dev = dev;
 		dai->driver = &dai_drv[i];
 		if (dai->driver->id)
@@ -4086,9 +4092,9 @@ __snd_soc_register_component(struct device *dev,
 	 * since it had been used snd_soc_register_dais(),
 	 */
 	if ((1 == num_dai) && allow_single_dai)
-		ret = snd_soc_register_dai(dev, dai_drv);
+		ret = snd_soc_register_dai(cmpnt, dai_drv);
 	else
-		ret = snd_soc_register_dais(dev, dai_drv, num_dai);
+		ret = snd_soc_register_dais(cmpnt, dai_drv, num_dai);
 	if (ret < 0) {
 		dev_err(dev, "ASoC: Failed to regster DAIs: %d\n", ret);
 		goto error_component_name;
-- 
1.8.0
