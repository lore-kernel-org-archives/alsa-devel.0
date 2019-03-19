From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/13] ASoC: tlv320aic32x4: Fix clock
 activation on bias level change
Date: Tue, 19 Mar 2019 15:33:47 +0000
Message-ID: <20190319153347.GH5514@sirena.org.uk>
References: <20190319033756.20616-1-nh6z@nh6z.net>
 <20190319033756.20616-10-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4532221793161858240=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA639F80791
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 16:33:50 +0100 (CET)
In-Reply-To: <20190319033756.20616-10-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org


--===============4532221793161858240==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 08:37:52PM -0700, Annaliese McDermond wrote:
> The clocks are double-disabled when they are first coming up
> because they are already off when it first moves into STANDBY.
> Check if the state is already off and leave things alone if
> it is.

This looks like a bug fix for the existing code prior to the series -
changes like this should be put at the start of the series so that they
can be more easily sent as fixes without having to wait for the next
merge window.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyRC9oACgkQJNaLcl1U
h9BT/wf+KLxRwMqbPp3N5bg9x0UKm7hTcAd/Wuh6pUdnakpetHH0m9GgczG/pE8k
MTi4KhjRajQMhH/fuGozqhWBF+fF5gEnDlambA06PNxU5ts57hysMKczbNjVJodt
Rn8rcZLswCow402di4J/MdoAAq4mgwxeHmBDBi9q6DTEuMNJTrSeteVLfE+MEzSY
NAOWK8MW1ezkGt/1j8t0p9gmdDVc1Lcxe8o+LZrBMsOZV8jf8+duh1ZqrrQuS0vs
9700QFUAX6bW6wNa6q6Im1Dxz6zPo0ZXwpnhlCyJ36k5t0RDN4EX4qdDq0+O2Ih2
aacrDoG4E6FV0aPDcobl7BM13WMhrQ==
=N7rX
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--

--===============4532221793161858240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4532221793161858240==--
