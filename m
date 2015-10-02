From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: fix dma stop transferring issue"
	to the asoc tree
Date: Fri, 02 Oct 2015 18:13:46 +0100
Message-ID: <E1Zi3ty-00082V-0n@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0315260713
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:52 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yitian Bu <yitian.bu@tangramtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: fix dma stop transferring issue

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 924eb475126fd6bc23c475ac742a69fc466c0b75 Mon Sep 17 00:00:00 2001
From: yitian <yitian.bu@tangramtek.com>
Date: Tue, 29 Sep 2015 22:43:17 +0800
Subject: [PATCH] ASoC: dwc: fix dma stop transferring issue

Designware I2S uses tx empty and rx available signals as the DMA
handshaking signals. during music playing, if XRUN occurs,
i2s_stop() function will be executed and both tx and rx irq are
masked, when music continues to be played, i2s_start() is executed
but both tx and rx irq are not unmasked which cause I2S stop
sending DMA handshaking signal to DMA controller, and it finally
causes music playing will be stopped once XRUN occurs for the first
time.

[On list discussion suggests this may be partly a race condition on slow
systems -- broonie]

Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_i2s.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 0d28e3b..ba34252 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -141,13 +141,22 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
 static void i2s_start(struct dw_i2s_dev *dev,
 		      struct snd_pcm_substream *substream)
 {
-
+	u32 i, irq;
 	i2s_write_reg(dev->i2s_base, IER, 1);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < 4; i++) {
+			irq = i2s_read_reg(dev->i2s_base, IMR(i));
+			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x30);
+		}
 		i2s_write_reg(dev->i2s_base, ITER, 1);
-	else
+	} else {
+		for (i = 0; i < 4; i++) {
+			irq = i2s_read_reg(dev->i2s_base, IMR(i));
+			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x03);
+		}
 		i2s_write_reg(dev->i2s_base, IRER, 1);
+	}
 
 	i2s_write_reg(dev->i2s_base, CER, 1);
 }
-- 
2.5.0
