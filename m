From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: wrong decibel data?
Date: Sat, 10 Apr 2010 08:56:55 +0200
Message-ID: <4BC02137.6000207@yellowcouch.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>	<u2w4f3252891004081611tc0293e7fzb6312ca188eacdc1@mail.gmail.com>	<s2l98391a7b1004090030vd55faadew6ae97c85a7a4b379@mail.gmail.com>	<r2u4f3252891004090649p3f327273x3af60905a06045fe@mail.gmail.com>	<4BBF5F81.1010205@yellowcouch.org>
	<w2t4f3252891004091632j1728479at2c4d623e44f0d0c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1178790572620976223=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A150103803
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Apr 2010 08:57:52 +0200 (CEST)
In-Reply-To: <w2t4f3252891004091632j1728479at2c4d623e44f0d0c7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1178790572620976223==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D1C31D2D470FBFC8C891156"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D1C31D2D470FBFC8C891156
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Raymond Yau wrote:
>> Yes about that. I always wondered how they come up with 96dB ?
>>
>> A perceived doubling of volume is normally assumed to be +3dB,
>> (log_10(2)=3D0.3) which means that if you have 16 bit audio you have 1=
6
>> 'doublings', or in essence only 48 dB. Even worse, since the last bit =
is
>> a sign bit, you essentially can only achieve a dynamic range of 45dB !=

>>
>> Now, I know this is off topic, but I never heard any good explanation
>> why CD audio is suddenly 45 dB ?  If anybody knows, please share your
>> thoughts !
>>    =20
> http://en.wikipedia.org/wiki/Decibel
>
> When referring to measurements of amplitude it is usual to consider the=

> ratio of the squares of *A*1 (measured amplitude) and *A*0 (reference
> amplitude). This is because in most applications power is proportional =
to
> the square of amplitude,
>
> in electrical circuit , dissipated power is typically proportional to t=
he
> square of voltage or current
>  =20
Okay, that would then only make for a factor two. Instead of 45dB one
gets 90dB, this is still not 96dB as ordinarily claimed ?

Wkr,

Werner,-

--=20
http://werner.yellowcouch.org/



--------------enig6D1C31D2D470FBFC8C891156
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvAIToACgkQ2TDF0fTmy3WvlQCfQXoObYrSe0WAdZbryQGgMqCO
uzsAn1sEWjEnRgiyfvtexuX1N9AsgaeN
=GDwf
-----END PGP SIGNATURE-----

--------------enig6D1C31D2D470FBFC8C891156--

--===============1178790572620976223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1178790572620976223==--
