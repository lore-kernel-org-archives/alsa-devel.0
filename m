From: yegorslists@googlemail.com
Subject: [PATCH] davinci-mcasp: don't overwrite DIT settings
Date: Mon,  4 Mar 2013 10:38:33 +0100
Message-ID: <1362389913-4450-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.visionsystems.de (hhlx01.visionsystems.de [62.145.30.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AA751264F24
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 10:39:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mporter@ti.com, Yegor Yefremov <yegorslists@googlemail.com>, vaibhav.bedia@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Channel size settings will be made at the end of
davinci_mcasp_hw_params() routine and thus overwrite frame
format settings made for DIT mode. This patch fixes this issue
by taking op_mode into account. Tested with official PSP 3.2
kernel and sii9022a HDMI transmitter.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 sound/soc/davinci/davinci-mcasp.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 90a9b99..de59075 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -643,16 +643,23 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 	/* mapping of the XSSZ bit-field as described in the datasheet */
 	fmt = (word_length >> 1) - 1;
 
-	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
-					RXSSZ(fmt), RXSSZ(0x0F));
-	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
-					TXSSZ(fmt), TXSSZ(0x0F));
-	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
-							TXROT(7));
-	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
-							RXROT(7));
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
+	if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
+	{
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
+	}
+	else
+	{
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
+						RXSSZ(fmt), RXSSZ(0x0F));
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+						TXSSZ(fmt), TXSSZ(0x0F));
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
+								TXROT(7));
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
+								RXROT(7));
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
+	}
 
 	return 0;
 }
-- 
1.7.7
