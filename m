From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: OMAP: Set DMA stream name at runtime
	in McBSP DAI driver
Date: Fri, 10 Oct 2008 15:52:17 +0100
Message-ID: <1223650337-15371-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081010145127.GA15329@rakim.wolfsonmicro.main>
	<1223650337-15371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223650337-15371-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223650337-15371-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43C552476B
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 16:52:36 +0200 (CEST)
In-Reply-To: <1223650337-15371-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

This suits better when adding support for multiple links and different
link formats.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-mcbsp.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index e97e6b2..0a063a9 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -59,12 +59,7 @@ static struct omap_mcbsp_data mcbsp_data[NUM_LINKS];
  * Stream DMA parameters. DMA request line and port address are set runtime
  * since they are different between OMAP1 and later OMAPs
  */
-static struct omap_pcm_dma_data omap_mcbsp_dai_dma_params[NUM_LINKS][2] = {
-{
-	{ .name		= "I2S PCM Stereo out", },
-	{ .name		= "I2S PCM Stereo in", },
-},
-};
+static struct omap_pcm_dma_data omap_mcbsp_dai_dma_params[NUM_LINKS][2];
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
 static const int omap1_dma_reqs[][2] = {
@@ -222,6 +217,8 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else {
 		return -ENODEV;
 	}
+	omap_mcbsp_dai_dma_params[id][substream->stream].name =
+		substream->stream ? "Audio Capture" : "Audio Playback";
 	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
 	omap_mcbsp_dai_dma_params[id][substream->stream].port_addr = port;
 	cpu_dai->dma_data = &omap_mcbsp_dai_dma_params[id][substream->stream];
-- 
1.5.6.5
