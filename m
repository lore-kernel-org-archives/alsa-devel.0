From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add the register
	RT5645_CHARGE_PUMP to readable check function" to the asoc tree
Date: Tue, 25 Aug 2015 19:13:08 +0100
Message-ID: <E1ZUIia-0006BM-W4@debutante>
References: <1440419579-9970-5-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE20B26516A
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 20:13:20 +0200 (CEST)
In-Reply-To: <1440419579-9970-5-git-send-email-oder_chiou@realtek.com>
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

   ASoC: rt5645: Add the register RT5645_CHARGE_PUMP to readable check function

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

>From b1d42598cb654ce63b55ccf27da09dcd914781f3 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Mon, 24 Aug 2015 20:32:59 +0800
Subject: [PATCH] ASoC: rt5645: Add the register RT5645_CHARGE_PUMP to readable
 check function

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d9f34421414e..0a4cb6bc3433 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -394,6 +394,7 @@ static bool rt5645_readable_register(struct device *dev, unsigned int reg)
 	case RT5645_DEPOP_M1:
 	case RT5645_DEPOP_M2:
 	case RT5645_DEPOP_M3:
+	case RT5645_CHARGE_PUMP:
 	case RT5645_MICBIAS:
 	case RT5645_A_JD_CTRL1:
 	case RT5645_VAD_CTRL4:
-- 
2.5.0
