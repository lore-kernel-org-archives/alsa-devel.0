From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: mxs: Remove
	SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
Date: Mon,  6 Jan 2014 17:19:22 +0100
Message-ID: <1389025162-5601-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 48BD52610D1
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 17:19:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since commit 7b11304 ("dma: mxs-dma: Report correct residue for cyclic DMA")
the mxs dmaengine driver has support for residue reporting. So there is no need
to specify the SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag anymore. This allows a
finer grained resolution for the PCM pointer as well as avoids the race
condition that can occur with the period counting that is used when the
dmaengine driver does not support residue reporting.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
I don't have the hardware, so only compiled tested. But I assume that residue
reporting was added to the driver for exactly this.
---
 sound/soc/mxs/mxs-pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index 04a6b0d..c05c057 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -57,7 +57,6 @@ static const struct snd_dmaengine_pcm_config mxs_dmaengine_pcm_config = {
 int mxs_pcm_platform_register(struct device *dev)
 {
 	return devm_snd_dmaengine_pcm_register(dev, &mxs_dmaengine_pcm_config,
-		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 		SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX);
 }
 EXPORT_SYMBOL_GPL(mxs_pcm_platform_register);
-- 
1.8.0
