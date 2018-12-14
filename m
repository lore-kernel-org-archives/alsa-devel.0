From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding" to the asoc tree
Date: Fri, 14 Dec 2018 12:49:22 +0000 (GMT)
Message-ID: <20181214124922.9B3BE11258A2@debutante.sirena.org.uk>
References: <1544790569-10608-2-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544790569-10608-2-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>, plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.combroonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.comsrinivas.kandagatla@linaro.org, asishb@codeaurora.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding

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

>From 76119509d23cdd9fbc71585042b27b6511b44b4d Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 17:59:26 +0530
Subject: [PATCH] ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding

This patch adds bindings required for DISPLAY_PORT_RX
port on AFE.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/dt-bindings/sound/qcom,q6afe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index e2d3892240b8..1df06f8ad5c3 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -106,6 +106,7 @@
 #define QUINARY_TDM_TX_6	101
 #define QUINARY_TDM_RX_7	102
 #define QUINARY_TDM_TX_7	103
+#define DISPLAY_PORT_RX		104
 
 #endif /* __DT_BINDINGS_Q6_AFE_H__ */
 
-- 
2.19.0.rc2
