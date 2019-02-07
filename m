From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] dt-bindings: sound: msm8916-wcd-analog: fix example regulator names
Date: Thu,  7 Feb 2019 17:57:55 +0100
Message-ID: <20190207165755.1548-4-johan@kernel.org>
References: <20190207165755.1548-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207165755.1548-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

Fix upper-case regulator names in the binding example which do not match
the corresponding required properties.

While at it, add a blank line after the required-properties section to
improve readability.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
index fdcea3d12ee5..e7d17dda55db 100644
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
@@ -30,6 +30,7 @@ Required properties
  - vdd-cdc-io-supply: phandle to VDD_CDC_IO regulator DT node.
  - vdd-cdc-tx-rx-cx-supply: phandle to VDD_CDC_TX/RX/CX regulator DT node.
  - vdd-micbias-supply: phandle of VDD_MICBIAS supply's regulator DT node.
+
 Optional Properties:
  - qcom,mbhc-vthreshold-low: Array of 5 threshold voltages in mV for 5 buttons
 			     detection on headset when the mbhc is powered up
@@ -92,9 +93,9 @@ spmi_bus {
 				  "cdc_ear_cnp_int",
 				  "cdc_hphr_cnp_int",
 				  "cdc_hphl_cnp_int";
-	               VDD-CDC-IO-supply = <&pm8916_l5>;
-	               VDD-CDC-TX-RX-CX-supply = <&pm8916_l5>;
-	               VDD-MICBIAS-supply = <&pm8916_l13>;
+	               vdd-cdc-io-supply = <&pm8916_l5>;
+	               vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+	               vdd-micbias-supply = <&pm8916_l13>;
 	               #sound-dai-cells = <1>;
 	};
 };
-- 
2.20.1
