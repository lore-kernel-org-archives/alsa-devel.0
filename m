From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: sst-acpi: Add support for
 multiple machine drivers per platform
Date: Thu, 20 Feb 2014 01:15:44 +0900
Message-ID: <20140219161544.GM2669@sirena.org.uk>
References: <1392820558-27548-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2540480778562568440=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D78A265A45
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:15:57 +0100 (CET)
In-Reply-To: <1392820558-27548-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2540480778562568440==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+7MpFbMlrzW53O/Q"
Content-Disposition: inline


--+7MpFbMlrzW53O/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 04:35:58PM +0200, Jarkko Nikula wrote:

> Matching machine driver is found by looking at ACPI ID which would best
> match with the driver. Typically this would be the ACPI ID of audio codec
> but is not tied to it.

You're going to need DMI matching as well, there's going to be quirks of
some kind.  Otherwise this looks fine if an ugly way of doing it,
assuming Liam is happy.

--+7MpFbMlrzW53O/Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBNitAAoJELSic+t+oim9ay0P/1UpcrBTaG024Aw9PtZA/G0d
4Ufbong5aDPhdej1p4uZ3QRaG4ugke1i2TppsVzK6dOaYUJDC9TS+62LT3HHPblJ
FUBizYuMIOTk/HkxEIAy+5Y2Z+ambrV98rYKxGf3E8a4tDn1dk1rdECh337pQi/i
PhGObVLyaxhd0mVXq+7tU8Hvw4+CmBONkW4HkvbZ8mfMkSUqQLJwck8elBkbyMy7
EOU/VnJ1NZgjSSja1hrdXU0RGtMxobAFUZ3FcF8iC8x0Y90hNfqUqI3PmBj2PEYS
XDr5KXm1NnW+Z1+q1lmoOsA6XBUa45ezltpvSbdjhNb0vv2Q1VepYcfgC4I8mlfU
X/GVnZYbZCAAivVs5/8GkWgDQpYTygbgC0RLOGbZ9cOKpyRIKUqerx+JeZIXiJN9
guaEXrNfA5hjxcu73vz3psM/L1C5vTim5APCejIeQKsAinFqSoyw177PDxADGegf
Tc7P3CRZnnmA/+WDL9cXQufjS9QBz0Oyi3svXooW+Kg0I5JlOAMWT8YnKvzO78ys
ojS2xeBWAxHKwKFRaPOgUTmLwHaBWx6aywO8o7CcZjvphRzsRLkMisBedgpDsYYh
7oaco/sPUBp8utGsgTKdbI0rdexKJ5bwVmmCXbb3ndHYQjPMz+k+D3Ksq8OGR7MQ
s/MnOQlLyGV3Ro3i6O23
=uKNj
-----END PGP SIGNATURE-----

--+7MpFbMlrzW53O/Q--

--===============2540480778562568440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2540480778562568440==--
