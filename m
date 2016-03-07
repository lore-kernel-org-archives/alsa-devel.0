From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Set PLL src according to
	source" to the asoc tree
Date: Mon, 07 Mar 2016 14:43:00 +0700
Message-ID: <E1acpoi-00075F-Vc@finisterre>
References: <1457334578-32302-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8478326512B
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:43:05 +0100 (CET)
In-Reply-To: <1457334578-32302-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jack Yu <jack.yu@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Set PLL src according to source

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

>From c467fc0e010b66069c0d5bb3e8e869adf267115f Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 7 Mar 2016 15:09:37 +0800
Subject: [PATCH] ASoC: rt5640: Set PLL src according to source

rt5640_set_dai_pll set pll source according to given source and
dai id. However, the pll source should be set according to given
source only.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6cd84fb2196a..863c190c5076 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1902,21 +1902,12 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_MCLK);
 		break;
 	case RT5640_PLL1_S_BCLK1:
+		snd_soc_update_bits(codec, RT5640_GLB_CLK,
+			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK1);
+		break;
 	case RT5640_PLL1_S_BCLK2:
-		dai_sel = get_sdp_info(codec, dai->id);
-		if (dai_sel < 0) {
-			dev_err(codec->dev,
-				"Failed to get sdp info: %d\n", dai_sel);
-			return -EINVAL;
-		}
-		if (dai_sel & RT5640_U_IF1) {
-			snd_soc_update_bits(codec, RT5640_GLB_CLK,
-				RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK1);
-		}
-		if (dai_sel & RT5640_U_IF2) {
-			snd_soc_update_bits(codec, RT5640_GLB_CLK,
-				RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK2);
-		}
+		snd_soc_update_bits(codec, RT5640_GLB_CLK,
+			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK2);
 		break;
 	default:
 		dev_err(codec->dev, "Unknown PLL source %d\n", source);
-- 
2.7.0
