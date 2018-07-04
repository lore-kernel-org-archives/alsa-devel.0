From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/6] ASoC: qdsp6: q6afe-dai: Do not overwrite
	slim dai num_channels
Date: Wed,  4 Jul 2018 10:49:42 +0100
Message-ID: <20180704094944.16440-5-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 945D126772D
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 11:51:57 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id j33-v6so4678950wrj.5
 for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2018 02:51:57 -0700 (PDT)
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

num_channels for slim dais are aready set int set_channel_map,
do not overwrite them in hw_params.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 8dd3683eb367..074582afda85 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -81,7 +81,6 @@ static int q6slim_hw_params(struct snd_pcm_substream *substream,
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	struct q6afe_slim_cfg *slim = &dai_data->port_config[dai->id].slim;
 
-	slim->num_channels = params_channels(params);
 	slim->sample_rate = params_rate(params);
 
 	switch (params_format(params)) {
-- 
2.16.2
