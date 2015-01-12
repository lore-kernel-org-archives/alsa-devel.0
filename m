From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: mc13783: Update set_tdm_slot()
	semantics
Date: Mon, 12 Jan 2015 10:27:17 +0100
Message-ID: <1421054841-19858-2-git-send-email-lars@metafoo.de>
References: <1421054841-19858-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-146.synserver.de (smtp-out-146.synserver.de
 [212.40.185.146])
 by alsa0.perex.cz (Postfix) with ESMTP id B7FD926064A
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 10:27:48 +0100 (CET)
In-Reply-To: <1421054841-19858-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The mc13783 driver uses inverted semantics for the tx_mask and rx_mask
parameter of the set_tdm_slot() callback compared to rest of ASoC. This
patch updates the driver's semantics to be consistent with the rest of ASoC,
i.e. a set bit means a active slot and a cleared bit means a inactive slot.
This will allow us to use the set_tdm_slot() API in a more generic way.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/mc13783.c  | 10 +++++-----
 sound/soc/fsl/imx-mc13783.c |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index c1e441c..2ffb9a0 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -328,16 +328,16 @@ static int mc13783_set_tdm_slot_dac(struct snd_soc_dai *dai,
 	}
 
 	switch (rx_mask) {
-	case 0xfffffffc:
+	case 0x03:
 		val |= SSI_NETWORK_DAC_RXSLOT_0_1;
 		break;
-	case 0xfffffff3:
+	case 0x0c:
 		val |= SSI_NETWORK_DAC_RXSLOT_2_3;
 		break;
-	case 0xffffffcf:
+	case 0x30:
 		val |= SSI_NETWORK_DAC_RXSLOT_4_5;
 		break;
-	case 0xffffff3f:
+	case 0xc0:
 		val |= SSI_NETWORK_DAC_RXSLOT_6_7;
 		break;
 	default:
@@ -360,7 +360,7 @@ static int mc13783_set_tdm_slot_codec(struct snd_soc_dai *dai,
 	if (slots != 4)
 		return -EINVAL;
 
-	if (tx_mask != 0xfffffffc)
+	if (tx_mask != 0x3)
 		return -EINVAL;
 
 	val |= (0x00 << 2);	/* primary timeslot RX/TX(?) is 0 */
diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 6bf5bce..9589452 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -37,8 +37,7 @@ static int imx_mc13783_hifi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xfffffffc, 0xfffffffc,
-					4, 16);
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 0x3, 4, 16);
 	if (ret)
 		return ret;
 
-- 
1.8.0
