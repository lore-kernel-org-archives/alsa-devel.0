From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH] ASoC: Automatically set TDM if needed on
 pxa-ssp and allow frame width override when using TDM.
Date: Wed, 10 Jun 2009 11:17:29 -0300
Message-ID: <1244643449.27053.204.camel@brutus>
References: <1244567590.7406.100.camel@brutus>
	<1719ee7f0906100444l187377f4l9a91b0f24338e032@mail.gmail.com>
	<74d0deb30906100505q55185f32u513eadeeefc432a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4629868909901347080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 77850243FE
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 16:17:35 +0200 (CEST)
Received: by mail-qy0-f171.google.com with SMTP id 1so1094017qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 07:17:35 -0700 (PDT)
In-Reply-To: <74d0deb30906100505q55185f32u513eadeeefc432a5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============4629868909901347080==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-sTMIGTKuNAA5JIa4RA4H"


--=-sTMIGTKuNAA5JIa4RA4H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Qua, 2009-06-10 =C3=A0s 14:05 +0200, pHilipp Zabel escreveu:
> Hmm right, the real frame width is DataSize * slots. So maybe
>        /* set data size */
>        data_size =3D frame_width/slots;
>        if (data_size > 16)
>                sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(data_size - 16);
>        else
>                sscr0 |=3D SSCR0_DataSize(data_size);
> would be more appropriate. Or have that parameter be sample_width
> instead, as Mark initially proposed.

Ack.

Naming it frame_width was not a good idea. Im using frame_width for the
distance between each SFRM assertion when not networked and for the
duration of each slot when networked. I will name it slot_width instead.

--=20
Daniel Ribeiro

--=-sTMIGTKuNAA5JIa4RA4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkovwHkACgkQw3OYl0G0liRvHwCfYTZfDqfPMlxipuo9iZLpsgnX
TU8AnjZZjCE1V/tty8F5xqrr7HVAB+Rm
=8aB+
-----END PGP SIGNATURE-----

--=-sTMIGTKuNAA5JIa4RA4H--


--===============4629868909901347080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4629868909901347080==--
