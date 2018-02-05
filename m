From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 2/2] ASoC: ak5558: Add bindings for AK5558
	ADC
Date: Mon, 5 Feb 2018 19:01:55 +0200
Message-ID: <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0049.outbound.protection.outlook.com [104.47.40.49])
 by alsa0.perex.cz (Postfix) with ESMTP id BA9AE26742B
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 18:33:45 +0100 (CET)
In-Reply-To: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, wakasugi.jb@om.asahi-kasei.co.jp, fabio.estevam@nxp.com, andy.shevchenko@gmail.com, linux-imx@nxp.com, cosmin.samoila@nxp.com, daniel.baluta@nxp.com, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org

Document the bindings for AK5558 ADC.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak5558.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
new file mode 100644
index 0000000..7d67ca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak5558.txt
@@ -0,0 +1,22 @@
+AK5558 8 channel differential 32-bit delta-sigma ADC
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak5558"
+- reg : The I2C address of the device.
+
+Optional properties:
+
+- reset-gpios: A GPIO specifier for the power down & reset pin.
+
+Example:
+
+&i2c {
+	ak5558: adc@10 {
+		compatible = "asahi-kasei,ak5558";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	};
+};
-- 
2.7.4
