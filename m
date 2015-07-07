From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lm49453: Remove fs_rate from struct
	lm49453_priv" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:45 +0100
Message-ID: <E1ZCTNZ-0005Vg-Is@finisterre>
References: <1435222874.22996.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6438A2655A5
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:58 +0200 (CEST)
In-Reply-To: <1435222874.22996.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: lm49453: Remove fs_rate from struct lm49453_priv

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

>From 6f4397949689d74c3bd0016c80d59a90c6e8afee Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 25 Jun 2015 17:01:14 +0800
Subject: [PATCH] ASoC: lm49453: Remove fs_rate from struct lm49453_priv

fs_rate is only used in lm49453_hw_params() so don't need to store it in
private data.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/lm49453.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 6600aa0..5b4086d 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -188,7 +188,6 @@ static struct reg_default lm49453_reg_defs[] = {
 /* codec private data */
 struct lm49453_priv {
 	struct regmap *regmap;
-	int fs_rate;
 };
 
 /* capture path controls */
@@ -1112,13 +1111,10 @@ static int lm49453_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
 	u16 clk_div = 0;
 
-	lm49453->fs_rate = params_rate(params);
-
 	/* Setting DAC clock dividers based on substream sample rate. */
-	switch (lm49453->fs_rate) {
+	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
 	case 32000:
-- 
2.1.4
