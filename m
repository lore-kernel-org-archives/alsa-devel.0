From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: wm8903: disable mic detect irqs until
	jack registered
Date: Fri,  8 Jun 2012 11:37:54 -0600
Message-ID: <1339177075-20506-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9315A24374
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 19:38:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

If either mic detection interrupt is unmasked when the IRQ handler is
first registered, they might fire immediately. However, at this point,
wm8903->mic_jack cannot have been set, since wm8903_mic_detect() can
only operate after wm8903_probe() has completed. If the IRQ fires at
this point, wm8903_irq() will use the uninitialized or stale mic_jack,
and crash.

This problem can be triggered by fully initializing an audio card, then
removing and re-inserting the machine driver module. This would leave
mic detection enabled in HW, and mic_jack set to a stale value.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This is useful in 3.5.

As an aside, I wondered instead about modifying wm8903_remove() to disable
mic detection, and clear any status. However, even if we do that, I think
we still want to make this change too, since I think we want probe() to
work the first time without relying on previous HW state?

 sound/soc/codecs/wm8903.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 304b5cf..d00a2b3 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1946,7 +1946,16 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 
 		snd_soc_update_bits(codec, WM8903_INTERRUPT_CONTROL,
 				    WM8903_IRQ_POL, irq_pol);
-		
+
+		/*
+		 * Ensure mic detection interrupts are masked until after
+		 * wm8903_mic_detect() is called, so that wm8903_irq() has
+		 * a valid wm8903->mic_jack() to report on.
+		 */
+		snd_soc_update_bits(codec, WM8903_INTERRUPT_STATUS_1_MASK,
+				    WM8903_MICDET_EINT | WM8903_MICSHRT_EINT,
+				    WM8903_MICDET_EINT | WM8903_MICSHRT_EINT);
+
 		ret = request_threaded_irq(wm8903->irq, NULL, wm8903_irq,
 					   trigger | IRQF_ONESHOT,
 					   "wm8903", codec);
-- 
1.7.0.4
