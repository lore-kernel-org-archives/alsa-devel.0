From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [BUGFIX PATCH] ASoC: imx-sgtl5000: prevent module from being unloaded when in use
Date: Thu, 22 Nov 2012 13:31:08 +0100
Message-ID: <1353587470-11994-3-git-send-email-LW@KARO-electronics.de>
References: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

set the 'onwer' field of the registered snd_soc_card object to prevent
removal of the module when its resources are in use.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 sound/soc/fsl/imx-sgtl5000.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.=
c
index 199408e..3d9b1c4 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -162,6 +162,7 @@ static int __devinit imx_sgtl5000_probe(struct plat=
form_device *pdev)
 	if (ret)
 		goto clk_fail;
 	data->card.num_links =3D 1;
+	data->card.owner =3D THIS_MODULE;
 	data->card.dai_link =3D &data->dai;
 	data->card.dapm_widgets =3D imx_sgtl5000_dapm_widgets;
 	data->card.num_dapm_widgets =3D ARRAY_SIZE(imx_sgtl5000_dapm_widgets)=
;
--=20
1.7.2.5
