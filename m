From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH RFC 2/3] magician: pass .set_power callback to
	uda1380 pdata
Date: Sat, 26 Jun 2010 18:14:44 +0300
Message-ID: <1277565285-11563-3-git-send-email-anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 18B95103881
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 17:15:31 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 11so1046443bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 08:15:31 -0700 (PDT)
In-Reply-To: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/pxa/magician.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 4c8d99a..f2ad1b6 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -457,12 +457,21 @@ static struct snd_soc_device magician_snd_devdata = {
 
 static struct platform_device *magician_snd_device;
 
+static void set_power(int enable)
+{
+	gpio_direction_output(EGPIO_MAGICIAN_CODEC_POWER, enable);
+	if (enable) {
+		gpio_direction_output(EGPIO_MAGICIAN_CODEC_RESET, 1);
+		udelay(5);
+		gpio_set_value(EGPIO_MAGICIAN_CODEC_RESET, 0);
+	}
+}
+
 /*
  * FIXME: move into magician board file once merged into the pxa tree
  */
 static struct uda1380_platform_data uda1380_info = {
-	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
-	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
+	.set_power = set_power,
 	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
 };
 
@@ -490,6 +499,12 @@ static int __init magician_init(void)
 	if (!client)
 		return -ENODEV;
 
+	ret = gpio_request(EGPIO_MAGICIAN_CODEC_POWER, "CODEC_POWER");
+	if (ret)
+		goto err_request_codec_pwr;
+	ret = gpio_request(EGPIO_MAGICIAN_CODEC_RESET, "CODEC_RESET");
+	if (ret)
+		goto err_request_codec_reset;
 	ret = gpio_request(EGPIO_MAGICIAN_SPK_POWER, "SPK_POWER");
 	if (ret)
 		goto err_request_spk;
@@ -535,6 +550,10 @@ err_request_mic:
 err_request_ep:
 	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
 err_request_spk:
+	gpio_free(EGPIO_MAGICIAN_CODEC_RESET);
+err_request_codec_reset:
+	gpio_free(EGPIO_MAGICIAN_CODEC_POWER);
+err_request_codec_pwr:
 	return ret;
 }
 
@@ -551,6 +570,8 @@ static void __exit magician_exit(void)
 	gpio_free(EGPIO_MAGICIAN_MIC_POWER);
 	gpio_free(EGPIO_MAGICIAN_EP_POWER);
 	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
+	gpio_free(EGPIO_MAGICIAN_CODEC_RESET);
+	gpio_free(EGPIO_MAGICIAN_CODEC_POWER);
 }
 
 module_init(magician_init);
-- 
1.7.1
