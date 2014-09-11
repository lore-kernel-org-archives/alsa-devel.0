From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Fix register address to set SPDIF data
	type.
Date: Thu, 11 Sep 2014 17:17:40 +0100
Message-ID: <20140911161740.GO4015@sirena.org.uk>
References: <1410447166-2336-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0405835123275607302=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B81E0264FEE
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 18:17:57 +0200 (CEST)
In-Reply-To: <1410447166-2336-1-git-send-email-Paul.Handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Handrigan <Paul.Handrigan@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0405835123275607302==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W4pDZ/VvazBYHhxQ"
Content-Disposition: inline


--W4pDZ/VvazBYHhxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2014 at 09:52:46AM -0500, Paul Handrigan wrote:
> ASoC: cs4265: Fix register address to set the proper data type.
>=20
> The SPDIF control register must be written to set the data type in hw_par=
ams
> not the ADC control register.

Applied, thanks.  Please use subject lines matching the style for the
subsystem.

--W4pDZ/VvazBYHhxQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEcskAAoJECTWi3JdVIfQK9UH/1E6GUdD+YWXgFs/5rlzBVzv
R06maXjDje0xIZ+fsfdRXD4ndmBa9X5IgIp2sFFNajwG5FReuP8jk2a67tu6AHIH
Eo3MgnPiKbYFi+X5UGWo3WySlYg3pVKsR43/PARoPpBEJ4T6zVpJCe8eA7rjl643
tKXCJLLeFc1BXfsY7iaz6r2A01b9BewnG2JJAr682dkoE8EQogWqEAMOrgfTyg3i
/mzmhhWf62jUthcigOUoawKpO2MBMPi6CaEG1IW96/IXENSDCNS2rotNTzI+w4Vz
zfDPvuU6Sx1p7nvOhzSTPqF5QZV7xUZfxfJ2j6Ju10I/EkESV0/bgUX7UpQcMFQ=
=npbz
-----END PGP SIGNATURE-----

--W4pDZ/VvazBYHhxQ--

--===============0405835123275607302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0405835123275607302==--
