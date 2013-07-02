From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: imx_mc13783: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 17:26:00 +0800
Message-ID: <CAPgLHd9uFhvTi+Kw2RkJEQLVepeC8K0WA2ZhPY=N7jveY0T3OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, wfp5p@virginia.edu, fabio.estevam@freescale.com, shawn.guo@linaro.org
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing .owner of struct snd_soc_card. This prevents the
module from being removed from underneath its users.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/fsl/imx-mc13783.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 9df173c..55742a1 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -90,6 +90,7 @@ static const struct snd_soc_dapm_route imx_mc13783_routes[] = {
 
 static struct snd_soc_card imx_mc13783 = {
 	.name		= "imx_mc13783",
+	.owner		= THIS_MODULE,
 	.dai_link	= imx_mc13783_dai_mc13783,
 	.num_links	= ARRAY_SIZE(imx_mc13783_dai_mc13783),
 	.dapm_widgets	= imx_mc13783_widget,
