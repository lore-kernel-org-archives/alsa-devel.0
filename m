From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320aic3x: Add support for CBM_CFS and
	CBS_CFM clocking modes
Date: Tue, 20 Nov 2018 14:42:53 +0200
Message-ID: <20181120124253.27775-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 605BA267837
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 13:41:29 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The codec can support any variation of bclk/fs master/slave configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6a271e6e6b8f..6aa0edf8c5ef 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1260,6 +1260,16 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		aic3x->master = 0;
 		iface_areg &= ~(BIT_CLK_MASTER | WORD_CLK_MASTER);
 		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		aic3x->master = 1;
+		iface_areg |= BIT_CLK_MASTER;
+		iface_areg &= ~WORD_CLK_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		aic3x->master = 1;
+		iface_areg |= WORD_CLK_MASTER;
+		iface_areg &= ~BIT_CLK_MASTER;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
