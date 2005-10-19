From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: Switch to dmix pure by default?
Date: Wed, 19 Oct 2005 17:44:20 +0200
Message-ID: <20051019154420.GA14091@piware.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ALSA developers!

I'm Martin Pitt, one of Ubuntu's core developers, and I hacked a fair
bit around a better audio support in our latest release. We currently
use ALSA 1.0.9 (thus with dmix enabled by default) and use esd on top
of that since dmix pure still does not work on too many cards
(including the powermac driver on my iBook).

However, since esound sucks particularly in terms of A/V
synchronisation and has annoying bugs, and the whole concept of a
desktop sound daemon is more like a workaround than a sane piece in
the software stack, we would like to drop esound entirely and just use
ALSA by default in the future. I imagine that this is true for other
Linux distros as well.

Now I have several questions:

 1) Are you guys interested in reports about cards which do not work
 with dmix (at least not with the default configuration)?

 2) Is there a document which describes dmix debugging, so that we can
 already pre-process bug reports, can sort them out faster, make it
 easier for you, and maybe even can help you with fixing?

 3) As it appears to me, dmix is a pure software mixing plugin, thus
 from the mere concept, it seems hardware agnostic to me. Why does it
 fail on some hardware in the first place?

Thank you in advance, and have a nice day!

Martin

--=20
Martin Pitt        http://www.piware.de
Ubuntu Developer   http://www.ubuntu.com
Debian Developer   http://www.debian.org

In a world without walls and fences, who needs Windows and Gates?

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDVmnUDecnbV4Fd/IRAu0tAKCb21zOeDGqUfWGONGXlX4FTVEzpACgni1Q
86lyzSQTrecPAZAbMwuiDCY=
=+9Z+
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
