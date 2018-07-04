From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci: Use snd_pcm_stop_xrun()
	helper" to the asoc tree
Date: Wed, 04 Jul 2018 15:42:11 +0100
Message-ID: <E1faiyx-00043h-B6@debutante>
References: <20180704140146.6768-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01FFC267796
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 16:42:14 +0200 (CEST)
In-Reply-To: <20180704140146.6768-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Alexandre Torgue <alexandre.torgue@st.com>, Patrick Lai <plai@codeaurora.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci: Use snd_pcm_stop_xrun() helper

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From dae35d1f4f7dab9ccef20037df91c43e680bad0f Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 4 Jul 2018 16:01:43 +0200
Subject: [PATCH] ASoC: davinci: Use snd_pcm_stop_xrun() helper

Replace open-codes with the standard snd_pcm_stop_xrun() helper.
It simplifies codes a lot.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.18.0.rc2
