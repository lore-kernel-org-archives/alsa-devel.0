From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ASoC: DaVinci: Correct McASP FIFO
	initialization
Date: Wed, 23 Sep 2009 10:12:08 -0400
Message-ID: <1253715128-31452-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EAB2243CB
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 06:54:30 +0200 (CEST)
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
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

McASP write FIFO registers should be modified for playback and read FIFO
registers for capture. Check the PCM mode before manipulating the
FIFO registers. Currently, irrespective of playback/capture both the
FIFOs are enabled or disbaled. This resulted in errors in audio loopback
mode.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/davinci-mcasp.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 7a06c0a..613fd98 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -386,17 +386,17 @@ static void mcasp_start_tx(struct davinci_audio_dev *dev)
 
 static void davinci_mcasp_start(struct davinci_audio_dev *dev, int stream)
 {
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (dev->txnumevt)	/* enable FIFO */
+			mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+								FIFO_ENABLE);
 		mcasp_start_tx(dev);
-	else
+	} else {
+		if (dev->rxnumevt)	/* enable FIFO */
+			mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+								FIFO_ENABLE);
 		mcasp_start_rx(dev);
-
-	/* enable FIFO */
-	if (dev->txnumevt)
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, FIFO_ENABLE);
-
-	if (dev->rxnumevt)
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, FIFO_ENABLE);
+	}
 }
 
 static void mcasp_stop_rx(struct davinci_audio_dev *dev)
@@ -413,17 +413,17 @@ static void mcasp_stop_tx(struct davinci_audio_dev *dev)
 
 static void davinci_mcasp_stop(struct davinci_audio_dev *dev, int stream)
 {
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (dev->txnumevt)	/* disable FIFO */
+			mcasp_clr_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+								FIFO_ENABLE);
 		mcasp_stop_tx(dev);
-	else
+	} else {
+		if (dev->rxnumevt)	/* disable FIFO */
+			mcasp_clr_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+								FIFO_ENABLE);
 		mcasp_stop_rx(dev);
-
-	/* disable FIFO */
-	if (dev->txnumevt)
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, FIFO_ENABLE);
-
-	if (dev->rxnumevt)
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, FIFO_ENABLE);
+	}
 }
 
 static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
-- 
1.5.6
