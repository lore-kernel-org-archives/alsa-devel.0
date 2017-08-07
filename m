From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: reset dma_offset at hw_params"
	to the asoc tree
Date: Mon, 07 Aug 2017 12:52:04 +0100
Message-ID: <E1degZo-0006o6-19@debutante>
References: <1502102372-27635-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1632671C3
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 13:52:13 +0200 (CEST)
In-Reply-To: <1502102372-27635-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, Hsin-Yu Chao <hychao@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: reset dma_offset at hw_params

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

>From b56bff43a965ffe03b4a994fd1a102059d272807 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 7 Aug 2017 18:39:32 +0800
Subject: [PATCH] ASoC: rt5514: reset dma_offset at hw_params

dma_offset needs reset every time otherwise for consecutive PCM
open the last dma_offset value will cause incorrect pointer position
be reported to user space.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 6f513cc4c56c..640193d845be 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -151,7 +151,6 @@ static irqreturn_t rt5514_spi_irq(int irq, void *data)
 	u8 buf[8];
 
 	rt5514_dsp->get_size = 0;
-	rt5514_dsp->dma_offset = 0;
 
 	/**
 	 * The address area x1800XXXX is the register address, and it cannot
@@ -205,6 +204,7 @@ static int rt5514_spi_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 			params_buffer_bytes(hw_params));
 	rt5514_dsp->substream = substream;
+	rt5514_dsp->dma_offset = 0;
 	mutex_unlock(&rt5514_dsp->dma_lock);
 
 	return ret;
-- 
2.13.3
