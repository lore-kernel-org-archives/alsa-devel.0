From: Jordi Mallach <jordi@debian.org>
Subject: Re: New Debian patches
Date: Tue, 11 Feb 2003 12:05:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030211110522.GA5896@nubol.int.oskuro.net>
References: <20030210175931.GB5402@nubol.int.oskuro.net> <s5h1y2fdxlq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1y2fdxlq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, debian-alsa@lists.wedontsleep.org
List-Id: alsa-devel@alsa-project.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2003 at 09:34:41AM +0100, Takashi Iwai wrote:
> > For the alsaconf patch, it's the changes I made to the script to make it
> > work on Debian. It still lacks propper unbashization (removing let's,
> > etc).
> what merit do we have by this?
> the script doesn't work (as syntax errors) without this patch?

Uh, on what line? It works here... on the contrary, using /bin/sh on
POSIX shells like dash failed due to bashisms.

> > More flavours could be added to the distributions detection, and adding
> > distro-specific stuff to it.
> yep.  at least, !"debian" doesn't always mean "redhat"  :)

Yeah, but it's the two distributions I know how to detect :)

> btw, the second patch is wrong.  isa directory must be checked even if
> CONFIG_ISA is not set, because snd-sb-common module can be used by
> snd-als4000 (PCI) module.

Hmm. Any idea on how to fix Debian Bug#179522, then?
(http://bugs.debian.org/179522)

Heh, unlucky round of patches :)

Thanks,
Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+SNjyJYSUupF6Il4RAjevAKDcze9RiDKtyd/jRlVu3ztoHlOFRACfRMhQ
l7CDgXvHt3VJGlIRj90TlfQ=
=MhIF
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
