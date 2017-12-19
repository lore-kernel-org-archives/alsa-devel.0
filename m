From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: only enable wakeup when fully initialized" to the asoc tree
Date: Tue, 19 Dec 2017 11:09:24 +0000
Message-ID: <E1eRFm0-0002Rg-Dj@debutante>
References: <20171216040723.11710-1-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171216040723.11710-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Jimmy Cheng-Yi Chiang <cychiang@google.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: only enable wakeup when fully initialized

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

>From 20220945b1a8e77c789dd4bb9aa1471b6e8695cc Mon Sep 17 00:00:00 2001
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 15 Dec 2017 20:07:23 -0800
Subject: [PATCH] ASoC: rt5514-spi: only enable wakeup when fully initialized

If an rt5514-spi device is probed but the platform hasn't linked it in,
we might never fully request the SPI IRQ, nor configure the rt5514 DSP,
but we still might try to enable the SPI IRQ (enable_irq_wake()). This
is bad, and among other things, can cause the interrupt to trigger every
time we try to suspend the system (e.g., because the interrupt trigger
setting was never set properly).

Instead of setting our wakeup capabilities in the SPI driver probe
routine, let's wait until we've actually requested the IRQ.

Fixes issues seen on the "kevin" Chromebook (Samsung Chromebook Plus).

Fixes: 58f1c07d23cd ("ASoC: rt5514: Voice wakeup support.")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index ca6a90d8fc39..64bf26cec20d 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -289,6 +289,8 @@ static int rt5514_spi_pcm_probe(struct snd_soc_platform *platform)
 			dev_err(&rt5514_spi->dev,
 				"%s Failed to reguest IRQ: %d\n", __func__,
 				ret);
+		else
+			device_init_wakeup(rt5514_dsp->dev, true);
 	}
 
 	return 0;
@@ -456,8 +458,6 @@ static int rt5514_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	device_init_wakeup(&spi->dev, true);
-
 	return 0;
 }
 
-- 
2.15.1
