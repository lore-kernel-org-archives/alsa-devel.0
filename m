From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: making aoss able to wrap fopen() calls
Date: Fri, 6 Feb 2004 12:28:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402061228.12714.pwk.linuxfan@gmx.de>
References: <200402051727.25712.pwk.linuxfan@gmx.de> <Pine.LNX.4.58.0402051748390.1864@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402051748390.1864@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Donnerstag, 5. Februar 2004 17:49 schrieb Jaroslav Kysela:
> > Could you point me to a good idea of implementing this ? On irc I was
> > discussing doing a libc wrapper that replaces the fopen calls with some
> > substitute (that aoss can handle), but I'm not sure if its the way to g=
o.
> >
> > Please tell me how it can be achieved.
>
> The whole libaoss is based on glibc wrappers (open, close, ioctl, write,
> read, mmap) so follow this rule ;-)

Right,=20

I have done some looking at source code, and have found the places I needed=
 to=20
find (in alsa-oss.c).=20
Two questions:
(1) Is my assumtion right, that I will have to write substitute functions f=
or=20
fopen(), fclose(), fread() and fwrite() ?

(2) My current approach is to "translate" the f* calls into calls that can =
be=20
handled already. Is this a good idea ?

Peter
=2D --=20
A critic is a bundle of biases held loosely together by a sense of taste.
		-- Whitney Balliett
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAI3pJg2ieGvTmHiURAhCoAKCbo0VxbUDm85MBiR9ZpqX3HhDUxgCdFya4
+2bewyW36EcCJksr9jpWsOY=3D
=3D1X1j
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
