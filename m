From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC: kirkwood-i2s: fix a compilation warning
Date: Mon, 15 Jul 2013 10:36:44 +0200
Message-ID: <20130715103644.04e57749@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

In the function kirkwood_set_rate, when the rate cannot be satisfied
by the internal nor by an external clock, the clock source in undefined=
:

 warning: =E2=80=98clks_ctrl=E2=80=99 may be used uninitialized in this=
 function

As the ALSA subsystem should never gives such a rate, this patch remove=
s
the check of the external clock pointer.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kir=
kwood-i2s.c
index 4c9dad3..8da5cdb 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -111,7 +111,7 @@ static void kirkwood_set_rate(struct snd_soc_dai *d=
ai,
 		kirkwood_set_dco(priv->io, rate);
=20
 		clks_ctrl =3D KIRKWOOD_MCLK_SOURCE_DCO;
-	} else if (!IS_ERR(priv->extclk)) {
+	} else {
 		/* use optional external clk for other rates */
 		dev_dbg(dai->dev, "%s: extclk set rate =3D %lu -> %lu\n",
 			__func__, rate, 256 * rate);
