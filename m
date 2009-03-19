From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 1/3] ASoC: pxa-ssp: Use 16-bit DMA for magician
	stereo
Date: Thu, 19 Mar 2009 09:32:01 +0100
Message-ID: <1237451521.14402.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 48E161038E6
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 09:32:46 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e12so23611fga.21
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 01:32:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Now magician and similar boards can use network mode with only one
active slot to explicitly set 16 bit frame width, even for S16_LE
stereo sound.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index b0bf409..c7c1996 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -627,12 +627,18 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	u32 sscr0;
 	u32 sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
+	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
 
 	/* select correct DMA params */
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		dma = 1; /* capture DMA offset is 1,3 */
-	if (chn == 2)
-		dma += 2; /* stereo DMA offset is 2, mono is 0 */
+	/* Network mode with one active slot (ttsa == 1) can be used
+	 * to force 16-bit frame width on the wire (for S16_LE), even
+	 * with two channels. Use 16-bit DMA transfers for this case.
+	 */
+	if (((chn == 2) && (ttsa != 1)) || (width == 32))
+		dma += 2; /* 32-bit DMA offset is 2, 16-bit is 0 */
+
 	cpu_dai->dma_data = ssp_dma_params[cpu_dai->id][dma];
 
 	dev_dbg(&ssp->pdev->dev, "pxa_ssp_hw_params: dma %d\n", dma);
@@ -712,7 +718,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	/* When we use a network mode, we always require TDM slots
 	 * - complain loudly and fail if they've not been set up yet.
 	 */
-	if ((sscr0 & SSCR0_MOD) && !(ssp_read_reg(ssp, SSTSA) & 0xf)) {
+	if ((sscr0 & SSCR0_MOD) && !ttsa) {
 		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
 		return -EINVAL;
 	}
-- 
1.6.2
