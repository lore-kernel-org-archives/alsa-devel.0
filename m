From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/7] ASoC: Intel: mfld-pcm: add control
 for powering up/down dsp
Date: Thu, 25 Sep 2014 15:22:31 +0100
Message-ID: <20140925142231.GT27755@sirena.org.uk>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6731168020022712851=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FE95260421
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 16:22:47 +0200 (CEST)
In-Reply-To: <1411125368-5836-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6731168020022712851==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qKhyKP9HH88saeqA"
Content-Disposition: inline


--qKhyKP9HH88saeqA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2014 at 04:46:03PM +0530, Subhransu S. Prusty wrote:
> From: Vinod Koul <vinod.koul@intel.com>
>=20
> When we have PCM (FE/BE) opened or DAPM widgets triggered we need power
> up/down DSP accordingly. The DSP will do ref count of these requests
> i.e. link these runtime_get/put calls of DSP

Applied, thanks.

--qKhyKP9HH88saeqA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJCUnAAoJECTWi3JdVIfQAtsH/3mu+jjdTFfHuX3TZnXDp49V
V64A5ogbQN2PloIul7+E226HX52/ooLslAjEqzrgggsBcW5x0530Ecbm5nSZdPkI
J4wKu07s9rJ2nojxjenNIHRJt+DOX1QV2BKdiSCTqBS8iPTnvJ03t9xnez4jAKem
bQrYq22VoyKs2wzwiG1WgV//iQ6hwUVZZNBftu90/Al1+j2GjkSKdFlPzHZz4rZc
ca86ThQKG6kzVi6OanvTqK+DM9zDh+wwKX8mYevowdGxaCZdiJNRKKn8JG1WUWFl
a3zYEQQL0ykd4JY9Oibv4zut/PXNMKDNbtwb6wKOemeRc4JmQs09ZPF7Z+9tHXg=
=Nxeo
-----END PGP SIGNATURE-----

--qKhyKP9HH88saeqA--

--===============6731168020022712851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6731168020022712851==--
