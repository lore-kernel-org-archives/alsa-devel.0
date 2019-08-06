From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/28] ASoC: soc-core: set
 component->debugfs_root NULL
Date: Tue, 6 Aug 2019 17:54:30 +0100
Message-ID: <20190806165430.GE4527@sirena.org.uk>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87y3072iib.wl-kuninori.morimoto.gx@renesas.com>
 <f7a47bad-b680-cbd2-2341-7be081ac4b2c@linux.intel.com>
 <20190806162258.GD4527@sirena.org.uk>
 <d80703b2-be84-608d-0048-1f24a1fe7ebd@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2662377586668074435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98378F800F4
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 18:54:33 +0200 (CEST)
In-Reply-To: <d80703b2-be84-608d-0048-1f24a1fe7ebd@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2662377586668074435==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2019 at 11:46:28AM -0500, Pierre-Louis Bossart wrote:
> On 8/6/19 11:22 AM, Mark Brown wrote:

> > ...with this, the two in combination add protection against a double
> > free.  Not 100% sure it's worth it but I queued the patch since I
> > couldn't strongly convince myself it's a bad idea.

> I was only referring to the first test, which will be duplicated. see bel=
ow.
> The second part is just fine.

> {
> 	struct dentry *child, *parent;
>=20
> 	if (IS_ERR_OR_NULL(dentry))
> 		return;

Oh, I see it's got a NULL test in it.  TBH I don't think it hurts to
check in the caller, it avoids someone having to check to make sure that
the NULL check is in the function.

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1JsMYACgkQJNaLcl1U
h9DuJgf/TuotBtghx6a4Qp7kdbnrgurCNu5qlYUF+WIJf0XHQQEk0IHOtFDALJrG
Y7q/s9ea7VPPcr2/Jqao4Y4dalSuRguobLBeQg4bG+CC/kFb9L2DTwzxkflgmebn
BDk4l+uEqzyea0s/x50b6c2rlf1OrpWElllgqF63okJzFYfhw7usLkH0+AnhYWJA
Fqo5uBzx/pY0N/QXTQbzdYpkMwobrp3GKtaexZ3/w4kt+GFPWdgQsoH0N42CaY4f
jGYR9AN/tCQdO+v6Md+wnz/qVud9s0KwJiIKIHWZfPbm6vi6o9o6i9LgqUY0K5Xk
Fep26C/sZIkDlfX0sX0v+9vbmLuf1A==
=9Es5
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--

--===============2662377586668074435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2662377586668074435==--
