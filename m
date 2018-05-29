From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] ASoC: qdsp6: q6afe-dai: use
	q6afe_dai_prepare() for MI2S
Date: Tue, 29 May 2018 11:18:30 +0100
Message-ID: <20180529101833.30489-4-srinivas.kandagatla@linaro.org>
References: <20180529101833.30489-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 406922671EE
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 12:20:56 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id i14-v6so24533831wre.2
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 03:20:55 -0700 (PDT)
In-Reply-To: <20180529101833.30489-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, spatakok@qti.qualcomm.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Use common q6afe_dai_prepare() for MI2S dais, this will remove
some code duplication. Also make the if statement to switch to
make the code look neater.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 53 ++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 4378e29a95c5..e529edfd8001 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -144,38 +144,6 @@ static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
 
 }
 
-static int q6afe_mi2s_prepare(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
-	int rc;
-
-	if (dai_data->is_port_started[dai->id]) {
-		/* stop the port and restart with new port config */
-		rc = q6afe_port_stop(dai_data->port[dai->id]);
-		if (rc < 0) {
-			dev_err(dai->dev, "fail to close AFE port (%d)\n", rc);
-			return rc;
-		}
-	}
-
-	rc = q6afe_i2s_port_prepare(dai_data->port[dai->id],
-			       &dai_data->port_config[dai->id].i2s_cfg);
-	if (rc < 0) {
-		dev_err(dai->dev, "fail to prepare AFE port %x\n", dai->id);
-		return rc;
-	}
-
-	rc = q6afe_port_start(dai_data->port[dai->id]);
-	if (rc < 0) {
-		dev_err(dai->dev, "fail to start AFE port %x\n", dai->id);
-		return rc;
-	}
-	dai_data->is_port_started[dai->id] = true;
-
-	return 0;
-}
-
 static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -191,12 +159,27 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (dai->id == HDMI_RX)
+	switch (dai->id) {
+	case HDMI_RX:
 		q6afe_hdmi_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].hdmi);
-	else if (dai->id >= SLIMBUS_0_RX && dai->id <= SLIMBUS_6_TX)
+		break;
+	case SLIMBUS_0_RX ... SLIMBUS_6_TX:
 		q6afe_slim_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].slim);
+		break;
+	case PRIMARY_MI2S_RX ... QUATERNARY_MI2S_TX:
+		rc = q6afe_i2s_port_prepare(dai_data->port[dai->id],
+			       &dai_data->port_config[dai->id].i2s_cfg);
+		if (rc < 0) {
+			dev_err(dai->dev, "fail to prepare AFE port %x\n",
+				dai->id);
+			return rc;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	rc = q6afe_port_start(dai_data->port[dai->id]);
 	if (rc < 0) {
@@ -289,7 +272,7 @@ static struct snd_soc_dai_ops q6hdmi_ops = {
 };
 
 static struct snd_soc_dai_ops q6i2s_ops = {
-	.prepare	= q6afe_mi2s_prepare,
+	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6i2s_hw_params,
 	.set_fmt	= q6i2s_set_fmt,
 	.shutdown	= q6afe_dai_shutdown,
-- 
2.16.2
