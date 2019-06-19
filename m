From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: Intel: sof-rt5682: add MCLK
 support for BYT platform
Date: Wed, 19 Jun 2019 11:48:31 +0100
Message-ID: <20190619104831.GQ5316@sirena.org.uk>
References: <20190618181539.9169-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3474689786432206818=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F3D8F808AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 12:48:37 +0200 (CEST)
In-Reply-To: <20190618181539.9169-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3474689786432206818==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SLvi8k+ew82wFfnH"
Content-Disposition: inline


--SLvi8k+ew82wFfnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 02:15:38AM +0800, Bard liao wrote:
> From: Xun Zhang <xun2.zhang@intel.com>
>=20
> The sof-rt5682 machine driver currently uses BCLK on BYT/Minnowboard
> platform. The MCLK signal is available since the Turbot revision, so
> enable MCLK on BYT/Minnowboard Turbot platform.
>=20
> Signed-off-by: Xun Zhang <xun2.zhang@intel.com>
> Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
> ---

If you've got an ack or other tag for a patch you should carry that
forward to new postings unless there's some reason to remove it.

--SLvi8k+ew82wFfnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0KEv4ACgkQJNaLcl1U
h9BekAf+Kdpq1fuCR3RmHbadwWkKbu1kEwnn3loLqguUmgjSf3hFieDhoBX36VPI
ByM1pyv66P5nZri7y6WlQkPVcu0wwh9akqYN9wPQHJW8WQx6M8i55ghkiy3M/Mz8
2fhQuMFIat8RR6uKXxOuHfHiIfF6fl1m03uc2vj7tymVivpq653vgOo5cY6N69AH
+dAOLAscubwfaY0g5OhOwvP/uMkx7Mauvr1qVim3zGScTuIO30jFDyAe8ulFiK34
Ykn68uxHdXVmt/7QaRN4w7Rbp/lXnMnAyp2Ksqdb+23mbDoLH3oYSVcYctvgt7h6
C0uKHhY/a3W91CYjI8R7WiX9j8bUDQ==
=vLU/
-----END PGP SIGNATURE-----

--SLvi8k+ew82wFfnH--

--===============3474689786432206818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3474689786432206818==--
