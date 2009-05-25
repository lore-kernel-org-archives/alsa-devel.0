From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: Third time: Unlink PCM resource ?
Date: Tue, 26 May 2009 00:29:35 +0200
Message-ID: <4A1B1BCF.8050808@yellowcouch.org>
References: <4A1AB98B.9010604@yellowcouch.org>
	<s5hk54589xd.wl%tiwai@suse.de>	<4A1ADAEF.3070803@yellowcouch.org>
	<s5h8wklvyfc.wl%tiwai@suse.de>	<4A1AE302.8080702@yellowcouch.org>
	<s5h7i05vxol.wl%tiwai@suse.de>	<alpine.LNX.2.00.0905252036550.4067@eeebox2.perex-int.cz>	<4A1AF346.9040602@yellowcouch.org>
	<alpine.LNX.2.00.0905252352590.4067@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3417745945709668641=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 172A324369
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 00:27:41 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0905252352590.4067@eeebox2.perex-int.cz>
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
--===============3417745945709668641==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0C2AD1A132E2D8AC697A12BC"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C2AD1A132E2D8AC697A12BC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela wrote:
> Your example program does not contain dsp_close() call in parent before=
=20
> dsp_open(). That's reason why PCM device is blocked.
>  =20
That could make sense, but then the wave should not stop playing when
the child process closes the dsp ?
Currently the child process has no way to release the dsp without
stopping the parent process during play.

Werner,-

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enig0C2AD1A132E2D8AC697A12BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkobG9QACgkQYJM5sO5rAR1DeQCeIn8245Q/guMsQ8Xmhis/qMck
M2sAnjeEOO3H30A7HYdLsJ+nh8+gHwGp
=dZki
-----END PGP SIGNATURE-----

--------------enig0C2AD1A132E2D8AC697A12BC--

--===============3417745945709668641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3417745945709668641==--
