From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove unused dapm_get_snd_card()
 and dapm_get_soc_card()
Date: Tue, 23 Jul 2013 20:32:04 +0100
Message-ID: <20130723193204.GQ9858@sirena.org.uk>
References: <1374570745-32224-1-git-send-email-lars@metafoo.de>
 <1374583782.2475.26.camel@loki>
 <20130723173646.GL9858@sirena.org.uk> <51EEC3FB.9050701@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7808995941178806697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 520D3265198
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 21:32:09 +0200 (CEST)
In-Reply-To: <51EEC3FB.9050701@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7808995941178806697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tB3UQx9o7itSJcWB"
Content-Disposition: inline


--tB3UQx9o7itSJcWB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 07:57:15PM +0200, Lars-Peter Clausen wrote:
> On 07/23/2013 07:36 PM, Mark Brown wrote:

> >We can always add them back in later if they get a user.

> If there are any out of tree users they should just use dapm->card
> instead. It's much more simpler than this 'if (dapm->codec) return
> dapm->codec->card; else if (dapm->platform) return
> dapm->platform->card;' and at the same time more robust since it
> also works for dapm contexts which don't belong to a codec or
> platform.

Right, though my thought looking at the code was that the intention was
to also do a transition so that dapm->card isn't there any more.

--tB3UQx9o7itSJcWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7toxAAoJELSic+t+oim91R4P/1P8MeWl9xVE7oUeOjR6o9s9
OTAWc5ECma1J+Y2XCiURLP4y8/bGPeWwHfBUPCrGhQ6oRqebdGV4IckkLuj2akjQ
5ZbjO3Gim4+dhPxRTMXi9V10/yJ0uKlAvFn4yXVu9IxEX6+H9WrU6yR/k8Sy7d+D
XBO1Vpa/u/bd2r9Cf311Uat8xmJUFCj2upgLFrCEmhbipE3ZBLeApyMG4XdxgZre
R/CricQy0snSt7SbvbkoWOcX+34Y3y6xEs35sq8P0xsky+5XaumMCBMjy6gd5fQR
HvIS7oMbzc8syGFbQKRi6gtWKw8HbyQAKKDh3h5SmnU7/fvCB2ty2w+nLw2IXtD+
Klyz+/G1oGhpkz8POPX7/D24eTt7QMKO4dtDJ4rNxTnxoC4FHBPpiauL04k2srhz
SJIm0gYVcoL3lGCm1DkwiL8i//P8chiMwFVHfr911ZqlKPjbx9yuLRo+ItYvWQkl
1UGlVGaVXbpqWxYlnpak1M5d59jowNgx2eHGTNArjcQ3WN9qr14u9aGUZY7GmDAI
coHfTqi+BMlxQXuyJSW0BGZxCCuGtRVT7KM7eGutB975/fmrWpkHYygTAF7D11pw
ly1QDSiZyleuvi2vmHNTD/4wILf1PrvB+yYM53m9koee/NIvT85pjDG/PIhcIKRN
dv/W85Na9BiCcmyudPb6
=G2lQ
-----END PGP SIGNATURE-----

--tB3UQx9o7itSJcWB--

--===============7808995941178806697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7808995941178806697==--
