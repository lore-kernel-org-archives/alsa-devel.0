From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: tas6424: Add support for the
	mute pin
Date: Mon, 23 Apr 2018 16:37:46 +0100
Message-ID: <20180423153746.GJ19834@sirena.org.uk>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-4-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4269219535096977826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EF1C266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 17:37:54 +0200 (CEST)
In-Reply-To: <1524218684-19752-4-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, robh+dt@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4269219535096977826==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Content-Disposition: inline


--n8884J15jRwcBTvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 12:04:44PM +0200, Jean-Jacques Hiblot wrote:

> +	- mute-gpio: GPIO used to mute all the outputs

Same thing with the plural here.

> +	if (tas6424->mute_gpio) {
> +		gpiod_set_value_cansleep(tas6424->mute_gpio, mute ? 1 : 0);
> +		return 0;
> +	}

Just use mute directly, the ternery operator is doing nothing for
legibility here and C does the integer to boolean thing for you.

> +	if (tas6424->mute_gpio) {
> +		gpiod_set_value_cansleep(tas6424->mute_gpio, 0);
> +		/*
> +		 * channels are muted via the mute pin, don't also. Don't also
> +		 * mute them via the registers so that subsequent register
> +		 * access is not necessary to un-mute the channels

Extra "don't also" in there.

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrd/ckACgkQJNaLcl1U
h9DP7Qf+LcNLKDMaaEDioJluhqvPyFi/YfQF0mjrwrKRtQa/b4BPRVOA8HCqP0N8
Tc+Ao+VGQsaTvdkgVhE94uhuEGhebfEIug0dhHeudybwwBkCuw7dWJ/nBwFvmA9n
OY5W1KbvUAxNx4wUGICnehJ6Rm4yaY7CAMuoGVbybmfmSju3TRvTZBasK+YagtAv
oSzDsaF6vFDbOTnyUBkEzEOPLsMYoxqVGbTo232cFZvAKAJB8susvIr42FiPGCwF
3pJJr4VZKIfXpemRasRlr6nQw5Caeniw2HkSO1b+2jTwdyBuc8nJkib/nqZi0hND
d9MSRkr4KKZ3auawy6pbiv8jTejqyg==
=Plkg
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--

--===============4269219535096977826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4269219535096977826==--
