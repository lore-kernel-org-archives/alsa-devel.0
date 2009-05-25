From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 23:25:06 +0200
Message-ID: <4A1B0CB2.2060103@yellowcouch.org>
References: <4A1AB98B.9010604@yellowcouch.org>
	<s5hk54589xd.wl%tiwai@suse.de>	<4A1ADAEF.3070803@yellowcouch.org>
	<s5h8wklvyfc.wl%tiwai@suse.de>	<4A1AE302.8080702@yellowcouch.org>
	<s5h7i05vxol.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2890305485013475188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D9B32455A
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 23:23:10 +0200 (CEST)
In-Reply-To: <s5h7i05vxol.wl%tiwai@suse.de>
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
--===============2890305485013475188==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDFC977826A7FF182441019CB"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDFC977826A7FF182441019CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
> OK, I see the problem now, too.  In practice, you can get a file
> descriptor from poll descriptor, but this doesn't cover all underlying
> fds.  A new API function or an additional SND_PCM_* flag for
> snd_pcm_open() would be needed, indeed.
>
> In the latter case, it must be easy -- just pass O_CLOEXEC flag to
> open() call...
>  =20
That handles the close on exec well, but we are talking about forks
here. There is not necessarily an exec involved in the child process.

Wkr,

Werner,-

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enigDFC977826A7FF182441019CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkobDLYACgkQYJM5sO5rAR2AaQCeLtIabi+SB61bpqGF6p+lrlpP
eisAn0QZ/JX5B0NVDWF0vRaTMdJRylA5
=783i
-----END PGP SIGNATURE-----

--------------enigDFC977826A7FF182441019CB--

--===============2890305485013475188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2890305485013475188==--
