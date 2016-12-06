From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l34: Simplify the logic to set
	CS35L34_MCLK_CTL setting" to the asoc tree
Date: Tue, 06 Dec 2016 12:23:32 +0000
Message-ID: <E1cEEmS-0001d2-Vh@finisterre>
References: <20161203071050.17811-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71C0C2668CC
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 13:23:45 +0100 (CET)
In-Reply-To: <20161203071050.17811-1-axel.lin@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l34: Simplify the logic to set CS35L34_MCLK_CTL setting

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

>From 914657c2be09fb89a50c7841e98186301c93767e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 3 Dec 2016 15:10:50 +0800
Subject: [PATCH] ASoC: cs35l34: Simplify the logic to set CS35L34_MCLK_CTL
 setting

The logic of "value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_XXXXXX;" is
unnecessary complex. By setting CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK
as the mask for regmap_update_bits() call, what the code does is exactly
the same as setting value = CS35L34_MCLK_RATE_XXXXXX.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l34.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index e0f672af1d84..7c5d1510cf2c 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -610,15 +610,15 @@ static int cs35l34_dai_set_sysclk(struct snd_soc_dai *dai,
 
 	switch (freq) {
 	case CS35L34_MCLK_5644:
-		value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_5P6448;
+		value = CS35L34_MCLK_RATE_5P6448;
 		cs35l34->mclk_int = freq;
 	break;
 	case CS35L34_MCLK_6:
-		value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_6P0000;
+		value = CS35L34_MCLK_RATE_6P0000;
 		cs35l34->mclk_int = freq;
 	break;
 	case CS35L34_MCLK_6144:
-		value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_6P1440;
+		value = CS35L34_MCLK_RATE_6P1440;
 		cs35l34->mclk_int = freq;
 	break;
 	case CS35L34_MCLK_11289:
-- 
2.10.2
