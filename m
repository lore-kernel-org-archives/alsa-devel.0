From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: fix BE dai not hw_free and
	shutdown" to the asoc tree
Date: Tue, 29 May 2018 15:59:39 +0100
Message-ID: <E1fNg67-00068C-3o@debutante>
References: <1527473899-23079-2-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C9997267705
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 16:59:47 +0200 (CEST)
In-Reply-To: <1527473899-23079-2-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: fix BE dai not hw_free and shutdown

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

>From 9c0ac70ad24d76b873c1551e27790c7f6a815d5c Mon Sep 17 00:00:00 2001
From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Date: Mon, 28 May 2018 10:18:18 +0800
Subject: [PATCH] ASoC: dpcm: fix BE dai not hw_free and shutdown

In case, one BE is used by two FE1/FE2
FE1--->BE-->
       |
FE2----]
when FE1/FE2 call dpcm_be_dai_hw_free() together
the BE users will be 2 (> 1), hence cannot be hw_free
the be state will leave at, ex. SND_SOC_DPCM_STATE_STOP

later FE1/FE2 call dpcm_be_dai_shutdown(),
will be skip due to wrong state.
leaving the BE not being hw_free and shutdown.

The BE dai will be hw_free later when calling
dpcm_be_dai_shutdown() if still in invalid state.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2df4719a84db..2d846b3dd70c 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1866,8 +1866,10 @@ int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN))
-			continue;
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN)) {
+			soc_pcm_hw_free(be_substream);
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
+		}
 
 		dev_dbg(be->dev, "ASoC: close BE %s\n",
 			be->dai_link->name);
-- 
2.17.0
