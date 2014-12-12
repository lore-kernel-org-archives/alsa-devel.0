From: Andrew Jackson <andrew.jackson@arm.com>
Subject: [PATCH v2 3/6] ASoC: dwc: Iterate over all channels
Date: Fri, 12 Dec 2014 09:25:02 +0000
Message-ID: <494c09d07353babe621dd292c96723dcdddccd68.1418372910.git.Andrew.Jackson@arm.com>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C23C265382
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 10:25:24 +0100 (CET)
In-Reply-To: <cover.1418372910.git.Andrew.Jackson@arm.com>
In-Reply-To: <cover.1418372910.git.Andrew.Jackson@arm.com>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

The Designware core can be configured with up to four stereo channels.
Each stereo channel is individually configured so, when the driver's
hw_params call is made, each requested stereo channel has to be
programmed.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |   39 ++++++++++++++++++---------------------
 1 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index b9d6a25..1d26ded 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -209,16 +209,9 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	switch (config->chan_nr) {
 	case EIGHT_CHANNEL_SUPPORT:
-		ch_reg = 3;
-		break;
 	case SIX_CHANNEL_SUPPORT:
-		ch_reg = 2;
-		break;
 	case FOUR_CHANNEL_SUPPORT:
-		ch_reg = 1;
-		break;
 	case TWO_CHANNEL_SUPPORT:
-		ch_reg = 0;
 		break;
 	default:
 		dev_err(dev->dev, "channel not supported\n");
@@ -227,20 +220,24 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	i2s_disable_channels(dev, substream->stream);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		i2s_write_reg(dev->i2s_base, TXFFR, 1);
-		i2s_write_reg(dev->i2s_base, TCR(ch_reg), xfer_resolution);
-		i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
-		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
-		i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
-	} else {
-		i2s_write_reg(dev->i2s_base, RXFFR, 1);
-		i2s_write_reg(dev->i2s_base, RCR(ch_reg), xfer_resolution);
-		i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
-		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
-		i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
+	for (ch_reg = 0; ch_reg < (config->chan_nr / 2); ch_reg++) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			i2s_write_reg(dev->i2s_base, TXFFR, 1);
+			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
+				      xfer_resolution);
+			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
+			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
+			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
+		} else {
+			i2s_write_reg(dev->i2s_base, RXFFR, 1);
+			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
+				      xfer_resolution);
+			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
+			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
+			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
+		}
 	}
 
 	i2s_write_reg(dev->i2s_base, CCR, ccr);
-- 
1.7.1
