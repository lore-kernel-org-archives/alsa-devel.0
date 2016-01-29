From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: copy dpcm->hw_params and call
	be_hw_params_fixup every time" to the asoc tree
Date: Fri, 29 Jan 2016 01:22:27 +0100
Message-ID: <E1aOwpX-0005mr-S2@finisterre>
References: <87si1r4shm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 765BC2614CB
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 01:22:38 +0100 (CET)
In-Reply-To: <87si1r4shm.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-pcm: copy dpcm->hw_params and call be_hw_params_fixup every time

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

>From b0639bd2428d61a13b69d2ff247cfceae90b8366 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:47:12 +0000
Subject: [PATCH] ASoC: soc-pcm: copy dpcm->hw_params and call
 be_hw_params_fixup every time

Current DPCM doesn't copy dpcm->hw_params and doesn't call be_hw_params
if some FE are connected. But 2nd or later FE might want to know BE hw_params.
This patch solves this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e898b42..be2fd5e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1866,18 +1866,6 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
 			continue;
 
-		/* only allow hw_params() if no connected FEs are running */
-		if (!snd_soc_dpcm_can_be_params(fe, be, stream))
-			continue;
-
-		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE))
-			continue;
-
-		dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
-			dpcm->fe->dai_link->name);
-
 		/* copy params for each dpcm */
 		memcpy(&dpcm->hw_params, &fe->dpcm[stream].hw_params,
 				sizeof(struct snd_pcm_hw_params));
@@ -1894,6 +1882,18 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 			}
 		}
 
+		/* only allow hw_params() if no connected FEs are running */
+		if (!snd_soc_dpcm_can_be_params(fe, be, stream))
+			continue;
+
+		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE))
+			continue;
+
+		dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
+			dpcm->fe->dai_link->name);
+
 		ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
 		if (ret < 0) {
 			dev_err(dpcm->be->dev,
-- 
2.6.4
