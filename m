From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: stm32: fix a typo in
	stm32_adfsdm_probe()
Date: Thu, 11 Jan 2018 11:11:51 +0000
Message-ID: <1515669111-125208-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (unknown [45.249.212.32])
 by alsa0.perex.cz (Postfix) with ESMTP id D1ACE266E76
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 12:05:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Fix a typo, we should return PTR_ERR(priv->iio_cb) instead of
PTR_ERR(priv->iio_ch).

Fixes: 55da094824c4 ("ASoC: stm32: add DFSDM DAI support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index af50891..7306e3e 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -320,7 +320,7 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 
 	priv->iio_cb = iio_channel_get_all_cb(&pdev->dev, NULL, NULL);
 	if (IS_ERR(priv->iio_cb))
-		return PTR_ERR(priv->iio_ch);
+		return PTR_ERR(priv->iio_cb);
 
 	ret = devm_snd_soc_register_platform(&pdev->dev,
 					     &stm32_adfsdm_soc_platform);
