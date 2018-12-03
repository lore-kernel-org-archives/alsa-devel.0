From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ASoC: dt-bindings: use a generic node name for rt5631
Date: Mon,  3 Dec 2018 12:47:28 +0100
Message-ID: <20181203114728.636936-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: alsa-devel@alsa-project.org

The example should follow the practice or using a generic node name
instead of the precise programming model, as recommended by the DTSpec.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/sound/rt5631.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5631.txt b/Documen=
tation/devicetree/bindings/sound/rt5631.txt
index 92b986ca337b..56bc85232c49 100644
--- a/Documentation/devicetree/bindings/sound/rt5631.txt
+++ b/Documentation/devicetree/bindings/sound/rt5631.txt
@@ -35,14 +35,14 @@ Pins on the device (for linking into audio routes):
=20
 Example:
=20
-alc5631: alc5631@1a {
+alc5631: audio-codec@1a {
 	compatible =3D "realtek,alc5631";
 	reg =3D <0x1a>;
 };
=20
 or
=20
-rt5631: rt5631@1a {
+rt5631: audio-codec@1a {
 	compatible =3D "realtek,rt5631";
 	reg =3D <0x1a>;
 };
--=20
2.19.1
