From: Vasiliy Kulikov <segoon@openwall.com>
Subject: [PATCH] ASoC: s3c24xx: test wrong variable
Date: Sun, 21 Nov 2010 20:40:21 +0300
Message-ID: <1290361223-15211-1-git-send-email-segoon@openwall.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

After clk_get() mclk is checked three times instead of mout_epll
and sclk_spdif checks.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile this driver, so it is not tested.

 sound/soc/s3c24xx/smdk_spdif.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk_spdif.c b/sound/soc/s3c24xx/smdk_spdif.c
index 11c88b1..761e02b 100644
--- a/sound/soc/s3c24xx/smdk_spdif.c
+++ b/sound/soc/s3c24xx/smdk_spdif.c
@@ -38,7 +38,7 @@ static int set_audio_clock_heirachy(struct platform_device *pdev)
 	}
 
 	mout_epll = clk_get(NULL, "mout_epll");
-	if (IS_ERR(fout_epll)) {
+	if (IS_ERR(mout_epll)) {
 		printk(KERN_WARNING "%s: Cannot find mout_epll.\n",
 				__func__);
 		ret = -EINVAL;
@@ -54,7 +54,7 @@ static int set_audio_clock_heirachy(struct platform_device *pdev)
 	}
 
 	sclk_spdif = clk_get(NULL, "sclk_spdif");
-	if (IS_ERR(fout_epll)) {
+	if (IS_ERR(sclk_spdif)) {
 		printk(KERN_WARNING "%s: Cannot find sclk_spdif.\n",
 				__func__);
 		ret = -EINVAL;
-- 
1.7.0.4
