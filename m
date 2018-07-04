From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Use snd_pcm_stop_xrun() helper"
	to the asoc tree
Date: Wed, 04 Jul 2018 15:42:09 +0100
Message-ID: <E1faiyv-00042j-5k@debutante>
References: <20180704140146.6768-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C71B5267766
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 16:42:13 +0200 (CEST)
In-Reply-To: <20180704140146.6768-3-tiwai@suse.de>
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

   ASoC: qcom: Use snd_pcm_stop_xrun() helper

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

>From 1a42e7e3aff1aa4789378020318dff7432317d25 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 4 Jul 2018 16:01:44 +0200
Subject: [PATCH] ASoC: qcom: Use snd_pcm_stop_xrun() helper

The XRUN trigger from the driver should be done via
snd_pcm_stop_xrun().  It fixes the missing stream locking as a gratis,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.18.0.rc2
