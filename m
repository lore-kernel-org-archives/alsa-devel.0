From: "yitian" <yitian.bu@tangramtek.com>
Subject: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop
	transferring issue
Date: Tue, 29 Sep 2015 22:43:17 +0800
Message-ID: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg64.qq.com (smtpbg62.qq.com [103.7.29.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0F0265705
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 16:43:31 +0200 (CEST)
Content-Language: zh-cn
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Andrew.Jackson@arm.com, wsa@the-dreams.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Designware I2S uses tx empty and rx available signals as the DMA
handshaking signals. during music playing, if XRUN occurs,
i2s_stop() function will be executed and both tx and rx irq are
masked, when music continues to be played, i2s_start() is executed
but both tx and rx irq are not unmasked which cause I2S stop
sending DMA handshaking signal to DMA controller, and it finally
causes music playing will be stopped once XRUN occurs for the first
time.

Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
---
changes in V2:
 - add definition for i and irq
---
 sound/soc/dwc/designware_i2s.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index a3e97b4..76b2e19 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -141,13 +141,22 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev
*dev, u32 stream)
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

1.7.12.4
