From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Atmel: ClassD: Set GCK's parent clock
Date: Fri, 20 Nov 2015 18:08:54 +0000
Message-ID: <20151120180854.GD1929@sirena.org.uk>
References: <1447903590-3285-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8743753357678553738=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F66A264FFF
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:09:15 +0100 (CET)
In-Reply-To: <1447903590-3285-1-git-send-email-songjun.wu@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Songjun Wu <songjun.wu@atmel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8743753357678553738==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2015 at 11:26:30AM +0800, Songjun Wu wrote:
> Set GCK's parent clock as audio clock, make
> sure the GCK's parent clock is audio clock.

> +	ret = clk_set_parent(dd->gclk, dd->aclk);
> +	if (ret) {
> +		dev_err(dev, "failed to set GCK parent clock: %d\n", ret);
> +		return ret;
> +	}

Why are we doing this in the driver?  This should be done by whatever
creates the clock tree, not by the driver that uses the clocks - that
way if some future SoC has a different clock tree the driver will
continue to work.

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWT2G1AAoJECTWi3JdVIfQk1sIAIDTRZKUJ1ae7Vcd7VdtR9yl
t1RQ7QAreyf1/DhVm6MoyZnqfSSYmT1925i3uk0K2yAFt82Q8CKgQXMW+N6ANwZE
/kTsPXk9NM6IkQxmorQdkLVm51s0g9kpSOXMFE7PsGzr3AG9zv9vpefoCBd4lxEy
+dgOeu/Hq5aqpH7OcaLMIUjooPCteue9f9CJcW3ng/znqMvVbjDbFVu6VDkt8b3t
7Iebvr7NminVpkvUhTN9SP7HQryk8cN76cXT+AYkzxQf5GZawELpIufdzQrezNjS
zomr1jMVHfMiIl/PuMEVxQaPch5oYgsYCL2KBp7xwAgz/h25sdaRZ/fqzKre7Oo=
=m7Lc
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--

--===============8743753357678553738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8743753357678553738==--
