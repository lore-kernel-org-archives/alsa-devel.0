From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: cht_bsw_rt5645: Fix writing to
	string literal
Date: Fri, 26 Feb 2016 11:12:10 +0900
Message-ID: <20160226021210.GE18327@sirena.org.uk>
References: <1456217420-9327-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6242911084322375752=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C1392606F5
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:12:24 +0100 (CET)
In-Reply-To: <1456217420-9327-1-git-send-email-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@caione.org>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, lgirdwood@gmail.com, yang.a.fang@intel.com, Carlo Caione <carlo@endlessm.com>, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org


--===============6242911084322375752==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ZrfUtnV9bgsmoNR"
Content-Disposition: inline


--9ZrfUtnV9bgsmoNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2016 at 09:50:20AM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>=20
> We cannot use strcpy() to write to a const char * location. This is
> causing a 'BUG: unable to handle kernel paging request' error at boot
> when using the cht-bsw-rt5645 driver.
>=20
> With this patch we also fix a wrong indexing in the driver where the
> codec_name of the wrong dai_link is being overwritten.

So how was the original code tested then...?

--9ZrfUtnV9bgsmoNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWz7R2AAoJECTWi3JdVIfQgC4H/1xornAhfr+HlkRfkwBb8FSh
YjZbOwhm5XCu/y4XKjffw239qJCqtaLfq8wGgsoJp5cghbdoHVxXPjbItrOafBUb
v8hRzjZ1AcxGL938XxFSAJMi2wKARnTVc6gtR1o9sqfD6KZcKvxVxQQf3JtV3sxD
YQMuH/UHAGeXHi2QrjWW7ou7PndUbSJTsMxW7WW9GZxdBptQbOufBozDmvSGDnmO
GBT7uHCmTJbEDksSDGJG5ythJTZt1XHwpJHftzbL61fW7yEadCvA07OqRY9uk6TU
T1NXCfkrx5uvIhM7HJULz8MjEZtNscgsqbZGj7NbpOa+dkuw86uV8ZDVoUfy3YI=
=FweA
-----END PGP SIGNATURE-----

--9ZrfUtnV9bgsmoNR--

--===============6242911084322375752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6242911084322375752==--
