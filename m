From: "David E. Storey" <dave@tamos.net>
Subject: alsa and gtk
Date: 08 Jun 2003 07:29:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055071787.418.9.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CvbzBEUU4+Vpr3yCDy9u"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-CvbzBEUU4+Vpr3yCDy9u
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

folks,

thought I'd bounce this off the list in case anyone has seen it before.
I'm trying to write something like TotalMix for the RME HDSP, but more
suited for mixing in-ear-monitors. So I wrote this mini library that
uses the snd_ctl_* api of alsa. Wrote all the functionality, tested the
functionality in a CLI and everything worked. Yesterday, I started
writing the GUI in GTK and some weird things started happening. Whenever
I tried using the library outside of gtk_main, everything worked fine.
It wasn't until after I started using snd_ctl_* functions from within
gtk callbacks that I was having issues. If I move the library calls
outside of something within  or before gtk_main, it works just fine.
After calling gtk_main, any functions are also toast. When trying to
write to a control element, I get:

Control hw:1 element write error: No such file or directory

and similarly, when I try to read an element, I get:

Control hw:1 element read error: No such file or directory

Once gtk_main hits, the game is over. Is there something gtk_main does
to the environment that affects alsa? I'm willing to post code for
anyone who's interested. Normally, I'd start pouring through GTK+ and
Alsa source at this point, but time is of the essence in my case.

thanks,
d!

--=-CvbzBEUU4+Vpr3yCDy9u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+4x4r+5sC2muyxOMRApjZAJ95CCFxtlxNdNKScIMcnbiHO0EoGgCfQ/Lj
bYDfH9oeQS92d8lbcsmev/w=
=XV8t
-----END PGP SIGNATURE-----

--=-CvbzBEUU4+Vpr3yCDy9u--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
