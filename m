From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:for-4.19 199/204]
 sound/soc//meson/axg-tdm-interface.c:225:8: error: implicit declaration of
 function 'clk_set_duty_cycle'; did you mean 'clk_set_rate'?
Date: Tue, 31 Jul 2018 15:02:22 +0100
Message-ID: <20180731140222.GE5719@sirena.org.uk>
References: <201807210204.l9GJCtSI%fengguang.wu@intel.com>
 <1532112058.26720.62.camel@baylibre.com>
 <1c2a42498ea90428fb6504414154fe3663258ed6.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0868733975046742772=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9466F2677AA
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 16:02:23 +0200 (CEST)
In-Reply-To: <1c2a42498ea90428fb6504414154fe3663258ed6.camel@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Michael Turquette <mturquette@baylibre.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0868733975046742772==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 10:39:03AM +0200, Jerome Brunet wrote:

> The commit adding the duty-cycle feature in CCF is directly based on v4.18-rc1
> Do you plan on pulling this in your branch ? or wait for dependency to be sorted
> out during the merge window maybe ?

I'd like to but I'd rather have an explicit ack from the clock
maintainers that that's OK and ideally a signed tag.  Though it's taken
so long that at this point it's not going to be much worse than just
hoping it gets sorted out in mainline given the lack of branches, it's
not affecting common platforms.

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltga+0ACgkQJNaLcl1U
h9BlEAf+O5PbtI9FVzOpbHkNhe2A+IuIUuFK0iSFF6rITBNS5GzabXaAh1oUESvS
OXSp3cyyIOimNj+liVJ0lvpS+mmPrGg2+daEXcuVtVTZHUH/WpgX3jXQkT0scjGk
tV4RtbvzouWo1x6FQ2BVGTYyKFqYI01fw+aCZ07W0WtDUKPkZ/ehwVerPNZrC1yy
YAvi3nQOo146j5k7XeNVDEuG7pIgmZeg+zRljW0FcTyTjtMNDX8U4PKrzU0TlaMN
f6/QQeEoFbsmv427KyHkbBUdWF4GtaYLgqFhaQ7BaPcv8DzbOREd0wtR/NPpLEK6
XfHCuEHib7Olbz0KAvZQSSOlxBImEg==
=OGeM
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--

--===============0868733975046742772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0868733975046742772==--
