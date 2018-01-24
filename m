From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [RESEND PATCH] ASoC: rt5514-spi: Check the validity of
	drvdata pointer on resume
Date: Wed, 24 Jan 2018 14:50:00 +0000
Message-ID: <20180124145000.5016-1-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 504C0266C0E
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 15:50:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
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
