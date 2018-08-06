From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6afe-dai: add SLIM tx AIF_IN
	dapm" to the asoc tree
Date: Mon,  6 Aug 2018 12:50:23 +0100 (BST)
Message-ID: <20180806115023.F111F1124240@debutante.sirena.org.uk>
References: <20180806101209.15167-6-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BE7502676A3
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:50:25 +0200 (CEST)
In-Reply-To: <20180806101209.15167-6-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6afe-dai: add SLIM tx AIF_IN dapm

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

>From 0961503412e3e13d82f885f9fb3af527edd58e47 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 6 Aug 2018 11:12:09 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: add SLIM tx AIF_IN dapm

Add missing AIF_IN dapm for slim tx ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index e988692a3ced..139d24be3fb9 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1117,6 +1117,13 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_RX", "Slimbus4 Playback", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_RX", "Slimbus5 Playback", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_RX", "Slimbus6 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_TX", "Slimbus Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_TX", "Slimbus1 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_TX", "Slimbus2 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_TX", "Slimbus3 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_TX", "Slimbus4 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_TX", "Slimbus5 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_TX", "Slimbus6 Capture", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_RX", "Quaternary MI2S Playback",
 						0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_TX", "Quaternary MI2S Capture",
-- 
2.18.0
