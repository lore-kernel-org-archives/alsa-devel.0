From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cAVS: add device_link to HDMI audio
Date: Wed, 10 Apr 2019 12:29:49 +0100
Message-ID: <20190410112949.GM6106@sirena.org.uk>
References: <1554686513-7770-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8766615126937636648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B28B8F89623
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 13:29:56 +0200 (CEST)
In-Reply-To: <1554686513-7770-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: libin.yang@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8766615126937636648==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Content-Disposition: inline


--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 09:21:53AM +0800, libin.yang@intel.com wrote:
> From: Libin Yang <libin.yang@intel.com>
>=20
> In resume from S3, HDAC HDMI codec driver dapm event callback may be
> operated before HDMI codec driver turns on the display audio power
> domain because of the contest between display driver and hdmi codec drive=
r.

This doesn't apply against current code, please check and resend.

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt06wACgkQJNaLcl1U
h9APPgf9GCuJOI2+xWIm3dtdbPPwNfINQxE3cAPG2RIHyTP9wCVuCQcM47Xfltd1
a9lUdrekMs38upk6fRjhjPT73UDltcov24tNLILC8BKpR1LP8Iw8dFCTXe9tuUAC
MZcTt6IQuZYltReoQ7dLHi/2K9OG5mHoZbpOULNNUj3aOJJOVz3P8Ij3tSDPN6kS
mH3b+uCISgyWWB+Ci5J6rTieWwgde55YbQL68WMl9aohR29MKih5eLxWCFhGBfD1
D5jN80eh9sstbPK40UOU7JKvqTNALARm9V5mAxpbRW7YHduWFIFnu5T5yGdcyzcT
TpgMy93PsIrWQrU/r0itq4athZd5uw==
=Jl0f
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--

--===============8766615126937636648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8766615126937636648==--
