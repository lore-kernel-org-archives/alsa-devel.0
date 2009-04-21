From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to
 new-style i2c drivers
Date: Tue, 21 Apr 2009 11:41:43 +0200
Message-ID: <1240306903.17388.14.camel@johannes.local>
References: <20090420225425.2a150a4f@hyperion.delvare>
	<1240261492.4632.21.camel@johannes.local>
	<20090421112921.373fae89@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3839915481360719647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id EF02224610
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 11:42:17 +0200 (CEST)
In-Reply-To: <20090421112921.373fae89@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Andreas Schwab <schwab@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org


--===============3839915481360719647==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-nrMTzKGHld4lDBFdObB3"


--=-nrMTzKGHld4lDBFdObB3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> > Have you taken care of snd-powermac similarly?
>=20
> Yes I did, see my patch "keywest: Convert to new-style i2c driver" to
> the alsa-devel and linuxppc-dev mailing lists:
> http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070884.html
>=20
> Would you be able to test this patch? This would be very welcome. I can
> resend it to you if it helps.

Cool. No, was just wondering, I can't test it, none of my machines can
use that (which is why I wrote aoa, heh)

johannes

--=-nrMTzKGHld4lDBFdObB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ7ZTUAAoJEKVg1VMiehFY7TsP/0Z4xG04Sm2WJz2tLnne1xlB
Ha8PgerkkM/8ivdwFZhKZRu1uqd69xxPjNOaP4bPjgczT15/AyEM6K7Vb1mdhfVI
RJOpDmOc87fIgcaKP0sFXhkNONCDzvCezErG/5THoCQGrNDf3CyXyamKPvHrYgyx
FJ11t1RlaJVlh/KoUN0bQ+zCzFlHSzYynIAjseJ3V5GA2K6AWoAGJ1N1F1Y/hlq6
buOtBFqgoncXH3AQQfcc/WBfQy6hKxqyp72CTxjR8JW/noEshSRIxbFxIY4ZhId/
RJoJgn4iBxGFM24CpwDyWQ8M4MRwFCROUR1HecKcE/ZOjHge5bztP+ngOQY48yCl
q4aIh0cwB+5RWPLxhqE/5LuN96CrGx1GIycZHaPobG1ci+V2i9cEDPNNDQJFjGFI
mZUy5H4hsvxrnLjoUAd0O+23BplY/iVjZqhYobGPbszJUUPfy/Lp1gg3esNkG7/4
5pTMfa2rdp2L1r3HDoriUBodvcbNTIeFLvMkxbJUlVz9/OzcIFYC+ROzed5IRymk
2Ul3S/B5Zi7ZlwA+yzKG3Uz9a/mLkOEUt+i1GZdGCHZzW8yn2xpvAqY1BqMOqFPq
/ntQHyxYWvt5FqUs6gLWeOK0Mwu43s+/5c6R4io5HSWwuHK2hNkeR8SN2w1gHCtE
TeBEpJgQfhoDtgfXg91i
=kzNu
-----END PGP SIGNATURE-----

--=-nrMTzKGHld4lDBFdObB3--


--===============3839915481360719647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3839915481360719647==--
