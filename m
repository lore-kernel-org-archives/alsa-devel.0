From: yegorslists@googlemail.com
Subject: [PATCH v6 2/2] ALSA: ASoC: davinci-mcasp: don't
	overwrite DIT settings
Date: Thu,  4 Apr 2013 16:13:20 +0200
Message-ID: <1365084800-17929-2-git-send-email-yegorslists@googlemail.com>
References: <1365084800-17929-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.visionsystems.de (hhlx01.visionsystems.de [62.145.30.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B2DB0265ED6
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 16:13:59 +0200 (CEST)
In-Reply-To: <1365084800-17929-1-git-send-email-yegorslists@googlemail.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Yegor Yefremov <yegorslists@googlemail.com>, vaibhav.bedia@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Channel size settings will be made at the end of
davinci_mcasp_hw_params() routine and thus overwrite frame
format settings made for DIT mode. This patch fixes this issue
by taking op_mode into account. Tested with official PSP 3.2
kernel and sii9022a HDMI transmitter.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Tested-by: Daniel Mack <zonque@gmail.com>
---
v6: CC Mark Brown
v5: add Daniel's Tested-by
v4: change subjuct to include "ALSA: ASoC: "
v3: don't set mask in davinci_hw_dit_param()
v2: fix checkpatch.pl warnings

 sound/soc/davinci/davinci-mcasp.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 90a9b99..dcd56f2 100644
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
@@ -772,9 +776,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 /* S/PDIF */
 static void davinci_hw_dit_param(struct davinci_audio_dev *dev)
 {
-	/* TXMASK for 24 bits */
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0x00FFFFFF);
-
 	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
 	   and LSB first */
 	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
-- 
1.7.7
