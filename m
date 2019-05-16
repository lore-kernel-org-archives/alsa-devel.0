From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH RESEND V3] ASoC: cs42xx8: add reset-gpio in binding document
Date: Thu, 16 May 2019 11:24:12 +0000
Message-ID: <c2118efa4ee6c915473060405805e6c6c6db681f.1558005661.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <B540429D4C6352488F3D67CDEADD7BBC@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Add reset-gpio property, which is an optional option

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in RESEND v3
- send updated binding document only

Changes in v3
- update binding document.

Changes in v2
- use devm_gpiod_get_optional instead of of_get_named_gpio

 Documentation/devicetree/bindings/sound/cs42xx8.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42xx8.txt b/Document=
ation/devicetree/bindings/sound/cs42xx8.txt
index 8619a156d038..ab8f54095269 100644
--- a/Documentation/devicetree/bindings/sound/cs42xx8.txt
+++ b/Documentation/devicetree/bindings/sound/cs42xx8.txt
@@ -14,6 +14,11 @@ Required properties:
   - VA-supply, VD-supply, VLS-supply, VLC-supply: power supplies for the d=
evice,
     as covered in Documentation/devicetree/bindings/regulator/regulator.tx=
t
=20
+Optional properties:
+
+  - reset-gpio : a GPIO spec to define which pin is connected to the chip'=
s
+    !RESET pin
+
 Example:
=20
 cs42888: codec@48 {
@@ -25,4 +30,5 @@ cs42888: codec@48 {
 	VD-supply =3D <&reg_audio>;
 	VLS-supply =3D <&reg_audio>;
 	VLC-supply =3D <&reg_audio>;
+	reset-gpio =3D <&pca9557_b 1 1>;
 };
--=20
2.21.0
