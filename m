From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v2 2/2] ASoC: kirkwood: fix loss of external clock at probe
 time
Date: Sat, 21 Sep 2013 12:00:36 +0200
Message-ID: <20130921120036.5730dbfd@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

At probe time, when the clock driver is not yet initialized, the
external clock of the kirkwood sound device will not be usable.

This patch fixes this problem defering the device probe.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kir=
kwood-i2s.c
index 0f3d73d..14f32d9 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -496,7 +496,10 @@ static int kirkwood_i2s_dev_probe(struct platform_=
device *pdev)
 		return err;
=20
 	priv->extclk =3D devm_clk_get(&pdev->dev, "extclk");
-	if (!IS_ERR(priv->extclk)) {
+	if (IS_ERR(priv->extclk)) {
+		if (PTR_ERR(priv->extclk) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	} else {
 		if (priv->extclk =3D=3D priv->clk) {
 			devm_clk_put(&pdev->dev, priv->extclk);
 			priv->extclk =3D ERR_PTR(-EINVAL);


--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
