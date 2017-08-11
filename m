From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 9/9] arm64: dts: msm8996: db820c: Add sound card support
Date: Fri, 11 Aug 2017 15:29:52 +0200
Message-ID: <20170811132952.32572-10-srinivas.kandagatla@linaro.org>
References: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811132952.32572-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, lkasam@qti.qualcomm.com, sboyd@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds hdmi sound card support to db820c via qdsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 37 +++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 67 ++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index b9852ba..0157630 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -18,6 +18,8 @@
 #include "apq8096-db820c-pmic-pins.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/qcom,afe.h>
+#include <dt-bindings/sound/qcom,asm.h>
 
 / {
 	aliases {
@@ -207,6 +209,41 @@
 		};
 	};
 
+	adsp-pil {
+		smd-edge {
+			apr {
+				snd {
+					compatible	= "qcom,apq8096-sndcard";
+					qcom,model = "DB820c";
+
+					cpu@1 {
+						is-fe;
+						link-name = "MultiMedia1 PCM";
+						cpu {
+							sound-dai = <&pcm  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+						};
+						platform {
+							sound-dai = <&pcm  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+						};
+					};
+
+					qdsp@1 {
+						link-name = "HDMI";
+						cpu {
+							sound-dai = <&hdmi_dai>;
+						};
+						platform {
+							sound-dai = <&routing>;
+						};
+						codec {
+							sound-dai = <&hdmi>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	rpm-glink {
 		rpm_requests {
 			pm8994-regulators {
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 9e3e3f5..163c251 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -14,6 +14,8 @@
 #include <dt-bindings/clock/qcom,gcc-msm8996.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/sound/qcom,afe.h>
+#include <dt-bindings/sound/qcom,asm.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8996";
@@ -1157,6 +1159,33 @@
 			status = "okay";
 		};
 
+	        lpass_q6_smmu: arm,smmu-lpass_q6@1600000 {
+			compatible = "qcom,msm8996-smmu-v2";
+	                reg = <0x1600000 0x20000>;
+	                #iommu-cells = <1>;
+                        power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
+
+			#global-interrupts = <1>;
+		        interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
+				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
+			clock-names = "iface", "bus";
+                        status = "okay";
+		};
+
 		mdss: mdss@900000 {
 			compatible = "qcom,mdss";
 
@@ -1240,6 +1269,7 @@
 
 				phys = <&hdmi_phy>;
 				phy-names = "hdmi_phy";
+				#sound-dai-cells = <0>;
 
 				ports {
 					#address-cells = <1>;
@@ -1303,6 +1333,43 @@
 			qcom,ipc = <&apcs 16 8>;
 			qcom,smd-edge = <1>;
 			qcom,remote-pid = <2>;
+
+			apr {
+				compatible = "qcom,apr-msm8996";
+				qcom,smd-channels = "apr_audio_svc";
+
+				pcm: pcm0 {
+					compatible = "qcom,q6pcm-v2";
+					iommus = <&lpass_q6_smmu 1>;
+					#sound-dai-cells = <1>;
+				};
+
+			        routing:routing {
+					compatible = "qcom,q6pcm-routing-v2";
+					#sound-dai-cells = <0>;
+				};
+
+				hdmi_dai: dai_hdmi {
+					compatible = "qcom,q6hdmi-v2";
+					qcom,afe-port = <&afe AFE_PORT_HDMI_RX>;
+					#sound-dai-cells = <0>;
+				};
+
+				snd {
+				};
+
+				adm {
+					compatible = "qcom,q6adm-v2";
+				};
+
+				asm {
+					compatible = "qcom,q6asm-v2";
+				};
+
+				afe: afe {
+					compatible = "qcom,q6afe-v2";
+				};
+			};
 		};
 	};
 
-- 
2.9.3
