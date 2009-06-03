From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] Fix possibly incorrect offset in wm97xx-core
Date: Wed, 3 Jun 2009 23:44:37 +0200
Message-ID: <200906032344.37640.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B9B6103895
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 23:44:38 +0200 (CEST)
Received: by bwz11 with SMTP id 11so326842bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 14:44:38 -0700 (PDT)
Content-Disposition: inline
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
Cc: Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I just hit a problem with the accelerated (interrupt driven) ts driver. It 
stop responding after a while (sometimes right after you release a stylus off 
the touchscreen, it doesn't generate any more interrupts). I made the 
following patch that fixes the problem for me (and if I read the 9712 and 
9713 manuals correctly, the patch should be OK)

Thanks for reply.

diff --git a/drivers/input/touchscreen/wm97xx-core.c 
b/drivers/input/touchscreen/wm97xx-core.c
index 69af838..4f13a7f 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -307,11 +307,7 @@ static void wm97xx_pen_irq_worker(struct work_struct 
*work)
                                         WM97XX_GPIO_13);
                }

-               if (wm->id == WM9712_ID2)
-                       wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
-                                               ~WM97XX_GPIO_13) << 1);
-               else
-                       wm97xx_reg_write(wm, AC97_GPIO_STATUS, status &
+               wm97xx_reg_write(wm, AC97_GPIO_STATUS, status &
                                                ~WM97XX_GPIO_13);
                mutex_unlock(&wm->codec_mutex);
        }
