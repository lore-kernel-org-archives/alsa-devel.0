From: "Derek D. Martin" <ddm@pizzashack.org>
Subject: alsa configure/install bug
Date: Mon, 24 Jun 2002 14:31:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020624143111.B1332@pizzashack.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline; filename="msg.pgp"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

A couple of issues with the configure script and/or the install target
of the makefile:

a) the help for configure claims that the default location for the
- --with-moddir parameter is /lib/modules/<KVER>/misc.  However, after
make install, the modules are apparently actually installed in
subtrees of /lib/modules/<KVER>/kernel/sound.

b) When modules are installed in the above directories, modprobe can't
find them.  Is this distribution specific?  Is there a way to
configure this behavior?  I'm running RH 7.1 on a Toshiba Satellite.
I'll also note that with a recent beta of the 0.9 code, modules were
installed in the misc directory.

Thanks

- -- 
Derek Martin               ddm@pizzashack.org    
- ---------------------------------------------
I prefer mail encrypted with PGP/GPG!
GnuPG Key ID: 0x81CFE75D
Retrieve my public key at http://pgp.mit.edu
Learn more about it at http://www.gnupg.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9F2VvdjdlQoHP510RApXFAJ0RNPn1lnOv4fc8C8Dy23LmoGbiKgCeLbuy
mZ2VxwJokexuIfJ7Z3uQuxw=
=aa5T
-----END PGP SIGNATURE-----


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
