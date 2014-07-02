From: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH] ASoC: rsnd: fixup index of SSI mod when SRC is used
Date: Wed,  2 Jul 2014 13:18:51 +0200
Message-ID: <1404299931-21384-1-git-send-email-j@bitron.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
List-Id: alsa-devel@alsa-project.org

The default index 1 was used as the loop was terminated before the
following code could be reached:

	if (mod[i] =3D=3D this)
		index =3D i;

Signed-off-by: J=C3=BCrg Billeter <j@bitron.ch>
---
 sound/soc/sh/rcar/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 4e86265..d737fea 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -295,9 +295,11 @@ static void rsnd_dma_of_name(struct rsnd_dma *dma,
 	mod[0] =3D NULL; /* for "mem" */
 	index =3D 1;
 	for (i =3D 1; i < MOD_MAX; i++) {
-		if (!src) {
-			mod[i] =3D ssi;
+		if (!ssi) {
 			break;
+		} else if (!src) {
+			mod[i] =3D ssi;
+			ssi =3D NULL;
 		} else if (!dvc) {
 			mod[i] =3D src;
 			src =3D NULL;
--=20
2.0.1
