From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH v2 3/5] ASoC: adau17x1: Add adau17x1 bindings document
Date: Tue, 16 Feb 2016 13:56:43 +0100
Message-ID: <1455627405-18155-4-git-send-email-andire@axis.com>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455627405-18155-1-git-send-email-andire@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andreas Irest=C3=A5l <andire@axis.com>
---
 .../devicetree/bindings/sound/adi,adau17x1.txt     | 24 ++++++++++++++=
++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau17x=
1.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt b=
/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
new file mode 100644
index 0000000..8dbce0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
@@ -0,0 +1,24 @@
+Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781
+
+Required properties:
+
+ - compatible:		Should contain one of the following:
+			"adi,adau1361"
+			"adi,adau1461"
+			"adi,adau1761"
+			"adi,adau1961"
+			"adi,adau1381"
+			"adi,adau1781"
+
+ - reg:			The i2c address. Value depends on the state of ADDR0
+			and ADDR1, as wired in hardware.
+
+Examples:
+#include <dt-bindings/sound/adau17x1.h>
+
+	i2c_bus {
+		adau1361@38 {
+			compatible =3D "adi,adau1761";
+			reg =3D <0x38>;
+		};
+	};
--=20
2.1.4
