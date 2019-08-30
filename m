From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] ASoC: ti: davinci-i2s: Move the XSYNCERR
	workaround to .prepare callback
Date: Fri, 30 Aug 2019 13:38:39 +0300
Message-ID: <20190830103841.25128-3-peter.ujfalusi@ti.com>
References: <20190830103841.25128-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDEBEF80096
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 12:38:26 +0200 (CEST)
In-Reply-To: <20190830103841.25128-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Currently the driver uses snd_soc_rtdcom_lookup() in it's mcbsp_start
function to try to stop/restart the DMA as the initial XSYNCERR workaround
need to be done before the DMA is armed.

There are couple of things wrong with this:
- the driver crashes with NULL pointer dereference as the
  component->driver->ops is actually NULL
- the driver should not use snd_soc_rtdcom_lookup() in the first place
- Fiddling with DMA is never a good thing

Move the workaround handling to .prepare which is called before the DMA is
armed, so it complies with the requirements.

Reported-by (usage of snd_soc_rtdcom_lookup): Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-i2s.c | 82 ++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 48 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index f04d9fb5130f..d89b5c928c4d 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -187,57 +187,9 @@ static void toggle_clock(struct davinci_mcbsp_dev *dev, int playback)
 static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 spcr;
 	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
-	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-	if (spcr & mask) {
-		/* start off disabled */
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
-				spcr & ~mask);
-		toggle_clock(dev, playback);
-	}
-	if (dev->pcr & (DAVINCI_MCBSP_PCR_FSXM | DAVINCI_MCBSP_PCR_FSRM |
-			DAVINCI_MCBSP_PCR_CLKXM | DAVINCI_MCBSP_PCR_CLKRM)) {
-		/* Start the sample generator */
-		spcr |= DAVINCI_MCBSP_SPCR_GRST;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-	}
-
-	if (playback) {
-		/* Stop the DMA to avoid data loss */
-		/* while the transmitter is out of reset to handle XSYNCERR */
-		if (component->driver->ops->trigger) {
-			int ret = component->driver->ops->trigger(substream,
-				SNDRV_PCM_TRIGGER_STOP);
-			if (ret < 0)
-				printk(KERN_DEBUG "Playback DMA stop failed\n");
-		}
-
-		/* Enable the transmitter */
-		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		spcr |= DAVINCI_MCBSP_SPCR_XRST;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-
-		/* wait for any unexpected frame sync error to occur */
-		udelay(100);
-
-		/* Disable the transmitter to clear any outstanding XSYNCERR */
-		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-		toggle_clock(dev, playback);
-
-		/* Restart the DMA */
-		if (component->driver->ops->trigger) {
-			int ret = component->driver->ops->trigger(substream,
-				SNDRV_PCM_TRIGGER_START);
-			if (ret < 0)
-				printk(KERN_DEBUG "Playback DMA start failed\n");
-		}
-	}
 
 	/* Enable transmitter or receiver */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
@@ -575,7 +527,41 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 {
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	u32 spcr;
+	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
+
 	davinci_mcbsp_stop(dev, playback);
+
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	if (spcr & mask) {
+		/* start off disabled */
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
+					spcr & ~mask);
+		toggle_clock(dev, playback);
+	}
+	if (dev->pcr & (DAVINCI_MCBSP_PCR_FSXM | DAVINCI_MCBSP_PCR_FSRM |
+			DAVINCI_MCBSP_PCR_CLKXM | DAVINCI_MCBSP_PCR_CLKRM)) {
+		/* Start the sample generator */
+		spcr |= DAVINCI_MCBSP_SPCR_GRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+	}
+
+	if (playback) {
+		/* Enable the transmitter */
+		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		spcr |= DAVINCI_MCBSP_SPCR_XRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+
+		/* wait for any unexpected frame sync error to occur */
+		udelay(100);
+
+		/* Disable the transmitter to clear any outstanding XSYNCERR */
+		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+		toggle_clock(dev, playback);
+	}
+
 	return 0;
 }
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
