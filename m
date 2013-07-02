From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: ttc_dkb: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 17:26:40 +0800
Message-ID: <CAPgLHd_CJUYf8Ry=J9Y8ZPSrCgqPLTj74rDr__bxoymQ8GR_1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing .owner of struct snd_soc_card. This prevents the
module from being removed from underneath its users.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/pxa/ttc-dkb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index f4ea4f6..13c9ee0 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -122,6 +122,7 @@ static struct snd_soc_dai_link ttc_pm860x_hifi_dai[] = {
 /* ttc/td audio machine driver */
 static struct snd_soc_card ttc_dkb_card = {
 	.name = "ttc-dkb-hifi",
+	.owner = THIS_MODULE,
 	.dai_link = ttc_pm860x_hifi_dai,
 	.num_links = ARRAY_SIZE(ttc_pm860x_hifi_dai),
 
