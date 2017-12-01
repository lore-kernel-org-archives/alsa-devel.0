From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Add CODEC clock slave
	support" to the asoc tree
Date: Fri, 01 Dec 2017 13:43:15 +0000
Message-ID: <E1eKlb1-00019v-SE@debutante>
References: <20171129213300.20021-13-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A5E9A267C74
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 14:43:20 +0100 (CET)
In-Reply-To: <20171129213300.20021-13-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Add CODEC clock slave support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 77f8b3cfc33cd4231cc2748bcac9f43b9eea546c Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 15:32:53 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Add CODEC clock slave support

This CODEC supports being the WCLK and/or BCLK slave, add
support for this here.

Also make the alert into an error as alert is more urgent
than needed here and is rarely used.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 05e6d194d6a9..d77cc36d7360 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -925,8 +925,16 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
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
