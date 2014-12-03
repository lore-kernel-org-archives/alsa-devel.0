From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: [PATCH 3/5] ASoC: dwc: Iterate over all channels
Date: Wed, 03 Dec 2014 16:39:01 +0000
Message-ID: <547F3CA5.2010500@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>
List-Id: alsa-devel@alsa-project.org

On the Designware core, the channels are independent and not combined
in higher registers.  So as more channels are added, more registers need
to be updated.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index f8946bd..c497ada 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -227,19 +227,25 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	i2s_disable_channels(dev, substream->stream);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		i2s_write_reg(dev->i2s_base, TCR(ch_reg), xfer_resolution);
-		i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
-		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
-		i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
-	} else {
-		i2s_write_reg(dev->i2s_base, RCR(ch_reg), xfer_resolution);
-		i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
-		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
-		i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
-	}
+	/* Iterate over set of channels - independently controlled.
+	 */
+	do {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
+				      xfer_resolution);
+			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
+			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
+			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
+		} else {
+			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
+				      xfer_resolution);
+			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
+			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
+			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
+		}
+	} while (ch_reg-- > 0);
 
 	i2s_write_reg(dev->i2s_base, CCR, ccr);
 
-- 
1.7.1
