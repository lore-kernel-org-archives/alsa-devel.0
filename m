From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] ASoC: add mt6351 codec driver
Date: Thu, 19 Apr 2018 15:41:39 +0100
Message-ID: <20180419144139.GG27188@sirena.org.uk>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-2-kaichieh.chuang@mediatek.com>
 <20180418164040.GG10061@sirena.org.uk>
 <1524103097.3290.14.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5838039384056307137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 07F05267235
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 16:41:46 +0200 (CEST)
In-Reply-To: <1524103097.3290.14.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============5838039384056307137==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 19, 2018 at 09:58:17AM +0800, KaiChieh Chuang wrote:
> On Wed, 2018-04-18 at 17:40 +0100, Mark Brown wrote:

> > > +	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > +	if (IS_ERR(priv->regmap))
> > > +		return PTR_ERR(priv->regmap);

> > This should be the default behaviour so I'm guessing you don't need the
> > callback?

> the regmap is obtain from parent dev, i assume i can use
> snd_soc_component_init_regmap() as alternative for
> get_regmap().callback?

Yes, though you shouldn't even need to do that - the core should just
try using the parent regmap if none is provided.

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYqqIACgkQJNaLcl1U
h9COWwf/X3Glme1dInVh20LNwCsONUv8nFqls3g06hu3FIyuR5SX9/XOq3a5HoZa
w5LkRmve66WIQPWV3u8lZu7SnquzzJvXHSaxfw6BV5LTJ54obq9Xf7Haig0c+6cq
//b7olDohoDnHHw0lI1W/jRiE73JOxMaXOOyMsYqFwM3CByy/y8zpHTQ6qXlVjJk
K46VL8uP6zw3EH3EJyRE0lVS4mL05jVl8vUnu6T9r4oUtxJfMIznozZRFz6EDp4c
c5llouu1mTYu/1IQprqTXVAE9YzjLKR8jjcrInAGbA5j3N/1lQf24JtIjqf5a/Ce
mZW/3jRNf7TawAtjSmHW71L//pbT/A==
=VgQz
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--

--===============5838039384056307137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5838039384056307137==--
