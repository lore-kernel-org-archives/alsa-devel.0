From: Alien <alien999999999@users.sourceforge.net>
Subject: snd-au8810 A64 issues
Date: Sun, 6 Feb 2005 19:09:55 +0100
Message-ID: <200502061909.58700.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5870258.OhoKMEdmzL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart5870258.OhoKMEdmzL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

i was going to ask for help

but then i noticed what the issue was, i'm trying to fix it now

the problem was that each writel was called with >>2 (because of type issue=
s)=20
in 64bit, this gives issues

since this is still the first adventure of me in kernel programming, i woul=
d=20
however like some help with this...

i get kernel oops when modprobing this driver
=2D-=20
Alien is my name and head-biting is my game.

--nextPart5870258.OhoKMEdmzL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCBl12uBWKXETrtdcRAp7KAJ0ZF2IqRKwXfmN1dwxbclDwQjXgGACgi3a3
UqrvFd7SxxQJaS8fxyNRYBU=
=qRY8
-----END PGP SIGNATURE-----

--nextPart5870258.OhoKMEdmzL--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
