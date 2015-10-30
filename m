From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 00/17] ASoC: Intel: Skylake: More fixes and
	updates
Date: Fri, 30 Oct 2015 17:04:38 +0530
Message-ID: <20151030113437.GA21326@localhost>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
 <20151029033434.GA31066@vkoul-mobl.iind.intel.com>
 <20151030005025.GM28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7297822355650669500=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 52A92260410
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 12:31:13 +0100 (CET)
In-Reply-To: <20151030005025.GM28319@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7297822355650669500==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2015 at 09:50:25AM +0900, Mark Brown wrote:
> On Thu, Oct 29, 2015 at 12:34:37PM +0900, Vinod Koul wrote:
>=20
> > Jeeja found two more fixes for this so I have appended these to the last
> > patch. First fixes bit format on SSP port and second fixes the missing
> > machine entry required as BIOS doesn't have that
>=20
> > They seem to appear in this thread so easy to find :)
>=20
> Please don't send new patches as followups to something in the middle of
> a series, it creates confusion trying to understand what the current
> version of the series is intended to be.  Please resend whatever you
> want applying as a separate series.

Okay will resend now. Since they were dependent I though way to ensure that=
 was
to append to this one...

Thanks
--=20
~Vinod

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWM1XNAAoJEHwUBw8lI4NHzIoQAKDXAKnHVYRNA0jTy37lIUM2
wzD4XV5/ZWrP6cYUxGpvmAtfJ8Lli7BlyNZqPCn5npLN20OvUzUUraa3hUD63sPr
t1rw+cInQtuEpJ/VV6C0CTolK889omUphZyzll8V4ygk6chaCQjtE6mk/hXCoKzN
x3v80efqjTX7JYPm12VircTq5PZ2n0/6M0cnJYoid3iygTbUFlBNulfldoAyImv+
9xm+nfs4nxYqmHM5yrLVja3EfvICzwNcnfCIqWggL8UdDijL3xnhz4z04MF4fj7Q
PyyHLhOULlV3798bMvZZogXYpGUPz8BAJOgNn7tJ1tbl7sIMF7KQwc7+pNJ5xIli
3slHVClcORx+fFVzt3gY8QJHYDTnHLEJ/X48bJl6MzdkQcSqZ7kLrAgpcJvKC3KW
Qryh9yQpTMaB8Gi9A+HyF+uiwoSO7TOnPU8+KSY4GVF6PlHciEF+cc2sgV1cROGL
nXhXm8bguKASY+kdtcmd5aJAY3IcMoZOgLPZ1uNUZ72w2+I2yGzRB1vbJfaKot7h
MfTjWk9f7ePDGlLQQLPbHjn6RR+YE4IImkYRi1UL6hADOIbWZWmYX8oVQ6q+uD1y
lTM3NweAqrkIuTJgSi84pkK/03Z+/foEtTs9uTu90lvd2dD/mDqvPHNymKnhJ2kP
L1xLwWSRLlvCLwClxj2J
=dTWE
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--===============7297822355650669500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7297822355650669500==--
