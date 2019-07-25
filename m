From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: ti: davinci-mcasp: Add support for
	RIGHT_J format
Date: Thu, 25 Jul 2019 11:34:11 +0300
Message-ID: <20190725083411.7211-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 250C8F800E8
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 10:34:15 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The formater unit's rotation needs to be programmed differently for right
aligned bus format to have the data moved to the correct place.

Take the opportunity and simplify the formater unit setup code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
