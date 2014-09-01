From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Correct interface
	register 2 variable name
Date: Mon, 1 Sep 2014 12:46:37 +0300
Message-ID: <1409564797-15782-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 533952616CB
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 11:46:44 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Rename iface_reg3 to iface_reg2 since this variable is actually used for
interface register 2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 0f64c7890eed..9f9d23b94c22 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -813,7 +813,7 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u8 iface_reg1 = 0;
-	u8 iface_reg3 = 0;
+	u8 iface_reg2 = 0;
 	u8 dsp_a_val = 0;
 
 	dev_dbg(codec->dev, "## %s: fmt = 0x%x\n", __func__, fmt);
@@ -838,7 +838,7 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		/* NOTE: BCLKINV bit value 1 equas NB and 0 equals IB */
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 		case SND_SOC_DAIFMT_NB_NF:
-			iface_reg3 |= AIC31XX_BCLKINV_MASK;
+			iface_reg2 |= AIC31XX_BCLKINV_MASK;
 			break;
 		case SND_SOC_DAIFMT_IB_NF:
 			break;
@@ -870,7 +870,7 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			    dsp_a_val);
 	snd_soc_update_bits(codec, AIC31XX_IFACE2,
 			    AIC31XX_BCLKINV_MASK,
-			    iface_reg3);
+			    iface_reg2);
 
 	return 0;
 }
-- 
2.0.4
