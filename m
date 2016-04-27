From: Matthias Reichl <hias@horus.com>
Subject: [PATCH 2/2] ASoC: bcm2835: Add S16_LE support via packed DMA transfers
Date: Wed, 27 Apr 2016 15:26:52 +0200
Message-ID: <1461763613-28714-2-git-send-email-hias@horus.com>
References: <1461763613-28714-1-git-send-email-hias@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461763613-28714-1-git-send-email-hias@horus.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Martin Sperl <kernel@martin.sperl.org>, Luis de Bethencourt <luis@debethencourt.com>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The bcm2835-i2s driver already has support for the S16_LE format but
that format hasn't been made available because dmaengine_pcm didn't
support packed data transfers.

bcm2835-i2s needs 16-bit left+right channel data to be packed into
a 32-bit word, the FIFO register is 32-bit only and doesn't support
16-bit access.

Now that dmaengine_pcm supports packed transfers the format can
be made available by setting the SND_DMAENGINE_PCM_DAI_FLAG_PACK flag.

No further configuration is necessary:
- snd_dmaengine_dai_dma_data.addr_width is already set to
  DMA_SLAVE_BUSWIDTH_4_BYTES to force 32-bit DMA transfers
- dmaengine_pcm will pick up the S16_LE format from the DAI
  configuration and make it available since it's no longer
  masked out due to the PACK flag.
- there are no further corner cases to catch in hw_params,
  since the channel count is fixed at 2 we always have two
  16-bit stereo samples that can be transferred via 32-bit DMA

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 sound/soc/bcm/bcm2835-i2s.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 1c1f221..40ba01d 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -678,6 +678,15 @@ static int bcm2835_i2s_probe(struct platform_device *pdev)
 	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].maxburst = 2;
 	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].maxburst = 2;
 
+	/*
+	 * Set the PACK flag to enable S16_LE support (2 S16_LE values
+	 * packed into 32-bit transfers).
+	 */
+	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].flags =
+		SND_DMAENGINE_PCM_DAI_FLAG_PACK;
+	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].flags =
+		SND_DMAENGINE_PCM_DAI_FLAG_PACK;
+
 	/* BCLK ratio - use default */
 	dev->bclk_ratio = 0;
 
-- 
2.1.4
