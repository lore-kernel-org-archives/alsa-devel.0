From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 2/4] ASoC: rx1950: remove unnecessary headers
Date: Tue,  7 Sep 2010 17:04:16 +0300
Message-ID: <1283868258-26493-3-git-send-email-anarsoul@gmail.com>
References: <1283868258-26493-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5392D24481
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 16:05:57 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2222155eyd.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2010 07:05:53 -0700 (PDT)
In-Reply-To: <1283868258-26493-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Philipp Zabel <philipp.zabel@gmail.com>, anarsoul@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/s3c24xx/rx1950_uda1380.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index 0f6e806..9552296 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -19,18 +19,11 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
 
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/uda1380.h>
-- 
1.7.2.2
