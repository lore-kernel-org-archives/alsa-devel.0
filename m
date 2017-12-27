From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] ASoC: rt5514-spi: Check the validity of drvdata pointer on resume
Date: Wed, 27 Dec 2017 11:17:24 +0000
Message-ID: <20171227111724.13041-1-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The rt5514-spi driver seem to assume the validity of the drvdata pointer
on resume, which it may not be populated, leading to a not-so-nice crash.

This stems from the fact that rt5514_spi_pcm_probe() is never called on
my system (a kevin Chromebook). No idea why, but if it can happen, it
is worth fixing.

Fixes: e9c50aa6bd39 ("ASoC: rt5514-spi: check irq status to schedule data copy in resume function")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
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
2.14.2
