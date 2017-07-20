From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: fix GPIO6 pin function define"
	to the asoc tree
Date: Thu, 20 Jul 2017 13:23:42 +0100
Message-ID: <E1dYAUY-00014z-5E@debutante>
References: <1500527271-11188-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC671266CC3
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 14:23:52 +0200 (CEST)
In-Reply-To: <1500527271-11188-1-git-send-email-bardliao@realtek.com>
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

   ASoC: rt5665: fix GPIO6 pin function define

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

>From b50e2842b25fc14299ccf98dc9467b6304082bcb Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 20 Jul 2017 13:07:49 +0800
Subject: [PATCH] ASoC: rt5665: fix GPIO6 pin function define

The GPIO6 pin function select value was wrong.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index 1db5c6a62a8e..d95249c4c47b 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1692,8 +1692,8 @@
 #define RT5665_GP6_PIN_MASK			(0x3 << 5)
 #define RT5665_GP6_PIN_SFT			5
 #define RT5665_GP6_PIN_GPIO6			(0x0 << 5)
-#define RT5665_GP6_PIN_BCLK3			(0x0 << 5)
-#define RT5665_GP6_PIN_PDM_SCL			(0x1 << 5)
+#define RT5665_GP6_PIN_BCLK3			(0x1 << 5)
+#define RT5665_GP6_PIN_PDM_SCL			(0x2 << 5)
 #define RT5665_GP7_PIN_MASK			(0x3 << 3)
 #define RT5665_GP7_PIN_SFT			3
 #define RT5665_GP7_PIN_GPIO7			(0x0 << 3)
-- 
2.13.2
