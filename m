From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
 Left_J support
Date: Mon, 08 Jun 2009 13:25:32 -0300
Message-ID: <1244478332.30582.83.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<74d0deb30906080858m7dc52cfaxfbb6366c529fc0e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4232622924357744445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 68AC7103877
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 18:26:54 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4109571qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 09:26:51 -0700 (PDT)
In-Reply-To: <74d0deb30906080858m7dc52cfaxfbb6366c529fc0e2@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============4232622924357744445==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-b7nYZUZ53t0WSfr41b54"


--=-b7nYZUZ53t0WSfr41b54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-06-08 =C3=A0s 17:58 +0200, pHilipp Zabel escreveu:
> I thought sample width is determined by the snd_pcm_hw_params. But
> maybe I'm mixing up alsa sample width vs sample width on the wire?
> I'm leaning towards set_frame_width because that's directly what I
> want to do: override pxa_ssp_hw_params' standard decision to use
> 32-bit frames for S16_LE stereo and set 16-bit frames instead.

Actually, the current code is not doing this. It is using 32bit DMA, but
with 16bit frame size on the wire for S16_LE stereo (unless you setup 2
timeslots).

--=20
Daniel Ribeiro

--=-b7nYZUZ53t0WSfr41b54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkotO3wACgkQw3OYl0G0liQvSwCgiw/soGQf4Umhjgb3H0R/VTs8
2qUAn2B5LLHCBBEYGptaANTqwiuO/WNm
=lGNf
-----END PGP SIGNATURE-----

--=-b7nYZUZ53t0WSfr41b54--


--===============4232622924357744445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4232622924357744445==--
