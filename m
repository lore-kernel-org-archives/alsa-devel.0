From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: set clear_irq when imm IRQ
	happened
Date: Thu, 30 Nov 2017 10:13:17 +0800
Message-ID: <1512007997-31704-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F8FB266E70
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 03:13:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, cychiang@google.com, anatol.pomozov@gmail.com, WTLI@nuvoton.com, wuchengli@google.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Although the crosstalk is disabled, it is better to set clear_irq
properly when the impedance measurement interrupt happens.
It can avoid that the driver clears other IRQs by accident
if the active_irq has another IRQ events.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index d3c1a02..603cd72 100644
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
2.6.4
