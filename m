From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: dapm: Add support for
	autodisable mux controls
Date: Thu, 30 Apr 2015 16:58:58 +0100
Message-ID: <20150430155858.GA22845@sirena.org.uk>
References: <1430390332-14037-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430390332-14037-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <554223B8.1040304@metafoo.de>
 <20150430150039.GR3480@opensource.wolfsonmicro.com>
 <55424CC6.7030701@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1753482705203679620=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD5A5264F0A
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 17:59:09 +0200 (CEST)
In-Reply-To: <55424CC6.7030701@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1753482705203679620==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SOeYZCt5d38i4IhE"
Content-Disposition: inline


--SOeYZCt5d38i4IhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 05:39:50PM +0200, Lars-Peter Clausen wrote:

> Hm, right. What I had in mind is to not export the off state to userland,
> but I guess it makes sense to make it possible to select it explicitly since
> it is consistent with the auto-disable switches.

It's not just consistent, you need to be able to do that so that you can
set something to a known unused input when it's not in use, otherwise
you need to worry about making sure that you don't end up causing audio
to flow through the mux unintentionally when you go into some other use
case.

--SOeYZCt5d38i4IhE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQlFCAAoJECTWi3JdVIfQRykH/1E7S+yhjCLMJIo55EntaFGU
LuQc2zaS3WPJG0AZ7UkFOEb8AAsKMNMhw6vNLkh3NguqeaB0QgVBZCjbszvbnN0q
lmEN4zgN5qr/XEhMe98by4TrH49lsUlOe2B6oya+Lxl1NpNeEzwb14opGCaJPGqn
aON/6rSxXGsTMDrp3ttQg5F6e6Mn3PSBcHsfbVucphptj/+/VyC0Jd25obIN1giC
t66tKWaPkXmu8S6s88gFgb5XFI0MieO+5Xw13+fx+2LXiTb9Aaq+6HKxohAeRIms
SEWn2bSrx54dbNRGO6XhiWKlBAzPfHqCzx5xmaIypuKqcQal/oo0dW8x6gJO6C8=
=8U03
-----END PGP SIGNATURE-----

--SOeYZCt5d38i4IhE--

--===============1753482705203679620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1753482705203679620==--
