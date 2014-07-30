From: weiyj_lk@163.com
Subject: [PATCH] ASoC: sirf-audio-codec: Fix return value check
	in sirf_audio_codec_driver_probe()
Date: Wed, 30 Jul 2014 08:04:12 +0800
Message-ID: <1406678652-31950-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by alsa0.perex.cz (Postfix) with ESMTP id D057426549D
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 02:04:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Barry Song <baohua@kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Rongjun Ying <rongjun.ying@csr.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/sirf-audio-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index d90cb0f..06ba492 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -471,8 +471,8 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mem_res);
-	if (base == NULL)
-		return -ENOMEM;
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	sirf_audio_codec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					    &sirf_audio_codec_regmap_config);
