From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 0/7] ALSA: jack: Refactoring for jack
	kctls
Date: Thu, 23 Apr 2015 19:18:22 +0100
Message-ID: <20150423181822.GA22845@sirena.org.uk>
References: <1429756366-22520-1-git-send-email-yang.jie@intel.com>
 <s5h8udjko4m.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90551F692@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4728014083069263593=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79761261AAB
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 20:18:30 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90551F692@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tanu.kaskinen@linux.intel.com" <tanu.kaskinen@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4728014083069263593==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tmTZLG6vUqJL4TmU"
Content-Disposition: inline


--tmTZLG6vUqJL4TmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 01:45:07PM +0000, Jie, Yang wrote:

> Hi, Mark, per my understanding, we didn't create specific kcontrols for
> each ASoC jack, now, my new change reuse the jack pins' info to create
> these kcontrols, which can be seen and controlled from upper layer
> (e.g. PA).=20

I have not been keeping up with this series because it's quite large and
there have been many revisions in a short period of time, along with a
large number of other substantial patch serieses from your colleagues.

--tmTZLG6vUqJL4TmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOTdtAAoJECTWi3JdVIfQiWgH/Ao2qCX8fhyG4v7kZhnA+xRa
ii0QQn3rgFaxIDHyy6S3YpfD2mQkkzoCF1LNF5+gU3aABAe80WL/UjlsG8C0gQZ2
4NvcZ3GqcpbwDL+aPd4yUBegy2z0TkF3KEERFhgaFV+yqkRYy8Kt8mQl5KDP70oP
YmJNrzPY2QrvispNbJrlfx9bCgcqWhZZRJ7Ayj+mcHVG/XjfvLXN42+Dp3PxVD/t
v/T/UqpWJgWrfnO3W0dtC2M/VO8JZqjSluLY3GPgncXOqIaeXG849Dw+9LCdXWYU
f83DpiSKQ6SAZYillB8n7Yk+FcuEemMFdugu6mB/qVjbGv3Igrbh4RyZglEIXYc=
=R2YF
-----END PGP SIGNATURE-----

--tmTZLG6vUqJL4TmU--

--===============4728014083069263593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4728014083069263593==--
