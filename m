From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 5/6] ASoC: davinci-pcm: extract period elapsed
	functions
Date: Tue, 24 May 2011 14:50:19 -0400
Message-ID: <370afaeca1dbc55213db8a8df1f8b0b46c076af3.1306258759.git.bengardiner@nanometrics.ca>
References: <cover.1306258759.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 64EE71039F0
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 20:50:33 +0200 (CEST)
Received: by mail-vx0-f173.google.com with SMTP id 37so6400464vxb.32
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 11:50:29 -0700 (PDT)
In-Reply-To: <cover.1306258759.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Steven Faludi <stevenfaludi@nanometrics.ca>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Extract functions that modify the prtd->period member in preparation for
conversion to BATCH mode playback.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: Steven Faludi <stevenfaludi@nanometrics.ca>

---
 sound/soc/davinci/davinci-pcm.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 5d9269a..fedca81 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -155,6 +155,22 @@ struct davinci_runtime_data {
 	struct edmacc_param ram_params;
 };
 
+static void davinci_pcm_period_elapsed(struct snd_pcm_substream *substream)
+{
+	struct davinci_runtime_data *prtd = substream->runtime->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	prtd->period++;
+	if (unlikely(prtd->period >= runtime->periods))
+		prtd->period = 0;
+}
+
+static void davinci_pcm_period_reset(struct snd_pcm_substream *substream)
+{
+	struct davinci_runtime_data *prtd = substream->runtime->private_data;
+
+	prtd->period = 0;
+}
 /*
  * Not used with ping/pong
  */
@@ -216,9 +232,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 		edma_set_transfer_params(link, acnt, fifo_level, count,
 							fifo_level, ABSYNC);
 
-	prtd->period++;
-	if (unlikely(prtd->period >= runtime->periods))
-		prtd->period = 0;
+	davinci_pcm_period_elapsed(substream);
 }
 
 static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
@@ -591,7 +605,7 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 
 		return 0;
 	}
-	prtd->period = 0;
+	davinci_pcm_period_reset(substream);
 	davinci_pcm_enqueue_dma(substream);
 
 	/* Copy self-linked parameter RAM entry into master channel */
-- 
1.7.4.1
