From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 20/31] ASoC: txx9: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 10:35:20 +0000
Message-ID: <20131106103520.GB11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-21-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4591122811767573021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 09F0B265158
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:35:23 +0100 (CET)
In-Reply-To: <1383673218-18405-21-git-send-email-tiwai@suse.de>
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


--===============4591122811767573021==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OJWLbGElk4npXSe3"
Content-Disposition: inline


--OJWLbGElk4npXSe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:07PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--OJWLbGElk4npXSe3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehtlAAoJELSic+t+oim9s2IP/35Xqbz4129rCJr5vYJhWF3H
6mVW/X4SmgXmHtCmR3/EOaTngqdwXifTkRf0wAXEwf9S4ez5KX/ovctW4NV9IbvO
PG2w6iLLR7Ee0twE6GGB3Wml9dR1c9exZHSCNHA0MUfn30VVCQ9VqRuvaO7Elicf
bR46bxL/A9Fv8QKfMuyaLN1WFNvHZT7aKFDZyj9jvRUAsyo0qgrOM1wzGqpn7bFF
rjk0RoDWXjR1ya+lnF4q7724Oz72rISF7jGVal0tbLOkQhVPxAPF2BBJVLnjLmHI
BTCb+e4WJuLm8i44CgqKvxw2J4gD4LfrTdIOubWTqV0l0SQvMwvCFMjUmsK5cokp
mUyy31iW+xnkAYbXEVD8eSArdw1zcLQEIeo+fWrMxG7QrQnAMN+uaxYmQ5cFQ1kk
z01cZOmFuVNvxRE2nk/KMlN52WbZeRAgl6w+TOiMkfbugWwCsX+seJFP6iAy/RzB
U3S0Ktt3x2hYnnYwxzqWTUDquV033GqdIokMaqGKUeuyqpc85iKu9JTK2mDwD4Im
ordWcmyQJeGD7mp/Am94kfLQgrotaB8QPTCfkgAoLcypEtNBRRfAlXFq37zWY8Dl
JSuJfDuyA5GRjPdazX+K43fKDrChvvxx0mW/lxz/zO3p509RTIKmjBSwuulKD6H0
HNluEurT9z1q739w8VaW
=9seC
-----END PGP SIGNATURE-----

--OJWLbGElk4npXSe3--

--===============4591122811767573021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4591122811767573021==--
