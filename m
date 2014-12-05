From: Alexander Stein <alexanders83@web.de>
Subject: [PATCH v2 1/2] ALSA: sound/atmel/ac97c.c: Add missing
	clock prepare
Date: Fri,  5 Dec 2014 20:10:06 +0100
Message-ID: <1417806607-8433-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 6176A264F54
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 20:10:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Alexander Stein <alexanders83@web.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Clocks must be prepared before enabling them. Do this in one step.
Replace clk_enable with clk_prepare_enable and clk_disable with
clk_disable_unprepare. This fixes the following warning:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:895 __clk_enable+0x24/0x9c()
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Tainted: G        W      3.18.0-rc7+ #245
[<c000dce8>] (unwind_backtrace) from [<c000bcf0>] (show_stack+0x10/0x14)
[<c000bcf0>] (show_stack) from [<c001664c>] (warn_slowpath_common+0x60/0x80)
[<c001664c>] (warn_slowpath_common) from [<c00166fc>] (warn_slowpath_null+0x18/0x20)
[<c00166fc>] (warn_slowpath_null) from [<c02fd7ac>] (__clk_enable+0x24/0x9c)
[<c02fd7ac>] (__clk_enable) from [<c02fdbb4>] (clk_enable+0x18/0x2c)
[<c02fdbb4>] (clk_enable) from [<c0322688>] (atmel_ac97c_probe+0x154/0x694)
[<c0322688>] (atmel_ac97c_probe) from [<c0235e08>] (platform_drv_probe+0x48/0x94)
[<c0235e08>] (platform_drv_probe) from [<c02345f8>] (driver_probe_device+0x138/0x350)
[<c02345f8>] (driver_probe_device) from [<c02348bc>] (__driver_attach+0x68/0x8c)
[<c02348bc>] (__driver_attach) from [<c0232bd0>] (bus_for_each_dev+0x70/0x84)
[<c0232bd0>] (bus_for_each_dev) from [<c0233cd8>] (bus_add_driver+0xfc/0x1f8)
[<c0233cd8>] (bus_add_driver) from [<c0234f0c>] (driver_register+0x9c/0xe0)
[<c0234f0c>] (driver_register) from [<c0008ac4>] (do_one_initcall+0x110/0x1c8)
[<c0008ac4>] (do_one_initcall) from [<c053cd58>] (kernel_init_freeable+0xf8/0x1b8)
[<c053cd58>] (kernel_init_freeable) from [<c03c0414>] (kernel_init+0x8/0xe4)
[<c03c0414>] (kernel_init) from [<c00096d0>] (ret_from_fork+0x14/0x24)
---[ end trace cb88537fdc8fa201 ]---
atmel_ac97c fffa0000.sound: AC'97 0 does not respond - RESET
atmel_ac97c fffa0000.sound: AC'97 0 access is not valid [0xffffffff], removing mixer.
------------[ cut here ]------------

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 sound/atmel/ac97c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 86f07e9..fa283d3 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -989,7 +989,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "no peripheral clock\n");
 		return PTR_ERR(pclk);
 	}
-	clk_enable(pclk);
+	clk_prepare_enable(pclk);
 
 	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
 			      SNDRV_DEFAULT_STR1, THIS_MODULE,
@@ -1167,7 +1167,7 @@ err_ioremap:
 err_request_irq:
 	snd_card_free(card);
 err_snd_card_new:
-	clk_disable(pclk);
+	clk_disable_unprepare(pclk);
 	clk_put(pclk);
 	return retval;
 }
@@ -1184,7 +1184,7 @@ static int atmel_ac97c_suspend(struct device *pdev)
 		if (test_bit(DMA_TX_READY, &chip->flags))
 			dw_dma_cyclic_stop(chip->dma.tx_chan);
 	}
-	clk_disable(chip->pclk);
+	clk_disable_unprepare(chip->pclk);
 
 	return 0;
 }
@@ -1194,7 +1194,7 @@ static int atmel_ac97c_resume(struct device *pdev)
 	struct snd_card *card = dev_get_drvdata(pdev);
 	struct atmel_ac97c *chip = card->private_data;
 
-	clk_enable(chip->pclk);
+	clk_prepare_enable(chip->pclk);
 	if (cpu_is_at32ap7000()) {
 		if (test_bit(DMA_RX_READY, &chip->flags))
 			dw_dma_cyclic_start(chip->dma.rx_chan);
@@ -1222,7 +1222,7 @@ static int atmel_ac97c_remove(struct platform_device *pdev)
 	ac97c_writel(chip, COMR, 0);
 	ac97c_writel(chip, MR,   0);
 
-	clk_disable(chip->pclk);
+	clk_disable_unprepare(chip->pclk);
 	clk_put(chip->pclk);
 	iounmap(chip->regs);
 	free_irq(chip->irq, chip);
-- 
2.2.0
