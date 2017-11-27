From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Add the sanity check for the
	driver_data in the resume function" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:31 +0000
Message-ID: <E1eJOW7-000706-Mc@debutante>
References: <1511173399-26065-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C1C72675C0
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:35 +0100 (CET)
In-Reply-To: <1511173399-26065-1-git-send-email-oder_chiou@realtek.com>
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

   ASoC: rt5514: Add the sanity check for the driver_data in the resume function

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

>From 346cccf88319344c9f513bd85df6ae2258e8a8ea Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 20 Nov 2017 18:23:19 +0800
Subject: [PATCH] ASoC: rt5514: Add the sanity check for the driver_data in the
 resume function

If the rt5514 spi driver is loaded, but the snd_soc_platform_driver is not
loaded by the correct DAI settings, the NULL pointer will be gotten by
snd_soc_platform_get_drvdata in the resume function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 2df91db765ac..ca6a90d8fc39 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -482,10 +482,13 @@ static int __maybe_unused rt5514_resume(struct device *dev)
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
 
-	if (rt5514_dsp->substream) {
-		rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf, sizeof(buf));
-		if (buf[0] & RT5514_IRQ_STATUS_BIT)
-			rt5514_schedule_copy(rt5514_dsp);
+	if (rt5514_dsp) {
+		if (rt5514_dsp->substream) {
+			rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf,
+				sizeof(buf));
+			if (buf[0] & RT5514_IRQ_STATUS_BIT)
+				rt5514_schedule_copy(rt5514_dsp);
+		}
 	}
 
 	return 0;
-- 
2.15.0
