From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: mop500: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 17:25:37 +0800
Message-ID: <CAPgLHd8i0kcs5RE2UUPmFS5ueMgRAzofeaAUnGz4WuYFBANeBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com, lee.jones@linaro.org, linus.walleij@linaro.org, ola.o.lilja@stericsson.com, wfp5p@virginia.edu
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing .owner of struct snd_soc_card. This prevents the
module from being removed from underneath its users.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/ux500/mop500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 8f5cd00..178d1ba 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -52,6 +52,7 @@ static struct snd_soc_dai_link mop500_dai_links[] = {
 
 static struct snd_soc_card mop500_card = {
 	.name = "MOP500-card",
+	.owner = THIS_MODULE,
 	.probe = NULL,
 	.dai_link = mop500_dai_links,
 	.num_links = ARRAY_SIZE(mop500_dai_links),
