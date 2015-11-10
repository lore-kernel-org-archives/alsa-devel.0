From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Fix TDM slot rx/tx mask
	associations" to the asoc tree
Date: Tue, 10 Nov 2015 18:53:36 +0000
Message-ID: <E1ZwE2y-0001if-NG@debutante>
References: <1447093159-32294-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E0EFB265469
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 19:53:42 +0100 (CET)
In-Reply-To: <1447093159-32294-1-git-send-email-dannenberg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Fix TDM slot rx/tx mask associations

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1bdd593247ee5a74eb58828a4cf18bdc8a5f1baa Mon Sep 17 00:00:00 2001
From: Andreas Dannenberg <dannenberg@ti.com>
Date: Mon, 9 Nov 2015 12:19:19 -0600
Subject: [PATCH] ASoC: davinci-mcasp: Fix TDM slot rx/tx mask associations

Fixes the associations between the tx_mask and rx_mask and the associated
playback / capture streams during setting of the TDM slot. With this
patch in place it is now possible for example to only populate tx_mask
(leaving rx_mask as 0) for output-only codecs to control the TDM slot(s)
the McASP serial port uses for transmit. Before that, this scenario
would incorrectly rely on the rx_mask for this.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 4495a40a9468..caa0bebcd7f4 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -681,8 +681,8 @@ static int davinci_mcasp_set_tdm_slot(struct snd_soc_dai *dai,
 	}
 
 	mcasp->tdm_slots = slots;
-	mcasp->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = rx_mask;
-	mcasp->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = tx_mask;
+	mcasp->tdm_mask[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
+	mcasp->tdm_mask[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
 	mcasp->slot_width = slot_width;
 
 	return davinci_mcasp_set_ch_constraints(mcasp);
-- 
2.6.2
