From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/31] ASoC: tpa6130a2: Use WARN_ON()
	instead of BUG_ON()
Date: Wed, 6 Nov 2013 10:18:54 +0000
Message-ID: <20131106101854.GL11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1226059242892016833=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F4F261B00
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:18:57 +0100 (CET)
In-Reply-To: <1383673218-18405-5-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1226059242892016833==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mit9XoPEfICDqq/V"
Content-Disposition: inline


--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:51PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSeheLAAoJELSic+t+oim9508P/ilsJCd9DP1ihWkqHXJ75tbU
NTPWyW9eN4E9tVGt2uHQtFKWF/gD3Oyxe32uGGUO2cqLaqK9e+6uNEqWwjRWYycS
3EH6qVPU1r1ouf3JzulN3Quepgb1ilXkfsyxkbOVaxYsB5Y+8I996uKb1U4NFvb4
oOtiqu+bb2aOS9JaBJTOiQJuqMYFLNdYqoiI1VZgAvcLSCdpYup+B+rfzryQ0VpS
g7AKII/SZTna5tTrriVLeacW7j2mVO8QwDgwHG9qKsF3q3fQ30KBD0PVCZV18bix
hIRrwaNhsWZTrfmgIKEvfgjkKUtltvfNIo5zo2jf6NUYV2iTL7nz3OSw4MpnnHqr
jlUS+MwXCezIKs+3Q9n8GFWV4brcjJ5qET0oFjVuDduraytllBzrpbY3S95S+2pQ
qTh4jaVdoMz0J8Whtls+DT9/nYiM/EtONyqpx0ZjTo5GYPf3AuVmZ3KTeCdK3beJ
AWAPGK8g3X0TOmaahTbNaXoDa5YzNfUE+MdskNLf56IE8GLGezFV/MDS9vZX67Fs
V0o1z0lydrTiXf/1Ox7fNoZehfrNSTPLTVeKqJfth9ELFOC4onmMVIai26uXn5qx
OndTeLiJ6V5Qs/bx1k68RBUuoIs9/xE9zNaxh+9bwkwId0g1yvmFquYifSp3gPMC
bR5uakGDtYFwlQFqVsZB
=12ty
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--

--===============1226059242892016833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1226059242892016833==--
