From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-mcasp: Add support for
	RIGHT_J format" to the asoc tree
Date: Thu, 25 Jul 2019 14:19:26 +0100 (BST)
Message-ID: <20190725131926.496612742B63@ypsilon.sirena.org.uk>
References: <20190725083411.7211-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 059D7F8015A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 15:19:27 +0200 (CEST)
In-Reply-To: <20190725083411.7211-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, jsarha@ti.com, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-mcasp: Add support for RIGHT_J format

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 816fe206138a7e3895c3a74fbd326a51df003f70 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 25 Jul 2019 11:34:11 +0300
Subject: [PATCH] ASoC: ti: davinci-mcasp: Add support for RIGHT_J format

The formater unit's rotation needs to be programmed differently for right
aligned bus format to have the data moved to the correct place.

Take the opportunity and simplify the formater unit setup code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190725083411.7211-1-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 43 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index ac59b509ead5..09ba3d3c70a0 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -465,6 +465,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* FS need to be inverted */
 		inv_fs = true;
 		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_LEFT_J:
 		/* configure a full-word SYNC pulse (LRCLK) */
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
@@ -758,34 +759,28 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 				       int sample_width)
 {
 	u32 fmt;
-	u32 tx_rotate = (sample_width / 4) & 0x7;
+	u32 tx_rotate, rx_rotate, slot_width;
 	u32 mask = (1ULL << sample_width) - 1;
-	u32 slot_width = sample_width;
-
-	/*
-	 * For captured data we should not rotate, inversion and masking is
-	 * enoguh to get the data to the right position:
-	 * Format	  data from bus		after reverse (XRBUF)
-	 * S16_LE:	|LSB|MSB|xxx|xxx|	|xxx|xxx|MSB|LSB|
-	 * S24_3LE:	|LSB|DAT|MSB|xxx|	|xxx|MSB|DAT|LSB|
-	 * S24_LE:	|LSB|DAT|MSB|xxx|	|xxx|MSB|DAT|LSB|
-	 * S32_LE:	|LSB|DAT|DAT|MSB|	|MSB|DAT|DAT|LSB|
-	 */
-	u32 rx_rotate = 0;
 
+	if (mcasp->slot_width)
+		slot_width = mcasp->slot_width;
+	else
+		slot_width = sample_width;
 	/*
-	 * Setting the tdm slot width either with set_clkdiv() or
-	 * set_tdm_slot() allows us to for example send 32 bits per
-	 * channel to the codec, while only 16 of them carry audio
-	 * payload.
+	 * TX rotation:
+	 * right aligned formats: rotate w/ slot_width
+	 * left aligned formats: rotate w/ sample_width
+	 *
+	 * RX rotation:
+	 * right aligned formats: no rotation needed
+	 * left aligned formats: rotate w/ (slot_width - sample_width)
 	 */
-	if (mcasp->slot_width) {
-		/*
-		 * When we have more bclk then it is needed for the
-		 * data, we need to use the rotation to move the
-		 * received samples to have correct alignment.
-		 */
-		slot_width = mcasp->slot_width;
+	if ((mcasp->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
+	    SND_SOC_DAIFMT_RIGHT_J) {
+		tx_rotate = (slot_width / 4) & 0x7;
+		rx_rotate = 0;
+	} else {
+		tx_rotate = (sample_width / 4) & 0x7;
 		rx_rotate = (slot_width - sample_width) / 4;
 	}
 
-- 
2.20.1
