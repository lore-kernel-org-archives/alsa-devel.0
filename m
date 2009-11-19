From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 4/4] ASoC: DaVinci: use edma_pause, edma_resume
Date: Wed, 18 Nov 2009 17:49:54 -0700
Message-ID: <1258591794-18416-4-git-send-email-troy.kisky@boundarydevices.com>
References: <1258591794-18416-1-git-send-email-troy.kisky@boundarydevices.com>
	<1258591794-18416-2-git-send-email-troy.kisky@boundarydevices.com>
	<1258591794-18416-3-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-02.inet.qwest.net (mpls-qmqp-02.inet.qwest.net
	[63.231.195.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F65A1037EA
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 01:50:05 +0100 (CET)
In-Reply-To: <1258591794-18416-3-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Use edma_pause and edma_resume to make missing dma_events
less likely. This may not be needed, but it looks better.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-pcm.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 664d493..ad4d7f4 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -528,12 +528,12 @@ static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		edma_start(prtd->asp_channel);
+		edma_resume(prtd->asp_channel);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		edma_stop(prtd->asp_channel);
+		edma_pause(prtd->asp_channel);
 		break;
 	default:
 		ret = -EINVAL;
@@ -568,6 +568,7 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 			/* copy 1st iram buffer */
 			edma_start(prtd->ram_channel);
 		}
+		edma_start(prtd->asp_channel);
 		return 0;
 	}
 	prtd->period = 0;
@@ -577,6 +578,7 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 	edma_read_slot(prtd->asp_link[0], &prtd->asp_params);
 	edma_write_slot(prtd->asp_channel, &prtd->asp_params);
 	davinci_pcm_enqueue_dma(substream);
+	edma_start(prtd->asp_channel);
 
 	return 0;
 }
-- 
1.5.6.3
