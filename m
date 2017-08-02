From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8523: Fix array size for bclk_ratios"
	to the asoc tree
Date: Wed, 02 Aug 2017 18:30:32 +0100
Message-ID: <E1dcxTc-0003tH-P9@debutante>
References: <20170802095514.29138-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF0202673EB
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 19:30:41 +0200 (CEST)
In-Reply-To: <20170802095514.29138-1-axel.lin@ingics.com>
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

   ASoC: wm8523: Fix array size for bclk_ratios

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

>From 19b4b7292615358b9599ff9410a3e564b4844e90 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 2 Aug 2017 17:55:13 +0800
Subject: [PATCH] ASoC: wm8523: Fix array size for bclk_ratios

ARRAY_SIZE(bclk_ratios) returns 7 for current code, then it cannot catch
the error if "no matching BCLK/fs ratio". Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 6d0a2723bfde..b1e4ce72e533 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -116,7 +116,7 @@ static struct {
 static struct {
 	int value;
 	int ratio;
-} bclk_ratios[WM8523_NUM_RATES] = {
+} bclk_ratios[] = {
 	{ 2, 32 },
 	{ 3, 64 },
 	{ 4, 128 },
-- 
2.13.2
