From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: set PLL_CTRL2 non-volatile" to
	the asoc tree
Date: Wed, 23 Dec 2015 00:38:08 +0000
Message-ID: <E1aBXRQ-0001ki-BS@debutante>
References: <1450404983-26646-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B94BC26602D
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:40:22 +0100 (CET)
In-Reply-To: <1450404983-26646-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: set PLL_CTRL2 non-volatile

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

>From d0d1eedd5ad345f16234311b375bf94d6c90e14b Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 18 Dec 2015 10:16:23 +0800
Subject: [PATCH] ASoC: rt5677: set PLL_CTRL2 non-volatile

There is a status bit on RT5677_PLL1_CTRL2 and RT5677_PLL2_CTRL2.
That's why those registers are set volatile. However, the status
bit is currently not used by codec driver. So, it should be no
problem if we set them non-volatile.
The purpose of setting them non-volatile is to restore the setting
after a syspend/resume cycle.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f73fd125e49c..13fef00e7b25 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -297,8 +297,6 @@ static bool rt5677_volatile_register(struct device *dev, unsigned int reg)
 	case RT5677_HAP_GENE_CTRL2:
 	case RT5677_PWR_DSP_ST:
 	case RT5677_PRIV_DATA:
-	case RT5677_PLL1_CTRL2:
-	case RT5677_PLL2_CTRL2:
 	case RT5677_ASRC_22:
 	case RT5677_ASRC_23:
 	case RT5677_VAD_CTRL5:
-- 
2.6.2
