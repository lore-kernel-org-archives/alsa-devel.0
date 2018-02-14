From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v3 2/2] ASoC: ak4458: Add bindings for AK4458
	DAC
Date: Wed, 14 Feb 2018 15:21:07 +0200
Message-ID: <1518614467-20613-3-git-send-email-cosmin.samoila@nxp.com>
References: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0071.outbound.protection.outlook.com [104.47.38.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E65266EB0
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 14:56:00 +0100 (CET)
In-Reply-To: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, robh@kernel.org
Cc: shegjiu.wang@nxp.com, linux-kernel@vger.kernel.org, linux-imx@nxp.com, Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>, daniel.baluta@nxp.com, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org

Document the bindings for AK4458 DAC

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
new file mode 100644
index 0000000..7839be7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -0,0 +1,23 @@
+AK4458 audio DAC
+
+This device supports I2C mode.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak4458"
+- reg : The I2C address of the device for I2C
+
+Optional properties:
+- reset-gpios: A GPIO specifier for the power down & reset pin
+- mute-gpios: A GPIO specifier for the soft mute pin
+
+Example:
+
+&i2c {
+	ak4458: dac@10 {
+		compatible = "asahi-kasei,ak4458";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>
+		mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>
+	};
+};
-- 
2.7.4
