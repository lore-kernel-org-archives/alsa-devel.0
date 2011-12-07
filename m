From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: Convert e750_wm9705 to use
	gpio_request_one()
Date: Wed, 07 Dec 2011 10:04:07 +0800
Message-ID: <1323223447.7936.4.camel@phoenix>
References: <1323223290.7936.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 415EA24581
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 03:04:14 +0100 (CET)
Received: by ghbg15 with SMTP id g15so55804ghb.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2011 18:04:13 -0800 (PST)
In-Reply-To: <1323223290.7936.1.camel@phoenix>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/e750_wm9705.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index ce5f056..55c53d1 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -129,22 +129,16 @@ static int __init e750_init(void)
 	if (!machine_is_e750())
 		return -ENODEV;
 
-	ret = gpio_request(GPIO_E750_HP_AMP_OFF,  "Headphone amp");
+	ret = gpio_request_one(GPIO_E750_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH,
+			       "Headphone amp");
 	if (ret)
 		return ret;
 
-	ret = gpio_request(GPIO_E750_SPK_AMP_OFF, "Speaker amp");
+	ret = gpio_request_one(GPIO_E750_SPK_AMP_OFF, GPIOF_OUT_INIT_HIGH,
+			       "Speaker amp");
 	if (ret)
 		goto free_hp_amp_gpio;
 
-	ret = gpio_direction_output(GPIO_E750_HP_AMP_OFF, 1);
-	if (ret)
-		goto free_spk_amp_gpio;
-
-	ret = gpio_direction_output(GPIO_E750_SPK_AMP_OFF, 1);
-	if (ret)
-		goto free_spk_amp_gpio;
-
 	e750_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!e750_snd_device) {
 		ret = -ENOMEM;
-- 
1.7.5.4
