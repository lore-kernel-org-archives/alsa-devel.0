From: Bob McElrath <bob+alsa-devel@mcelrath.org>
Subject: xrun
Date: Wed, 30 Oct 2002 00:36:13 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021030063611.GH1046@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ecMC0kzqsE2ddMN"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm seeing xrun messages during arecord:
xrun!!! (at least 417.967 ms long)
Status:
state       : XRUN
trigger_time: 1035959057.461844
tstamp      : 1035959057.879744
delay       : 0
avail       : 16384
avail_max   : 16384

What causes this, and what can I do about it?  I assume 'xrun' means
that the driver didn't get any samples for that length of time.  During
this time the rest of the computer stalls too.  i.e. the mouse cursor
stops for that long if I'm moving it.

Will the lock-break kernel patch or preemptive patch work?  (the latter
isn't available on my arch though)  It worries me that the overrun was
0.5s long...sometimes > 1s...

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--3ecMC0kzqsE2ddMN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2/fdsACgkQjwioWRGe9K0FrgCg41bsnAegzdgf6UraDXvMo6XE
31wAnicH0az+dcOO7NwcKU1fkRoie8sc
=g3XX
-----END PGP SIGNATURE-----

--3ecMC0kzqsE2ddMN--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
