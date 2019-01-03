From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] bindings: sound: davinci-mcasp: Document GPIO support
Date: Thu, 3 Jan 2019 16:05:51 +0200
Message-ID: <20190103140552.29809-3-peter.ujfalusi@ti.com>
References: <20190103140552.29809-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103140552.29809-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

McASP pins can be used as GPIO, add optional section to enable GPIO support
for McASP.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index b279b6072bd5..a58f79f5345c 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -45,6 +45,23 @@ Optional properties:
 - fck_parent : Should contain a valid clock name which will be used as parent
 	       for the McASP fck
 
+Optional GPIO support:
+If any McASP pin need to be used as GPIO then the McASP node must have:
+...
+  gpio-controller
+  #gpio-cells = <2>;
+...
+
+When requesting a GPIO, the first parameter is the PIN index in McASP_P*
+registers.
+For example to request the AXR2 pin of mcasp8:
+function-gpios = <&mcasp8 2 0>;
+
+Or to request the ACLKR pin of mcasp8:
+function-gpios = <&mcasp8 29 0>;
+
+For generic gpio information, please refer to bindings/gpio/gpio.txt
+
 Example:
 
 mcasp0: mcasp0@1d00000 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
