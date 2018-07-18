From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND 02/15] ASoC: meson: add axg fifo
	base driver
Date: Wed, 18 Jul 2018 12:50:54 +0100
Message-ID: <20180718115054.GI5700@sirena.org.uk>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
 <20180717154304.9973-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7386913901980755936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BDAD726720C
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 13:50:56 +0200 (CEST)
In-Reply-To: <20180717154304.9973-3-jbrunet@baylibre.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7386913901980755936==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 17, 2018 at 05:42:51PM +0200, Jerome Brunet wrote:

> +	return !status ? IRQ_NONE : IRQ_HANDLED;

Please just write normal conditional statements, it makes things a lot
easier to read (the ! isn't helping either here).

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPKZ0ACgkQJNaLcl1U
h9A0+gf/VsQEQ3Eh3LFVvVOE4q/C6dHPik7B1mL+EauJ5ivAVTQbE/MpoHy/rAF0
sVXGt+XVVsef/OLGmglJ3QM+k3z4QagK7r0eH4S4DjiDsBTW2h8OO1kR/Yrdnwee
BULhCJqV5IBuTRIIlxAMvSYPe07SEs3KNzPbFjVbfTH6w44XdCDEnR+rKBkAcCOA
c/NWQke0nlQe5LZC4GVQEPtXD3m4SlHyXyYc6Hiuf9f6+9GWEXMvh6lJU9mvo3VY
ZUNXZjkzBc20K9ekCWVtOZwPC59rbsgoGYhhkXQhIGi0buyv+EjoYqn4QM/lDcOV
WfA/uW/+EQukr9SjnXLNlMKcVCeexA==
=WYYV
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--

--===============7386913901980755936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7386913901980755936==--
