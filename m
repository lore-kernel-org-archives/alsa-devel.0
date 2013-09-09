From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 6/8] ARM/dts: am33xx: Add mcasp0 and
 mcasp1 device tree entries
Date: Mon, 9 Sep 2013 16:27:42 +0100
Message-ID: <20130909152742.GN29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <a8dd2abf8c468f6a42557b2794d104d31da4649a.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3683518642109619885=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C0DD2650D7
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:27:45 +0200 (CEST)
In-Reply-To: <a8dd2abf8c468f6a42557b2794d104d31da4649a.1378738436.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: oku@iki.fi
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Pantelis Antoniou <panto@antoniou-consulting.com>, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============3683518642109619885==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jPcKFu7Fa0A6HrUo"
Content-Disposition: inline


--jPcKFu7Fa0A6HrUo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 06:12:17PM +0300, oku@iki.fi wrote:
> From: Pantelis Antoniou <panto@antoniou-consulting.com>
>=20
> Add missing mcasp entries in the am33xx.dtsi include file.
>=20
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>

Acked-by: Mark Brown <broonie@linaro.org>

I'd expect this to go via the arm-soc tree, the bindings are already
merged and there's no build time dependency on any ASoC code anyway.

--jPcKFu7Fa0A6HrUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLejrAAoJELSic+t+oim99RoP/A5Z7lQB5ITaPOXMTH/NE7bn
LEedLTFYKXBigEZ676UNc1dS2zsoMwSmF7A4snNVZsvN44eCpWk7WH8xVkN4Rjj1
zXaQ1xLKmL4+5SofLxA2lnCR+UJNfmyCuA54DGB9aYieVpHBXdSLSgfi6SM5E6zb
RzQtdVkpm/sA4bORHGDjIa9McNxunac8zNwHPNddLzntjzV5x70y/2Ceh+xEgYt3
eyV6yg71zqUtQT4DbMcNaMZ2JHdpO9zOsIVPVzmoJYMjWSUxYNwOIpI3j27jL9d8
MvTFPTkMMVIJRCQNaHopXXMWAmoAynPC2PXoDvSEn4RJGsH2FGR24JP74J9Yk9WO
APxCr+dJH68wrjO0Bf8dwhepW9KmD/ott/hz4iRywZZcsg7JHhvnWQcN3uyiHpfc
2Iu22m1GDi5MFTq+Tr8ZGOQbDeRou/amZRyfcmsUIo4BStDa3v+eFTSaXahMRNet
mugpuLWRUFfiWbzD+oxffGc4qXr6I2O0l887hnq/7JCmgYfP5dumhU+j59NrdPLt
dEBjuGlI0/8lbc/kLCgY8mc1AaDr3HUMV1u3QCKuON5hiCa4EFtbG78wAqPsEWzp
mQjPw+nNbxbflntmFmSlBJwlHBE0NgWPPnQr6Izl0yeDe+SP/wIeh2KVWGGqVx6u
dwdJYyy8ErddtT3dYKkU
=eyfk
-----END PGP SIGNATURE-----

--jPcKFu7Fa0A6HrUo--

--===============3683518642109619885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3683518642109619885==--
