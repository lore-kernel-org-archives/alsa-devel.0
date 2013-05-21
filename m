From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Tue, 21 May 2013 13:18:49 -0500
Message-ID: <20130521181849.GG1627@sirena.org.uk>
References: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0374721238277582623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B6BB261A96
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 20:24:09 +0200 (CEST)
In-Reply-To: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Graeme Gregory <graeme@openmoko.org>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0374721238277582623==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRy5AYMdKszmZQyZ"
Content-Disposition: inline


--yRy5AYMdKszmZQyZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 18, 2013 at 08:25:00PM +0800, Barry Song wrote:
> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
> we don't want everyone to have a seperate codec driver. anyway, the
> feature of Bluetooth SCO is same on all platforms, so this patch
> makes the DFBM-CS320 driver become a common BT SCO link driver.

Applied, thanks.

--yRy5AYMdKszmZQyZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRm7qGAAoJELSic+t+oim98TIP/jLbLobpS5fcInLqB51Sy+/Z
O779ZzoQHdCny6BLIUPkkRaej7pSf3yvu3ZlpUzdqKR35I+zuWil8AUQ92D70aTh
k/TgC3VUXTEjhejmlDj054fhZhGY0ESuSUQmTxIJZRFwLrpTvOUUpbuQa1hUSHSI
4iLW+zZdiVO0dzdqbcbwdkqjzihs3tHe4nlnY3VJKpEOCQzTtq7f5P2PK7NOfvrY
HwlQ568cQCLyr8xzamSsiGzBgcYWLx7e2f0Z5tFaBAuKOK4ssrOXG2+HvvjRPYCs
ajuEewlPejgLLCDLDQtU71z1NqSguG1/jyoeH1lxMaHrO9Inwad7S7nB8PqirzQ1
jfoANOdbfTXRthacHzEhcpzi+9/yEGcUMwGnaLir1x6KJRN0bX+fdU30XhcjfxPl
Q8USD1k4DhGv7GgDMDo5nukMfll/xnwwIa7B1DMqGzkw5eb1CtLvRGYGaMbFYmPl
gzmO1Qcun88lDLFS11Oi3FjvTqD36ufDXBRqSEtFEdZEYB0ZS7Wv3awgTZUvSUXa
MGUKPpyBKGBoDb8qBEVWSu6R+/aYsVeUzbIE31J0QjqfJeRlOjy/Ts7Ik8wCTMh2
/78/7r0pdds6fSIiLMfMkAZAkEv1Wdj8UXJmWeigoxTa48u9Gr+3KFm7h+yMsVJY
AZJdMIC6k7zBY4puXK26
=bbXW
-----END PGP SIGNATURE-----

--yRy5AYMdKszmZQyZ--

--===============0374721238277582623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0374721238277582623==--
