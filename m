From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v3 4/4] ASoC: add imx-audmix DT binding documentation
Date: Thu, 17 Jan 2019 12:46:32 +0000
Message-ID: <1547729177-14317-5-git-send-email-viorel.suman@nxp.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add the DT binding documentation for Audio Mixer
machine driver.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 Documentation/devicetree/bindings/sound/imx-audmix.txt | 18 ++++++++++++++=
++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt

diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Docum=
entation/devicetree/bindings/sound/imx-audmix.txt
new file mode 100644
index 0000000..c840ed5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
@@ -0,0 +1,18 @@
+NXP Audio Mixer (AUDMIX) machine driver.
+
+Required properties:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  - compatible		: Compatible list, contains "fsl,imx-audmix"
+
+  - model		: Short audio card description.
+
+  - audmix-controller	: Must contain the phandle to the AUDMIX device node=
.
+
+Machine driver configuration example:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  sound-audmix-sai {
+    compatible =3D "fsl,imx-audmix";
+    model =3D "audmix-sai";
+    audmix-controller =3D <&audmix>;
+  };
+
--=20
2.7.4
