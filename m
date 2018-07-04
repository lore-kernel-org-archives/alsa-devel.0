From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] ASoC: qdsp6: q6afe: Add missing slimbus
	capture ports
Date: Wed,  4 Jul 2018 10:49:39 +0100
Message-ID: <20180704094944.16440-2-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C792226772D
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 11:51:54 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id w16-v6so5118504wmc.2
 for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2018 02:51:54 -0700 (PDT)
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Existing code already has support for SLIMbus TX and RX, only thing
that was missing from TX side was mapping between virtual to actual
DSP port ids.

This patch adds those mappings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 621b67b34db9..90e2d8e658bf 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -514,6 +514,20 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				SLIMBUS_5_RX, 1, 1},
 	[SLIMBUS_6_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX,
 				SLIMBUS_6_RX, 1, 1},
+	[SLIMBUS_0_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX,
+				SLIMBUS_0_TX, 0, 1},
+	[SLIMBUS_1_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX,
+				SLIMBUS_1_TX, 0, 1},
+	[SLIMBUS_2_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX,
+				SLIMBUS_2_TX, 0, 1},
+	[SLIMBUS_3_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX,
+				SLIMBUS_3_TX, 0, 1},
+	[SLIMBUS_4_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX,
+				SLIMBUS_4_TX, 0, 1},
+	[SLIMBUS_5_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX,
+				SLIMBUS_5_TX, 0, 1},
+	[SLIMBUS_6_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX,
+				SLIMBUS_6_TX, 0, 1},
 	[PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
 				PRIMARY_MI2S_RX, 1, 1},
 	[PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
@@ -1372,6 +1386,13 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX:
-- 
2.16.2
