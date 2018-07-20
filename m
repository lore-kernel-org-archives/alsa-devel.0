From: Marcel Ziswiler <marcel@ziswiler.com>
Subject: [PATCH] ASoC: sgtl5000: fix spelling in devicetree binding document
Date: Fri, 20 Jul 2018 09:53:02 +0200
Message-ID: <20180720075302.21079-1-marcel@ziswiler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: alsa-devel@alsa-project.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes a spelling mistake.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 Documentation/devicetree/bindings/sound/sgtl5000.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 0f214457476f..9c58f724396a 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -17,7 +17,7 @@ Optional properties:
 
 - VDDD-supply : the regulator provider of VDDD
 
-- micbias-resistor-k-ohms : the bias resistor to be used in kOmhs
+- micbias-resistor-k-ohms : the bias resistor to be used in kOhms
 	The resistor can take values of 2k, 4k or 8k.
 	If set to 0 it will be off.
 	If this node is not mentioned or if the value is unknown, then
-- 
2.14.4
