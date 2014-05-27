From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH]  ASoC: fix snd_soc_jack_add_gpiods stub
Date: Tue, 27 May 2014 16:50:44 +0100
Message-ID: <20140527155044.GY12304@sirena.org.uk>
References: <7602265.lTCp4nNe4p@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7238747554946053164=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00E842658AC
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:51:00 +0200 (CEST)
In-Reply-To: <7602265.lTCp4nNe4p@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7238747554946053164==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BGUAHuIYmWoGf9S4"
Content-Disposition: inline


--BGUAHuIYmWoGf9S4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2014 at 05:46:05PM +0200, Arnd Bergmann wrote:
> f025d3b9c64e1 ("ASoC: jack: Add support for GPIO descriptor defined jack
> pins") added this new interface, but the stub function provided for
> non-gpiolib builds was defined in the header file as a global function,
> leading to lots of "multiple definition of `snd_soc_jack_add_gpiods'"
> warnings.

I've already applied a fix for this from Jarkko.

--BGUAHuIYmWoGf9S4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThLRRAAoJELSic+t+oim9fRAP/2ChbNNfTJWyQp9e5mqoojUU
J84ecF9Yks9bU2b7wZg+uE1DT2Uk6u60xUEyHT/QEAK9tDiRNlI/HdaAZaQ8idM5
8NJ9VXTtPEKZElURBskgEzaWmAtF7Rskg2zBoTVYYr6xtgeO8OEMfPaWJWU6MO7n
J7D2LxOGQtPTTcXPClyb1WP3ejlRmOQ+mJDJ263PT1v9U835o/ETVJLGQRNAMUIL
CcAkjhDA9LPHERcUs8FJRReZeQglO+A6Ch63zOOsb2CvjIfv2oiHm7KT5vd3JAGD
yEqQShV7bRvL7zXr+9TA1/sn0invOy9On9u/muUfrqqWuIt18sfEm3TLqO52kVBR
NJtRuKDQmpdV24oR1wMr7hxdCD+NXfJ8iReJA1AvtQkaV4rS71nogzns12aozALJ
wWeytVtMUU4TBfux1ircj3DsnUmGtclMyvB+0gD7rp4oObGblSHS8+zqClTBmGST
gQLSnIJd0fFzvMvy8BiVuzX6Ji0K+vHJn1FAVTSeZxsxG4QJBqFuolA7T+vElttk
64BJ4lSNhYAWJrlvop9OF8GdVkZW7t0mniGIO25hZIO83lMWJ+EEUwVcWW4k2Uwn
lpL7uunLZnOzsgmZxwLSBeG7tOTJYSNhLSdxfAlMHhbWyx3ca6JQNhVT3p3g2DrJ
kRMepwvNBgIzalro2pmo
=FlNc
-----END PGP SIGNATURE-----

--BGUAHuIYmWoGf9S4--

--===============7238747554946053164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7238747554946053164==--
