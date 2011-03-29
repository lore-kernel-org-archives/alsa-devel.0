From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH alsa-kernel] snd-hda-codec-realtek: Add
 quirk for Jetway NF92
Date: Tue, 29 Mar 2011 11:10:09 +0200
Message-ID: <1301389809.15348.3.camel@mattotaupa>
References: <20110328184307.GJ29800@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3603274404272215771=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FB9E24387
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 11:10:12 +0200 (CEST)
Received: from f053045115.adsl.alicedsl.de ([78.53.45.115]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q4UwE-0002WJ-KR
	for alsa-devel@alsa-project.org; Tue, 29 Mar 2011 09:10:10 +0000
In-Reply-To: <20110328184307.GJ29800@alittletooquiet.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3603274404272215771==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zVzeleMmqwyO+1+NNBF7"


--=-zVzeleMmqwyO+1+NNBF7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Forest,


Am Montag, den 28.03.2011, 14:43 -0400 schrieb Forest Bond:
> The Jetway NF92 mainboard works with model=3D3stack-6ch-dig.

what did not work before?

To provide additional information please run `alsa-info.sh` [1] with the
standard configuration and with your quirk applied and attach both
outputs.

> Add a quirk to automatically configure the codec accordingly.
>=20
> Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>

Please make sure that your From line and Signed-of-by line match.

> ---
>  sound/pci/hda/patch_realtek.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
> index f1a03f2..6cc8378 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -18777,6 +18777,7 @@ static struct snd_pci_quirk alc662_cfg_tbl[] =3D =
{
>  	SND_PCI_QUIRK_MASK(0x1854, 0xf000, 0x2000, "ASUS H13-200x",
>  			   ALC663_ASUS_H13),
>  	SND_PCI_QUIRK(0x1991, 0x5628, "Ordissimo EVE", ALC662_LENOVO_101E),
> +	SND_PCI_QUIRK(0x16f3, 0xa625, "Jetway NF92", ALC662_3ST_6ch_DIG),
>  	{}
>  };


Thanks,

Paul


[1] http://alsa-project.org/main/index.php/Help_To_Debug

--=-zVzeleMmqwyO+1+NNBF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2Rod8ACgkQPX1aK2wOHVhqWQCeMHzvNy57VsmFFtODHUW3/qN3
O4wAn2ZxLt4jXe3I0jDUR+Px+nmoyTrj
=Pxs7
-----END PGP SIGNATURE-----

--=-zVzeleMmqwyO+1+NNBF7--


--===============3603274404272215771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3603274404272215771==--
