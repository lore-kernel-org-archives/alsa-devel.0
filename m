From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 0/4] Support ZTE zx296702 SPDIF/I2S
Date: Thu, 4 Jun 2015 17:16:13 +0100
Message-ID: <20150604161613.GI14071@sirena.org.uk>
References: <1433424887-11694-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1929221332646631944=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E5E726061E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 18:16:27 +0200 (CEST)
In-Reply-To: <1433424887-11694-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: jason.liu@linaro.org, alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1929221332646631944==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CmWxRWyFvh6D3sQF"
Content-Disposition: inline


--CmWxRWyFvh6D3sQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 09:34:43PM +0800, Jun Nie wrote:
> Changes vs v4:
>   - Fix devm_zalloc argument issue in SPDIF driver and static issue in i2s.

I already did the devm fix by hand and I applied some fixes from
Fengguang for other issues.  Please send incremental fixes for any other
issues.

--CmWxRWyFvh6D3sQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcHnNAAoJECTWi3JdVIfQl38H/2TIoz70+dJ9Ba5/yIACvW4r
xwmV1rknDnuGqa604qYbp2ZlQ/pbpcekxT/lIYUxet1ZHr0yFu8kgPyKpvBenWBQ
OPESDfKej4JMiaRvwacuCd7f0gL9tN37FxQoTZOC0PdJxRy0KTMWNcq8ym1mI7Z7
dNRkM27pD4EzU0kYlE14MN4bau+yuLENagvPX3TZHM+m5uNUZA/5jKDV2At1OCOW
u8v6e9bNbtoBnlxEL6vVIrfFlXuoF56IOc1S2/XNF9xfmO47hVJJiJeK++yq1vFe
nmTAtGrLbJRBCVLEoE/wLx+iJMFSxO2I3uo0cFPn3Mk5VVV5RtxjjV1tviYj+OM=
=VYpJ
-----END PGP SIGNATURE-----

--CmWxRWyFvh6D3sQF--

--===============1929221332646631944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1929221332646631944==--
