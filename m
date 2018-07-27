From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: pci: cthw20k1: Replace mdelay() with
	msleep()
Date: Fri, 27 Jul 2018 16:57:56 +0800
Message-ID: <20180727085756.12440-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 76A6526775C
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 10:58:04 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so2865866pgv.1
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 01:58:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com
Cc: alsa-devel@alsa-project.org, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

hw_pll_init(), hw_reset_dac() and hw_card_init() are never 
called in atomic context.
They calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/pci/ctxfi/cthw20k1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 8e6eb9d7984b..6a051a1c3724 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -1319,7 +1319,7 @@ static int hw_pll_init(struct hw *hw, unsigned int rsr)
 			break;
 
 		hw_write_20kx(hw, PLLCTL, pllctl);
-		mdelay(40);
+		msleep(40);
 	}
 	if (i >= 3) {
 		dev_alert(hw->card->dev, "PLL initialization failed!!!\n");
@@ -1407,7 +1407,7 @@ static int hw_reset_dac(struct hw *hw)
 	/* To be effective, need to reset the DAC twice. */
 	for (i = 0; i < 2;  i++) {
 		/* set gpio */
-		mdelay(100);
+		msleep(100);
 		gpioorg = (u16)hw_read_20kx(hw, GPIO);
 		gpioorg &= 0xfffd;
 		hw_write_20kx(hw, GPIO, gpioorg);
@@ -2030,7 +2030,7 @@ static int hw_card_init(struct hw *hw, struct card_conf *info)
 	hw_write_20kx(hw, GIE, 0);
 	/* Reset all SRC pending interrupts */
 	hw_write_20kx(hw, SRCIP, 0);
-	mdelay(30);
+	msleep(30);
 
 	/* Detect the card ID and configure GPIO accordingly. */
 	switch (hw->model) {
-- 
2.17.0
