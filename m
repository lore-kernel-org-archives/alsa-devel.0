From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] ASoC: qdsp6: q6routing: add slim rx
	routings
Date: Wed,  4 Jul 2018 10:49:41 +0100
Message-ID: <20180704094944.16440-4-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id CB5DB2676FB
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 11:51:56 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id w16-v6so5118615wmc.2
 for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2018 02:51:56 -0700 (PDT)
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

This patch add routings mixer controls for slim rx ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index c80fdbc2442e..35269b492761 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -68,6 +68,13 @@
 	{ mix_name, "SEC_MI2S_TX", "SEC_MI2S_TX" },	\
 	{ mix_name, "QUAT_MI2S_TX", "QUAT_MI2S_TX" },	\
 	{ mix_name, "TERT_MI2S_TX", "TERT_MI2S_TX" },		\
+	{ mix_name, "SLIMBUS_0_TX", "SLIMBUS_0_TX" },		\
+	{ mix_name, "SLIMBUS_1_TX", "SLIMBUS_1_TX" },		\
+	{ mix_name, "SLIMBUS_2_TX", "SLIMBUS_2_TX" },		\
+	{ mix_name, "SLIMBUS_3_TX", "SLIMBUS_3_TX" },		\
+	{ mix_name, "SLIMBUS_4_TX", "SLIMBUS_4_TX" },		\
+	{ mix_name, "SLIMBUS_5_TX", "SLIMBUS_5_TX" },		\
+	{ mix_name, "SLIMBUS_6_TX", "SLIMBUS_6_TX" },		\
 	{ mix_name, "PRIMARY_TDM_TX_0", "PRIMARY_TDM_TX_0"},	\
 	{ mix_name, "PRIMARY_TDM_TX_1", "PRIMARY_TDM_TX_1"},	\
 	{ mix_name, "PRIMARY_TDM_TX_2", "PRIMARY_TDM_TX_2"},	\
@@ -122,6 +129,27 @@
 	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,		\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_0_TX", SLIMBUS_0_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_1_TX", SLIMBUS_1_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_2_TX", SLIMBUS_2_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_3_TX", SLIMBUS_3_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_4_TX", SLIMBUS_4_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_5_TX", SLIMBUS_5_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_6_TX", SLIMBUS_6_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
 	SOC_SINGLE_EXT("PRIMARY_TDM_TX_0", PRIMARY_TDM_TX_0,		\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
-- 
2.16.2
