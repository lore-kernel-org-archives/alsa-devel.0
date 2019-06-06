From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: sun4i-i2s: Change SR and WSS
 computation
Date: Thu, 6 Jun 2019 13:06:47 +0200
Message-ID: <20190606110647.iojplb27mdo276xk@flea>
References: <20190605100801.2488-1-maxime.ripard@bootlin.com>
 <3BD9CEE4EBD5E74B98FE2D277EB60E0B38FF8117@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1645152245780739438=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3BD9CEE4EBD5E74B98FE2D277EB60E0B38FF8117@IRSMSX104.ger.corp.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rojewski, Cezary" <cezary.rojewski@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1645152245780739438==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o7dxdhneu2w5lbt5"
Content-Disposition: inline


--o7dxdhneu2w5lbt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jun 05, 2019 at 04:36:28PM +0000, Rojewski, Cezary wrote:
> >+static s8 sun4i_i2s_get_sr(const struct sun4i_i2s *i2s, int width)
> >+{
> >+	if (width < 16 || width > 24)
> >+		return -EINVAL;
> >+
> >+	if (width % 4)
> >+		return -EINVAL;
> >+
> >+	return (width - 16) / 4;
> >+}
> >+
> >+static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
> >+{
> >+	if (width < 16 || width > 32)
> >+		return -EINVAL;
> >+
> >+	if (width % 4)
> >+		return -EINVAL;
> >+
> >+	return (width - 16) / 4;
> >+}
> >+
> >+static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
> >+{
> >+	if (width % 4)
> >+		return -EINVAL;
> >+
>
> In the two above you start with boundary check before mod yet in
> this one the order is reversed.  Keeping the same order should prove
> more cohesive.

Indeed, I'll fix this.

>
> >+	if (width < 8 || width > 32)
> >+		return -EINVAL;
> >+
> >+	return (width - 8) / 4 + 1;
> >+}
> >+
>
> Other, probably less welcome suggestion is introduction of unified
> function which ones listed here would simply invoke. All of these
> "computations" differ in fact only in: min and max boundary. The +1
> for _sr_wss is negligible, you can append it on return.

It's not just about the min and max boundaries. It's also the offset
at which to start with (16 vs 8), and the offset to apply to the
result (0 vs 1).

That's 4 parameters out of 5 that are different. For something that
trivial, I don't think it's worth it to put it in common.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o7dxdhneu2w5lbt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPjzxwAKCRDj7w1vZxhR
xU5ZAQDqFqCGgErcrAi4FdZbvdZZ+e5HA8TXh3Adj2HYz68TGAEAnsOVcPT4sWAS
/Bvn0cG01lOSXngr19W99FolGay/Lgk=
=cTma
-----END PGP SIGNATURE-----

--o7dxdhneu2w5lbt5--


--===============1645152245780739438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1645152245780739438==--
