From: Hod McWuff <hod@wuff.dhs.org>
Subject: Re: alsamixer issues?
Date: 13 Mar 2002 11:10:42 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1016035842.7702.2.camel@samoyed.wuff.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2KOYcFrK7aoE9W3VJngc"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: prismatic7@bigpond.com, eric@zhevny.com
Cc: alsa-devel@lists.sourceforge.net, alsa-users@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-2KOYcFrK7aoE9W3VJngc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I think that anytime you change kernels alsa needs to be recompiled
> because it has to be able to resolve the symbols of the currently
> running kernel.

You need to re-'./configure && make && make install' the 'alsa-drivers'
package. The other packages do NOT need to be recompiled, and once
you've built the drivers for all of your installed kernels, you can
switch between them freely.

- Hod McWuff




--=-2KOYcFrK7aoE9W3VJngc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8j3oBCcSqvpnxLx8RAqKdAJ4ydsj0LWrJi6AprhSebHdr8JtzIwCfeEaf
FOY5i8CpnFJFe+Hy0sgQRjA=
=Xnfp
-----END PGP SIGNATURE-----

--=-2KOYcFrK7aoE9W3VJngc--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
