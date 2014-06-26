From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 7/7] ASoC: kirkwood: implement NO_PERIOD_WAKEUP support
Date: Thu, 26 Jun 2014 15:23:20 +0100
Message-ID: <E1X0Aa8-0003iZ-L6@rmk-PC.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Permit ALSA to run without hardware interrupts from the audio interface.
Instead, ALSA will use a kernel timer to decide when to check the buffer
state, resulting in a lighter workload for the CPU.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c | 11 ++++++-----
 sound/soc/kirkwood/kirkwood-i2s.c |  9 ++++++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index aac22fccdcdc..4cf2245950d7 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -28,11 +28,12 @@ static struct kirkwood_dma_data *kirkwood_priv(struct snd_pcm_substream *subs)
 }
 
 static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
-	.info = (SNDRV_PCM_INFO_INTERLEAVED |
-		 SNDRV_PCM_INFO_MMAP |
-		 SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		 SNDRV_PCM_INFO_PAUSE),
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
 	.buffer_bytes_max	= KIRKWOOD_SND_MAX_BUFFER_BYTES,
 	.period_bytes_min	= KIRKWOOD_SND_MIN_PERIOD_BYTES,
 	.period_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES,
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index e98650c01eba..0704cd6d2314 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -234,6 +234,7 @@ static unsigned kirkwood_i2s_play_mute(unsigned ctl)
 static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	uint32_t ctl, value;
 
@@ -271,9 +272,11 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
 		/* enable interrupts */
-		value = readl(priv->io + KIRKWOOD_INT_MASK);
-		value |= KIRKWOOD_INT_CAUSE_PLAY_BYTES;
-		writel(value, priv->io + KIRKWOOD_INT_MASK);
+		if (!runtime->no_period_wakeup) {
+			value = readl(priv->io + KIRKWOOD_INT_MASK);
+			value |= KIRKWOOD_INT_CAUSE_PLAY_BYTES;
+			writel(value, priv->io + KIRKWOOD_INT_MASK);
+		}
 
 		/* enable playback */
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
-- 
1.8.3.1
