From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 08/12] ASoC: SOF: ipc: fix a race,
 leading to IPC timeouts
Date: Wed, 5 Jun 2019 12:34:20 +0100
Message-ID: <20190605113420.GQ2456@sirena.org.uk>
References: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
 <20190522162142.11525-9-pierre-louis.bossart@linux.intel.com>
 <20190523063433.6zuwdlt4vzw6urxj@debian.ka.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8086920979213112540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A104F808E7
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2019 13:34:23 +0200 (CEST)
In-Reply-To: <20190523063433.6zuwdlt4vzw6urxj@debian.ka.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8086920979213112540==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xPlWqmdJYj61cSlc"
Content-Disposition: inline


--xPlWqmdJYj61cSlc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2019 at 08:34:35AM +0200, Guennadi Liakhovetski wrote:
> Currently on all supported platforms the IPC IRQ thread first signals
> the sender when an IPC response is received from the DSP, then
> unmasks the IPC interrupt. Those actions are performed without

Please don't send new versions of single patches in the middle of a
series, it makes it really hard to follow what the current version of
the series is.  It's better to resend the whole series.

--xPlWqmdJYj61cSlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz3qLsACgkQJNaLcl1U
h9BM/QgAg4zzmQfbPs0RSTstn6Cv+Kxkd7F/3BLjBozmaQSInhw9rKQeZTmHPyd2
D8UsXW/HbhA4DvY+0nkGBbD+ULpzxXSC1XfjfAAqd+M9/39yMSWJBd7QBkhm33QL
Eh5KlNeX1DirL7CZeQ39iK8PfcojDIfELOKiPNu7mYstbt5Y/6jLzonemcQYwVQ+
y25/1fcmmxSVYaJ7sieSURIL579HT32nnG/olbvaFfyHveijqJ2F4v3RkTBq5QZp
DQoFA/34DCE0s9LJnvI4XV5PH2hSouYFd2suoMY7CDLy3wygoq16AE+vpVZ26EI+
lQru4olf586Ystsw+esVOS3268MUBg==
=7GCB
-----END PGP SIGNATURE-----

--xPlWqmdJYj61cSlc--

--===============8086920979213112540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8086920979213112540==--
