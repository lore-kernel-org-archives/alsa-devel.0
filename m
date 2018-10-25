From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: On OMAP1 and OMAP2420 only
	16bit format is supported
Date: Thu, 25 Oct 2018 16:48:24 +0300
Message-ID: <20181025134824.16527-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA3226759E
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2018 15:47:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi
List-Id: alsa-devel@alsa-project.org

For samples sizes of 20/24/32 bit the DRR2/DXR2 registers must be used to
receive or transmit the most significant part of the 32bit sample.
We can not trick the system by using the DRR2/DXR2 register offset and use
32bit element size since these (and other McBSP) registers are 16bit ones.

We would need support for port_window in cyclic mode from the sDMA driver,
but it is not straight forward as we would need to have the sDMA frame to
cover the 32bit (DRR2+DRR1/DXR2+DXR1), but the frames must cover the ALSA
period to be able to receive periodic interrupts.

Since the 32bit samples are not working (DMA timeout), just remove it in
case we have McBSP with reg_size of 2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

I have noticed that on Nokia n810 32bit samples just don't work at all for audio

Regards,
Peter

 sound/soc/omap/omap-mcbsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d0ebb6b9bfac..caa24c463b3e 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -862,6 +862,11 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (mcbsp->pdata->reg_size == 2) {
+		omap_mcbsp_dai.playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		omap_mcbsp_dai.capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &omap_mcbsp_component,
 					      &omap_mcbsp_dai, 1);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
