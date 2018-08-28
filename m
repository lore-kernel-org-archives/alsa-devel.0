From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Remove clock framework ifdefs" to
	the asoc tree
Date: Tue, 28 Aug 2018 21:49:11 +0100 (BST)
Message-ID: <20180828204911.0C81F44007A@finisterre.ee.mobilebroadband>
References: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 337E826781A
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:49:15 +0200 (CEST)
In-Reply-To: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Remove clock framework ifdefs

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

>From d78b1e43e2182640b33d1c39245965d9231f0130 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 28 Aug 2018 14:35:02 +0100
Subject: [PATCH] ASoC: dapm: Remove clock framework ifdefs

The clock code now has stub functions defined in its header files so
the ifdefs around clocking code should no longer be necessary.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 461d951917c0..78ab6965af55 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1320,14 +1320,13 @@ int dapm_clock_event(struct snd_soc_dapm_widget *w,
 
 	soc_dapm_async_complete(w->dapm);
 
-#ifdef CONFIG_HAVE_CLK
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		return clk_prepare_enable(w->clk);
 	} else {
 		clk_disable_unprepare(w->clk);
 		return 0;
 	}
-#endif
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dapm_clock_event);
@@ -3498,7 +3497,6 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		}
 		break;
 	case snd_soc_dapm_clock_supply:
-#ifdef CONFIG_CLKDEV_LOOKUP
 		w->clk = devm_clk_get(dapm->dev, w->name);
 		if (IS_ERR(w->clk)) {
 			ret = PTR_ERR(w->clk);
@@ -3508,9 +3506,6 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 				w->name, ret);
 			return NULL;
 		}
-#else
-		return NULL;
-#endif
 		break;
 	default:
 		break;
-- 
2.18.0
