From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Fix sync function
Date: Wed, 24 Sep 2014 09:58:24 +0100
Message-ID: <20140924085824.GA16977@sirena.org.uk>
References: <1411092979-19260-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8933790967863670104=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0B8C2610B9
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 10:58:40 +0200 (CEST)
In-Reply-To: <1411092979-19260-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8933790967863670104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 10:16:19AM +0800, Bard Liao wrote:
> We try to write index registers into cache when we write an index
> register, but we change the reg value before updating the cache.
> As a result, the cache is never be updated. This patch will fix
> this issue and also correct some incorrect default value in the
> cache.

This is two different fixes, you need to send each one in a different
patch - there's not any code overlap between the changes.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoevAAoJECTWi3JdVIfQ6WQH+gJxhCpSl5dDnUpnKqV1wauS
ve6f3pp45lPxPhsLKr8QbibcAn5M3v1gWtcqxNEhjYAXCLJyoUg4mT9V0Vt6Bs7w
7jwK4+KNZS5iayNT3U7GisoMlBKsUybdUrq671AYcj++RUmF/GfbzHBDRODNkFWf
cI31cJs9CE/FGZoSOJARGO50Sw3CaM8rRc7BG9H9Lz/hEE+54lpUxvXkEkr6fWRM
Ow734NAgD9rTHw8SkTsN9WjPgl6on0/dd11HZg6T2OeWM2VQao2QE1tz4oNVaGEf
q6DIsSkuajywTi3rTFQXD2v24Wi7dAQQLmzKz5CqHLvHDE+PZpRu/xI4iUVukPo=
=9RIk
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

--===============8933790967863670104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8933790967863670104==--
