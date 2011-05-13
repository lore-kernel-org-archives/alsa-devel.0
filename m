From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 1/2] [RFC] ASoC: davinci-mcasp: enable
	ping-pong SRAM buffers
Date: Fri, 13 May 2011 17:26:45 -0400
Message-ID: <771769182c177a9cd9472392e1d5a92d21025aa2.1305321198.git.bengardiner@nanometrics.ca>
References: <cover.1305321198.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 3541710380D
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 23:26:53 +0200 (CEST)
Received: by yxl31 with SMTP id 31so1309892yxl.41
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 14:26:51 -0700 (PDT)
In-Reply-To: <cover.1305321198.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Sekhar Nori <nsekhar@ti.com>
List-Id: alsa-devel@alsa-project.org

The davinci-i2s driver copies the platform data for playback and capture
sram sizes which is in turn used by davinci-pcm to allocate ping-pong
buffers.

Copy also the platform data in the davinci-mcasp probe().

Not-signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 sound/soc/davinci/davinci-mcasp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 4ddc6d3..8566238 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -909,6 +909,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
+	dma_data->sram_size = pdata->sram_size_playback;
 	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
 							mem->start);
 
@@ -925,6 +926,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_CAPTURE];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
+	dma_data->sram_size = pdata->sram_size_capture;
 	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
 							mem->start);
 
-- 
1.7.4.1
