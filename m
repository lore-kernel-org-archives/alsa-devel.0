From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH] ASoC: Automatically set TDM if needed on
 pxa-ssp and allow frame width override when using TDM.
Date: Wed, 10 Jun 2009 11:17:11 -0300
Message-ID: <1244643431.27053.203.camel@brutus>
References: <1244567590.7406.100.camel@brutus>
	<1719ee7f0906100444l187377f4l9a91b0f24338e032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6177693727184288336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 37EAA243E0
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 16:17:19 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1094017qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 07:17:19 -0700 (PDT)
In-Reply-To: <1719ee7f0906100444l187377f4l9a91b0f24338e032@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Shen <boshen9@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============6177693727184288336==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-/N+bxjzYFfQoWe8hVvdy"


--=-/N+bxjzYFfQoWe8hVvdy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Qua, 2009-06-10 =C3=A0s 19:44 +0800, Paul Shen escreveu:
> Seems the frame_width has no  such relations with sampe width, the
> sample width is defined on runtime by the audio files.
> Make a example sample with  paly a often used 16bit sample width
> stereo aduio file.

> When you play 16bit audio sample with  2*16 bit frame ,
>          frame   --|____________|------------------|_____________|---
>          data      --<=3D=3D=3D=3D=3D=3D>-<=3D=3D=3D=3D=3D=3D>-<=3D=3D=3D=
=3D=3D=3D>-
>          here the datasize should be SSCR0_DataSize(16), the frame size i=
s 32

No, the example above would be DataSize(32), SFRMWDTH(16). (LEFT_J?)

Or it could be DataSize(16) and 2 active TDM Slots.

But the point here is to not use SSCR0_MOD when its not needed
(sample * chn <=3D 32), we need to support real networked configurations,
set_tdm_slot() should only be called if you are really using network
mode. eg:

set_tdm_slots(3, 2) shouldn't ever be needed.

> also you can play 16bit audio sample with 2*32 frame,
>          frame
> --|_________________________|------------------------------------|____
>          data     --<=3D=3D=3D=3D=3D=3D>-------------------<=3D=3D=3D=3D=
=3D=3D>-------------------<=3D=3D
>          here the datasize is also DataSize(16), but the frame size is 64=
.
>=20
> Do I misunderstand you?

Sure you can waste bitclocks.. But we should try to only waste bitclocks
when it is really needed, eg for I2S. The patch is not considering I2S
yet.


--=20
Daniel Ribeiro

--=-/N+bxjzYFfQoWe8hVvdy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkovwF0ACgkQw3OYl0G0liSk+QCghS4iKUWVlIjYOfXob7uX7eya
akUAnRGPZ0aX2Nk66dfQm1NvS9rK39gK
=1vVw
-----END PGP SIGNATURE-----

--=-/N+bxjzYFfQoWe8hVvdy--


--===============6177693727184288336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6177693727184288336==--
