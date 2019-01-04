From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/2]  Add support for AK4497 codec
Date: Fri, 4 Jan 2019 16:27:03 +0000
Message-ID: <20190104162649.13103-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Cosmin Samoila <cosmin.samoila@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
List-Id: alsa-devel@alsa-project.org

AK4497 is almost register compatible with AK4458. Almost means that
AK4497 has an extra "debug" register that we currently do not use.

Daniel Baluta (2):
  ASoC: ak4458: Add support for AK4497
  ASoC: dt-bindings: Document support for ak4497

 .../devicetree/bindings/sound/ak4458.txt      |  2 +-
 sound/soc/codecs/ak4458.c                     | 79 ++++++++++++++++++-
 2 files changed, 77 insertions(+), 4 deletions(-)

--=20
2.17.1
