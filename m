From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to
 new-style i2c drivers (v3)
Date: Wed, 15 Apr 2009 15:00:44 +0200
Message-ID: <1239800444.9071.5.camel@johannes.local>
References: <20090415142225.2bfd37f6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0847857901555129371=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A9921038CA
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 15:01:20 +0200 (CEST)
In-Reply-To: <20090415142225.2bfd37f6@hyperion.delvare>
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
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org


--===============0847857901555129371==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-w85SpofeRfo4bEvIEeNY"


--=-w85SpofeRfo4bEvIEeNY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 14:22 +0200, Jean Delvare wrote:
> The legacy i2c binding model is going away soon, so convert the AOA
> codec drivers to the new model or they'll break.
>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Tested-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
> Johannes, this is a reworked patch which assumes that the onyx codec
> probing can fail. It's not exactly clean but that's the easiest
> approach for now. Can you please give it a try? Thanks.

This works.
Tested-by: Johannes Berg <johannes@sipsolutions.net> [quad G5]

johannes

--=-w85SpofeRfo4bEvIEeNY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5dp6AAoJEKVg1VMiehFY08QP/1wZZeUbmRig8pLNDNJT0HVS
NsV2M3aVHADncVNzJc+Npu+BT7j5yxmgOCxGVCg/YnODNa2agh0lm4djRJtrBwaw
qrCYtyBwG+RWs/ERCBwjGV5rlgaZP6FqnvF47zByexzUyRWJ6YhFIYlQwx47uOyM
3/EJSYi6Naitd2q4wEI2lFMXgYvTxZ7q0bvsz6c6Wh/kRqtcy+QdIpgtzjzmHfCK
/RXggG2L/UGKfaaRrT+Now/XqAKWP6xCewN9NimKmeLKCohWGSHKk5uGdQwh4Xg3
K39aXZUVJFNBzpfmHtftN7Xl9P5i9At6zs5GgORgQBj5MxY0ODwEQUDlHyfNga0n
+GzSvQLfyNGfvcaUFOutB9NuutnQ/+xqKcgt0RACHDiXgc3X6ji4pcI0NZiYssd+
CoXtsQ40IO+gY8Mv1/hZ2np5tKseA8mnwHCN1qa913BfXpKOD7OmxXplabtEjM5b
zjmMwBIVzti/Uy9i93doyXNIBKzb5oPBq3jf74MllpUp6BqwJRsMZTg49ul0e8Bu
LPnooJbbj+Lpu2hFPQUsQ070RgkT+XtPFjewhO+j0wkbXu3SWy61Gubclp3OccTc
jkKN7CTpggAD7WOkryjTXzg2ao8lpe1ajZX3vSVGvQqhp9Odge65LHX3ChGWa9xI
Ayn+8g8EjM7Du0Z6oaXS
=O4uf
-----END PGP SIGNATURE-----

--=-w85SpofeRfo4bEvIEeNY--


--===============0847857901555129371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0847857901555129371==--
