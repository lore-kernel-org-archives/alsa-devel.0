From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v2 1/2] ASoC: kirkwood: clk: probe defer when clock not yet
 ready
Date: Sat, 21 Sep 2013 12:00:06 +0200
Message-ID: <20130921120006.47b00fe7@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

At probe time, a clock device may not be ready when some other device
wants to use it.=20

This patch lets the functions clk_get/devm_clk_get return a probe defer
when the clock is defined in the DT but not yet available.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
 drivers/clk/clk.c    | 2 +-
 drivers/clk/clkdev.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a004769..582abc8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2181,7 +2181,7 @@ EXPORT_SYMBOL_GPL(of_clk_del_provider);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
 	struct of_clk_provider *provider;
-	struct clk *clk =3D ERR_PTR(-ENOENT);
+	struct clk *clk =3D ERR_PTR(-EPROBE_DEFER);
=20
 	/* Check if we have such a provider in our array */
 	mutex_lock(&of_clk_lock);
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..f8b28d9 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -157,8 +157,13 @@ struct clk *clk_get(struct device *dev, const char=
 *con_id)
=20
 	if (dev) {
 		clk =3D of_clk_get_by_name(dev->of_node, con_id);
-		if (!IS_ERR(clk) && __clk_get(clk))
-			return clk;
+		if (!IS_ERR(clk)) {
+			if (__clk_get(clk))
+				return clk;
+		} else {
+			if (PTR_ERR(clk) =3D=3D -EPROBE_DEFER)
+				return clk;
+		}
 	}
=20
 	return clk_get_sys(dev_id, con_id);


--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
