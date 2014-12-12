From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/6] ASoC: dwc: Remove unnecessary debug
 messages and tests
Date: Fri, 12 Dec 2014 19:29:36 +0000
Message-ID: <20141212192936.GT11764@sirena.org.uk>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>
 <97f65b6037b9ac676f6ca7717a230a68cbe81fd1.1418372910.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1664134409936452336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22D482606CE
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 20:30:15 +0100 (CET)
In-Reply-To: <97f65b6037b9ac676f6ca7717a230a68cbe81fd1.1418372910.git.Andrew.Jackson@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Jackson <andrew.jackson@arm.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1664134409936452336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ddlq+5wZogx8hGrT"
Content-Disposition: inline


--ddlq+5wZogx8hGrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2014 at 09:25:00AM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
>=20
> The devm_XXX allocation functions print a message on failure,
> so additional messages are not required.

Applied, thanks.

--ddlq+5wZogx8hGrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUi0IfAAoJECTWi3JdVIfQTDgIAIY5bDThEf6xA3UGvw2Sqov0
LLrnGf2Lgk8KnuNp3hZweTZzyHddqK3e0BF7rm0cSc83t31zc8sICmaLhlVuam7c
oLxxPtBFM7ej6TeGXQJQbB681bCoM2pIQuv1leS/GuKNhRb7XSCl/koKy3i7An4q
0rivYjI7wjoqUUV72QWEBlMzxp7rnfvywRWzJit0v/NN6NzrVvmkJAz1erZC6dkT
DoBeSHbGZca9xbweVJqMjXf7xSfwNVJtsVMAZD8mSGYMfrMF53x+Nn8Ud4dcXY8T
mMr0h405UvDyAEIG4uaYH7iek7OFk6+qzlNYfiBg5lclerDsUpxXRBqoRIJBgmQ=
=6kUA
-----END PGP SIGNATURE-----

--ddlq+5wZogx8hGrT--

--===============1664134409936452336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1664134409936452336==--
