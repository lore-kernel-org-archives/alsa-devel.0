From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: tlv320aic31xx: Don't call kfree
 for memory allocated by devm_kzalloc
Date: Tue, 18 Mar 2014 12:00:44 +0000
Message-ID: <20140318120044.GO11706@sirena.org.uk>
References: <1394982385.19788.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4230275927453840201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 994B9260202
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 13:00:53 +0100 (CET)
In-Reply-To: <1394982385.19788.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4230275927453840201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+OvhQd+MVTzxy63P"
Content-Disposition: inline


--+OvhQd+MVTzxy63P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 16, 2014 at 11:06:25PM +0800, Axel Lin wrote:
> The kfree call is not necessary, but we need to call snd_soc_unregister_codec()
> in remove().

Applied, thanks.

--+OvhQd+MVTzxy63P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKDVpAAoJELSic+t+oim9BJUQAIiL/72+5K/bRaOjh/iTkwtw
5DdEuO3P+XTPUhPP5cUBQSeOo2M4IuyvTiEaSoDdHdKPogM1PNboLw/Qhb2Ay+wz
m8qR8zObUdRsQltmWHLv0yjZaZg/YwNhfFKInyC/kB+JNHxGLGUskGUpFzrAZuy5
jNZ/QYEt6FboKM/Y0/SnLHheafqjcpYl+JK3AJzFHOfkf6K6+2WRyvH5Unh0KaOs
mGU+DSL2Vu7f7XyoX+COF3J9OgX2QoYDZQ0E7G756SqrQACCpCYH5S1dZQYFQMpX
mYKNdXqBxQFHPMtwDDXDcnflC6eTd9bN0g795S7KxO2+zlEnFGhUh0mTzgjPiMOz
SvD4lQ8rhtXmQY/1FYjfGw+1UzNx2gGHhDkWpLSpzsaJzV0cpedYavwt7HTf627X
3Ss3DyN0a4VgcN8s9RLn1Guskf37IijiUjKqtCKea5R/djBluOhp/SW3JlMkPHua
d70TTBPj/jpcDvlo8YqWg1RxhbmGw9m9mHP33RhkP2p/FgArynZ67ILyFuYqcfOy
wGzGwCwBxtNi7FK1dFPPhfm8J2pcRu9St/C5dAh0N2dcN65hmbYMiP5K+R91uVq8
9cQyBl9gH6+iVMOsAAsDZ4B+B9iXDsdWZ4GsIUTwNSkTGIMFk9gB2S30DjrpYs6f
Xpj3naeXVo57jLnWOXDT
=om44
-----END PGP SIGNATURE-----

--+OvhQd+MVTzxy63P--

--===============4230275927453840201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4230275927453840201==--
