From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake:
	large_config_get overhaul
Date: Wed, 7 Aug 2019 14:28:59 +0100
Message-ID: <20190807132859.GE4048@sirena.co.uk>
References: <20190723144341.21339-1-cezary.rojewski@intel.com>
 <20190723144341.21339-3-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7185630423781472824=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B40BF800F3
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 15:29:06 +0200 (CEST)
In-Reply-To: <20190723144341.21339-3-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7185630423781472824==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 04:43:41PM +0200, Cezary Rojewski wrote:
> LARGE_CONFIG_GET is among the most crucial IPCs. Host is expected to
> send single request first to obtain total payload size from received
> header's data_off_size. From then on, it loops for each frame exceeding
> inbox size until entire payload is read. If entire payload is contained
> within the very first frame, no looping is performed.

This doesn't apply against current code, please check and resend.

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1K0hoACgkQJNaLcl1U
h9D2Qgf+KlTV9j2+wgO4G10ROipBPUMRw24G4bLFMCR+SOUqioAl0Xn8QdCYjZpm
Y1tse3pfeCO2YVv3Ws8MSOCpJliRE2Jia9qcxx1ELHHp7uOCirN/ZWdKrWOmhdkU
4PfZNkRAPHofntv/qPqiCPciXD3lbxEqDWgySGHvSLzbj79PCBW/ZbciMgCFdstA
DWbhyPNELpf4OlqHXYQ2pYD01WmDKf2m+55q7nT74fot5n8lCdVIuQizkzZLZXk0
LZ8WJypIUtlbM4lJeUMYm3/xVoS8r4cdP/zk+lHTl0/kP8HQLjR55J0PRG600EFx
CMpF49pYhGNe2ud9FSzAt15CJmET+g==
=AqUh
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--

--===============7185630423781472824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7185630423781472824==--
