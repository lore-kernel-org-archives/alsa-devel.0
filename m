From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: fix a range check in
 of_q6afe_parse_dai_data()
Date: Fri, 13 Jul 2018 18:05:57 +0300
Message-ID: <20180713150557.gsx7wrau2l7tg2jq@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id AC5D2267600
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 17:06:13 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>
List-Id: alsa-devel@alsa-project.org

The main thing is that the data->priv[] array has AFE_PORT_MAX elements
so the > condition should be >=.  But we may as well check for negative
values as well just to be safe.

Fixes: 24c4cbcfac09 ("ASoC: qdsp6: q6afe: Add q6afe dai driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index e7f809e3ee1f..89df25e711c5 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1329,7 +1329,7 @@ static void of_q6afe_parse_dai_data(struct device *dev,
 		int id, i, num_lines;
 
 		ret = of_property_read_u32(node, "reg", &id);
-		if (ret || id > AFE_PORT_MAX) {
+		if (ret || id < 0 || id >= AFE_PORT_MAX) {
 			dev_err(dev, "valid dai id not found:%d\n", ret);
 			continue;
 		}
