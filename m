From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: Check the validity of drvdata pointer on resume" to the asoc tree
Date: Wed, 24 Jan 2018 15:36:06 +0000
Message-ID: <E1eeN5q-0004lO-5c@debutante>
References: <20171216011230.107527-1-briannorris@chromium.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171216011230.107527-1-briannorris@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Brian Norris <briannorris@chromium.org>, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: Check the validity of drvdata pointer on resume

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

>From 509bf3a7d43ab173abc354df2a859229ede043c0 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 24 Jan 2018 14:50:00 +0000
Subject: [PATCH] ASoC: rt5514-spi: Check the validity of drvdata pointer on
 resume

The rt5514-spi driver seem to assume the validity of the drvdata pointer
on resume, which it may not be populated, leading to a not-so-nice crash.

This stems from the fact that rt5514_spi_pcm_probe() is never called on
my system (a kevin Chromebook). No idea why, but if it can happen, it
is worth fixing.

Fixes: e9c50aa6bd39 ("ASoC: rt5514-spi: check irq status to schedule data copy in resume function")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/rt5514-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 2df91db765ac..9255afcf2c3a 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -482,7 +482,7 @@ static int __maybe_unused rt5514_resume(struct device *dev)
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
 
-	if (rt5514_dsp->substream) {
+	if (rt5514_dsp && rt5514_dsp->substream) {
 		rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf, sizeof(buf));
 		if (buf[0] & RT5514_IRQ_STATUS_BIT)
 			rt5514_schedule_copy(rt5514_dsp);
-- 
2.15.1
