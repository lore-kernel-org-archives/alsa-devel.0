From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/21] ASoC: OMAP: Add checking to detect
	bufferless pcms
Date: Thu, 23 Apr 2009 20:55:41 +0100
Message-ID: <1240516555-22249-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A7B51038A2
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:07 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

From: Joonyoung Shim <jy0922.shim@samsung.com>

Add checking in hw_params and prepare to detect bufferless pcms(i.e. BT
<--> codec).

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-pcm.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 07cf7f4..6454e15 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -87,8 +87,10 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct omap_pcm_dma_data *dma_data = rtd->dai->cpu_dai->dma_data;
 	int err = 0;
 
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
 	if (!dma_data)
-		return -ENODEV;
+		return 0;
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	runtime->dma_bytes = params_buffer_bytes(params);
@@ -134,6 +136,11 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
 	struct omap_dma_channel_params dma_params;
 
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	if (!prtd->dma_data)
+		return 0;
+
 	memset(&dma_params, 0, sizeof(dma_params));
 	/*
 	 * Note: Regardless of interface data formats supported by OMAP McBSP
-- 
1.5.6.3
