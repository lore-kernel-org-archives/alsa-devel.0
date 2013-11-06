From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/31] ASoC: sh: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 10:35:06 +0000
Message-ID: <20131106103506.GA11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-20-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1951500154059386596=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 436DE261A19
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:35:09 +0100 (CET)
In-Reply-To: <1383673218-18405-20-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1951500154059386596==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jsn5+Lu/ZvzbAGtZ"
Content-Disposition: inline


--Jsn5+Lu/ZvzbAGtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:06PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--Jsn5+Lu/ZvzbAGtZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehtXAAoJELSic+t+oim9ehYP/AkC0KoFiEBR1ZI91dsinY+d
3L3p4UCk6TMNNfK7WCFr09dRUhXk+JOyuvL7mleFcajhtwrXm0R5Gb7rEn3XM9ta
sAMm6ZEOo1qEWAJ2jucWX8kojuahi5Z1xcpZmgxxFEwK3H+Gq5e0BBdRHYMYKLGb
MIIQKRnDl2Gi9ldrhuJ3ENVD53eyH2GBcP+rvbEN0mDGc0y7kMtHkBkGVW5kCEbA
rmdbYlotoScSB2qckBdwySn8xzTFkeFi4MbsU+XHROvHY7Vr0kLRFRc5p/8RtmBG
dput2QJGdpYIWCP9AY8j0/YIws4DTwQaR6uv+F7vXzTMtWTu+jH5YGSFaPIy4/rF
7HSvkJBL3SczNwuJQv3OwfeNpNJOg4KxrhfwFUkHvx52DZarrAGxJuduKD2/ru9f
AnFDJZvBl3C3uB/XxVpo+QUOn5B47JMoU9CEqTPtjOuPwDs5bFa00t/RVesJ/gsu
8Srs72yufVXR+c3nlcV6C0xztojaHAkvOcHGf9qJ8k/5rnF2X5bkrTA53qQpoMHy
uZ9aHVdH3a21SdBBJDOktDSlLSjMLyVCOIuZ//kxOANVxvFCzN8u9AYf23Sn2lQ0
8XwzH0qIHg4SkEVB1GJTOyEAwEQPgkURh8s1zL/HeLxbIm4gn4DsB+yMScUTvjzc
2XCGa6BpdTYOrjkbJAEr
=bIZk
-----END PGP SIGNATURE-----

--Jsn5+Lu/ZvzbAGtZ--

--===============1951500154059386596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1951500154059386596==--
