From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: brownstone: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 17:26:21 +0800
Message-ID: <CAPgLHd-VN4BiM=cEkFF4EgbL7iqR1XrhEzBiKyoJBVnzKspHJg@mail.gmail.com>
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
 sound/soc/pxa/brownstone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 4ad7609..e582c05 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -129,6 +129,7 @@ static struct snd_soc_dai_link brownstone_wm8994_dai[] = {
 /* audio machine driver */
 static struct snd_soc_card brownstone = {
 	.name         = "brownstone",
+	.owner        = THIS_MODULE,
 	.dai_link     = brownstone_wm8994_dai,
 	.num_links    = ARRAY_SIZE(brownstone_wm8994_dai),
 
