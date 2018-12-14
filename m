From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: qdafe: add support for display_port_rx" to the asoc tree
Date: Fri, 14 Dec 2018 12:49:20 +0000 (GMT)
Message-ID: <20181214124920.BE0F911258A2@debutante.sirena.org.uk>
References: <1544790569-10608-3-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544790569-10608-3-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>, plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.combroonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.comsrinivas.kandagatla@linaro.org, asishb@codeaurora.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: qdafe: add support for display_port_rx

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

>From 3f6856a28f5eeb4fcaeb3ae25118171747354e51 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 17:59:27 +0530
Subject: [PATCH] ASoC: qdsp6: qdafe: add support for display_port_rx

This patch adds support for Display_Port_Rx
port in AFE.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 829b5e987b2a..e0945f7a58c8 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -71,6 +71,7 @@
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
+#define AFE_PORT_ID_HDMI_OVER_DP_RX	0x6020
 
 #define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
 /* Clock set API version */
@@ -704,6 +705,8 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				QUINARY_TDM_RX_7, 1, 1},
 	[QUINARY_TDM_TX_7] =  { AFE_PORT_ID_QUINARY_TDM_TX_7,
 				QUINARY_TDM_TX_7, 0, 1},
+	[DISPLAY_PORT_RX] = { AFE_PORT_ID_HDMI_OVER_DP_RX,
+				DISPLAY_PORT_RX, 1, 1},
 };
 
 static void q6afe_port_free(struct kref *ref)
@@ -1384,6 +1387,7 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 
 	switch (port_id) {
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
+	case AFE_PORT_ID_HDMI_OVER_DP_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX:
-- 
2.19.0.rc2
