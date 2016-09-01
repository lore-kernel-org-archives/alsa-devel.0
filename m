From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Wait for resume before
	enabling FLL" to the asoc tree
Date: Thu, 01 Sep 2016 21:35:10 +0100
Message-ID: <E1bfYha-0002pJ-5Z@debutante>
References: <1472121572-13020-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DFDB82671DF
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2016 22:35:19 +0200 (CEST)
In-Reply-To: <1472121572-13020-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Wait for resume before enabling FLL

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

>From 63d19e0693668de5ce46b5f0f948645bf43b546b Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Thu, 25 Aug 2016 11:39:32 +0100
Subject: [PATCH] ASoC: arizona: Wait for resume before enabling FLL

When enabling an FLL use pm_runtime_get_sync() instead of
pm_runtime_get() to ensure that all the register settings
have been written out and the codec is powered-up before
we write the enable bit.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0fc3b4b61552..ccb3ca2f77a4 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2268,7 +2268,7 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 					 ARIZONA_FLL1_SYNC_BW);
 
 	if (!already_enabled)
-		pm_runtime_get(arizona->dev);
+		pm_runtime_get_sync(arizona->dev);
 
 	regmap_update_bits_async(arizona->regmap, fll->base + 1,
 				 ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
-- 
2.8.1
