From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/9] ASoC: arizona: Move calculation of FLL
	configuration
Date: Sun, 9 Mar 2014 08:26:49 +0000
Message-ID: <20140309082649.GO28112@sirena.org.uk>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1394210065-23941-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4050098204339909125=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3799265552
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 09:27:00 +0100 (CET)
In-Reply-To: <1394210065-23941-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4050098204339909125==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/yfn7NBi5qsQ3/E8"
Content-Disposition: inline


--/yfn7NBi5qsQ3/E8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2014 at 04:34:20PM +0000, Charles Keepax wrote:
> Currently the FLL configuration is calculated before it is known which
> FLL path the configuration will be applied to. Newer versions of the IP
> have differences in the configuration required for each FLL path, which
> makes it complicated to calculate the FLL configuration in advance.
>=20
> This patch simply checks the validity of a requested input and output
> frequency before we know which FLL path they will be applied to and
> saves the actual calculation of the configuration until we know where
> the settings will be applied.

I'll apply this but are you sure that this validity check is actually
accurate?  For some of the devices there were input/output
configurations that couldn't be reached due to constraints in the system
even though both input and output were in range.

--/yfn7NBi5qsQ3/E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHCXGAAoJELSic+t+oim92rAP/A7Md5yPjyxSRvO56AfUtjWs
Pu3nwh6tjRC0a7JCcBjUjvlZrZ/u/6pDnS5qLlYcPkQayw0xlZfLILlbya3+oTcE
JfyW/u2X11hVDBITquVhpWCIIpTuu6NoH0u7lpV/vUfLpkkY4ZaQ4LIWhScOsMzp
Mvb5D8eCt84BACmtNO7w8yRYwTGr4n/Esx3XKiDODxgiB7T8vN9hmfYlQ4zHdPk5
hs1WXxNezDh9Xl9cRgOcFp+rMYcJhBKudPgudMBNhRu0VdO+JXuPjORjDKuFNHXf
SkraBdFxtve8c0bA1Fz9K5UhdFWlws9jUu6dwkx63HtZO9P/T5RQiFeoS3PkyR+u
+uvnoHOzRD2c+xxg8oTs1HO5q2OdhJzhn+vH+c1x+1tE3z4aeyEB1Fk3UCQtZnYI
WfZvK0PSaIT4wS7aYESKDT3e7WnYBg8hRmhQsri0ENFAlzsk7S83JWiUZDMuDtZ8
eB9KPwmzaEUxrXu+zttS4vST5wTBdCwy3bu5YNkqqFHjA1jSaBl7hOZoK//LJHdi
H0UTg+DIGXRe9iZe2YFKOlzDpuxh+RAiiI5h5trWB1VDU+0lCXcxZznB2VYoIcIJ
M08mjFaDyMmJ6ytr2F1AFVnyFl3gFwohTsloN2seRzxWjfnTMDX/yuB6T041wzyh
cSlRT/+you02hz5dbKsf
=7pVF
-----END PGP SIGNATURE-----

--/yfn7NBi5qsQ3/E8--

--===============4050098204339909125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4050098204339909125==--
