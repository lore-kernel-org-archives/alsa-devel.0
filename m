From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ASoC: Fix error paths in N810 machine driver
	init and release clocks at exit
Date: Tue, 26 Aug 2008 13:32:57 +0300
Message-ID: <1219746777-17328-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id B476710383D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 12:34:03 +0200 (CEST)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m7QAXiD8024319
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 05:33:58 -0500
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
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Thanks to Felipe Balbi <felipe.balbi@nokia.com> by noticing that if clk_get
to sys_clkout2_src fails, then n810_snd_device is never released.

Add also sys_clkout2_src release into error path, error code return and
release the clocks at exit.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 7694621..87d0ed0 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -329,12 +329,14 @@ static int __init n810_soc_init(void)
 	sys_clkout2_src = clk_get(dev, "sys_clkout2_src");
 	if (IS_ERR(sys_clkout2_src)) {
 		dev_err(dev, "Could not get sys_clkout2_src clock\n");
-		return -ENODEV;
+		err = PTR_ERR(sys_clkout2_src);
+		goto err2;
 	}
 	sys_clkout2 = clk_get(dev, "sys_clkout2");
 	if (IS_ERR(sys_clkout2)) {
 		dev_err(dev, "Could not get sys_clkout2\n");
-		goto err1;
+		err = PTR_ERR(sys_clkout2);
+		goto err3;
 	}
 	/*
 	 * Configure 12 MHz output on SYS_CLKOUT2. Therefore we must use
@@ -343,7 +345,8 @@ static int __init n810_soc_init(void)
 	func96m_clk = clk_get(dev, "func_96m_ck");
 	if (IS_ERR(func96m_clk)) {
 		dev_err(dev, "Could not get func 96M clock\n");
-		goto err2;
+		err = PTR_ERR(func96m_clk);
+		goto err4;
 	}
 	clk_set_parent(sys_clkout2_src, func96m_clk);
 	clk_set_rate(sys_clkout2, 12000000);
@@ -356,20 +359,25 @@ static int __init n810_soc_init(void)
 	gpio_direction_output(N810_SPEAKER_AMP_GPIO, 0);
 
 	return 0;
-err2:
+err4:
 	clk_put(sys_clkout2);
+err3:
+	clk_put(sys_clkout2_src);
+err2:
 	platform_device_del(n810_snd_device);
 err1:
 	platform_device_put(n810_snd_device);
 
 	return err;
-
 }
 
 static void __exit n810_soc_exit(void)
 {
 	gpio_free(N810_SPEAKER_AMP_GPIO);
 	gpio_free(N810_HEADSET_AMP_GPIO);
+	clk_put(sys_clkout2_src);
+	clk_put(sys_clkout2);
+	clk_put(func96m_clk);
 
 	platform_device_unregister(n810_snd_device);
 }
-- 
1.5.6.3
