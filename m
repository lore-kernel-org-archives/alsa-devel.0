From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: max98090: Fix ill-defined
	sidetone route
Date: Mon, 24 Nov 2014 17:14:17 +0000
Message-ID: <20141124171417.GJ7712@sirena.org.uk>
References: <1416835957-14153-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1416835957-14153-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9206162244863548768=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE7542651E4
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 18:16:19 +0100 (CET)
In-Reply-To: <1416835957-14153-2-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9206162244863548768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Content-Disposition: inline


--n8884J15jRwcBTvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2014 at 03:32:36PM +0200, Jarkko Nikula wrote:
> Commit 5fe5b767dc6f ("ASoC: dapm: Do not pretend to support controls for non
> mixer/mux widgets") revealed ill-defined control in a route between
> "STENL Mux" and DACs in max98090.c:

Applied, thanks.

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc2doAAoJECTWi3JdVIfQzbYH/2QdVw9CAItR5YEowY7860jT
oHNupu/9LEYyMVnbppMCw80yBNH6OrWsaRFt7FhfL4Fl7wnd/I8uf0W9NtgudNhX
Qyf9pw5deYv/O8Bv3GFMh2OQKO/u0RphRCqqhLBO5Ss/8b5HmTRupSIs7HWQvVKC
HeArn47TmixjZWXRvTUUbP1fYHX7leX9Iobco0iBdmCSCchnAoYYAgdHTCtbP9Hz
Ro1fso0RyPwlo7yWdB/KlH9wf1sYVP6Byp5CpRrxugQt0TLiyUqE9udcQPfZPqcp
V5wilQiErDvIK6ZrTxs9jbsVds/rhyVV94NYuzdCnI7e0Ee9J6iz061judc0Z68=
=vybn
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--

--===============9206162244863548768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9206162244863548768==--
