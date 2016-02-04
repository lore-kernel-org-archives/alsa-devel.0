From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/11] ASoC: Intel: Skylake: Fix delay wrap
	condition
Date: Thu, 4 Feb 2016 20:33:48 +0530
Message-ID: <20160204150347.GB2531@localhost>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
 <1454502594-21700-3-git-send-email-vinod.koul@intel.com>
 <20160204112436.GM4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3987310915831958325=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 49BD92606CB
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 16:00:15 +0100 (CET)
In-Reply-To: <20160204112436.GM4455@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3987310915831958325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2016 at 11:24:36AM +0000, Mark Brown wrote:
> On Wed, Feb 03, 2016 at 05:59:45PM +0530, Vinod Koul wrote:
>=20
> > +	delay =3D (hstream->bufsize =3D=3D delay) ? 0 : delay;
>=20
> Please don't abuse the ternery operator, if you're not inserting it into
> the middle of another expression there's no reason not to use a normal
> if statement.

Ah okay. Sure I will send an update to modify this

Thanks
--=20
~Vinod

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJWs2hTAAoJEHwUBw8lI4NHfqEP92jKE9PG6yOQsQT5qqYDOhto
Nhm2tb8nDJX0Yk3bXIAImjXUjlwDJXbLescjT8T4n5WutNGM7s5bISdhO5phT5NC
9wK6N8U9nLb/A2pVXZjTm0RQWoDH6/VqDpx+51LtFw6rbEF2FL0Gg4t2gWIF2qrH
ae0FWi3k3tUVnhwPNS7pjGnSum51i5sbmDfxm4LQdXDN6WcmLtCNEal2pvmcSMCL
Tt6mwmQbdyBhWSSKpn6qLZuV9TfEePnuHhDiJD2BOZpqTBOl9EWVJDsh5UJGJaLJ
B5tI7om+vltJI9odL4SChKTpyYQgbu/vlVRVakfsjJBu5LsotCZwRJygAto47KNx
df+WeubKod8q1L7kdR8QwFB79+aYo3gIFmH1DVar6HUlGwJqagNT3yw4BZ0n80Bk
i4Y3Nfe6H9vEMhJu94mFfhbyGhWvbYJ7ePV0s96qUXPutqzQXFl8cdlbKenAAz2p
TUSK56TOstxpk066G3HFjtzO920PtZ62mkNwMeh+GGCdku2ZG7e9SgrUewvdUJsC
RwaLEPaYA07Qow4U4FxZcJxjrv5FXx+JfWqzjJdog91Vm7BAlcYCDTYZVlGghvV5
QIsCOyoZnWhFu8fsw9ryRtO+3r19FyEmhtgZhxs8Okudfr52VMqydEHrTM9mh07n
AsGMGsCpowzjLzppBLM=
=B/m5
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============3987310915831958325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3987310915831958325==--
