From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: qdsp6: q6routing: off by one in
	routing_hw_params()
Date: Fri, 13 Jul 2018 18:11:04 +0300
Message-ID: <20180713151100.x5usbqhlhrzjmeoq@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 973C8267727
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 17:11:17 +0200 (CEST)
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

The data->port_data[] array has AFE_MAX_PORTS elements so the check
should be >= instead of > or we write one element beyond the end of the
array.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 35269b492761..0e7cf9e35d51 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -927,7 +927,7 @@ static int routing_hw_params(struct snd_pcm_substream *substream,
 	else
 		path_type = ADM_PATH_LIVE_REC;
 
-	if (be_id > AFE_MAX_PORTS)
+	if (be_id >= AFE_MAX_PORTS)
 		return -EINVAL;
 
 	session = &data->port_data[be_id];
