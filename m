From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: Third time: Unlink PCM resource ?
Date: Tue, 26 May 2009 10:14:56 +0200
Message-ID: <4A1BA500.2080907@yellowcouch.org>
References: <4A1AB98B.9010604@yellowcouch.org>
	<s5hk54589xd.wl%tiwai@suse.de>	<4A1ADAEF.3070803@yellowcouch.org>
	<s5h8wklvyfc.wl%tiwai@suse.de>	<4A1AE302.8080702@yellowcouch.org>
	<s5h7i05vxol.wl%tiwai@suse.de>	<alpine.LNX.2.00.0905252036550.4067@eeebox2.perex-int.cz>
	<s5hvdno5s1m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7497430610745698703=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AF2A24676
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 10:12:57 +0200 (CEST)
In-Reply-To: <s5hvdno5s1m.wl%tiwai@suse.de>
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
--===============7497430610745698703==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF75AF6961D996D3B5708D25A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF75AF6961D996D3B5708D25A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
> OK, in a case without exec, we need an explicit call.
> But I guess snd_pcm_close() isn't appropriate (as Werner experienced)
> since it calls snd_pcm_drop() there.  I guess this call isn't needed
> as the driver itself takes care?
>  =20
You mean: modifying the snd_pcm_close routine to not call snd_pcm_drop ?
I guess that might work as well to solve my problem.
Will such a fix appear in a new alsa release ?

I'd like to thank you for the time you spent to look at this issue.

With kind regards,

Werner,-

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enigF75AF6961D996D3B5708D25A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkobpQAACgkQYJM5sO5rAR0PNgCdHEKxIZpkrXahr8Pw0KIPcCL8
DoEAmwf5PbAmT8yaDi+hh25rjIPJYX0W
=NHx2
-----END PGP SIGNATURE-----

--------------enigF75AF6961D996D3B5708D25A--

--===============7497430610745698703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7497430610745698703==--
