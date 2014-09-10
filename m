From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 03/12] ALSA: control: Add init callback
	for kcontrol
Date: Wed, 10 Sep 2014 13:35:31 +0530
Message-ID: <20140910080531.GC1770@intel.com>
References: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
 <1409661367-19047-4-git-send-email-subhransu.s.prusty@intel.com>
 <20140906142124.GG2601@sirena.org.uk>
 <s5hppf8g2ul.wl-tiwai@suse.de> <20140908041421.GI1610@intel.com>
 <s5hppf6a679.wl-tiwai@suse.de> <20140908080807.GJ1610@intel.com>
 <20140909114425.GU2601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5916917826970616146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 700ED261B31
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 10:28:41 +0200 (CEST)
In-Reply-To: <20140909114425.GU2601@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5916917826970616146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2014 at 12:44:25PM +0100, Mark Brown wrote:
> On Mon, Sep 08, 2014 at 01:38:07PM +0530, Vinod Koul wrote:
>=20
> Please (as I'm sure has been pointed out before) fix your mailer to word
> wrap within paragraphs.
Oops, i though I had set mutt to fix it after you pointed out last time,
will check again.

>=20
> > On Mon, Sep 08, 2014 at 10:04:42AM +0200, Takashi Iwai wrote:
>=20
> > > For example, you can embed an init flag into your record and call the
> > > initializer in get/put callback if not called yet.
>=20
> > Yes but that would involve open coding in all control hanlers for the
> > driver :
>=20
> > if (!initialized) allocate_control_mem();
>=20
> > This approach was done earlier (checking in info) and flaged off by
> > Mark. It make better to have these handled in the framework.
>=20
> No, that's not the problem I identified.  The bug you had was that the
> driver was initialising the data in only the info callback and would just
> fail if someone decided to call another callback first.
Yes and during the discussed we wanted to handle it in framework leading to
init callback.

Nevertheless we are moving it back to driver while fixing the bug you
pointed.

Thanks
--=20
~Vinod

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUEAZLAAoJEHwUBw8lI4NHYpUQALMlA5Sx2s+R9lUpqdBhFaZP
LnRGDOswRXiOHEZi/tcqzRXkj/a+8h/3f8CKO2OiYCm8WhezC5GPK4It1p3YcxJ/
nJ1G1mTcw3xI86ZfFvxM8hbb4xb6JG9oK3GwRZ1/dhWJb+WFDLqXI9ilGoyJB6Pv
dnB2SHIliAK51MNflFou5ZSLpUNNQvJFfAkHLFn9xQmUt4wHMpBvx59ByhO5+8/t
PT8J6D7QyPENCJQAJXq4QzP0+DAwLVPl5Z2zTfYtvD9EphchxG7Ymd913TI0tbxu
6eM/IsME8byiR+9nBalF74E+fohaH/4mbnv0dKIfNLMOkV0o3tAgRSOAx7STWiHJ
zoJP652eLisHOAtlj7iYLAJsrQbuDpJOdBkhh8PxOA19zlE4oKFiV2Fulwx4xg4Z
53Y+NRBw2zwUVG3PZR15AlsdzOOiTVftyRhcvOKS0zeIwemYyT0v1iy8UqChwHKe
Ii+UqZHK1BCV9zHJKYxF+iRNEv/Cg7dyNfGKyPU03Xk3zilyZPxNfZp0B7yz4v/d
Kw3mHZ+oCeysZbouWfElLYQghHSbM7LB7atFghGlQdGn6a1iQj5yMiXK18Wb8V1J
4FWlUFDZ5oR0lxxEePb44aom7RTCNulM4bMlhYr2TCCiMLV0RnYBP0ZePvbwD2cS
mSpk23PxH9oMEHhgHGzu
=QtdZ
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

--===============5916917826970616146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5916917826970616146==--
