From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8523: Constfiy lrclk_ratios and
	bclk_ratios" to the asoc tree
Date: Wed, 02 Aug 2017 18:30:29 +0100
Message-ID: <E1dcxTZ-0003sO-Ik@debutante>
References: <20170802095514.29138-2-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78EAA2673E9
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 19:30:40 +0200 (CEST)
In-Reply-To: <20170802095514.29138-2-axel.lin@ingics.com>
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
Cc: patches@opensource.cirrus.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8523: Constfiy lrclk_ratios and bclk_ratios

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

>From c0d088f04f115409287003b5fc0dfd3184d7d306 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 2 Aug 2017 17:55:14 +0800
Subject: [PATCH] ASoC: wm8523: Constfiy lrclk_ratios and bclk_ratios

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index b1e4ce72e533..c7c33e98fbcb 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -100,7 +100,7 @@ static const struct snd_soc_dapm_route wm8523_dapm_routes[] = {
 	{ "LINEVOUTR", NULL, "DAC" },
 };
 
-static struct {
+static const struct {
 	int value;
 	int ratio;
 } lrclk_ratios[WM8523_NUM_RATES] = {
@@ -113,7 +113,7 @@ static struct {
 	{ 7, 1152 },
 };
 
-static struct {
+static const struct {
 	int value;
 	int ratio;
 } bclk_ratios[] = {
-- 
2.13.2
