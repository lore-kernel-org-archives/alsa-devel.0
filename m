From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: reset dma_offset at hw_params
Date: Mon, 7 Aug 2017 18:39:32 +0800
Message-ID: <1502102372-27635-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id C66DD2669F6
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 12:39:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, Hsin-Yu Chao <hychao@chromium.org>, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

dma_offset needs reset every time otherwise for consecutive PCM
open the last dma_offset value will cause incorrect pointer position
be reported to user space.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 6f513cc..640193d 100644
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
2.7.4
