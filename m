From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ASoC: qcom: Use snd_pcm_stop_xrun() helper
Date: Wed,  4 Jul 2018 16:01:44 +0200
Message-ID: <20180704140146.6768-3-tiwai@suse.de>
References: <20180704140146.6768-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 306B326772D
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
snd_pcm_stop_xrun().  It fixes the missing stream locking as a gratis,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 31fe78aa207f..d07271ea4c45 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -458,7 +458,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
 			return IRQ_NONE;
 		}
 		dev_warn(soc_runtime->dev, "xrun warning\n");
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stop_xrun(substream);
 		ret = IRQ_HANDLED;
 	}
 
-- 
2.18.0
