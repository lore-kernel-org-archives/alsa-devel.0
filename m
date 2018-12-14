From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6routing: add display_port_rx
	port routing" to the asoc tree
Date: Fri, 14 Dec 2018 12:49:17 +0000 (GMT)
Message-ID: <20181214124917.129B111258A2@debutante.sirena.org.uk>
References: <1544790569-10608-5-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F07226798A
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:49:19 +0100 (CET)
In-Reply-To: <1544790569-10608-5-git-send-email-rohitkr@codeaurora.org>
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

   ASoC: qdsp6: q6routing: add display_port_rx port routing

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

>From 0718f87b0df49570cdcb96179997bd372cac1742 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 17:59:29 +0530
Subject: [PATCH] ASoC: qdsp6: q6routing: add display_port_rx port routing

This patch add support to Display_port_rx mixers required to
select path between ASM stream and AFE ports.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index d61b8404f7da..ddcd9978cf57 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -453,6 +453,9 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(HDMI_RX) };
 
+static const struct snd_kcontrol_new display_port_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(DISPLAY_PORT_RX) };
+
 static const struct snd_kcontrol_new primary_mi2s_rx_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(PRIMARY_MI2S_RX) };
 
@@ -655,6 +658,10 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 			   hdmi_mixer_controls,
 			   ARRAY_SIZE(hdmi_mixer_controls)),
 
+	SND_SOC_DAPM_MIXER("DISPLAY_PORT_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   display_port_mixer_controls,
+			   ARRAY_SIZE(display_port_mixer_controls)),
+
 	SND_SOC_DAPM_MIXER("SLIMBUS_0_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
 			   slimbus_rx_mixer_controls,
 			   ARRAY_SIZE(slimbus_rx_mixer_controls)),
@@ -833,6 +840,8 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 
 static const struct snd_soc_dapm_route intercon[] = {
 	Q6ROUTING_RX_DAPM_ROUTE("HDMI Mixer", "HDMI_RX"),
+	Q6ROUTING_RX_DAPM_ROUTE("DISPLAY_PORT_RX Audio Mixer",
+				"DISPLAY_PORT_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_0_RX Audio Mixer", "SLIMBUS_0_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_1_RX Audio Mixer", "SLIMBUS_1_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_2_RX Audio Mixer", "SLIMBUS_2_RX"),
-- 
2.19.0.rc2
