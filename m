From: Tim Blechmann <tim@klingt.org>
Subject: Re: alsa driver for digigram lx6464es
Date: Mon, 23 Mar 2009 11:26:11 +0100
Message-ID: <49C763C3.3000509@klingt.org>
References: <49C692B0.7040609@klingt.org> <s5hljqwlogv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2234887055628188491=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 4526224367
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2009 11:26:13 +0100 (CET)
In-Reply-To: <s5hljqwlogv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2234887055628188491==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig59BFC6AD0C01788A6FE776D8"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig59BFC6AD0C01788A6FE776D8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> takashi, i would like to submit the patch to alsa soon ... how should =
i
>> proceed? can you do a review of the code?
>=20
> Simply post patches to alsa-devel ML and Cc to me (or vice versa).
> But I'll be on vacation from this week (Wednesday) until the Easter
> holidays.  So, sooner better ;)

the patch seems to be too large for the mailing-list, 140kb ...	i hope
the moderator will accept the message ...

please note, that i included 4 header files and some minor code portions
from digigram's windows driver, which do not match the linux coding
style. i preferred to do so in order to keep the similarity to the
windows driver, which was my main reference for implementing the driver.

cheers, tim

--=20
tim@klingt.org
http://tim.klingt.org

The composer makes plans, music laughs.
  Morton Feldman


--------------enig59BFC6AD0C01788A6FE776D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknHY8UACgkQdL+4qsZfVssgbwCdE22RwDhfpwYa3Z/w/Bwcc0EJ
6jYAoJoWBOhxuqRmrL8vS4w611g9JQeM
=Bej/
-----END PGP SIGNATURE-----

--------------enig59BFC6AD0C01788A6FE776D8--

--===============2234887055628188491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2234887055628188491==--
