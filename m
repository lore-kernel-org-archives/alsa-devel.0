From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6afe-dai: add support to
	Display port RX dais" to the asoc tree
Date: Fri, 14 Dec 2018 12:49:18 +0000 (GMT)
Message-ID: <20181214124918.DFE7A11258A2@debutante.sirena.org.uk>
References: <1544790569-10608-4-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CE8326799F
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:49:20 +0100 (CET)
In-Reply-To: <1544790569-10608-4-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, asishb@codeaurora.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6afe-dai: add support to Display port RX dais

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

>From 32d2c61ba05944aa1e61d186611310dd911e1703 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 17:59:28 +0530
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: add support to Display port RX dais

This patch adds support of AFE DAI for Display_port_rx port.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index bfc3bbf1d4de..dc645ba4d8d0 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -341,6 +341,7 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 
 	switch (dai->id) {
 	case HDMI_RX:
+	case DISPLAY_PORT_RX:
 		q6afe_hdmi_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].hdmi);
 		break;
@@ -445,6 +446,7 @@ static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
 
 static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"HDMI Playback", NULL, "HDMI_RX"},
+	{"Display Port Playback", NULL, "DISPLAY_PORT_RX"},
 	{"Slimbus1 Playback", NULL, "SLIMBUS_1_RX"},
 	{"Slimbus2 Playback", NULL, "SLIMBUS_2_RX"},
 	{"Slimbus3 Playback", NULL, "SLIMBUS_3_RX"},
@@ -1090,6 +1092,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 	Q6AFE_TDM_CAP_DAI("Quinary", 5, QUINARY_TDM_TX_5),
 	Q6AFE_TDM_CAP_DAI("Quinary", 6, QUINARY_TDM_TX_6),
 	Q6AFE_TDM_CAP_DAI("Quinary", 7, QUINARY_TDM_TX_7),
+	{
+		.playback = {
+			.stream_name = "Display Port Playback",
+			.rates = SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_max =     192000,
+			.rate_min =	48000,
+		},
+		.ops = &q6hdmi_ops,
+		.id = DISPLAY_PORT_RX,
+		.name = "DISPLAY_PORT",
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	},
 };
 
 static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
@@ -1311,6 +1332,7 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 						0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_7", NULL,
 						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("DISPLAY_PORT_RX", "NULL", 0, 0, 0, 0),
 };
 
 static const struct snd_soc_component_driver q6afe_dai_component = {
-- 
2.19.0.rc2
