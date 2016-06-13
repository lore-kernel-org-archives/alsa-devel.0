From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Correct clock inversion check"
	to the asoc tree
Date: Mon, 13 Jun 2016 17:54:34 +0100
Message-ID: <E1bCV8E-0004Z5-Co@finisterre>
References: <1465426980-10924-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A3E326529F
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 18:54:48 +0200 (CEST)
In-Reply-To: <1465426980-10924-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Correct clock inversion check

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 88b1c01fb42e3d637c7e7f36cd4a30ce39a2add4 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Wed, 8 Jun 2016 16:10:05 -0700
Subject: [PATCH] ASoC: cs53l30: Correct clock inversion check

SND_SOC_DAIFMT_IB_NF = 0x3 (11b) | SND_SOC_DAIFMT_IB_IF = 0x4 (100b)
creates a mask 0x7 (111b) which also includes SND_SOC_DAIFMT_NB_IF
= 0x2 (10b).

So this patch uses the traditional way to check the clock inversion.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index aa511e70099e..384a3f79f1c5 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -599,8 +599,14 @@ static int cs53l30_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* Check to see if the SCLK is inverted */
-	if (fmt & (SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_IB_IF))
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
 		aspcfg ^= CS53L30_ASP_SCLK_INV;
+		break;
+	default:
+		break;
+	}
 
 	regmap_update_bits(priv->regmap, CS53L30_ASPCFG_CTL,
 			   CS53L30_ASP_MS | CS53L30_ASP_SCLK_INV, aspcfg);
-- 
2.8.1
