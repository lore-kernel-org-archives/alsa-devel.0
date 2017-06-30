From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Drop invalid DMI fields when
 setting card long name from DMI info
Date: Fri, 30 Jun 2017 11:58:33 +0100
Message-ID: <20170630105833.ur4cf5ipowiwe4ji@sirena.org.uk>
References: <20170629035536.16056-1-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6977700149016649935=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C881266EB6
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 12:58:45 +0200 (CEST)
In-Reply-To: <20170629035536.16056-1-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, mengdong.lin@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6977700149016649935==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z4wlv4ethpdel5fq"
Content-Disposition: inline


--z4wlv4ethpdel5fq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 11:55:36AM +0800, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> Sometimes DMI fields may be invalid and so can't give useful vendor,
> product or board info, such as "Type2 - Board Manufacturer" or
> "Type1 - TBD by OEM". Including such invalid DMI fileds may create silly
> card long name. So this patch creates a black list of invalid strings.
> And if a DMI field contains any string in this list, it will be excluded
> from the card long name.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--z4wlv4ethpdel5fq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllWLtgACgkQJNaLcl1U
h9AcyQf+MsKmydh6gtrIPnsZk0Vh8x/r+/nw6Gc0nXwTdE6aon3eXJXUwewoWszk
Ba6civDNklQ/2E42y+RwwljrN1ioenU7Dyhj+MyoaNszo9fQQs4Ck/rIx9wd+6pY
0lGI9uEsuoDTpOWyxXLY1l5KL45aImqaM+k18RLLBTk70a0a8mazoWmbaORnoDQV
QS7A45x4hHCaOmGGuW8n//1fg0ybcRmRSqkFvCNbL25iqExAkFP+G1yn1JE/UgSs
rAW4Rq5068m/P+N9qC1FG8kUisr3sKYatOs19mZ1kjpAQFsVRM92Ye6wNaB8bxsB
zjrVxuCfkDbVyMOk8/8E3DEEGXjKGA==
=5YrB
-----END PGP SIGNATURE-----

--z4wlv4ethpdel5fq--

--===============6977700149016649935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6977700149016649935==--
