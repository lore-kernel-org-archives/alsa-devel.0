From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 1/3] ASoC: stm32: dfsdm: manage multiple prepare
Date: Mon, 4 Mar 2019 15:52:43 +0100
Message-ID: <1551711165-28684-2-git-send-email-olivier.moysan@st.com>
References: <1551711165-28684-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7EB7F80733
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 15:53:07 +0100 (CET)
In-Reply-To: <1551711165-28684-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The DFSDM must be stopped when a new setting is applied.
restart systematically DFSDM on multiple prepare calls,
to apply changes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 706ff005234f..71d341b732a4 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -37,6 +38,8 @@ struct stm32_adfsdm_priv {
 	/* PCM buffer */
 	unsigned char *pcm_buff;
 	unsigned int pos;
+
+	struct mutex lock; /* protect against race condition on iio state */
 };
 
 static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
@@ -62,10 +65,12 @@ static void stm32_adfsdm_shutdown(struct snd_pcm_substream *substream,
 {
 	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
 
+	mutex_lock(&priv->lock);
 	if (priv->iio_active) {
 		iio_channel_stop_all_cb(priv->iio_cb);
 		priv->iio_active = false;
 	}
+	mutex_unlock(&priv->lock);
 }
 
 static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
@@ -74,13 +79,19 @@ static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
 	struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	mutex_lock(&priv->lock);
+	if (priv->iio_active) {
+		iio_channel_stop_all_cb(priv->iio_cb);
+		priv->iio_active = false;
+	}
+
 	ret = iio_write_channel_attribute(priv->iio_ch,
 					  substream->runtime->rate, 0,
 					  IIO_CHAN_INFO_SAMP_FREQ);
 	if (ret < 0) {
 		dev_err(dai->dev, "%s: Failed to set %d sampling rate\n",
 			__func__, substream->runtime->rate);
-		return ret;
+		goto out;
 	}
 
 	if (!priv->iio_active) {
@@ -92,6 +103,9 @@ static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
 				__func__, ret);
 	}
 
+out:
+	mutex_unlock(&priv->lock);
+
 	return ret;
 }
 
@@ -298,6 +312,7 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	priv->dai_drv = stm32_adfsdm_dai;
+	mutex_init(&priv->lock);
 
 	dev_set_drvdata(&pdev->dev, priv);
 
-- 
2.7.4
