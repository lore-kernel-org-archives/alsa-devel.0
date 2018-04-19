From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/3] ASoC: Add Multi CPU DAI support
Date: Thu, 19 Apr 2018 12:12:39 +0100
Message-ID: <20180419111239.GA27188@sirena.org.uk>
References: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8156440276146846027=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2795A266E30
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 13:12:50 +0200 (CEST)
In-Reply-To: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8156440276146846027==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 03:19:16PM +0530, Vinod Koul wrote:
> As discussed in [1], ASoC core supports multi codec DAIs
> on a DAI link. However it does not do so for CPU DAIs.
>=20
> So, add support for multi CPU DAIs on a DAI Link by adding
> multi CPU DAI in Card instantiation, suspend and resume
> functions, PCM ops, stream handling functions and DAPM.

The main reason it's taking me a long time to get round to reviewing
these is that they're big, invasive core changes with tiny commit logs
that I'm going to need to go over in great detail.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYeaUACgkQJNaLcl1U
h9DpZQf6AitNrUvvHJa+JUOjM2EH3qfr/KKgg1KuEzZIK9A7JwblvjD19Ou9Ys6v
RZ+NdrlMH3QHw2sP92AV0tV+AbAZZStjl9W+ydNmRaCKaklRVElQCHrMGSlOxtzw
tpgaO/BhEiA6w8L18FHAwmB9ux4KXG9HmsgOkzcHxHCwfZt+XMVyTyBi2yPgohU4
RZ7LBEldCB28xzEhfV/ZyF1Za1JG+T3KL/KBRqWyBQ7FTuCfAMwX5kC5P4mVtaTu
WnYCTkvYPFNyDK2unil/qrkt+3gJES+v5I79/aKwyWFNohimxwFBTWAUmeul4J6T
OwZojY4XPlExIIYaWuCTbvjbpufkVg==
=ZEd0
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

--===============8156440276146846027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8156440276146846027==--
