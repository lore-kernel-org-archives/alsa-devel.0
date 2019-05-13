From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH V2 0/2] ASoC: ak4458: fail on probe if codec is not present
Date: Mon, 13 May 2019 10:02:40 +0000
Message-ID: <1557741724-6859-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <79CDC12B48637547BD62FEE56C6A0ACA@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Viorel Suman <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

AK4458 is probed successfully even if AK4458 is not present - this
is caused by probe function returning no error on i2c access failure.
The patchset fixes this.

Changes since V1:
  Conditional statement rewritten as suggested by Mark.

Viorel Suman (2):
  ASoC: ak4458: rstn_control - return a non-zero on error only
  ASoC: ak4458: add return value for ak4458_probe

 sound/soc/codecs/ak4458.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--=20
2.7.4
