From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: omap-mcbsp: Simplify checks for
	McBSP IP with FIFO
Date: Tue, 17 Jan 2012 14:16:09 +0100
Message-ID: <1326806170-7425-2-git-send-email-peter.ujfalusi@ti.com>
References: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F91D2439F
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 14:16:35 +0100 (CET)
Received: by mail-gy0-f176.google.com with SMTP id g2so691475ghb.7
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 05:16:34 -0800 (PST)
In-Reply-To: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

>From OMAP3 onwards the McBSP ports have FIFO. To avoid adding supported
SoC families to the list we can just rule out the omap24xx SoCs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 0173719..56333d5 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -132,9 +132,10 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 		err = omap_mcbsp_request(bus_id);
 
 	/*
-	 * OMAP3 McBSP FIFO is word structured.
-	 * McBSP2 has 1024 + 256 = 1280 word long buffer,
-	 * McBSP1,3,4,5 has 128 word long buffer
+	 * There is a FIFO in OMAP3 and newer SoCs for McBSP. This FIFO is word
+	 * structured.
+	 * OMAP3 McBSP2 has 1024 + 256 = 1280 word long buffer,
+	 * All other McBSP port has 128 word long buffer.
 	 * This means that the size of the FIFO depends on the sample format.
 	 * For example on McBSP3:
 	 * 16bit samples: size is 128 * 2 = 256 bytes
@@ -146,7 +147,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 * 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
 	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
 	 */
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (cpu_class_is_omap2() && !cpu_is_omap24xx()) {
 		/*
 		* Rule for the buffer size. We should not allow
 		* smaller buffer than the FIFO size to avoid underruns
@@ -258,7 +259,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (cpu_class_is_omap2() && !cpu_is_omap24xx()) {
 		dma_data->set_threshold = omap_mcbsp_set_threshold;
 		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
-- 
1.7.8.3
