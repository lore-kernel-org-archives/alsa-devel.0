From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Remove the repeated
	definitions" to the asoc tree
Date: Wed, 23 Sep 2015 11:00:53 -0700
Message-ID: <E1ZeoLd-0005Sr-OS@finisterre>
References: <1442990130-15801-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A086D26047C
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 20:01:23 +0200 (CEST)
In-Reply-To: <1442990130-15801-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Remove the repeated definitions

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

>From de3f8fdf7393e4259b68ae8cea806c39d602769e Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Wed, 23 Sep 2015 14:35:27 +0800
Subject: [PATCH] ASoC: rt5645: Remove the repeated definitions

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 90325d9..f45861c 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -777,8 +777,6 @@
 #define RT5645_PWR_CLS_D_R_BIT			9
 #define RT5645_PWR_CLS_D_L			(0x1 << 8)
 #define RT5645_PWR_CLS_D_L_BIT			8
-#define RT5645_PWR_ADC_R			(0x1 << 1)
-#define RT5645_PWR_ADC_R_BIT			1
 #define RT5645_PWR_DAC_L2			(0x1 << 7)
 #define RT5645_PWR_DAC_L2_BIT			7
 #define RT5645_PWR_DAC_R2			(0x1 << 6)
-- 
2.5.0
