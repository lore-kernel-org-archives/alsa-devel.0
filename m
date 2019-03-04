From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH RESEND v5 0/3] Add NXP AUDMIX device and machine drivers
Date: Mon, 4 Mar 2019 10:36:23 +0000
Message-ID: <1551695748-21541-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patchset adds NXP Audio Mixer (AUDMIX) device and machine
drivers and related DT bindings documentation.

Changes since V4:
1. Removed "model" attribute from device driver DT bindings documentation
   as suggested by Nicolin.

Changes since V3:
1. Removed machine driver DT bindings documentation.
2. Trigger machine driver probe from device driver as suggested by Nicolin.

Changes since V2:
1. Moved "dais" node from machine driver DTS node to device driver DTS node
  as suggested by Rob.

Changes since V1:
1. Original patch split into distinct patches for the device driver and
  DT binding documentation.
2. Replaced AMIX with AUDMIX in both code and file names as it looks more
  RM-compliant.
3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
4. Added machine driver and related DT binding documentation.

Viorel Suman (3):
  ASoC: fsl: Add Audio Mixer CPU DAI driver
  ASoC: add fsl_audmix DT binding documentation
  ASoC: fsl: Add Audio Mixer machine driver

 .../devicetree/bindings/sound/fsl,audmix.txt       |  50 ++
 sound/soc/fsl/Kconfig                              |  16 +
 sound/soc/fsl/Makefile                             |   5 +
 sound/soc/fsl/fsl_audmix.c                         | 578 +++++++++++++++++=
++++
 sound/soc/fsl/fsl_audmix.h                         | 102 ++++
 sound/soc/fsl/imx-audmix.c                         | 327 ++++++++++++
 6 files changed, 1078 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
 create mode 100644 sound/soc/fsl/fsl_audmix.c
 create mode 100644 sound/soc/fsl/fsl_audmix.h
 create mode 100644 sound/soc/fsl/imx-audmix.c

--=20
2.7.4
