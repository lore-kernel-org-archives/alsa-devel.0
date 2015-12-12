From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: Apply symmetry for DPCM" to the
	asoc tree
Date: Sat, 12 Dec 2015 23:07:22 +0000
Message-ID: <E1a7tG6-0002bu-Nj@finisterre>
References: <1449804831-58929-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57A7B260851
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:31 +0100 (CET)
In-Reply-To: <1449804831-58929-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: PC Liao <pc.liao@mediatek.com>, Koro Chen <koro.chen@mediatek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: Apply symmetry for DPCM

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

>From 906c7d690c3b80e4321178c083db8c14afb56bf8 Mon Sep 17 00:00:00 2001
From: PC Liao <pc.liao@mediatek.com>
Date: Fri, 11 Dec 2015 11:33:51 +0800
Subject: [PATCH] ASoC: dpcm: Apply symmetry for DPCM

DPCM does not fully support symmetry attributes. soc_pcm_apply_symmetry()
is skipped in soc_pcm_open() for DPCM, without being applied elsewhere.
So HW parameters cannot be correctly limited, and user space can do
playback/capture at different rates while HW actually does not support it.
soc_pcm_params_symmetry() will return error and the second stream stops.

This patch adds soc_pcm_apply_symmetry() for FE, BE, and codec DAIs
in DPCM path that was skipped in soc_pcm_open().

Signed-off-by: PC Liao <pc.liao@mediatek.com>
Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index c482322..37de8af 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1616,6 +1616,56 @@ static void dpcm_set_fe_update_state(struct snd_soc_pcm_runtime *fe,
 	snd_pcm_stream_unlock_irq(substream);
 }
 
+static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
+			       int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
+	struct snd_soc_dai *fe_cpu_dai = fe->cpu_dai;
+	int err;
+
+	/* apply symmetry for FE */
+	if (soc_pcm_has_symmetry(fe_substream))
+		fe_substream->runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
+
+	/* Symmetry only applies if we've got an active stream. */
+	if (fe_cpu_dai->active) {
+		err = soc_pcm_apply_symmetry(fe_substream, fe_cpu_dai);
+		if (err < 0)
+			return err;
+	}
+
+	/* apply symmetry for BE */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+		struct snd_soc_pcm_runtime *rtd = be_substream->private_data;
+		int i;
+
+		if (soc_pcm_has_symmetry(be_substream))
+			be_substream->runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
+
+		/* Symmetry only applies if we've got an active stream. */
+		if (rtd->cpu_dai->active) {
+			err = soc_pcm_apply_symmetry(be_substream, rtd->cpu_dai);
+			if (err < 0)
+				return err;
+		}
+
+		for (i = 0; i < rtd->num_codecs; i++) {
+			if (rtd->codec_dais[i]->active) {
+				err = soc_pcm_apply_symmetry(be_substream,
+							     rtd->codec_dais[i]);
+				if (err < 0)
+					return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 {
 	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
@@ -1644,6 +1694,13 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 	dpcm_set_fe_runtime(fe_substream);
 	snd_pcm_limit_hw_rates(runtime);
 
+	ret = dpcm_apply_symmetry(fe_substream, stream);
+	if (ret < 0) {
+		dev_err(fe->dev, "ASoC: failed to apply dpcm symmetry %d\n",
+			ret);
+		goto unwind;
+	}
+
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 	return 0;
 
-- 
2.6.4
