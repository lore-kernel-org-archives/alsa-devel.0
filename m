From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: rt5663_set_jack_detect() can be
	static" to the asoc tree
Date: Thu, 17 May 2018 17:40:09 +0100 (BST)
Message-ID: <20180517164009.AFD4444007E@finisterre.ee.mobilebroadband>
References: <20180515145338.GA109360@lkp-ib03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 80B432671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:40:20 +0200 (CEST)
In-Reply-To: <20180515145338.GA109360@lkp-ib03>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, cychiang@google.com, lgirdwood@gmail.com, broonie@kernel.org, kbuild-all@01.org, shumingf@realtek.com, bardliao@realtek.com, Fengguang Wu <fengguang.wu@intel.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: rt5663_set_jack_detect() can be static

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

>From bdfe4d9ade5cca1a53205de9b30e761358d23ec7 Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Tue, 15 May 2018 22:53:38 +0800
Subject: [PATCH] ASoC: rt5663: rt5663_set_jack_detect() can be static

Fixes: 9958e8afbcad ("ASoC: rt5663: Use the set_jack() instead of the export function")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index eefa9187c895..9bd24ad42240 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1856,7 +1856,7 @@ static irqreturn_t rt5663_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int rt5663_set_jack_detect(struct snd_soc_component *component,
+static int rt5663_set_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *hs_jack, void *data)
 {
 	struct rt5663_priv *rt5663 = snd_soc_component_get_drvdata(component);
-- 
2.17.0
