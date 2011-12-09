From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 2/5] ASoC: mxs: add .owner to struct snd_soc_card
Date: Fri,  9 Dec 2011 14:38:09 +0100
Message-ID: <555be1750dd09586d5eede6457f72310890274b0.1323436034.git.LW@KARO-electronics.de>
References: <cover.1323436034.git.LW@KARO-electronics.de>
 <992d017bd0214a67a836f2d0279b4edb6913da28.1323436034.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <992d017bd0214a67a836f2d0279b4edb6913da28.1323436034.git.LW@KARO-electronics.de>
In-Reply-To: <cover.1323436034.git.LW@KARO-electronics.de>
References: <cover.1323436034.git.LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

This will prevent the module from being removed from underneath its
users

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 sound/soc/mxs/mxs-sgtl5000.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.=
c
index 7fbeaec..db5c184 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -105,6 +105,7 @@ static struct snd_soc_dai_link mxs_sgtl5000_dai[] =3D=
 {
=20
 static struct snd_soc_card mxs_sgtl5000 =3D {
 	.name		=3D "mxs_sgtl5000",
+	.owner		=3D THIS_MODULE,
 	.dai_link	=3D mxs_sgtl5000_dai,
 	.num_links	=3D ARRAY_SIZE(mxs_sgtl5000_dai),
 };
--=20
1.5.6.5
