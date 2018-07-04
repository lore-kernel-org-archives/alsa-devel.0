From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ASoC: stm32: Use snd_pcm_stop_xrun() helper
Date: Wed,  4 Jul 2018 16:01:46 +0200
Message-ID: <20180704140146.6768-5-tiwai@suse.de>
References: <20180704140146.6768-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 73B0E267732
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 16:01:50 +0200 (CEST)
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

The XRUN trigger from the driver should be done via
snd_pcm_stop_xrun().  It simplifies the locking as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/stm/stm32_sai_sub.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index cfeb219e1d78..6fea8a684da2 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -259,11 +259,8 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 		status = SNDRV_PCM_STATE_XRUN;
 	}
 
-	if (status != SNDRV_PCM_STATE_RUNNING) {
-		snd_pcm_stream_lock(sai->substream);
-		snd_pcm_stop(sai->substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(sai->substream);
-	}
+	if (status != SNDRV_PCM_STATE_RUNNING)
+		snd_pcm_stop_xrun(sai->substream);
 
 	return IRQ_HANDLED;
 }
-- 
2.18.0
