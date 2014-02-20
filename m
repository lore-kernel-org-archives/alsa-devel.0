From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: sst-acpi: Add support for
 multiple machine drivers per platform
Date: Thu, 20 Feb 2014 17:58:30 +0900
Message-ID: <20140220085830.GZ2669@sirena.org.uk>
References: <1392820558-27548-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140219161544.GM2669@sirena.org.uk>
 <5305A910.2000507@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3240870523672474803=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D2A32610D7
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 10:00:22 +0100 (CET)
In-Reply-To: <5305A910.2000507@linux.intel.com>
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


--===============3240870523672474803==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yapsC4sTCx4mg1sJ"
Content-Disposition: inline


--yapsC4sTCx4mg1sJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 09:04:48AM +0200, Jarkko Nikula wrote:

> Our target is to get as much as possible data from ACPI but
> meanwhile there will be machines where only data is basically just
> the SST and codec ACPI IDs + DMI or some other unique identifier.

If you were able to hook on to the generic card that'd be really good
(especially since all the DT systems would then be able to benefit from
the work too) but that's not a hard requirement by any means.

--yapsC4sTCx4mg1sJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBcOzAAoJELSic+t+oim9FXMP+QH9j8bkpa2uQX5Ti+q8DceV
0429h/2+M3WzljTbl6Dfxlh/8YzJ+ZncBdg7YbWWZ8fr4KN+NHWszRcLzt8POexi
6txizLVl8Ec/0jmGkafwAn67uxz9SVnsexgd7SydwR8yz030UxCuFsXIxRUFnW1S
wbMjYF+kcIXwZmFgqGQCUbEqtZUWsBLU6C/incybW4MEdvkYxpqSJmjvXI0Bk8Z2
+1LzVbeOsg3F+6fHreVwKIHU5Kgit1an5shsX9h3sZYcjQX0gUp/fSKwC0rsqNit
f2MrOoZpylf7MMGOacZO0S4Kd4ZpGI267+fQeAsRJ2mzCkmVq/ndPu4plKvu/ZpO
K4Vui6tJeniBlYEBOJW6uM9eW+0UZQDG6nylY1tXNcWNN28IRIM9/AhoKcXsTqMq
kAmnr2ZdrUuhmH8W/W+ogrVhsfYV1kQZcSPN3khfeehBxa2Rw2oLBF5i1yIk5LlJ
GRzNkIz1yL+9WnNcmyCaGQqAuqNynDPqrwc2VwPWz2YQFsfySCkU65JCgtkYuIk6
3ri0s+TUWhLtMr8JS9cDC95wweVIAsvHWUiOAuzZqQ/PLTflI1dIucJP0/tFea4L
6g3KEjX9L19xD6Cv+69CFzT9sRt7C2vp4vJJLkHWX6t2AocPWj7Mm3QEyJxD+r3W
UIztRbZgVeBBHnkHTPW4
=Y+n8
-----END PGP SIGNATURE-----

--yapsC4sTCx4mg1sJ--

--===============3240870523672474803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3240870523672474803==--
