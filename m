From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v5.2
Date: Mon, 6 May 2019 23:48:34 +0900
Message-ID: <20190506144834.GW14916@sirena.org.uk>
References: <20190506141144.GR14916@sirena.org.uk>
 <s5hr29b4qas.wl-tiwai@suse.de>
 <20190506144000.GV14916@sirena.org.uk>
 <s5hef5b4pak.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8938960786080265670=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66CFCF896F0
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 16:48:39 +0200 (CEST)
In-Reply-To: <s5hef5b4pak.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8938960786080265670==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwp4JDU+MaGmJm70"
Content-Disposition: inline


--pwp4JDU+MaGmJm70
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 04:42:59PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> OK, then I'll submit a few trivial fix patches for covering the random
> build warnings.

> In addition to the above, I see two others during my build tests:

> sound/soc/sof/ops.c:20:6: warning: =E2=80=98ret=E2=80=99 is used uninitia=
lized in this function [-Wuninitialized]

> sound/soc/codecs/da7219.c:2366:6: warning: unused variable =E2=80=98i=E2=
=80=99 [-Wunused-variable]

Dunno what compiler you're using but I'm not seeing those two, nor does
kernelci:

   https://storage.kernelci.org/broonie-sound/for-next/v5.1-rc7-328-g6455a8=
745ac1/arm64/allmodconfig/gcc-7/build.log

(same results there on x86, both using Debian's GCC).

--pwp4JDU+MaGmJm70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQSUEACgkQJNaLcl1U
h9DEZgf9E4Z1HuoUFnaYFrL7mCe8XJQiOdNkJW3bF9NgkDsygF2pKjuska1KAeFd
5RYvOGRDxSLEyKmWtW0M8C1Q2KQZLdoCUZ4Txe5hkLQQc4SAzHiuZjFfH5LTY7EY
jDZwh42cuQNLQnheIdfLaEqTzldJpnrpKz9PeudN519zo4Kz2CFpHUkH+vIyhpuK
F2LVEaAmC34lOQYD2YRBKzUR8lL0C2Q7FOfS4hVNODtGj6JZsAca07/xNZcDuP8b
8EIXTeD0zySXIG/dmycHPCHDWiWUMxEVTr42QVWw24IR8ZaZeDVoaN5s93EsCKyO
j2vX+Ssn4ArM7NOebfRfGRY00dSj4Q==
=tkwL
-----END PGP SIGNATURE-----

--pwp4JDU+MaGmJm70--

--===============8938960786080265670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8938960786080265670==--
