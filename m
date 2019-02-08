From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: sound: msm8916-wcd-analog: fix
	example regulator names" to the asoc tree
Date: Fri,  8 Feb 2019 13:11:05 +0000 (GMT)
Message-ID: <20190208131105.5FAE01127F30@debutante.sirena.org.uk>
References: <20190207165755.1548-4-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DA002674C9
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 14:11:07 +0100 (CET)
In-Reply-To: <20190207165755.1548-4-johan@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: sound: msm8916-wcd-analog: fix example regulator names

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

>From 510135535382db7f5ee8727818172e42c9c9cbd5 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 7 Feb 2019 17:57:55 +0100
Subject: [PATCH] dt-bindings: sound: msm8916-wcd-analog: fix example regulator
 names

Fix upper-case regulator names in the binding example which do not match
the corresponding required properties.

While at it, add a blank line after the required-properties section to
improve readability.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
