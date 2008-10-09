From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][DON'T PUSH][PATCH 2/3] ASoC: OMAP: Set
	DMA stream name at runtime in McBSP DAI driver
Date: Thu,  9 Oct 2008 15:57:21 +0300
Message-ID: <1223557042-17279-3-git-send-email-jarkko.nikula@nokia.com>
References: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id C61F924481
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 14:58:14 +0200 (CEST)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m99CvbYe028695
	for <alsa-devel@alsa-project.org>; Thu, 9 Oct 2008 15:57:55 +0300
In-Reply-To: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

This suits better when adding support for multiple links and different
link formats.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 4ff73fc..6e4c315 100644
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
