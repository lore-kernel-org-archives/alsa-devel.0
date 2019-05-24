From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add a debug log to track DAPM widget
	power up/down
Date: Fri, 24 May 2019 12:29:31 +0100
Message-ID: <20190524112931.GB2456@sirena.org.uk>
References: <1558684467-11333-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2102980459712228591=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D274AF806F7
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 13:54:00 +0200 (CEST)
In-Reply-To: <1558684467-11333-1-git-send-email-bgoswami@codeaurora.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: bgoswami@codeaurora.org
Cc: alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============2102980459712228591==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 12:54:27AM -0700, bgoswami@codeaurora.org wrote:
> From: Banajit Goswami <bgoswami@codeaurora.org>
>=20
> Add a debug log to help track widgets being powered-up and powered-down
> by DAPM.

We already have huge amounts of trace available via tracepoints and
having something on by default in the debug logs seems like it's going
to get very verbose for people who aren't specifically working on audio.
What's the advantage of adding dev_dbg() logs as well?

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzn1ZsACgkQJNaLcl1U
h9CL6Qf+P1bE2wDz1Z+mFlBUSWst8Df7vmXu/fK/uO0xkPH0B9Jw9fRe48G5RHeK
EW37C6ORAGvJrqtTHJDJLw3Uarqu8o0S9pS8Y4/xye+B9RYtZDj5Poj4czl/O5ZL
6gW1NzFlt64Cn0rLuvw92Pu3pete6jtrIf3p2Uzpr4/YWwo20x2879MOaZy/27hA
7VDo1X1TZ/wYGdsBMj7y0VvkCaYsqFkPe0N3FocMA1Xpk7C/8zFRJym+zpfSMkAR
fqwyz1xOxWmfxhduLL4rrZqcuK+9LmT44MzZgc9eu3BJz8BknXMmBWcqhtChWgzs
GdeMtNjhcqZhkFXH92+IWuz708Sklg==
=O7zi
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

--===============2102980459712228591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2102980459712228591==--
