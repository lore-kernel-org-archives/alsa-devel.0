From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: PATCH: wm8731 - reinitialize regmap cache
 after hardware reset
Date: Fri, 29 May 2015 10:32:37 +0100
Message-ID: <20150529093237.GI21577@sirena.org.uk>
References: <CA+abuVebbr9Cif_SfB+JcNhUOMV70fdWa-Q-nk+gFv9H5MRtgQ@mail.gmail.com>
 <1432831966.2726.63.camel@loki>
 <20150528192619.GE21577@sirena.org.uk>
 <CA+abuVeO4=au_X0Z_MjPsq40b1fHbjezKRy_fTOgQ=SzmaPK5Q@mail.gmail.com>
 <20150528145548.fa5a0f2d78c0bb2549088fc2@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3813646648635609867=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6337326059D
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 11:32:44 +0200 (CEST)
In-Reply-To: <20150528145548.fa5a0f2d78c0bb2549088fc2@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, skiselev@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3813646648635609867==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vv1mEC2IAGDct2wW"
Content-Disposition: inline


--Vv1mEC2IAGDct2wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2015 at 02:55:48PM -0700, Sergey Kiselev wrote:

Please fix your mail client to word wrap within paragraphs, it makes
your mail more readable.

> On Thu, May 28, 2015 at 12:26 PM, Mark Brown wrote:

> OK, I was trying to move the request supplies and reset code to
> wm8731_{i2c|spi}_probe(). And I noticed the following weirdness with
> the supplies: The current code in wm8731_probe() requests and enables
> regulators, resets the codec hardware, tweaks some registers, and then
> disables all the regulators:

That's totally normal, the new register values will be rewritten as part
of resyncing the register cache when the device is powered back up.

--Vv1mEC2IAGDct2wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVaDI0AAoJECTWi3JdVIfQ6j4H/0vjcg/anblkktnkzz64h2Ci
OuXLBR6JEmc8z/bNl19IREn33lv2Q2PM6CjDlTd+Gk4L63E004lr9HbvJ6SkBXDH
9RBEpDdj5xmt4CBz5CI5vAdR3GGL44GDBJnS8AERP6TuEjwNB3n5NlIpZDsVTmHz
9+qk7kHvv9tIsOKu7TdGEjcpfXlHNMzRsNFy2qN9fqB5rGYVx+rleEkEhO4nT31z
CdX3kG5aeWeLfO87JGHQKRwF2kQXKMVRf618c6gOVa0yAvnyJ60uZCgI3uEdu6kZ
ihZEr+7g8JJ7C3cVR8Y9oC2OoosrBi9gSNMlAiFEudADBnbXe8CJEvytueM7og0=
=hvl0
-----END PGP SIGNATURE-----

--Vv1mEC2IAGDct2wW--

--===============3813646648635609867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3813646648635609867==--
