From: Bob McElrath <bob+alsa-devel@mcelrath.org>
Subject: cs46xx sound quality and CD volume
Date: Thu, 10 Oct 2002 22:23:22 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021011032322.GC4014@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My Hercules Game Theater XP sounds great with the 0.90rc3 driver (on an
alpha!), good work folks!  The driver used to hang my machine hard.

However, one small buglet.  When recording from line1 (aux in the
current driver), the sound sometimes sounds very tinny and scratchy.  I
can fix this by muting/unmuting the CD and adjusting the CD volume.
Yes, the CD slider in alsamixer.  Not the Aux one or the Capture one or
the DAC one.  The CD one.  Weird, huh?  I've tried playing with all the
other sliders and they do not affect the recording quality.

Note this is with the old driver, not the new experimental DSP code (but
I'll try that soon).  I also have not tried to reproduce this by
recording from one of the other inputs.

This seems like a simple fix.  Anyone know how?

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2mRCoACgkQjwioWRGe9K2WmgCg18a+b0GT8DNuYpPp3VWguiCf
vwcAn2yErrPYXOg4SajrZjp9M48u8GkM
=Ea7e
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
