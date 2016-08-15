From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: add internal clock source
	support" to the asoc tree
Date: Mon, 15 Aug 2016 15:11:23 +0100
Message-ID: <E1bZIbr-0006qw-4L@debutante>
References: <1471037280-17433-13-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF642267778
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:11:34 +0200 (CEST)
In-Reply-To: <1471037280-17433-13-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: add internal clock source support

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

>From c49aed77d55b42a1ec5e1d01c2ab788abc82717c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Aug 2016 16:27:55 -0500
Subject: [PATCH] ASoC: rt5640: add internal clock source support

Adding missing definitions and flags to select internal
clock source as system clock, needed for jack detection.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 3 +++
 sound/soc/codecs/rt5640.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 09e8988bbb2d..b0f6f0712ba1 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1870,6 +1870,9 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 	case RT5640_SCLK_S_PLL1:
 		reg_val |= RT5640_SCLK_SRC_PLL1;
 		break;
+	case RT5640_SCLK_S_RCCLK:
+		reg_val |= RT5640_SCLK_SRC_RCCLK;
+		break;
 	default:
 		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
 		return -EINVAL;
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 58b664b06c16..90c88711c72a 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -984,6 +984,7 @@
 #define RT5640_SCLK_SRC_SFT			14
 #define RT5640_SCLK_SRC_MCLK			(0x0 << 14)
 #define RT5640_SCLK_SRC_PLL1			(0x1 << 14)
+#define RT5640_SCLK_SRC_RCCLK			(0x2 << 14)
 #define RT5640_PLL1_SRC_MASK			(0x3 << 12)
 #define RT5640_PLL1_SRC_SFT			12
 #define RT5640_PLL1_SRC_MCLK			(0x0 << 12)
-- 
2.8.1
