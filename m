From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: check irq status to
	schedule data copy in resume function" to the asoc tree
Date: Wed, 08 Nov 2017 21:30:44 +0000
Message-ID: <E1eCXvo-0005B1-21@debutante>
References: <1510124662-5065-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D46F026767A
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:30:59 +0100 (CET)
In-Reply-To: <1510124662-5065-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: check irq status to schedule data copy in resume function

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

>From e9c50aa6bd3996924b5fd87ab59289888cd5704a Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Wed, 8 Nov 2017 15:04:22 +0800
Subject: [PATCH] ASoC: rt5514-spi: check irq status to schedule data copy in
 resume function

For wake on voice use case, we need to copy data from DSP buffer
to PCM stream when system wakes up by voice. However the edge
triggered IRQ could be missed when system wakes up, in that case
the irq function will not be called. If the substream was constructed
beforce suspend, we will schedule data copy in resume function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index d03756913dd9..36e0a58ffc87 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -473,11 +473,21 @@ static int rt5514_suspend(struct device *dev)
 
 static int rt5514_resume(struct device *dev)
 {
+	struct snd_soc_platform *platform = snd_soc_lookup_platform(dev);
+	struct rt5514_dsp *rt5514_dsp =
+		snd_soc_platform_get_drvdata(platform);
 	int irq = to_spi_device(dev)->irq;
+	u8 buf[8];
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
 
+	if (rt5514_dsp->substream) {
+		rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf, sizeof(buf));
+		if (buf[0] & RT5514_IRQ_STATUS_BIT)
+			rt5514_schedule_copy(rt5514_dsp);
+	}
+
 	return 0;
 }
 
-- 
2.15.0
