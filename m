From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: set clear_irq when imm IRQ
	happened" to the asoc tree
Date: Thu, 30 Nov 2017 12:33:04 +0000
Message-ID: <E1eKO1Y-0000XO-Ex@debutante>
References: <1512007997-31704-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D164D2679BD
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 13:33:18 +0100 (CET)
In-Reply-To: <1512007997-31704-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, anatol.pomozov@gmail.com, WTLI@nuvoton.com, wuchengli@google.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, broonie@kernel.org, Wu-Cheng Li <wuchengli@chromium.org>, CTLIN0@nuvoton.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: set clear_irq when imm IRQ happened

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

>From e3fee43a968fd39dcc56be3757fcdfe250964125 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Thu, 30 Nov 2017 10:13:17 +0800
Subject: [PATCH] ASoC: nau8825: set clear_irq when imm IRQ happened

Although the crosstalk is disabled, it is better to set clear_irq
properly when the impedance measurement interrupt happens.
It can avoid that the driver clears other IRQs by accident
if the active_irq has another IRQ events.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Reviewed-by: Wu-Cheng Li <wuchengli@chromium.org>
Tested-by: Wu-Cheng Li <wuchengli@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index d3c1a02f1e15..603cd72c2a25 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1733,10 +1733,9 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 			nau8825->xtalk_event_mask = event_mask;
 		}
 	} else if (active_irq & NAU8825_IMPEDANCE_MEAS_IRQ) {
-		if (nau8825->xtalk_enable) {
+		if (nau8825->xtalk_enable)
 			schedule_work(&nau8825->xtalk_work);
-			clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
-		}
+		clear_irq = NAU8825_IMPEDANCE_MEAS_IRQ;
 	} else if ((active_irq & NAU8825_JACK_INSERTION_IRQ_MASK) ==
 		NAU8825_JACK_INSERTION_DETECTED) {
 		/* One more step to check GPIO status directly. Thus, the
-- 
2.15.0
