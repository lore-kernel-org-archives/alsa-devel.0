From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: set RT5645_PRIV_INDEX as
	volatile" to the asoc tree
Date: Thu, 07 Jul 2016 12:01:03 +0200
Message-ID: <E1bL67D-0000hj-Cz@finisterre>
References: <1467770115-16706-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27DA8265329
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 12:01:33 +0200 (CEST)
In-Reply-To: <1467770115-16706-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, koro.chen@mediatek.com, broonie@kernel.org, PC.Liao@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: set RT5645_PRIV_INDEX as volatile

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

>From 81467efcc88298ecd821c26fab04ce1b2c9d1b65 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 6 Jul 2016 09:55:14 +0800
Subject: [PATCH] ASoC: rt5645: set RT5645_PRIV_INDEX as volatile

RT5645_PRIV_INDEX(0x6a) indicate the address of PR- registers. So,
it should be volatile.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3c6594da6c9c..c0438e4e045b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -440,6 +440,7 @@ static bool rt5645_volatile_register(struct device *dev, unsigned int reg)
 
 	switch (reg) {
 	case RT5645_RESET:
+	case RT5645_PRIV_INDEX:
 	case RT5645_PRIV_DATA:
 	case RT5645_IN1_CTRL1:
 	case RT5645_IN1_CTRL2:
-- 
2.8.1
