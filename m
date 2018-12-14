From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 4/4] ASoC: qdsp6: q6routing: add
	display_port_rx port routing
Date: Fri, 14 Dec 2018 17:59:29 +0530
Message-ID: <1544790569-10608-5-git-send-email-rohitkr@codeaurora.org>
References: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FEA4267A8E
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:30:30 +0100 (CET)
In-Reply-To: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org, asishb@codeaurora.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

This patch add support to Display_port_rx mixers required to
select path between ASM stream and AFE ports.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index d61b840..ddcd997 100644
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
 
@@ -655,6 +658,10 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 			   hdmi_mixer_controls,
 			   ARRAY_SIZE(hdmi_mixer_controls)),
 
+	SND_SOC_DAPM_MIXER("DISPLAY_PORT_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   display_port_mixer_controls,
+			   ARRAY_SIZE(display_port_mixer_controls)),
+
 	SND_SOC_DAPM_MIXER("SLIMBUS_0_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
 			   slimbus_rx_mixer_controls,
 			   ARRAY_SIZE(slimbus_rx_mixer_controls)),
@@ -833,6 +840,8 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 
 static const struct snd_soc_dapm_route intercon[] = {
 	Q6ROUTING_RX_DAPM_ROUTE("HDMI Mixer", "HDMI_RX"),
+	Q6ROUTING_RX_DAPM_ROUTE("DISPLAY_PORT_RX Audio Mixer",
+				"DISPLAY_PORT_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_0_RX Audio Mixer", "SLIMBUS_0_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_1_RX Audio Mixer", "SLIMBUS_1_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_2_RX Audio Mixer", "SLIMBUS_2_RX"),
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
