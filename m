From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] add number of periods constraint to
	snd-aoa [try 3]
Date: Fri, 23 Nov 2007 13:49:42 +0100
Message-ID: <1195822183.4149.118.camel@johannes.berg>
References: <Pine.LNX.4.64.0711231424280.5270@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7818549788348703688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 9637324656
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 13:49:49 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0711231424280.5270@sbz-30.cs.Helsinki.FI>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Heikki O Lindholm <holindho@cs.helsinki.fi>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7818549788348703688==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yUJkarJMVGbjNFk7onrI"


--=-yUJkarJMVGbjNFk7onrI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2007-11-23 at 14:25 +0200, Heikki O Lindholm wrote:
> From: Heikki Lindholm <holindho@cs.helsinki.fi>
>=20
> The aoa driver is not specifying constraints on number of periods, and, i=
t=20
> seems, it might end with a non-integer number, which it cannot deal with.=
=20
> Fix by adding a proper constraint.
>=20
> Signed-off-by: Heikki Lindholm  <holindho@cs.helsinki.fi>
> ---
> try 3: fixed coding style
>=20
> diff -r 1b54a8725ded aoa/soundbus/i2sbus/i2sbus-pcm.c
> --- a/aoa/soundbus/i2sbus/i2sbus-pcm.c	Wed Nov 14 17:07:17 2007 +0100
> +++ b/aoa/soundbus/i2sbus/i2sbus-pcm.c	Fri Nov 23 14:16:07 2007 +0200
> @@ -194,6 +194,12 @@ static int i2sbus_pcm_open(struct i2sbus
>  	hw->period_bytes_max =3D 16384;
>  	hw->periods_min =3D 3;
>  	hw->periods_max =3D MAX_DBDMA_COMMANDS;
> +	err =3D snd_pcm_hw_constraint_integer(pi->substream->runtime,
> +						SNDRV_PCM_HW_PARAM_PERIODS);

Personally, I prefer that indented to just after the opening
parenthesis.

;)

> +	if (err < 0) {
> +		result =3D err;
> +		goto out_unlock;
> +	}
>  	list_for_each_entry(cii, &sdev->codec_list, list) {
>  		if (cii->codec->open) {
>  			err =3D cii->codec->open(cii, pi->substream);


So what I'm not sure on... Why do we see the same behaviour with other
drivers? Same bug?

johannes

--=-yUJkarJMVGbjNFk7onrI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0bMZaVg1VMiehFYAQL+RRAAvp+TFlxC828JsQnJiqvX89MlPusb9O/Y
dgl6CDx/PtblTGSdaBtsHI6DcFMhb4qLFgaok298ZarlTeR+n8G8/NrcZ31lknzp
Ugs1WHaAIBNgNJXfXULOnZ24SfQnxD6eA3pFB/c9WD0dYTPgMIeuekAjJeVVSMhR
/oPe/yJAyw64wHSueFjeVFoTJLfMUcVqKNrLoVP8L25fhl+g3E24KCKL+U7+R9uM
EVQlaqhQ+V1EHKG/oEL8XGiZJXNoryFn/Jyv9bUx2vmLfWfiltD5LKnvJtS51AVO
bNpdKVHk3JPnchvvqNKd5ErzM8Gd+av83Wsi4Q3zm8R/0gegce8ftuGxfZq1iWsU
3G4fPXRMyl+E1cYRmeAh0dobPx5td5GmnFOtekPIU1VhqbKwSZChdi0zZtrohf0j
vuYc/0Dy2rMXMBF0b0DZrN0D0epKH5ecXitCwjcX2EZ4EOtB6OzCLnnfDBgxIa8Q
TVik3Xt1uITJr+2hB5Wyk7A0vv1WpdBOumem0NtKzBbxpSJHkj/8pModU30+57W7
hgEhYS2T6x84dxDXOod66HBomnHSiRM9JPkxQpnf77RgOzXAuW1vyUw0uGTX3Dxu
ijkpE093LzAAU1YP4kKXzKrnjQYm8X0JzcS0iCtlseY9VwrZRbz0T0FvRjY3D7hu
3X/xYGuIJuA=
=JYIm
-----END PGP SIGNATURE-----

--=-yUJkarJMVGbjNFk7onrI--


--===============7818549788348703688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7818549788348703688==--
