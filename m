From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: fix iec958 controls indexation" to the asoc tree
Date: Mon,  4 Mar 2019 00:06:06 +0000 (GMT)
Message-ID: <20190304000606.7B327440082@finisterre.ee.mobilebroadband>
References: <1551359965-25228-2-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551359965-25228-2-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: fix iec958 controls indexation

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

>From 5f8a1000c3e630c3ac06f1d664eeaa755bce8823 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 28 Feb 2019 14:19:21 +0100
Subject: [PATCH] ASoC: stm32: sai: fix iec958 controls indexation

Allow indexation of sai iec958 controls according
to device id.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index f9297228c41c..506360b7bc01 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -100,7 +100,7 @@
  * @slot_mask: rx or tx active slots mask. set at init or at runtime
  * @data_size: PCM data width. corresponds to PCM substream width.
  * @spdif_frm_cnt: S/PDIF playback frame counter
- * @snd_aes_iec958: iec958 data
+ * @iec958: iec958 data
  * @ctrl_lock: control lock
  */
 struct stm32_sai_sub_data {
@@ -1068,11 +1068,12 @@ static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+	struct snd_kcontrol_new knew = iec958_ctls;
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
 		dev_dbg(&sai->pdev->dev, "%s: register iec controls", __func__);
-		return snd_ctl_add(rtd->pcm->card,
-				   snd_ctl_new1(&iec958_ctls, sai));
+		knew.device = rtd->pcm->device;
+		return snd_ctl_add(rtd->pcm->card, snd_ctl_new1(&knew, sai));
 	}
 
 	return 0;
-- 
2.20.1
