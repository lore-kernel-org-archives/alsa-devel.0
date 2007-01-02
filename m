From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] sound: aoa of_node_put and kfree cleanup
Date: Tue, 02 Jan 2007 14:12:08 +0100
Message-ID: <1167743529.13592.44.camel__1870.63659909672$1167743629$gmane$org@johannes.berg>
References: <200701021350.57816.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0243307809=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2FEB5243
	for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2007 14:12:47 +0100 (MET)
In-Reply-To: <200701021350.57816.m.kozlowski@tuxland.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0243307809==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rW6pTLpUqAYC6X5A8gHq"


--=-rW6pTLpUqAYC6X5A8gHq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-01-02 at 13:50 +0100, Mariusz Kozlowski wrote:

> 	This patch removes redundant argument checks for of_node_put() and kfree=
().

Looks good to me, thanks.

> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Acked-by: Johannes Berg <johannes@sipsolutions.net>

>  sound/aoa/fabrics/snd-aoa-fabric-layout.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff -upr linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.=
c linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
> --- linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006=
-12-28 12:57:54.000000000 +0100
> +++ linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2007=
-01-02 01:50:26.000000000 +0100
> @@ -1034,9 +1034,9 @@ static int aoa_fabric_layout_probe(struc
>  	list_del(&ldev->list);
>  	layouts_list_items--;
>   outnodev:
> - 	if (sound) of_node_put(sound);
> + 	of_node_put(sound);
>   	layout_device =3D NULL;
> - 	if (ldev) kfree(ldev);
> + 	kfree(ldev);
>  	return -ENODEV;
>  }
> =20
>=20
>=20

--=-rW6pTLpUqAYC6X5A8gHq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFmloo/ETPhpq3jKURAu0HAKCpstMghKAcQRj0bnPd/nhQsg1EIwCgpjHb
xYW5pMEBpvHsE4u1cYfaITA=
=GDsk
-----END PGP SIGNATURE-----

--=-rW6pTLpUqAYC6X5A8gHq--



--===============0243307809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0243307809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0243307809==--
