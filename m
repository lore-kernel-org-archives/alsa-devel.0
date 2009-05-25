From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 20:15:11 +0200
Message-ID: <4A1AE02F.3060704@yellowcouch.org>
References: <4A1AB98B.9010604@yellowcouch.org>
	<s5hk54589xd.wl%tiwai@suse.de>	<4A1ADAEF.3070803@yellowcouch.org>
	<alpine.LNX.2.00.0905252006020.4067@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7010837046420402211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 31BAD24484
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 20:13:12 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0905252006020.4067@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7010837046420402211==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig28460AA74F54BA6756ADCF74"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28460AA74F54BA6756ADCF74
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela wrote:
> Do you call close() for all opened file descriptors associated to=20
> snd_pcm_t handle in child process?
>  =20
I use snd_pcm_close() in the child process, but this will also close the
parent process its pcm device, which is clearly not wanted.

Wkr,

Werner,-

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enig28460AA74F54BA6756ADCF74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoa4DAACgkQYJM5sO5rAR1x+QCbBG5MKg2yoQOoPtYJCoZi5H0n
CgEAmgOl9a9d6AkdR6Cmrf/cSk3KHuI9
=obJk
-----END PGP SIGNATURE-----

--------------enig28460AA74F54BA6756ADCF74--

--===============7010837046420402211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7010837046420402211==--
