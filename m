From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic3x: Add delay after power on
	and register sync" to the asoc tree
Date: Sat, 31 Dec 2016 19:19:10 +0000
Message-ID: <E1cNPBO-0003u1-Ha@debutante>
References: <20161223092112.7992-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC0F2670BE
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2016 20:19:18 +0100 (CET)
In-Reply-To: <20161223092112.7992-3-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, jsarha@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic3x: Add delay after power on and register sync

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

>From 03303da5243f394f5cc5e530a8bc9f26ad2c79cb Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 23 Dec 2016 11:21:11 +0200
Subject: [PATCH] ASoC: tlv320aic3x: Add delay after power on and register sync

When the codec is powered on, it's registers are in reset state as the
power off will do a soft reset of the codec.

After the register sync we need to add delay to remove the pop-noise on
stream start.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic3x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index bb94d50052d7..29bf8c81ae02 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1393,6 +1393,12 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 			snd_soc_write(codec, AIC3X_PLL_PROGC_REG, pll_c);
 			snd_soc_write(codec, AIC3X_PLL_PROGD_REG, pll_d);
 		}
+
+		/*
+		 * Delay is needed to reduce pop-noise after syncing back the
+		 * registers
+		 */
+		mdelay(50);
 	} else {
 		/*
 		 * Do soft reset to this codec instance in order to clear
-- 
2.11.0
