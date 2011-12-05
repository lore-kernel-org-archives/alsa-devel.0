From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert e740_wm9705 to use
	gpio_request_one()
Date: Mon, 05 Dec 2011 17:09:11 +0800
Message-ID: <1323076151.29944.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 963B124474
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 10:09:22 +0100 (CET)
Received: by ghbg15 with SMTP id g15so4670729ghb.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 01:09:20 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Ian Molton <spyro@f2s.com>, Liam@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/e740_wm9705.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 35ed7eb8c..818dc57 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -146,29 +146,21 @@ static int __init e740_init(void)
 	if (!machine_is_e740())
 		return -ENODEV;
 
-	ret = gpio_request(GPIO_E740_MIC_ON,  "Mic amp");
+	/* Disable audio */
+	ret = gpio_request_one(GPIO_E740_MIC_ON, GPIOF_OUT_INIT_LOW, "Mic amp");
 	if (ret)
 		return ret;
 
-	ret = gpio_request(GPIO_E740_AMP_ON, "Output amp");
+	ret = gpio_request_one(GPIO_E740_AMP_ON, GPIOF_OUT_INIT_LOW,
+			       "Output amp");
 	if (ret)
 		goto free_mic_amp_gpio;
 
-	ret = gpio_request(GPIO_E740_WM9705_nAVDD2, "Audio power");
+	ret = gpio_request_one(GPIO_E740_WM9705_nAVDD2, GPIOF_OUT_INIT_HIGH,
+			   "Audio power");
 	if (ret)
 		goto free_op_amp_gpio;
 
-	/* Disable audio */
-	ret = gpio_direction_output(GPIO_E740_MIC_ON, 0);
-	if (ret)
-		goto free_apwr_gpio;
-	ret = gpio_direction_output(GPIO_E740_AMP_ON, 0);
-	if (ret)
-		goto free_apwr_gpio;
-	ret = gpio_direction_output(GPIO_E740_WM9705_nAVDD2, 1);
-	if (ret)
-		goto free_apwr_gpio;
-
 	e740_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!e740_snd_device) {
 		ret = -ENOMEM;
-- 
1.7.5.4
