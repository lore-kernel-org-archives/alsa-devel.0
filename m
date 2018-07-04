From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ASoC: davinci: Use snd_pcm_stop_xrun()
	helper
Date: Wed,  4 Jul 2018 16:01:43 +0200
Message-ID: <20180704140146.6768-2-tiwai@suse.de>
References: <20180704140146.6768-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E911267705
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 16:01:49 +0200 (CEST)
In-Reply-To: <20180704140146.6768-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Alexandre Torgue <alexandre.torgue@st.com>, Patrick Lai <plai@codeaurora.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

Replace open-codes with the standard snd_pcm_stop_xrun() helper.
It simplifies codes a lot.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/davinci/davinci-mcasp.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 47c0c821d325..f70db8412c7c 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -320,12 +320,8 @@ static irqreturn_t davinci_mcasp_tx_irq_handler(int irq, void *data)
 		handled_mask |= XUNDRN;
 
 		substream = mcasp->substreams[SNDRV_PCM_STREAM_PLAYBACK];
-		if (substream) {
-			snd_pcm_stream_lock_irq(substream);
-			if (snd_pcm_running(substream))
-				snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-			snd_pcm_stream_unlock_irq(substream);
-		}
+		if (substream)
+			snd_pcm_stop_xrun(substream);
 	}
 
 	if (!handled_mask)
@@ -355,12 +351,8 @@ static irqreturn_t davinci_mcasp_rx_irq_handler(int irq, void *data)
 		handled_mask |= ROVRN;
 
 		substream = mcasp->substreams[SNDRV_PCM_STREAM_CAPTURE];
-		if (substream) {
-			snd_pcm_stream_lock_irq(substream);
-			if (snd_pcm_running(substream))
-				snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-			snd_pcm_stream_unlock_irq(substream);
-		}
+		if (substream)
+			snd_pcm_stop_xrun(substream);
 	}
 
 	if (!handled_mask)
-- 
2.18.0
