From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 1/8] ASoC: davinci-mcasp: Add pinctrl
	support
Date: Mon, 9 Sep 2013 16:19:19 +0100
Message-ID: <20130909151919.GJ29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <6eaf283d62b023c3b7e2f26d937ca0ef602ef200.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6086114830603084826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E8A2A265125
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:19:22 +0200 (CEST)
In-Reply-To: <6eaf283d62b023c3b7e2f26d937ca0ef602ef200.1378738436.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: oku@iki.fi
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com, Joel A Fernandes <agnel.joel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6086114830603084826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OY4z34RctfP64Hws"
Content-Disposition: inline


--OY4z34RctfP64Hws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2013 at 06:12:12PM +0300, oku@iki.fi wrote:

> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev,
> +			 "pins are not configured from the driver\n");
> +

This should be being done by the driver core now - is that not working?

--OY4z34RctfP64Hws
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLeb0AAoJELSic+t+oim9D88P/RX1R00GoNS7FyPM82H0xXVD
Z1Y2Pbq1VDaSzx2lHt8r+nUSZvoM4Id0UpzO4o2AQVrcY1WGq6iFaui3O1mO67Uc
58x0dhDbdX7tznFnvCeZSpfpbThqh/jCkiP5xQG2BkBcG2Betc9R52dTWr/U1+cM
bB+F9wGF9WSkPIj5X/+vEtv7IduHas4G42zPpO3QhVa1dLtV9VVmseGNc4lh9Dmu
MvDUFkFrmigejeL2jrvzTH04z1ODfFEV2p9V2pQLS7SVY/kOIW67JHNTJL9aDbCV
nvJSCBEYJ9Hp+pG/DnMkvUhEchxvvevfXwNqjd8SS8eKs0Z3o2ooXzLxtzN7corJ
Kg6UdWzBgQzS8KjUlBZ0stLoCfiFP+XZXShkUwijpaMgh3pjz1itS3eDEEgKD3li
2Q4yswetjWY3uTO8eHCoaA8TLqpCG0FnCL2j6MwRtDNgNWohEgCKbdXInsLH+yMm
yl40MxGuOiiPyWMAUkm7rUX/j8UotsMco9mwGQG9b++u65KVz3xuI8VR7uCmOJz7
TCkc7ZKGUB9xIneld0FUK5bFKsH6/NOQQkUtIeF69PBnW61kyRA2NUjPXiwdpCN+
f8wPxqVPYVvCPNscx8bEaeTVvo5hYznTvt+2yrGjco3iscq6clIwoeKnMFazQ7p/
hMpEDD8jcmGMXyf+IYdb
=3n9w
-----END PGP SIGNATURE-----

--OY4z34RctfP64Hws--

--===============6086114830603084826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6086114830603084826==--
