From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 7/7] snd-atmel-ac97c: cleanup registers when
	removing driver
Date: Tue, 24 Mar 2009 13:47:50 +0100
Message-ID: <1237898870-15780-8-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-4-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-5-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-6-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-7-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EF95910382C
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:47:52 +0100 (CET)
In-Reply-To: <1237898870-15780-7-git-send-email-hans-christian.egtvedt@atmel.com>
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
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch will set the channel A and control channel mode register to
zero before disabling the AC97C peripheral.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 75100b0..c917306 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -969,6 +969,10 @@ static int __devexit atmel_ac97c_remove(struct platform_device *pdev)
 	if (gpio_is_valid(chip->reset_pin))
 		gpio_free(chip->reset_pin);
 
+	ac97c_writel(chip, CAMR, 0);
+	ac97c_writel(chip, COMR, 0);
+	ac97c_writel(chip, MR,   0);
+
 	clk_disable(chip->pclk);
 	clk_put(chip->pclk);
 	iounmap(chip->regs);
-- 
1.5.6.3
