From: zengzm.kernel@gmail.com
Subject: [PATCH 1/2] ASoC: sgtl5000: Fix wrong register name in
	restore
Date: Mon, 16 Jan 2012 15:15:52 +0800
Message-ID: <1326698152-25747-1-git-send-email-zengzm.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E6A25244C7
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 08:16:01 +0100 (CET)
Received: by iakk32 with SMTP id k32so2457376iak.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2012 23:15:59 -0800 (PST)
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
Cc: festevam@gmail.com, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, julia.lawall@lip6.fr, zengzm.kernel@gmail.com, shawn.guo@linaro.org, B29396@freescale.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

From: Zeng Zhaoming <zengzm.kernel@gmail.com>

Correct SGTL5000_CHIP_CLK_CTRL to SGTL5000_CHIP_REF_CTRL in
sgtl5000_restore_regs(), and add comment to explain the
restore order.

Signed-off-by: Zeng Zhaoming <zengzm.kernel@gmail.com>
---
 sound/soc/codecs/sgtl5000.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index fc9b127..71df1fe 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -987,12 +987,12 @@ static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 	/* restore regular registers */
 	for (reg = 0; reg <= SGTL5000_CHIP_SHORT_CTRL; reg += 2) {
 
-		/* this regs depends on the others */
+		/* These regs should restore in particular order */
 		if (reg == SGTL5000_CHIP_ANA_POWER ||
 			reg == SGTL5000_CHIP_CLK_CTRL ||
 			reg == SGTL5000_CHIP_LINREG_CTRL ||
 			reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
-			reg == SGTL5000_CHIP_CLK_CTRL)
+			reg == SGTL5000_CHIP_REF_CTRL)
 			continue;
 
 		snd_soc_write(codec, reg, cache[reg]);
@@ -1005,6 +1005,13 @@ static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 	/*
 	 * restore power and other regs according
 	 * to set_power() and set_clock()
+	 * the order of restore is:
+	 * 1. SGTL5000_CHIP_CLK_CTRL MCLK_FREQ bits (1:0) should be restore after
+	 *    SGTL5000_CHIP_ANA_POWER PLL bits set
+	 * 2. SGTL5000_CHIP_LINREG_CTRL should be set before
+	 *    SGTL5000_CHIP_ANA_POWER LINREG_D restored
+	 * 3. SGTL5000_CHIP_REF_CTRL controls Analog Ground Voltage,
+	 *    I prefer to resotre it after SGTL5000_CHIP_ANA_POWER restored
 	 */
 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
 			cache[SGTL5000_CHIP_LINREG_CTRL]);
-- 
1.7.6.1.385.gb7fcd0
