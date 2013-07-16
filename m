From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2] ASoC: kirkwood-i2s: fix a compilation warning
Date: Tue, 16 Jul 2013 08:47:47 +0200
Message-ID: <20130716084747.04625f29@armhf>
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

The ALSA subsystem should never gives such a rate because:
- the rates with the internal clock are limited to 44.1, 48 and 96 kHz
  as specified by the kirkwood_i2s_dai structure,
- the other rates are proposed in the structure kirkwood_i2s_dai_extclk
  only when the external clock is present.

In case of programming error (bad rate for internal clock and no
external clock), the function will simply cause a backtrace.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v2
	- add more explanations
---
 sound/soc/kirkwood/kirkwood-i2s.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kir=
kwood-i2s.c
index 4c9dad3..c9daf3b 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -105,14 +105,16 @@ static void kirkwood_set_rate(struct snd_soc_dai =
*dai,
 	uint32_t clks_ctrl;
=20
 	if (rate =3D=3D 44100 || rate =3D=3D 48000 || rate =3D=3D 96000) {
-		/* use internal dco for supported rates */
+		/* use internal dco for the supported rates
+		 * defined in kirkwood_i2s_dai */
 		dev_dbg(dai->dev, "%s: dco set rate =3D %lu\n",
 			__func__, rate);
 		kirkwood_set_dco(priv->io, rate);
=20
 		clks_ctrl =3D KIRKWOOD_MCLK_SOURCE_DCO;
-	} else if (!IS_ERR(priv->extclk)) {
-		/* use optional external clk for other rates */
+	} else {
+		/* use the external clock for the other rates
+		 * defined in kirkwood_i2s_dai_extclk */
 		dev_dbg(dai->dev, "%s: extclk set rate =3D %lu -> %lu\n",
 			__func__, rate, 256 * rate);
 		clk_set_rate(priv->extclk, 256 * rate);
