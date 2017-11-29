From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 12/19] ASoC: tlv320aic31xx: Add CODEC clock
	slave support
Date: Wed, 29 Nov 2017 15:32:53 -0600
Message-ID: <20171129213300.20021-13-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D5202679AB
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 22:33:05 +0100 (CET)
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

This CODEC supports being the WCLK and/or BCLK slave, add
support for this here.

Also make the alert into an error as alert is more urgent
than needed here and is rarely used.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 41e2d8077a62..b39db3eb06d0 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -926,8 +926,16 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_CBM_CFM:
 		iface_reg1 |= AIC31XX_BCLK_MASTER | AIC31XX_WCLK_MASTER;
 		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		iface_reg1 |= AIC31XX_WCLK_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		iface_reg1 |= AIC31XX_BCLK_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
 	default:
-		dev_alert(codec->dev, "Invalid DAI master/slave interface\n");
+		dev_err(codec->dev, "Invalid DAI master/slave interface\n");
 		return -EINVAL;
 	}
 
-- 
2.15.0
