From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 1/4] ASoC: qdsp6: dt-bindings: Add q6afe
	display_port dt binding
Date: Fri, 14 Dec 2018 17:59:26 +0530
Message-ID: <1544790569-10608-2-git-send-email-rohitkr@codeaurora.org>
References: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E82026798A
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:30:01 +0100 (CET)
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

This patch adds bindings required for DISPLAY_PORT_RX
port on AFE.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 include/dt-bindings/sound/qcom,q6afe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index e2d3892..1df06f8 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -106,6 +106,7 @@
 #define QUINARY_TDM_TX_6	101
 #define QUINARY_TDM_RX_7	102
 #define QUINARY_TDM_TX_7	103
+#define DISPLAY_PORT_RX		104
 
 #endif /* __DT_BINDINGS_Q6_AFE_H__ */
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
