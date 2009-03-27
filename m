From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ASoC: OMAP: Set minimum buffer size constraint
	for McBSP2 in OMAP3
Date: Fri, 27 Mar 2009 15:32:01 +0200
Message-ID: <1238160721-27180-2-git-send-email-jarkko.nikula@nokia.com>
References: <20090327085613.dc719780.jarkko.nikula@nokia.com>
	<1238160721-27180-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A40410389D
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 14:31:48 +0100 (CET)
In-Reply-To: <1238160721-27180-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, x0052729@ti.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d6882be..9c09b94 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -146,6 +146,17 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	int err = 0;
 
+	if (cpu_is_omap343x() && mcbsp_data->bus_id == 1) {
+		/*
+		 * McBSP2 in OMAP3 has 1024 * 32-bit internal audio buffer.
+		 * Set constraint for minimum buffer size to the same than FIFO
+		 * size in order to avoid underruns in playback startup because
+		 * HW is keeping the DMA request active until FIFO is filled.
+		 */
+		snd_pcm_hw_constraint_minmax(substream->runtime,
+			SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 4096, UINT_MAX);
+	}
+
 	if (!cpu_dai->active)
 		err = omap_mcbsp_request(mcbsp_data->bus_id);
 
-- 
1.6.2
