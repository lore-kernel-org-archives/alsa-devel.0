From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 2/4] ASoC: qdsp6: qdafe: add support for display_port_rx
Date: Fri, 14 Dec 2018 17:59:27 +0530
Message-ID: <1544790569-10608-3-git-send-email-rohitkr@codeaurora.org>
References: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org, asishb@codeaurora.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support for Display_Port_Rx
port in AFE.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 829b5e987..e0945f7a 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -71,6 +71,7 @@
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
+#define AFE_PORT_ID_HDMI_OVER_DP_RX	0x6020
 
 #define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
 /* Clock set API version */
@@ -704,6 +705,8 @@ struct afe_port_map {
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
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
