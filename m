From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: snd-au8810 A64 issues
Date: Mon, 7 Feb 2005 16:16:17 +0100
Message-ID: <200502071616.19653.alien999999999@users.sourceforge.net>
References: <200502061909.58700.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7159330.3CFDb8gojy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502061909.58700.alien999999999@users.sourceforge.net>
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

--nextPart7159330.3CFDb8gojy
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op zondag 6 februari 2005 19:09, schreef Alien:
> i was going to ask for help
>
> but then i noticed what the issue was, i'm trying to fix it now
>
> the problem was that each writel was called with >>2 (because of type
> issues) in 64bit, this gives issues
>
> since this is still the first adventure of me in kernel programming, i
> would however like some help with this...
>
> i get kernel oops when modprobing this driver

after recompiling my kernel without debug symbols and other debugging thing=
s,=20
the snd-hwdep module kernel oopsed even when i modprobed my snd-emu10k1 whi=
ch=20
had worked before (also, lirc oopsed twice with that configuration, all oth=
er=20
modules worked fine).
=2D-=20
Alien is my name and head-biting is my game.

--nextPart7159330.3CFDb8gojy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCB4ZDuBWKXETrtdcRAsIjAKCpUVPjf3+e8/pSMO5zyR9ZxbL9xQCglCU0
QdGTlEGkGWzdl5/mYo+0FEI=
=FBZ6
-----END PGP SIGNATURE-----

--nextPart7159330.3CFDb8gojy--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
