From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: fix wrong bit define for ADC L2
	power." to the asoc tree
Date: Mon, 12 Mar 2018 16:28:52 +0000 (GMT)
Message-ID: <20180312162852.4271A44007A@finisterre.ee.mobilebroadband>
References: <1520855409-28862-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E6C3326726B
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 17:28:55 +0100 (CET)
In-Reply-To: <1520855409-28862-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: fix wrong bit define for ADC L2 power.

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

>From 9849ef555c7212f4ae93d752cfa1232488ec7c83 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 12 Mar 2018 19:50:07 +0800
Subject: [PATCH] ASoC: rt5659: fix wrong bit define for ADC L2 power.

RT5659_PWR_ADC_L2_BIT should be 2.

Signed-off-by: Zhong An <zhongan@pinecone.net>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index 8f1aeef08489..3ae2d74861ef 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1008,7 +1008,7 @@
 #define RT5659_PWR_ADC_R1			(0x1 << 3)
 #define RT5659_PWR_ADC_R1_BIT			3
 #define RT5659_PWR_ADC_L2			(0x1 << 2)
-#define RT5659_PWR_ADC_L2_BIT			4
+#define RT5659_PWR_ADC_L2_BIT			2
 #define RT5659_PWR_ADC_R2			(0x1 << 1)
 #define RT5659_PWR_ADC_R2_BIT			1
 #define RT5659_PWR_CLS_D			(0x1)
-- 
2.16.2
