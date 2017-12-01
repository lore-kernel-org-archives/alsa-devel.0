From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Check clock and divider
	before division" to the asoc tree
Date: Fri, 01 Dec 2017 13:43:21 +0000
Message-ID: <E1eKlb7-0001B2-Ob@debutante>
References: <20171109002741.10897-9-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 58231267C5D
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 14:43:26 +0100 (CET)
In-Reply-To: <20171109002741.10897-9-afd@ti.com>
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

   ASoC: tlv320aic31xx: Check clock and divider before division

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

>From c6b8c779213dfe2a31e12400b1a2cf2a9a843236 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 15:32:52 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Check clock and divider before division

If our set_sysclk DAI callback has not been called yet p_div will be 0
and dividing by this will cause an error. Print an error message and
leave before this.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index ab03a19f6aaa..05e6d194d6a9 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -754,11 +754,17 @@ static int aic31xx_setup_pll(struct snd_soc_codec *codec,
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
 	int bclk_score = snd_soc_params_to_frame_size(params);
-	int mclk_p = aic31xx->sysclk / aic31xx->p_div;
+	int mclk_p;
 	int bclk_n = 0;
 	int match = -1;
 	int i;
 
+	if (!aic31xx->sysclk || !aic31xx->p_div) {
+		dev_err(codec->dev, "Master clock not supplied\n");
+		return -EINVAL;
+	}
+	mclk_p = aic31xx->sysclk / aic31xx->p_div;
+
 	/* Use PLL as CODEC_CLKIN and DAC_CLK as BDIV_CLKIN */
 	snd_soc_update_bits(codec, AIC31XX_CLKMUX,
 			    AIC31XX_CODEC_CLKIN_MASK, AIC31XX_CODEC_CLKIN_PLL);
-- 
2.15.0
