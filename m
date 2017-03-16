From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: fix define of
	RT5665_HP_DRIVER_5X" to the asoc tree
Date: Thu, 16 Mar 2017 14:11:14 +0000
Message-ID: <E1coW7W-0002dy-Jt@debutante>
References: <1489643921-29900-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D423F2671D3
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 15:11:34 +0100 (CET)
In-Reply-To: <1489643921-29900-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: fix define of RT5665_HP_DRIVER_5X

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

>From 763811987d5088d0461164f80e9d16869847a040 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 16 Mar 2017 13:58:40 +0800
Subject: [PATCH] ASoC: rt5665: fix define of RT5665_HP_DRIVER_5X

It is (0x3 << 2), not (0x2 << 2).

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index 12f7080a0d3c..a30f5e6d0628 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1106,7 +1106,7 @@
 #define RT5665_HP_DRIVER_MASK			(0x3 << 2)
 #define RT5665_HP_DRIVER_1X			(0x0 << 2)
 #define RT5665_HP_DRIVER_3X			(0x1 << 2)
-#define RT5665_HP_DRIVER_5X			(0x2 << 2)
+#define RT5665_HP_DRIVER_5X			(0x3 << 2)
 #define RT5665_LDO1_DVO_MASK			(0x3)
 #define RT5665_LDO1_DVO_09			(0x0)
 #define RT5665_LDO1_DVO_10			(0x1)
-- 
2.11.0
