From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 19:52:47 +0200
Message-ID: <4A1ADAEF.3070803@yellowcouch.org>
References: <4A1AB98B.9010604@yellowcouch.org> <s5hk54589xd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3465893198834073460=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CD3D24468
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 19:51:00 +0200 (CEST)
In-Reply-To: <s5hk54589xd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3465893198834073460==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6BECA6117F0949121802F368"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6BECA6117F0949121802F368
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
>> If this is the wrong mailinglist, then who should I contact regarding
>> these erratic semantics ?
>>    =20
>
> Which API are you using?  A simple test case code would be more
> helpful to demonstrate.
>  =20
The api provided by libasound. I'll see whether I can generate a concise
example if there is no known solution to this problem,
> But, in general, sharing the same DSP device among different processes
> don't sound like a good idea...
>  =20

I agree, but when one forks off a child the parent pcm handle
automatically passes to the child. If there is a possibility _not_ to
pass the PCM handle to the forked process then I would be quite happy as
well.

Werner,-

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enig6BECA6117F0949121802F368
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoa2u8ACgkQYJM5sO5rAR303wCfTqtojqZwm1oqj77dKMB07am9
MYMAoKYqmAAsyXF9+SJc/ybxmQpJPDuB
=HL+L
-----END PGP SIGNATURE-----

--------------enig6BECA6117F0949121802F368--

--===============3465893198834073460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3465893198834073460==--
