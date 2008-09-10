From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 3/4] pxa2xx-i2s: support runtime selection of
	correct cpu.
Date: Wed, 10 Sep 2008 05:01:19 +0400
Message-ID: <1221008480-13377-3-git-send-email-dbaryshkov@gmail.com>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<1221008480-13377-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 20EF610384A
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 03:01:33 +0200 (CEST)
Received: by gxk10 with SMTP id 10so12127886gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2008 18:01:33 -0700 (PDT)
In-Reply-To: <1221008480-13377-2-git-send-email-dbaryshkov@gmail.com>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/pxa2xx-i2s.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index c796b18..21ca3fe 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -65,11 +65,6 @@ static struct pxa2xx_gpio gpio_bus[] = {
 		.frm = GPIO31_SYNC_I2S_MD,
 	},
 	{ /* I2S SoC Master */
-#ifdef CONFIG_PXA27x
-		.sys = GPIO113_I2S_SYSCLK_MD,
-#else
-		.sys = GPIO32_SYSCLK_I2S_MD,
-#endif
 		.rx = GPIO29_SDATA_IN_I2S_MD,
 		.tx = GPIO30_SDATA_OUT_I2S_MD,
 		.clk = GPIO28_BITCLK_OUT_I2S_MD,
@@ -343,6 +338,11 @@ static struct platform_driver pxa2xx_i2s_driver = {
 
 static int __init pxa2xx_i2s_init(void)
 {
+	if (cpu_is_pxa27x())
+		gpio_bus[1].sys = GPIO113_I2S_SYSCLK_MD;
+	else
+		gpio_bus[1].sys = GPIO32_SYSCLK_I2S_MD;
+
 	clk_i2s = ERR_PTR(-ENOENT);
 	return platform_driver_register(&pxa2xx_i2s_driver);
 }
-- 
1.5.6.5
