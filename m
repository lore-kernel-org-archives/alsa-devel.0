From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: check irq status to
	schedule data copy" to the asoc tree
Date: Wed, 13 Sep 2017 17:49:28 +0100 (BST)
Message-ID: <20170913164928.E8583440011@finisterre.ee.mobilebroadband>
References: <20170913095428.27036-1-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 20195266DCF
 for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2017 19:07:20 +0200 (CEST)
In-Reply-To: <20170913095428.27036-1-hychao@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: check irq status to schedule data copy

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

>From 659178f5d1bb5164480c35e5a749c4fe1dde5867 Mon Sep 17 00:00:00 2001
From: Hsin-Yu Chao <hychao@chromium.org>
Date: Wed, 13 Sep 2017 17:54:28 +0800
Subject: [PATCH] ASoC: rt5514-spi: check irq status to schedule data copy

For wake on voice use case, we need to copy data from DSP buffer
to PCM stream when system wakes up by voice. However the edge
triggered IRQ could be missed when system wakes up, in that case
the irq function will not be called. Fix that by checking the irq
status bit and schedule data copy accordingly.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 17 +++++++++++++++--
 sound/soc/codecs/rt5514-spi.h |  3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index ed6e5373916c..12f2ecf3a4fe 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -145,9 +145,8 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 	mutex_unlock(&rt5514_dsp->dma_lock);
 }
 
-static irqreturn_t rt5514_spi_irq(int irq, void *data)
+static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 {
-	struct rt5514_dsp *rt5514_dsp = data;
 	u8 buf[8];
 
 	rt5514_dsp->get_size = 0;
@@ -180,6 +179,13 @@ static irqreturn_t rt5514_spi_irq(int irq, void *data)
 	if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
 		rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
 		schedule_delayed_work(&rt5514_dsp->copy_work, 0);
+}
+
+static irqreturn_t rt5514_spi_irq(int irq, void *data)
+{
+	struct rt5514_dsp *rt5514_dsp = data;
+
+	rt5514_schedule_copy(rt5514_dsp);
 
 	return IRQ_HANDLED;
 }
@@ -199,12 +205,19 @@ static int rt5514_spi_hw_params(struct snd_pcm_substream *substream,
 	struct rt5514_dsp *rt5514_dsp =
 			snd_soc_platform_get_drvdata(rtd->platform);
 	int ret;
+	u8 buf[8];
 
 	mutex_lock(&rt5514_dsp->dma_lock);
 	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 			params_buffer_bytes(hw_params));
 	rt5514_dsp->substream = substream;
 	rt5514_dsp->dma_offset = 0;
+
+	/* Read IRQ status and schedule copy accordingly. */
+	rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf, sizeof(buf));
+	if (buf[0] & RT5514_IRQ_STATUS_BIT)
+		rt5514_schedule_copy(rt5514_dsp);
+
 	mutex_unlock(&rt5514_dsp->dma_lock);
 
 	return ret;
diff --git a/sound/soc/codecs/rt5514-spi.h b/sound/soc/codecs/rt5514-spi.h
index a6434ee6ff03..c1a36647c119 100644
--- a/sound/soc/codecs/rt5514-spi.h
+++ b/sound/soc/codecs/rt5514-spi.h
@@ -20,6 +20,9 @@
 #define RT5514_BUFFER_VOICE_BASE	0x18000200
 #define RT5514_BUFFER_VOICE_LIMIT	0x18000204
 #define RT5514_BUFFER_VOICE_WP		0x1800020c
+#define RT5514_IRQ_CTRL			0x18002094
+
+#define RT5514_IRQ_STATUS_BIT		(0x1 << 5)
 
 /* SPI Command */
 enum {
-- 
2.13.2
