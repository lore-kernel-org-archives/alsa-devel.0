From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: OMAP: Add checking to detect bufferless
	pcms
Date: Wed, 22 Apr 2009 10:56:50 +0900
Message-ID: <49EE7962.6080008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 844EA244E0
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 03:57:03 +0200 (CEST)
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KIH007ESC2QSC@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 22 Apr 2009 10:56:50 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KIH005WMC2QPT@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 22 Apr 2009 10:56:50 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

Add checking in hw_params and prepare to detect bufferless pcms(i.e. BT
<--> codec).

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
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
