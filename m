From: yegorslists@googlemail.com
Subject: [PATCH v2] davinci-mcasp: don't overwrite DIT settings
Date: Mon,  4 Mar 2013 10:55:27 +0100
Message-ID: <1362390927-4644-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.visionsystems.de (ns.vscom.de [62.145.30.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 37874264F24
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 10:55:48 +0100 (CET)
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
v2: fix checkpatch.pl warnings

 sound/soc/davinci/davinci-mcasp.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 90a9b99..ce32b75 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -643,16 +643,20 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
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
+	if (dev->op_mode != DAVINCI_MCASP_DIT_MODE) {
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
+				RXSSZ(fmt), RXSSZ(0x0F));
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+				TXSSZ(fmt), TXSSZ(0x0F));
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+				TXROT(rotate), TXROT(7));
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
+				RXROT(rotate), RXROT(7));
+		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG,
+				mask);
+	}
+
 	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
 
 	return 0;
 }
-- 
1.7.7
