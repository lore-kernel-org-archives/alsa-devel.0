From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: mpc5200_dma: remove unused psc_dma" to the asoc tree
Date: Wed, 21 Jun 2017 12:16:47 +0100
Message-ID: <E1dNdct-0004Gq-6Z@debutante>
References: <87o9ti6jws.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87o9ti6jws.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: mpc5200_dma: remove unused psc_dma

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

>From 372f69a01be178b896ebb8ef7021e0b165084b25 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jun 2017 04:37:18 +0000
Subject: [PATCH] ASoC: fsl: mpc5200_dma: remove unused psc_dma
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

linux/sound/soc/fsl/mpc5200_dma.c:305:18: warning: unused variable \
	psc_dma’ [-Wunused-variable]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mpc5200_dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 0b82e209b6e3..1f7e70bfbd55 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -302,7 +302,6 @@ static int psc_dma_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
-	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	size_t size = psc_dma_hardware.buffer_bytes_max;
 	int rc;
 
-- 
2.11.0
