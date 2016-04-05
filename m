From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: Unmask I2S interrupts only for
	enabled channels" to the asoc tree
Date: Tue, 05 Apr 2016 11:58:37 -0700
Message-ID: <E1anWBR-0000iR-Bf@finisterre>
References: <409b73fe04f1bd5155a8e6be701370a4594edc52.1459875048.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80322265041
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 20:58:47 +0200 (CEST)
In-Reply-To: <409b73fe04f1bd5155a8e6be701370a4594edc52.1459875048.git.joabreu@synopsys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jose Abreu <joabreu@synopsys.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: Unmask I2S interrupts only for enabled channels

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

>From 613c7c4003c8338a9a638485d95de2775948295b Mon Sep 17 00:00:00 2001
From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Tue, 5 Apr 2016 18:08:02 +0100
Subject: [PATCH] ASoC: dwc: Unmask I2S interrupts only for enabled channels

There is no need to unmask all interrupts at I2S start. This
can cause performance issues in slower platforms.

Unmask only the interrupts for the used channels.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index bff258d7bcea..3effcd1a7df8 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -147,17 +147,18 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
 static void i2s_start(struct dw_i2s_dev *dev,
 		      struct snd_pcm_substream *substream)
 {
+	struct i2s_clk_config_data *config = &dev->config;
 	u32 i, irq;
 	i2s_write_reg(dev->i2s_base, IER, 1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < (config->chan_nr / 2); i++) {
 			irq = i2s_read_reg(dev->i2s_base, IMR(i));
 			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x30);
 		}
 		i2s_write_reg(dev->i2s_base, ITER, 1);
 	} else {
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < (config->chan_nr / 2); i++) {
 			irq = i2s_read_reg(dev->i2s_base, IMR(i));
 			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x03);
 		}
-- 
2.8.0.rc3
