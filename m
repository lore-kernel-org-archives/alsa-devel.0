From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] create driver symlink in snd-aoa
Date: Mon, 04 Dec 2006 09:48:06 +0100
Message-ID: <1165222086.5553.51.camel@johannes.berg>
References: <20061202101445.GA15619@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1412777601=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4ED61165
	for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2006 09:48:11 +0100 (MET)
In-Reply-To: <20061202101445.GA15619@aepfle.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1412777601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zQR0taO/ZMJZ67YYZml8"


--=-zQR0taO/ZMJZ67YYZml8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-12-02 at 11:14 +0100, Olaf Hering wrote:
> create sysfs driver symlink for snd-aoa in /sys/bus/aoa-soundbus/devices/=
*/

Looks good to me.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>=20
> ---
>  sound/aoa/fabrics/snd-aoa-fabric-layout.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> Index: linux-2.6/sound/aoa/fabrics/snd-aoa-fabric-layout.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c
> +++ linux-2.6/sound/aoa/fabrics/snd-aoa-fabric-layout.c
> @@ -1107,6 +1107,9 @@ static struct soundbus_driver aoa_soundb
>  	.suspend =3D aoa_fabric_layout_suspend,
>  	.resume =3D aoa_fabric_layout_resume,
>  #endif
> +	.driver =3D {
> +		.owner =3D THIS_MODULE,
> +	}
>  };
> =20
>  static int __init aoa_fabric_layout_init(void)
>=20

--=-zQR0taO/ZMJZ67YYZml8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFc+DG/ETPhpq3jKURAofWAJsH01FLVCtXsgrAnHgLrLe1KtW36wCfasis
WohFOmTA3V/BTpTU4xtVI/Q=
=R589
-----END PGP SIGNATURE-----

--=-zQR0taO/ZMJZ67YYZml8--



--===============1412777601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1412777601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1412777601==--
