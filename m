From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH for-4.15] ASoC: rt5514-spi: only enable wakeup
	when fully initialized
Date: Fri, 15 Dec 2017 20:07:23 -0800
Message-ID: <20171216040723.11710-1-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 518C0266B0F
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 05:07:37 +0100 (CET)
Received: by mail-io0-f194.google.com with SMTP id x129so4680897iod.13
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 20:07:37 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Brian Norris <briannorris@chromium.org>, Jimmy Cheng-Yi Chiang <cychiang@google.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

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
---
The patch that introduced the wakeup was in 4.15-rc1. I think this qualifies as
a bugfix, and should probably go into 4.15.

Other relevant patches that are useful, and fix similar (or the same) issues:

https://patchwork.kernel.org/patch/10067725/
[PATCH] ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink

https://patchwork.kernel.org/patch/10116761/
[PATCH for-4.15] ASoC: rt5514: don't assume rt5514 component was "attached"

 sound/soc/codecs/rt5514-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 9255afcf2c3a..48e4b9002caf 100644
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
2.15.1.504.g5279b80103-goog
